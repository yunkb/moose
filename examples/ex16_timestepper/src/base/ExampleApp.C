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
#include "ExampleApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

// Example 16 Includes
#include "TransientHalf.h"
#include "ExampleDiffusion.h"
#include "ExampleConvection.h"
#include "ExampleImplicitEuler.h"
#include "ExampleMaterial.h"

template <>
InputParameters
validParams<ExampleApp>()
{
  InputParameters params = validParams<MooseApp>();
  return params;
}

ExampleApp::ExampleApp(InputParameters parameters) : MooseApp(parameters)
{
  srand(processor_id());

  Moose::registerObjects(_factory);
  ExampleApp::registerObjects(_factory);

  Moose::associateSyntax(_syntax, _action_factory);
  ExampleApp::associateSyntax(_syntax, _action_factory);
}

ExampleApp::~ExampleApp() {}

void
ExampleApp::registerApps()
{
  registerApp(ExampleApp);
}

void
ExampleApp::registerObjects(Factory & factory)
{
  // Register our new executioner
  registerTimeStepper(TransientHalf);
  registerKernel(ExampleDiffusion);
  registerKernel(ExampleConvection);
  registerKernel(ExampleImplicitEuler);
  registerMaterial(ExampleMaterial);
}

void
ExampleApp::associateSyntax(Syntax & /*syntax*/, ActionFactory & /*action_factory*/)
{
}
