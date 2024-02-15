#Use this to set pertinent default values for the test cases
#' @export
setDefaults <- function (){

  set_defaults_patient(avg_hh_income = NULL, pct_college_educ = NULL) 
  set_defaults_encounter(visitid = NULL, interaction_date = "2012-12-31")
  set_defaults_labs(collected_date = NULL, result_date = NULL, order_date = NULL)
  set_defaults_medication_administrations(admin_date = NULL)
  set_defaults_microbiology(collect_date = NULL, receive_date = NULL)
  set_defaults_nlp_measurement(measurement_year = NULL, measurement_date = NULL)
  set_defaults_nlp_sds(occurrence_year = NULL, occurrence_date = NULL)
  set_defaults_observations(result_date = NULL)
  set_defaults_prescriptions_written(daily_dose = NULL, days_supply = NULL)

}