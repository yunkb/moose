
# NOTE: this jacobian test for the coupled thermomechanical model must use displaced mesh, otherwise the difference for the first step is huge

[GlobalParams]
  displacements = 'disp_x disp_y'
  temperature = temp
  scalar_out_of_plane_strain = scalar_strain_zz
  full_jacobian = true
[]

[MeshGenerators]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 4
    ny = 4
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

  [./temp]
    initial_condition = 0.5
  [../]

  [./scalar_strain_zz]
    order = FIRST
    family = SCALAR
  [../]
[]

[AuxVariables]
  [./stress_zz]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Modules]
  [./Peridynamics]
    [./Mechanics]
      formulation = OrdinaryState
    [../]
    [./GeneralizedPlaneStrain]
      [./gps]
        formulation = OrdinaryState
        out_of_plane_stress_variable = stress_zz
      [../]
    [../]
  [../]
[]

[Kernels]
  [./heat]
    type = HeatConductionBPD
    variable = temp
  [../]
[]

[AuxKernels]
  [./stress_zz]
    type = NodalStressStrainPD
    rank_two_tensor = stress
    variable = stress_zz

    poissons_ratio = 0.3
    youngs_modulus = 1e6
    thermal_expansion_coeff = 0.02
    stress_free_temperature = 0.5

    quantity_type = Component
    index_i = 2
    index_j = 2
  [../]
[]

[Materials]
  [./elastic_tensor]
    type = SmallStrainConstantHorizonOSPD
    poissons_ratio = 0.3
    youngs_modulus = 1e6
    thermal_expansion_coeff = 0.02
    stress_free_temperature = 0.5
  [../]
  [./thermal_mat]
    type = ThermalConstantHorizonBPD
    thermal_conductivity = 1.0
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
    petsc_options_iname = '-ksp_type -pc_type -snes_type'
    petsc_options_value = 'bcgs bjacobi test'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 1
  dt = 1
  num_steps = 1
[]
