
[GlobalParams]
  displacements = 'disp_x disp_y'
  temperature = temp
  out_of_plane_strain = strain_zz
  full_jacobian = true
[]

[Mesh]
  type = GeneratedMeshPD
  dim = 2
  nx = 4
  horizon_number = 3
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]

  [./strain_zz]
  [../]

  [./temp]
  [../]
[]

[Modules]
  [./Peridynamics]
    [./Mechanics]
      formulation = NonOrdinaryState
      eigenstrain_names = thermal_strain
    [../]
  [../]
[]

[Kernels]
  [./strain_zz]
    type = WeakPlaneStressNOSPD
    variable = strain_zz
    eigenstrain_names = thermal_strain
  [../]

  [./heat_conduction]
    type = HeatConductionBPD
    variable = temp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e5
    poissons_ratio = 0.3
  [../]
  [./strain]
    type = PlaneSmallStrainNOSPD
    eigenstrain_names = thermal_strain
  [../]
  [./thermal_strain]
    type = ComputeThermalExpansionEigenstrain
    thermal_expansion_coeff = 1e-5
    stress_free_temperature = 0.5
    eigenstrain_name = thermal_strain
  [../]

  [./stress]
    type = ComputeLinearElasticStress
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
[]
