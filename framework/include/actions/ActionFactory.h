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

#ifndef ACTIONFACTORY_H
#define ACTIONFACTORY_H

#include <vector>
#include <map>
#include <set>

#include "Action.h"
#include "InputParameters.h"
#include "ActionWarehouse.h"


/**
 * Macros
 */
#define stringifyName(name) #name
#define registerAction(tplt, action)                  action_factory.reg<tplt>(stringifyName(tplt), action)
#define registerActionName(name, is_required)         syntax.registerName(name, is_required)
#define addActionNameDependency(action, depends_on)   syntax.addDependency(action, depends_on)

// Forward Declaration
class ActionFactory;
class MooseApp;

/**
 * Typedef for function to build objects
 */
typedef Action * (*buildActionPtr)(const std::string & name, InputParameters parameters);

/**
 * Typedef for validParams
 */
typedef InputParameters (*paramsActionPtr)();


/**
 * Build an object of type T
 */
template<class T>
Action * buildAction(const std::string & name, InputParameters parameters)
{
  return new T(name, parameters);
}

/**
 * Specialized factory for generic Action System objects
 */
class ActionFactory
{
public:
  ActionFactory(MooseApp & app);

  virtual ~ActionFactory();

  template<typename T>
  void reg(const std::string & name, const std::string & action_name)
  {
    BuildInfo build_info;
    build_info._build_pointer = &buildAction<T>;
    build_info._params_pointer = &validParams<T>;
    build_info._action_name = action_name;
    build_info._unique_id = _unique_id++;
    _name_to_build_info.insert(std::make_pair(name, build_info));

    _action_to_name_map.insert(std::make_pair(action_name, name));
  }

  std::string getActionName(const std::string & action);

  Action * create(const std::string & action, const std::string & name, InputParameters params);

  InputParameters getValidParams(const std::string & name);

  class BuildInfo
  {
  public:
    buildActionPtr _build_pointer;
    paramsActionPtr _params_pointer;
    std::string _action_name;
    unsigned int _unique_id;
  };

  /// Typedef for registered Action iterator
  typedef std::multimap<std::string, BuildInfo>::iterator iterator;
  typedef std::multimap<std::string, BuildInfo>::const_iterator const_iterator;

  iterator begin();
  const_iterator begin() const;

  iterator end();
  const_iterator end() const;

  std::pair<std::multimap<std::string, std::string>::iterator, std::multimap<std::string, std::string>::iterator> getA(const std::string & action_name);

  std::multimap<std::string, BuildInfo> _name_to_build_info;

  std::multimap<std::string, std::string> _action_to_name_map;

  std::vector<std::string> _registered_parser_block_names;

  // TODO: I don't think we need this anymore
  static unsigned int _unique_id;        ///< Unique ID for identifying multiple registrations

protected:
  MooseApp & _app;
};

// -----------------------------------------------------------------------------
// ActionFactory class inline methods
inline
ActionFactory::iterator ActionFactory::begin()
{
  return _name_to_build_info.begin();
}

inline
ActionFactory::const_iterator ActionFactory::begin() const
{
  return _name_to_build_info.begin();
}

inline
ActionFactory::iterator ActionFactory::end()
{
  return _name_to_build_info.end();
}

inline
ActionFactory::const_iterator ActionFactory::end() const
{
  return _name_to_build_info.end();
}

inline
std::pair<std::multimap<std::string, std::string>::iterator, std::multimap<std::string, std::string>::iterator>
ActionFactory::getA(const std::string & action_name)
{
  return _action_to_name_map.equal_range(action_name);
}

#endif /* ACTIONFACTORY_H */
