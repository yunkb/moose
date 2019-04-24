//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef SMALLSTRAINVARIABLEHORIZONOSPD_H
#define SMALLSTRAINVARIABLEHORIZONOSPD_H

#include "SmallStrainMaterialBaseOSPD.h"

class SmallStrainVariableHorizonOSPD;

template <>
InputParameters validParams<SmallStrainVariableHorizonOSPD>();

/**
 * Material class for ordinary state based peridynamic solid mechanics model based on irregular
 * spatial discretization
 */
class SmallStrainVariableHorizonOSPD : public SmallStrainMaterialBaseOSPD
{
public:
  SmallStrainVariableHorizonOSPD(const InputParameters & parameters);

protected:
  virtual void computePDMicroModuli() override;
};

#endif // SMALLSTRAINVARIABLEHORIZONOSPD_H