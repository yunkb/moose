CDF      
      
len_string     !   len_line   Q   four      	time_step          len_name   !   num_dim       	num_nodes         num_elem   b   
num_el_blk        num_node_sets         num_el_in_blk1     b   num_nod_per_el1       num_nod_ns1       num_nod_ns2       num_nod_ns3       num_nod_ns4       num_nod_ns5       num_nod_ns6       num_nod_var       num_elem_var      num_info  @         api_version       @Д
=   version       @Д
=   floating_point_word_size            	file_size               int64_status             title         2d_ordinary_state_rc.e     maximum_name_length                    
time_whole                            v   	eb_status                             Э   eb_prop1               name      ID              Ч   	ns_status         	                        ns_prop1      	         name      ID                 coordx                      ђ      0   coordy                      ђ      ░   coordz                      ђ      	0   eb_names                       $      	░   ns_names      	                 ╚      	н   
coor_names                         d      
ю   node_num_map                    @          connect1      
            	elem_type         EDGE2              @   elem_num_map                   ѕ      P   node_ns1                          п   node_ns2                    @      У   node_ns3                          (   node_ns4                          8   node_ns5                          H   node_ns6                          X   vals_nod_var1                          ђ      v   vals_nod_var2                          ђ      vю   name_nod_var                       D      h   name_elem_var                          $      г   vals_elem_var1eb1            
                   w   elem_var_tab                             л   info_records                      e@      н                              у             ?└      ?п      ?С      ?В      ?└      ?п      ?С      ?В      ?└      ?п      ?С      ?В      ?└      ?п      ?С      ?В      ?└      ?└      ?└      ?└      ?п      ?п      ?п      ?п      ?С      ?С      ?С      ?С      ?В      ?В      ?В      ?В                                                                                                                                                                          Right                            All                              Left                             Top                              UpDiag                           Bottom                                                                                                                                                            	   
                                                            	      
                                                      	      
                                                      	      
                                          
                                          	      
                                          	      
                                                	      
                                          
                                 	   
   	      	      	      	      	      
      
      
      
      
      
                                                                                                                  	   
                                                                      !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   [   \   ]   ^   _   `   a   b                              
         	                              	                                       disp_x                           disp_y                             bond_status                            ####################                                                             # Created by MOOSE #                                                             ####################              ?­      ?№      ?­     ?­      ?­     ?­     ### Command Line Arguments ###  ?­      ?№      ?­     ?­      ?­     ?­     -i     ?№      ?­     ?№      ?­     ?­      ?­     ?­     ?­      ?­     ?2d_ordinary_state_rc.i ?­     ?­     ?­     ?­     ?­      ?№      ?­     ?№--no-gdb-backtrace    ?№      ?­     ?­      ?­     ?­     ?№      ?­     ?№      ?­      ?№      ?­     ?­      ?­     ?­     ?­     ?№      ?­     ?№  ### Version Info ###?­     ?­      ?­     ?№      ?­     ?№      ?­     ?­   Framework Information:     ?­     ?№      ?­      ?№      ?­     ?­      ?­    MOOSE version:           git commit 55b8e7b on 2017-04-04?­      ?­     ?­     PETSc Version:           3.6.3  ?­      ?­      ?№      ?­     ?­      ?№      Current Time:            Tue Apr  4 14:14:31 2017                                Executable Timestamp:    Tue Apr  4 14:13:44 2017                                                                                                                                                                                                  ### Input File ###                                                                                                                                                []                                                                                 block                          = INVALID                                         coord_type                     = XYZ                                             fe_cache                       = 0                                               kernel_coverage_check          = 1                                               material_coverage_check        = 1                                               name                           = 'MOOSE Problem'                                 restart_file_base              = INVALID                                         rz_coord_axis                  = Y                                               type                           = FEProblem                                       element_order                  = AUTO                                            order                          = AUTO                                            side_order                     = AUTO                                            control_tags                   = INVALID                                         enable                         = 1                                               error_on_jacobian_nonzero_reallocation = 0                                       force_restart                  = 0                                               near_null_space_dimension      = 0                                               null_space_dimension           = 0                                               petsc_inames                   =                                                 petsc_options                  = INVALID                                         petsc_values                   =                                                 solve                          = 1                                               transpose_null_space_dimension = 0                                               use_nonlinear                  = 1                                             []                                                                                                                                                                [AuxVariables]                                                                                                                                                      [./bond_status]                                                                    block                        = INVALID                                           family                       = MONOMIAL                                          initial_condition            = 1                                                 order                        = CONSTANT                                          outputs                      = INVALID                                           initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                         [../]                                                                          []                                                                                                                                                                [BCs]                                                                                                                                                               [./bottom_dy]                                                                      boundary                     = 2                                                 control_tags                 = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 type                         = FunctionPresetBC                                  use_displaced_mesh           = 0                                                 variable                     = disp_y                                            diag_save_in                 = INVALID                                           function                     = -0.001                                            save_in                      = INVALID                                           seed                         = 0                                               [../]                                                                                                                                                             [./left_dx]                                                                        boundary                     = 0                                                 control_tags                 = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 type                         = DirichletBC                                       use_displaced_mesh           = 0                                                 variable                     = disp_x                                            diag_save_in                 = INVALID                                           save_in                      = INVALID                                           seed                         = 0                                                 value                        = 0                                               [../]                                                                                                                                                             [./top_dy]                                                                         boundary                     = 3                                                 control_tags                 = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 type                         = DirichletBC                                       use_displaced_mesh           = 0                                                 variable                     = disp_y                                            diag_save_in                 = INVALID                                           save_in                      = INVALID                                           seed                         = 0                                                 value                        = 0                                               [../]                                                                          []                                                                                                                                                                [Executioner]                                                                      type                           = Transient                                       abort_on_solve_fail            = 0                                               compute_initial_residual_before_preset_bcs = 0                                   control_tags                   =                                                 dt                             = 1                                               dtmax                          = 1e+30                                           dtmin                          = 2e-14                                           enable                         = 1                                               end_time                       = 1                                               l_abs_step_tol                 = -1                                              l_max_its                      = 10000                                           l_tol                          = 1e-05                                           line_search                    = none                                            max_xfem_update                = 4294967295                                      n_startup_steps                = 0                                               nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-50                                           nl_max_funcs                   = 10000                                           nl_max_its                     = 50                                              nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-08                                           no_fe_reinit                   = 0                                               num_steps                      = 4294967295                                      petsc_options                  = INVALID                                         petsc_options_iname            = INVALID                                         petsc_options_value            = INVALID                                         picard_abs_tol                 = 1e-50                                           picard_max_its                 = 1                                               picard_rel_tol                 = 1e-08                                           reset_dt                       = 0                                               restart_file_base              =                                                 scheme                         = INVALID                                         solve_type                     = PJFNK                                           splitting                      = INVALID                                         ss_check_tol                   = 1e-08                                           ss_tmin                        = 0                                               start_time                     = 0                                               time_period_ends               = INVALID                                         time_period_starts             = INVALID                                         time_periods                   = INVALID                                         timestep_tolerance             = 2e-14                                           trans_ss_check                 = 0                                               use_multiapp_dt                = 0                                               verbose                        = 0                                             []                                                                                                                                                                [Executioner]                                                                      _fe_problem                    = 0x7fbc33017400                                  _fe_problem_base               = 0x7fbc33017400                                []                                                                                                                                                                [GlobalParams]                                                                     bond_status                    = bond_status                                     displacements                  = 'disp_x disp_y'                               []                                                                                                                                                                [Kernels]                                                                                                                                                           [./Peridynamics]                                                                   block                        = INVALID                                           bond_status                  = bond_status                                       diag_save_in                 = INVALID                                           displacements                = 'disp_x disp_y'                                   formulation                  = OrdinaryState                                     full_jacobian                = 0                                                 save_in                      = INVALID                                           temperature                  = INVALID                                           use_displaced_mesh           = 0                                               [../]                                                                          []                                                                                                                                                                [Materials]                                                                                                                                                         [./linelast]                                                                       type                         = ConstElasticOSPDMaterial                          block                        = INVALID                                           bond_status                  = bond_status                                       boundary                     = INVALID                                           compute                      = 1                                                 constant_on_elem             = 0                                                 control_tags                 = Materials                                         displacements                = 'disp_x disp_y'                                   enable                       = 1                                                 implicit                     = 1                                                 output_properties            = INVALID                                           outputs                      = none                                              plane_stress                 = 0                                                 poissons_ratio               = 0                                                 scalar_strain                = INVALID                                           seed                         = 0                                                 stress_free_temperature      = 273                                               temperature                  = INVALID                                           thermal_expansion_coeff      = 0                                                 use_displaced_mesh           = 0                                                 youngs_modulus               = 200000                                          [../]                                                                          []                                                                                                                                                                [Mesh]                                                                             displacements                  = 'disp_x disp_y'                                 block_id                       = INVALID                                         block_name                     = INVALID                                         boundary_id                    = INVALID                                         boundary_name                  = INVALID                                         construct_side_list_from_node_list = 0                                           ghosted_boundaries             = INVALID                                         ghosted_boundaries_inflation   = INVALID                                         patch_size                     = 40                                              second_order                   = 0                                               skip_partitioning              = 0                                               type                           = GeneratedMeshPD                                 uniform_refine                 = 0                                               R                              = 1                                               allow_renumbering              = 1                                               centroid_partitioner_direction = INVALID                                         construct_node_list_from_side_list = 1                                           control_tags                   =                                                 dim                            = 2                                               distribution                   = DEFAULT                                         enable                         = 1                                               ghost_point_neighbors          = 0                                               horizon_number                 = 3                                               horizon_size                   = INVALID                                         nemesis                        = 0                                               num_ghosted_layers             = 1                                               nx                             = 4                                               parallel_type                  = DEFAULT                                         partitioner                    = default                                         patch_update_strategy          = never                                           shape                          = 1                                               xmax                           = 1                                               xmin                           = 0                                               ymax                           = 1                                               ymin                           = 0                                               zmax                           = 1                                               zmin                           = 0                                             []                                                                                                                                                                [Mesh]                                                                           []                                                                                                                                                                [Outputs]                                                                          append_date                    = 0                                               append_date_format             = INVALID                                         checkpoint                     = 0                                               color                          = 1                                               console                        = 1                                               controls                       = 0                                               csv                            = 0                                               dofmap                         = 0                                               execute_on                     = 'INITIAL TIMESTEP_END'                          exodus                         = 1                                               file_base                      = 2d_ordinary_state_rc                            gmv                            = 0                                               gnuplot                        = 0                                               hide                           = INVALID                                         interval                       = 1                                               nemesis                        = 0                                               output_if_base_contains        = INVALID                                         print_linear_residuals         = 1                                               print_mesh_changed_info        = 0                                               print_perf_log                 = 0                                               show                           = INVALID                                         solution_history               = 0                                               sync_times                     =                                                 tecplot                        = 0                                               vtk                            = 0                                               xda                            = 0                                               xdr                            = 0                                             []                                                                                                                                                                [Preconditioning]                                                                                                                                                   [./SMP]                                                                            type                         = SMP                                               control_tags                 = Preconditioning                                   coupled_groups               = INVALID                                           enable                       = 1                                                 full                         = 1                                                 line_search                  = default                                           off_diag_column              = INVALID                                           off_diag_row                 = INVALID                                           pc_side                      = right                                             petsc_options                = INVALID                                           petsc_options_iname          = INVALID                                           petsc_options_value          = INVALID                                           solve_type                   = INVALID                                         [../]                                                                          []                                                                                                                                                                [Variables]                                                                                                                                                         [./disp_x]                                                                         block                        = INVALID                                           eigen                        = 0                                                 family                       = LAGRANGE                                          initial_condition            = INVALID                                           order                        = FIRST                                             outputs                      = INVALID                                           scaling                      = 1                                                 initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                         [../]                                                                                                                                                             [./disp_y]                                                                         block                        = INVALID                                           eigen                        = 0                                                 family                       = LAGRANGE                                          initial_condition            = INVALID                                           order                        = FIRST                                             outputs                      = INVALID                                           scaling                      = 1                                                 initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                         [../]                                                                          []                                                                                                                                                                                                                                                                                                                                                       ?­      ?№      ?­     ?­      ?­     ?­     ?№      ?­     ?№      ?­     ?­      ?№      ?­     ?­      ?­     ?­     ?­     ?№      ?­     ?№      ?­     ?­      ?­     ?­     ?­      ?­     ?№      ?­     ?№      ?­     ?­     ?­     ?­     ?­      ?№      ?­     ?№      ?­     ?­      ?№      ?­     ?­      ?­     ?­     ?№      ?­     ?№      ?­      ?№      ?­     ?­      ?­     ?­     ?­     ?№      ?­     ?№      ?­      ?­     ?­     ?­      ?­     ?№      ?­     ?№      ?­     ?­     ?­     ?­      ?№      ?­     ?№      ?­      ?№      ?­     ?­      ?­     ?­     ?­      ?№      ?­     ?­      ?­     ?­     ?­      ?­     ?­     ?­      ?­     ?­     ?­     ?­      ?­      ?№      ?­     ?­      ?№      ?­      ?­              ┐╔─ё'\┐d╩јЏ▒┐%v)─Nr        ┐E█VУ:ю┐МїSЖ┐#ћMй"сО        ┐E█UHЄ?┐МїRKLR┐#ћM╣█╩▀        ┐╔─ёМ┐┐d╩і_Й┐%v)┐IеЌ┐PbMмыЕ§┐PbMмыЕ§┐PbMмыЕ§┐PbMмыЕ§┐B'ц╠"м┐AУц┴	мъ┐AТN Cвq┐B'њџЈ б┐=9ьхМођ┐=иь╔Къ|┐=╝Џ[И]┐=:у@­                                ?­      ?№      ?­     ?­      ?­     ?­     ?№      ?­     ?№      ?­     ?­      ?№      ?­     ?­      ?­     ?­     ?­     ?№      ?­     ?№      ?­     ?­      ?­     ?­     ?­      ?­     ?№      ?­     ?№      ?­     ?­     ?­     ?­     ?­      ?№      ?­     ?№      ?­     ?­      ?№      ?­     ?­      ?­     ?­     ?№      ?­     ?№      ?­      ?№      ?­     ?­      ?­     ?­     ?­     ?№      ?­     ?№      ?­      ?­     ?­     ?­      ?­     ?№      ?­     ?№      ?­     ?­     ?­     ?­      ?№      ?­     ?№      ?­      ?№      ?­     ?­      ?­     ?­     ?­      ?№      ?­     ?­      ?­     ?­     ?­      ?­     ?­     ?­      ?­     ?­     ?­     ?­      ?­      ?№      ?­     ?­      ?№      ?­      