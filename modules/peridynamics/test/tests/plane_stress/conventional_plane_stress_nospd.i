
[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[MeshGenerators]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 10
    ny = 10
  []
  [gpd]
    type = MeshGeneratorPD
    input = gmg
    retain_fe_mesh = false
  []
[]

[Mesh]
  type = PeridynamicsMesh
  horizon_number = 3
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
[]

[BCs]
  [./left_dx]
    type = PresetBC
    variable = disp_x
    boundary = left
    value = 0.0
  [../]
  [./left_dy]
    type = PresetBC
    variable = disp_y
    boundary = left
    value = 0.0
  [../]
  [./right_dx]
    type = PresetBC
    variable = disp_x
    boundary = right
    value = 0.001
  [../]
[]

[Modules]
  [./Peridynamics]
    [./Mechanics]
      formulation = NonOrdinaryState
    [../]
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputePlaneStressIsotropicElasticityTensor
    youngs_modulus = 2.1e8
    poissons_ratio = 0.3
  [../]
  [./strain]
    type = SmallStrainNOSPD
  [../]
  [./stress]
    type = ComputeLinearElasticStress
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = PJFNK
  line_search = none
  start_time = 0
  end_time = 1
[]

[Outputs]
  file_base = conventional_plane_stress_nospd
  exodus = true
[]
