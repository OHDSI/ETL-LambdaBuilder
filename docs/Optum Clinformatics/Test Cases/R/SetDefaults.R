#Use this to set pertinent default values for the test cases
#' @export
setDefaults <- function (){

set_defaults_medical_claims(paid_dt = NULL, op_visit_id = NULL, ndc_qty = NULL)
set_defaults_member_enrollment(family_id = NULL)
set_defaults_provider(grp_practice = NULL, hosp_affil = NULL)

}