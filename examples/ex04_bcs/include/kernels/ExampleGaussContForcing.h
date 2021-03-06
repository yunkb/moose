/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/
#ifndef EXAMPLEGAUSSCONTFORCING_H
#define EXAMPLEGAUSSCONTFORCING_H

#include "Kernel.h"

class ExampleGaussContForcing;

template <>
InputParameters validParams<ExampleGaussContForcing>();

class ExampleGaussContForcing : public Kernel
{
public:
  ExampleGaussContForcing(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual();

  const Real _amplitude;
  const Real _x_center;
  const Real _y_center;
  const Real _z_center;

  const Real _x_spread;
  const Real _y_spread;
  const Real _z_spread;

  const Real _x_min;
  const Real _x_max;
  const Real _y_min;
  const Real _y_max;
  const Real _z_min;
  const Real _z_max;
};

#endif // EXAMPLEGAUSSCONTFORCING_H
