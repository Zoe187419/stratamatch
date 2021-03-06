#----------------------------------------------------------
### CONTAINS: 
# Low-level constructors for strata objects
#----------------------------------------------------------

#' New Manual Strata
#'
#' Basic constructor for an \code{manual_strata} object. These objects hold all
#' the information associated with a dataset that has been stratified via
#' \code{\link{manual_stratify}}.  This object may be passed to
#' \code{\link{strata_match}} to be matched or it may be unpacked by the user to be
#' matched by other means.
#'
#' @param treat a string giving the name of the column where treatment
#'   information is stored
#' @param covariates a character vector with the names of the categorical
#'   columns on which to stratify
#' @param analysis_set the data set which will be stratified
#' @param call the call to \code{manual_stratify} used to generate this object
#' @param issue_table a table of each stratum and potential issues of size and
#'   treat:control balance
#' @param strata_table a table of each stratum and the covariate bin this
#'   corresponds to
#' @return a basic \code{manual_strata} object
#' @keywords internal
new_manual_strata <- function(treat = character(),
                              covariates = character(),
                              analysis_set = data.frame(),
                              call = call(),
                              issue_table = data.frame(),
                              strata_table = data.frame()){


  stopifnot(is.character(treat))
  stopifnot(is.character(covariates))
  stopifnot(is.data.frame(analysis_set))
  stopifnot(is.call(call))
  stopifnot(is.data.frame(issue_table))
  stopifnot(is.data.frame(strata_table))

  my_manualstrata <- structure(list(analysis_set = analysis_set,
                                    treat = treat,
                                    call = call,
                                    issue_table = issue_table,
                                    covariates = covariates,
                                    strata_table = strata_table),
                               class = c("manual_strata", "strata"))

  return(my_manualstrata)
}

#' New Autostrata
#'
#' Basic constructor for an \code{auto_strata} object. These objects hold all
#' the information associated with a dataset that has been stratified via
#' \code{\link{auto_stratify}}.  This object may be passed to
#' \code{\link{strata_match}} to be matched or it may be unpacked by the user to be
#' matched by other means.
#'
#' @param outcome a string giving the name of the column where outcome
#'   information is stored
#' @param treat a string giving the name of the column where treatment
#'   information is stored
#' @param analysis_set the data set which will be stratified
#' @param call the call to \code{auto_stratify} used to generate this object
#' @param issue_table a table of each stratum and potential issues of size and
#'   treat:control balance
#' @param strata_table a table of each stratum and the prognostic score quantile
#'   bin this corresponds to
#' @param prognostic_scores a vector of prognostic scores.  
#' @param prognostic_model a model for prognosis fit on a separate data set. 
#' @param pilot_set the set of controls used to fit the prognostic model.
#'   These are excluded from subsequent analysis so that the prognostic score is
#'   not overfit to the data used to estimate the treatment effect.
#'
#' @seealso \code{\link{auto_stratify}}, a function which calls this constructor
#'   to produce an \code{auto_strata} object.
#'
#' @return a basic \code{auto_strata} object
#' @keywords internal
new_auto_strata <- function(outcome, treat,
                           analysis_set = NULL,
                           call = NULL,
                           issue_table = NULL,
                           strata_table = NULL,
                           prognostic_scores = NULL,
                           prognostic_model = NULL,
                           pilot_set = NULL){

  stopifnot(is.character(outcome))
  stopifnot(is.character(treat))
  stopifnot(is.data.frame(analysis_set))
  stopifnot(is.call(call))
  stopifnot(is.data.frame(issue_table))
  stopifnot(is.data.frame(strata_table))
  stopifnot(is.numeric(prognostic_scores))

  my_autostrata <- structure(list(analysis_set = analysis_set,
                                 treat = treat,
                                 call = call,
                                 issue_table = issue_table,
                                 strata_table = strata_table,
                                 outcome = outcome,
                                 prognostic_scores = prognostic_scores,
                                 prognostic_model = prognostic_model,
                                 pilot_set = pilot_set),
                            class = c("auto_strata", "strata"))
  return(my_autostrata)
}
