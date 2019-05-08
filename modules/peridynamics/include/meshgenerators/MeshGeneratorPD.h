//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef MESHGENERATORPD_H
#define MESHGENERATORPD_H

#include "MeshGenerator.h"

// Forward declarations
class MeshGeneratorPD;

template <>
InputParameters validParams<MeshGeneratorPD>();

/**
 * Generate peridynamics mesh based on finite element mesh
 */
class MeshGeneratorPD : public MeshGenerator
{
public:
  MeshGeneratorPD(const InputParameters & parameters);

  /**
   * Function to convert the finite element mesh to peridynamics mesh
   * @return The converted mesh
   */
  std::unique_ptr<MeshBase> generate();

protected:
  /// Reference to the input finite element mesh
  std::unique_ptr<MeshBase> & _input;

  /// flag to specify whether the FE mesh should be retained or not
  /// in addition to newly created PD mesh
  bool _retain_fe_mesh;
};

#endif // MESHGENERATORPD_H
