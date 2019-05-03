
[GlobalParams]
  displacements = 'disp_x disp_y'
  full_jacobian = true
[]

[MeshGenerators]
  [fmg]
    type = FileMeshGenerator
    file = hole_plate.e
  []
  [gpd]
    type = MeshGeneratorPD
    input = fmg
    retain_fe_mesh = false
  []
[]

[Mesh]
  type = PeridynamicsMesh
  # horizon_number = 3
  horizon_radius = 0.03
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
  [./Ux]
  [../]
  [./Uy]
  [../]
  [./Sxx]
  [../]
  [./Syy]
  [../]
  [./Sxy]
  [../]
  [./area]
  [../]
[]

[AuxKernels]
  [./Ux]
    type = FunctionAux
    variable = Ux
    function = '3.25e-5*x/(x^2+y^2)*(180*(x^2+y^2)+5.6+(2-0.02/(x^2+y^2))*(4*x^2/(x^2+y^2)-3))'
  [../]
  [./Uy]
    type = FunctionAux
    variable = Uy
    function = '3.25e-5*y/(x^2+y^2)*(-120*(x^2+y^2)-1.6+(2-0.02/(x^2+y^2))*(3-4*y^2/(x^2+y^2)))'
  [../]
  [./Sxx]
    type = FunctionAux
    variable = Sxx
    function = '10000*(1-0.01/(x^2+y^2)*(1.5*cos(2*atan2(y,x))+(1-0.015/(x^2+y^2))*cos(4*atan2(y,x))))'
  [../]
  [./Syy]
    type = FunctionAux
    variable = Syy
    function = '10000*(-0.01/(x^2+y^2)*(0.5*cos(2*atan2(y,x))-(1-0.015/(x^2+y^2))*cos(4*atan2(y,x))))'
  [../]
  [./Sxy]
    type = FunctionAux
    variable = Sxy
    function = '10000*(-0.01/(x^2+y^2)*(0.5*sin(2*atan2(y,x))+(1-0.015/(x^2+y^2))*sin(4*atan2(y,x))))'
  [../]
  [./area]
    type = NodalVolumePD
    variable = area
  [../]
[]

[BCs]
  [./left_x]
    type = FunctionPresetBC
    variable = disp_x
    boundary = left
    function = '3.25e-5*x/(x^2+y^2)*(180*(x^2+y^2)+5.6+(2-0.02/(x^2+y^2))*(4*x^2/(x^2+y^2)-3))'
  [../]
  [./left_y]
    type = FunctionPresetBC
    variable = disp_y
    boundary = left
    function = '3.25e-5*y/(x^2+y^2)*(-120*(x^2+y^2)-1.6+(2-0.02/(x^2+y^2))*(3-4*y^2/(x^2+y^2)))'
  [../]
  [./right_x]
    type = FunctionPresetBC
    variable = disp_x
    boundary = right
    function = '3.25e-5*x/(x^2+y^2)*(180*(x^2+y^2)+5.6+(2-0.02/(x^2+y^2))*(4*x^2/(x^2+y^2)-3))'
  [../]
  [./right_y]
    type = FunctionPresetBC
    variable = disp_y
    boundary = right
    function = '3.25e-5*y/(x^2+y^2)*(-120*(x^2+y^2)-1.6+(2-0.02/(x^2+y^2))*(3-4*y^2/(x^2+y^2)))'
  [../]
  [./top_x]
    type = FunctionPresetBC
    variable = disp_x
    boundary = top
    function = '3.25e-5*x/(x^2+y^2)*(180*(x^2+y^2)+5.6+(2-0.02/(x^2+y^2))*(4*x^2/(x^2+y^2)-3))'
  [../]
  [./top_y]
    type = FunctionPresetBC
    variable = disp_y
    boundary = top
    function = '3.25e-5*y/(x^2+y^2)*(-120*(x^2+y^2)-1.6+(2-0.02/(x^2+y^2))*(3-4*y^2/(x^2+y^2)))'
  [../]
  [./bottom_x]
    type = FunctionPresetBC
    variable = disp_x
    boundary = bottom
    function = '3.25e-5*x/(x^2+y^2)*(180*(x^2+y^2)+5.6+(2-0.02/(x^2+y^2))*(4*x^2/(x^2+y^2)-3))'
  [../]
  [./bottom_y]
    type = FunctionPresetBC
    variable = disp_y
    boundary = bottom
    function = '3.25e-5*y/(x^2+y^2)*(-120*(x^2+y^2)-1.6+(2-0.02/(x^2+y^2))*(3-4*y^2/(x^2+y^2)))'
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
  file_base = 2d_fnos_hole
  exodus = true
[]
