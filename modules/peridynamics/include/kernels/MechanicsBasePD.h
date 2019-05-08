//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef MECHANICSBASEPD_H
#define MECHANICSBASEPD_H

#include "KernelBasePD.h"
#include "DerivativeMaterialInterface.h"

class MechanicsBasePD;

template <>
InputParameters validParams<MechanicsBasePD>();

/**
 * Base kernel class for peridynamic solid mechanics models
 */
class MechanicsBasePD : public DerivativeMaterialInterface<KernelBasePD>
{
public:
  MechanicsBasePD(const InputParameters & parameters);
  virtual void computeOffDiagJacobian(MooseVariableFEBase & jvar) override;
  using Kernel::computeOffDiagJacobian;

  /**
   * Function to compute local contribution to the off-diagonal Jacobian at the current nodes
   */
  virtual void computeLocalOffDiagJacobian(unsigned int /* coupled_component */){};

  /**
   * Function to compute nonlocal contribution to the off-diagonal Jacobian at the current nodes
   */
  virtual void computePDNonlocalOffDiagJacobian(unsigned int /* jvar_num */,
                                                unsigned int /* coupled_component */){};

  virtual void initialSetup() override;
  virtual void prepare() override;

protected:
  /// displacement variables
  std::vector<MooseVariableFEBase *> _disp_var;

  ///@{ Temperature variable
  const bool _temp_coupled;
  MooseVariableFEBase * _temp_var;
  ///@}

  unsigned int _ndisp;

  ///@{ Material point based material property for eigen strains
  const std::vector<MaterialPropertyName> _eigenstrain_names;
  std::vector<const MaterialProperty<RankTwoTensor> *> _deigenstrain_dT;
  ///@}

  ///@{ Parameters for out-of-plane strain in weak plane stress formulation
  const bool _out_of_plane_strain_coupled;
  MooseVariableFEBase * _out_of_plane_strain_var;
  ///@}

  /// Vector of bond in current configuration
  const std::vector<RealGradient> * _orientation;

  /// Current variable dof numbers for nodes i and j
  std::vector<dof_id_type> _ivardofs_ij;

  /// Vector of bond in current configuration
  RealGradient _cur_ori_ij;

  /// Current bond length
  Real _cur_len_ij;
};

#endif // MECHANICSBASEPD_H
