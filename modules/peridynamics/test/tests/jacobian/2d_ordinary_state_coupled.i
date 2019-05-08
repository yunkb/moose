# Test for Jacobian correctness check of ordinary state-based peridynamic formulation

[GlobalParams]
  displacements = 'disp_x disp_y'
  temperature = temp
  full_jacobian = true
[]

[Mesh]
  type = GeneratedMeshPD
  dim = 2
  horizon_number = 3
  nx = 4
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./temp]
    initial_condition = 0.5
  [../]
[]

[Modules]
  [./Peridynamics]
    [./Mechanics]
      formulation = OrdinaryState
    [../]
  [../]
[]

[Kernels]
  [./heat]
    type = HeatConductionBPD
    variable = temp
  [../]
[]

[Materials]
  [./linelast]
    type = SmallStrainConstantHorizonOSPD
    youngs_modulus = 2e5
    poissons_ratio = 0.0
    thermal_expansion_coeff = 0.02
    stress_free_temperature = 0.5
  [../]

  [./thermal]
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
