/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/

#include "EFAFaceNode.h"

#include "EFANode.h"
#include "EFAError.h"

EFAFaceNode::EFAFaceNode(EFANode * node, double xi, double eta) : _node(node), _xi(xi), _eta(eta) {}

EFAFaceNode::EFAFaceNode(const EFAFaceNode & other_face_node)
  : _node(other_face_node._node), _xi(other_face_node._xi), _eta(other_face_node._eta)
{
}

EFAFaceNode::~EFAFaceNode() {}

EFANode *
EFAFaceNode::getNode()
{
  return _node;
}

double
EFAFaceNode::getParametricCoordinates(unsigned int i)
{
  double coord = -100.0;
  if (i == 0)
    coord = _xi;
  else if (i == 1)
    coord = _eta;
  else
    EFAError("get_getParametricCoordinates input out of bounds");

  return coord;
}

void
EFAFaceNode::switchNode(EFANode * new_node, EFANode * old_node)
{
  if (_node == old_node)
    _node = new_node;
}
