//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef HEATSOURCEBPD_H
#define HEATSOURCEBPD_H

#include "KernelBasePD.h"

class HeatSourceBPD;

template <>
InputParameters validParams<HeatSourceBPD>();

/**
 * Kernel class to implement hear source term for peridynamic heat conduction models
 */
class HeatSourceBPD : public KernelBasePD
{
public:
  HeatSourceBPD(const InputParameters & parameters);

protected:
  virtual void computeLocalResidual() override;

  ///@{ Power density values
  double _power_density;
  Function * _power_density_function;
  ///@}
};

#endif // HEATSOURCEBPD_H
