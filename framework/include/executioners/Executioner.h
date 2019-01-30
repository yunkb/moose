//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef EXECUTIONER_H
#define EXECUTIONER_H

#include "MooseObject.h"
#include "UserObjectInterface.h"
#include "PostprocessorInterface.h"
#include "Restartable.h"
#include "PerfGraphInterface.h"

// System includes
#include <string>

class Problem;
class Executioner;

template <>
InputParameters validParams<Executioner>();

/**
 * Executioners are objects that do the actual work of solving your problem.
 *
 * In general there are two "sets" of Executioners: Steady and Transient.
 *
 * The Difference is that a Steady Executioner usually only calls "solve()"
 * for the NonlinearSystem once... where Transient Executioners call solve()
 * multiple times... i.e. once per timestep.
 */
class Executioner : public MooseObject,
                    public UserObjectInterface,
                    public PostprocessorInterface,
                    public Restartable,
                    public PerfGraphInterface
{
public:
  /**
   * Constructor
   *
   * @param parameters The parameters object holding data for the class to use.
   */
  Executioner(const InputParameters & parameters);

  virtual ~Executioner();

  /**
   * Initialize the executioner
   */
  virtual void init();

  /**
   * Pure virtual execute function MUST be overridden by children classes.
   * This is where the Executioner actually does it's work.
   */
  virtual void execute() = 0;

  /**
   * Override this for actions that should take place before execution
   */
  virtual void preExecute();

  /**
   * Override this for actions that should take place after execution
   */
  virtual void postExecute();

  /**
   * Override this for actions that should take place before execution
   */
  virtual void preSolve();

  /**
   * Override this for actions that should take place after execution
   */
  virtual void postSolve();

  /**
   * Deprecated:
   * Return a reference to this Executioner's Problem instance
   */
  virtual Problem & problem();

  /**
   * Return a reference to this Executioner's FEProblemBase instance
   */
  FEProblemBase & feProblem();

  /** The name of the TimeStepper
   * This is an empty string for non-Transient executioners
   * @return A string of giving the TimeStepper name
   */
  virtual std::string getTimeStepperName();

  /**
   * Can be used by subsclasses to call parentOutputPositionChanged()
   * on the underlying FEProblemBase.
   */
  virtual void parentOutputPositionChanged() {}

  /**
   * Whether or not the last solve converged.
   */
  virtual bool lastSolveConverged();

  class PicardSolve : public MooseObject, public PerfGraphInterface
  {
  public:
    PicardSolve(const InputParameters & parameters);

    /**
     * Picard solve the FEProblem.
     * @return True if solver is converged.
     */
    bool solve();

    /// Enumeration for Picard convergence reasons
    enum class MoosePicardConvergenceReason
    {
      UNSOLVED = 0,
      CONVERGED_NONLINEAR = 1,
      CONVERGED_ABS = 2,
      CONVERGED_RELATIVE = 3,
      CONVERGED_CUSTOM = 4,
      DIVERGED_MAX_ITS = -1,
      DIVERGED_NONLINEAR = -2,
      DIVERGED_FAILED_MULTIAPP = -3
    };

    /**
     * Get the number of Picard iterations performed
     * Because this returns the number of Picard iterations, rather than the current
     * iteration count (which starts at 0), increment by 1.
     *
     * @return Number of Picard iterations performed
     */
    unsigned int numPicardIts() const { return _picard_it + 1; }

    /// Check the solver status
    MoosePicardConvergenceReason checkConvergence() const { return _picard_status; }

    /// This function checks the _xfem_repeat_step flag set by solve.
    bool XFEMRepeatStep() const { return _xfem_repeat_step; }

    /// Clear Picard status
    void clearPicardStatus() { _picard_status = MoosePicardConvergenceReason::UNSOLVED; }

    /// Whether or not this has Picard iterations
    bool hasPicardIteration() { return _has_picard_its; }

  protected:
    /**
     * Perform one Picard iteration or a full solve.
     *
     * @param begin_norm_old Residual norm after timestep_begin execution of previous Picard
     * iteration
     * @param begin_norm     Residual norm after timestep_begin execution
     * @param end_norm_old   Residual norm after timestep_end execution of previous Picard iteration
     * @param end_norm       Residual norm after timestep_end execution
     * @param relax          Whether or not we do relaxation in this iteration
     * @param relaxed_dofs   DoFs to be relaxed
     *
     * @return True if both nonlinear solve and the execution of multiapps are successful.
     *
     * Note: this function also set _xfem_repeat_step flag for XFEM. It tracks _xfem_update_count
     * state.
     * FIXME: The proper design will be to let XFEM use Picard iteration to control the execution.
     */
    bool solveStep(Real begin_norm_old,
                   Real & begin_norm,
                   Real end_norm_old,
                   Real & end_norm,
                   bool relax,
                   const std::set<dof_id_type> & relaxed_dofs);

    /// Reference to FEProblem
    FEProblemBase & _problem;
    /// Reference to nonlinear system base for faster access
    NonlinearSystemBase & _nl;

    /// Maximum Picard iterations
    unsigned int _picard_max_its;
    /// Whether or not we activate Picard iteration
    bool _has_picard_its;
    /// Relative tolerance on residual norm
    Real _picard_rel_tol;
    /// Absolute tolerance on residual norm
    Real _picard_abs_tol;
    /// Whether or not we force evaluation of residual norms even without multiapps
    bool _picard_force_norms;
    /// Relaxation factor for Picard Iteration
    Real _relax_factor;
    /// The transferred variables that are going to be relaxed
    std::vector<std::string> _relaxed_vars;

    /// Maximum number of xfem updates per step
    unsigned int _max_xfem_update;
    /// Controls whether xfem should update the mesh at the beginning of the time step
    bool _update_xfem_at_timestep_begin;

  private:
    const PerfID _picard_timer;

    ///@{ Variables used by the Picard iteration
    /// Picard iteration counter
    unsigned int _picard_it;
    /// Initial residual norm
    Real _picard_initial_norm;
    /// Full history of residual norm after evaluation of timestep_begin
    std::vector<Real> _picard_timestep_begin_norm;
    /// Full history of residual norm after evaluation of timestep_end
    std::vector<Real> _picard_timestep_end_norm;
    /// Status of Picard solve
    MoosePicardConvergenceReason _picard_status;

    /// Counter for number of xfem updates that have been performed in the current step
    unsigned int _xfem_update_count;
    /// Whether step should be repeated due to xfem modifying the mesh
    bool _xfem_repeat_step;
  };

  PicardSolve & picardSolve() { return _picard_solve; }

protected:
  /**
   * Adds a postprocessor to report a Real class attribute
   * @param name The name of the postprocessor to create
   * @param attribute The Real class attribute to report
   * @param execute_on When to execute the postprocessor that is created
   */
  virtual void addAttributeReporter(const std::string & name,
                                    Real & attribute,
                                    const std::string execute_on = "");

  FEProblemBase & _fe_problem;

  PicardSolve _picard_solve;

  /// Initial Residual Variables
  Real _initial_residual_norm;
  Real _old_initial_residual_norm;

  // Restart
  std::string _restart_file_base;

  // Splitting
  std::vector<std::string> _splitting;
};

#endif // EXECUTIONER_H
