#Use this to set pertinent default values for the test cases
#' @export
setDefaults <- function (){
  set_defaults_drug_claims(metqty = '0', daysupp = '30')
  set_defaults_inpatient_admissions(admdate = '2012-01-01', disdate = '2012-12-31', year = '2012', proc2 = NULL)
  
  
  if (Sys.getenv("truvenType") == "MDCD")
  {
    set_defaults_enrollment_detail(drugcovg = '1')
  }
  
  if (Sys.getenv("truvenType") == "CCAE")
  {
    set_defaults_enrollment_detail(indstry = '1')
    set_defaults_enrollment_detail(efamid = '0')
    
    set_defaults_enrollment_detail(wgtkey = '0')
    set_defaults_enrollment_detail(seqnum = '0')
    set_defaults_enrollment_detail(plankey = '0')
    set_defaults_facility_header(stdprov = '0')
  }
}