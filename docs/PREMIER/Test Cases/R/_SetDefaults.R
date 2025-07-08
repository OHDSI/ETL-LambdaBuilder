#Use this to set pertinent default values for the test cases
#' @export
setDefaults <- function (){
  set_defaults_patbill(serv_date = NULL)
  set_defaults_pat(age = 33)
  set_defaults_paticd_proc(proc_date = NULL)
  set_defaults_patcpt(proc_date = NULL)
}