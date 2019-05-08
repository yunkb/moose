//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "SmallStrainMaterialBaseOSPD.h"

class SmallStrainConstantHorizonOSPD;

template <>
InputParameters validParams<SmallStrainConstantHorizonOSPD>();

/**
 * Material class for ordinary state based peridynamic solid mechanics model based on regular
 * spatial discretization
 */
class SmallStrainConstantHorizonOSPD : public SmallStrainMaterialBaseOSPD
{
public:
  SmallStrainConstantHorizonOSPD(const InputParameters & parameters);

protected:
  virtual void computePDMicroModuli() override;
};
