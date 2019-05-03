
[GlobalParams]
  displacements = 'disp_x disp_y'
  full_jacobian = true
[]

[MeshGenerators]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 101
    ny = 101
    xmin = -0.5
    xmax = 0.5
    ymin = -0.5
    ymax = 0.5
  []
  [gpd]
    type = MeshGeneratorPD
    input = gmg
    retain_fe_mesh = false
  []
  [centerline]
    type = BoundingBoxNodeSetGenerator
    input = gpd
    new_boundary = 'centerline'
    bottom_left = '-0.5 -0.005 0'
    top_right = '0.5 0.005 0'
    location = INSIDE
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

[AuxVariables]
  [./vM]
  [../]
  [./vManalytical]
  [../]
  [./Ux]
  [../]
  [./Uy]
  [../]
[]

[AuxKernels]
  [./Ux]
    type = FunctionAux
    variable = Ux
    function = '0.001*x'
  [../]
  [./Uy]
    type = FunctionAux
    variable = Uy
    function = '-0.001*3.0/7.0*y'
  [../]
  [./vManalytical]
    type = FunctionAux
    variable = vManalytical
    function = '976.7237'
  [../]
[]

[BCs]
  [./left_dx]
    type = FunctionPresetBC
    variable = disp_x
    boundary = left
    function = '-0.00049505*t'
  [../]
  [./right_dx]
    type = FunctionPresetBC
    variable = disp_x
    boundary = right
    function = '0.00049505*t'
  [../]
  [./center_dy]
    type = DirichletBC
    variable = disp_y
    boundary = centerline
    value = 0.0
  [../]
[]

[Modules]
  [./Peridynamics]
    [./Mechanics]
      formulation = NonOrdinaryState
      stabilization = Force
    [../]
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1.0e6
    poissons_ratio = 0.3
  [../]
  [./strain]
    type = ForceStabilizedSmallStrainNOSPD
  [../]
  [./stress]
    type = ComputeLinearElasticStress
  [../]
[]

[UserObjects]
  [./vM]
    type = NodalRankTwoTensorScalarPD
    aux_variable = vM
    rank_two_tensor = stress
    scalar_type = VonMisesStress
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
  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu superlu_dist'
  start_time = 0
  end_time = 1
[]

[Outputs]
  file_base = 2d_fnos_plate
  exodus = true
[]
