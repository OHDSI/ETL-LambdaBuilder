#Use this to set pertinent default values for the test cases
#' @export
setDefaults <- function (){
  set_defaults_patient(chsdate = NULL, tod = NULL, deathdate = NULL)
  set_defaults_clinical(consid = NULL, sctmaptype = NULL, sctmapversion = NULL, sctisindicative = NULL, sctisassured = NULL)

  set_defaults_consultation(consid = NULL)
  set_defaults_referral(sctmaptype = NULL, sctmapversion = NULL, sctisindicative = NULL, sctisassured = NULL)
  set_defaults_test(consid = NULL, sctmaptype = NULL, sctmapversion = NULL, sctisindicative = NULL, sctisassured = NULL, data2 = NULL, data5 = NULL, data6 = NULL, data8_value = NULL, data8_date = NULL)
  
  set_defaults_therapy(consid = NULL, prn = NULL)
  
  set_defaults_immunisation(consid = NULL, sctmaptype = NULL, sctmapversion = NULL, sctisindicative = NULL, sctisassured = NULL)
  
  set_defaults_additional(data1_date = NULL, data2_date = NULL, data3_value = NULL, data3_date = NULL, data4_value = NULL, data4_date = NULL, data5_value = NULL, data5_date = NULL, data6_value = NULL, data6_date = NULL, data7_value = NULL, data7_date = NULL, data8_value = NULL, data8_date = NULL, data9_value = NULL, data9_date = NULL, data10_value = NULL, data10_date = NULL, data11_value = NULL, data11_date = NULL, data12_value = NULL, data12_date = NULL)
  

}