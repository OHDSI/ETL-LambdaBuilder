initFramework <- function() {
  frameworkContext <- new.env(parent = globalenv())
  class(frameworkContext) <- 'frameworkContext'
  assign('frameworkContext', frameworkContext, envir = globalenv())
  frameworkContext$inserts <- list()
  frameworkContext$expects <- list()
  frameworkContext$testId <- -1
  frameworkContext$testDescription <- ""
  frameworkContext$defaultValues <- new.env(parent = frameworkContext)

  defaults <- list()
  defaults$point_of_origin <- ''
  defaults$point_of_origin_desc <- ''
  assign('poorigin', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  assign('lookup_datadictionary', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$adm_type <- ''
  defaults$adm_type_desc <- ''
  assign('admtype', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$hosp_chg_id <- ''
  defaults$hosp_chg_desc <- 'HC CBC W/ AUTO DIFFERENTIAL'
  assign('hospchg', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- ''
  defaults$medrec_key <- ''
  defaults$apr_drg <- '0'
  defaults$apr_sev <- '0'
  defaults$apr_mort <- '0'
  assign('pataprdrg', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$disc_status <- ''
  defaults$disc_status_desc <- ''
  assign('disstat', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$ms_drg <- ''
  defaults$ms_drg_desc <- ''
  assign('msdrg', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- '203064414'
  defaults$specimen_id <- '67104654'
  defaults$collection_datetime <- '2012-10-09 08:00:00'
  defaults$result_organism <- 'Escherichia coli'
  defaults$susc_test_method_code <- ''
  defaults$test_method <- 'MIC'
  defaults$susc_test_method_code_type <- 'Non-Standard'
  defaults$medication <- 'gentamicin'
  defaults$susc_test_result_datetime <- '2009-06-11 21:05:00'
  defaults$rsv_result <- ''
  defaults$interpretation <- 'S'
  defaults$data_source_ind <- '3'
  assign('lab_sens_result', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$phy_spec <- ''
  defaults$phy_spec_desc <- ''
  assign('physpec', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- ''
  defaults$adm_date <- '2020-02-10'
  defaults$disc_mon <- '2021309'
  defaults$disc_date <- '2021-09-30'
  defaults$prov_id <- '1784'
  defaults$i_o_ind <- 'O'
  defaults$pat_type <- '28'
  defaults$point_of_origin <- '1'
  defaults$adm_type <- '3'
  defaults$disc_status <- '1'
  defaults$mart_status <- 'S'
  defaults$age <- '0'
  defaults$gender <- 'F'
  defaults$race <- 'W'
  defaults$admphy_spec <- '900'
  defaults$adm_phy <- '999999999'
  defaults$attphy_spec <- '4028'
  defaults$att_phy <- '35227191'
  defaults$std_payor <- '360'
  defaults$los <- '0'
  defaults$pat_charges <- '100.00'
  defaults$pat_cost <- '0.00'
  defaults$pat_fix_cost <- '0.00'
  defaults$pat_var_cost <- '0.00'
  defaults$medrec_key <- ''
  defaults$ms_drg <- '0'
  defaults$ms_drg_mdc <- '0000'
  defaults$hispanic_ind <- 'N'
  defaults$publish_type <- 'CP'
  assign('pat', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- '146818535'
  defaults$specimen_id <- ''
  defaults$collection_datetime <- '2010-10-13'
  defaults$specimen_source_code <- ''
  defaults$specimen_source <- 'blood'
  defaults$body_site_category_code <- ''
  defaults$body_site_category_desc <- ''
  defaults$lab_test_code <- ''
  defaults$test <- 'Blood culture'
  defaults$lab_test_code_type <- 'Non-Standard'
  defaults$lab_test_result_datetime <- ''
  defaults$observation <- 'negative'
  defaults$observation_category <- 'FINAL'
  defaults$data_source_ind <- '3'
  assign('lab_result', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- ''
  defaults$cpt_code <- '36415'
  defaults$cpt_pos <- '1'
  defaults$proc_date <- ''
  defaults$cpt_order_phy <- '999999999'
  defaults$cpt_order_phy_spec <- '900'
  defaults$cpt_proc_phy <- '999999999'
  defaults$cpt_proc_phy_spec <- '900'
  defaults$cpt_mod_code_1 <- ''
  defaults$cpt_mod_code_2 <- ''
  defaults$cpt_mod_code_3 <- ''
  defaults$cpt_mod_code_4 <- ''
  assign('patcpt', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$std_chg_code <- ''
  defaults$std_chg_desc <- ''
  defaults$clin_dtl_code <- '270270003100000'
  defaults$clin_dtl_desc <- 'BLADE'
  defaults$clin_sum_code <- '980100'
  defaults$clin_sum_desc <- 'PRO FEE'
  defaults$std_dept_code <- '360'
  defaults$std_dept_desc <- 'SURGERY'
  defaults$sum_dept_desc <- 'OR'
  defaults$prod_cat_code <- '99999'
  defaults$prod_cat_desc <- 'Unknown'
  defaults$prod_class_code <- '99999'
  defaults$prod_class_desc <- 'Unknown'
  defaults$prod_name_code <- '99999999999'
  defaults$prod_name_desc <- 'Unknown'
  defaults$prod_name_meth_code <- '999999999999'
  defaults$prod_name_meth_desc <- 'Unknown'
  assign('chgmstr', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_type <- ''
  defaults$pat_type_desc <- ''
  assign('pattype', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$version_id <- ''
  defaults$version_date <- ''
  assign('version', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- ''
  defaults$icd_version <- '10'
  defaults$icd_code <- 'I10'
  defaults$icd_pri_sec <- 'S'
  defaults$icd_poa <- '9'
  assign('paticd_diag', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- ''
  defaults$std_chg_code <- '110229000020000'
  defaults$hosp_chg_id <- '133918884'
  defaults$serv_date <- ''
  defaults$hosp_qty <- '1.00'
  defaults$std_qty <- '1.00'
  defaults$bill_charges <- '0.00'
  defaults$bill_cost <- '0.00'
  defaults$bill_var_cost <- '0.00'
  defaults$bill_fix_cost <- '0.00'
  assign('patbill', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$ms_drg_mdc <- ''
  defaults$ms_drg_mdc_desc <- ''
  assign('msdrgmdc', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$std_payor <- ''
  defaults$std_payor_desc <- ''
  assign('payor', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- '1543943384'
  defaults$facility_test_name <- 'Respiratory Rate'
  defaults$observation_datetime <- '2021-09-12 20:00:00'
  defaults$result_datetime <- '2021-09-12 20:00:00'
  defaults$lab_test_loinc_code <- '8867-4'
  defaults$lab_test <- 'Heart rate:NRat:Pt:XXX:Qn'
  defaults$lab_test_code_type <- 'LOINC'
  defaults$lab_test_result <- '100'
  defaults$lab_test_result_unit <- ''
  defaults$lab_test_result_status <- 'F'
  defaults$numeric_value_operator <- ''
  defaults$test_result_numeric_value <- ''
  defaults$abnormal_flag <- 'No abnormal flag'
  assign('vitals', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$icd_version <- '10'
  defaults$icd_code <- ''
  defaults$icd_desc <- 'FX OLECRAN PROCS SUBSQ DELY HEAL'
  defaults$ccs_cat_level1_code <- '999999'
  defaults$ccs_cat_level1_desc <- 'N/A'
  defaults$ccs_cat_level2_code <- '999999'
  defaults$ccs_cat_level2_desc <- 'N/A'
  defaults$icd_diag_proc <- 'P'
  defaults$icd_diag_proc_desc <- 'Procedure'
  assign('icdcode', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$prov_id <- '1091'
  defaults$disc_mon <- '2020101'
  defaults$ip_dx_count <- '0'
  defaults$op_dx_count <- '0'
  defaults$all_dx_count <- '1'
  defaults$ip_min_dx_date <- ''
  defaults$op_min_dx_date <- ''
  defaults$all_min_dx_date <- '2020-01-01'
  defaults$ip_max_dx_date <- ''
  defaults$op_max_dx_date <- ''
  defaults$all_max_dx_date <- '2019-07-31'
  defaults$ip_proj_wgt <- '0.0'
  assign('prov_enrollment', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- '1165158958'
  defaults$order_key <- ''
  defaults$collection_datetime <- ''
  defaults$specimen_source_snomed_code <- '119297000'
  defaults$specimen_source_snomed_desc <- 'Blood specimen'
  defaults$lab_test_loinc_code <- '2345-7'
  defaults$lab_test_loinc_desc <- 'Glucose:MCnc:Pt:Ser/Plas:Qn'
  defaults$lab_test_code_type <- 'LOINC'
  defaults$lab_test_result_datetime <- ''
  defaults$lab_test_result <- 'Negative'
  defaults$result_unit <- 'mg/dL'
  defaults$lab_test_result_status <- 'F'
  defaults$reference_interval <- ''
  defaults$numeric_value <- ''
  defaults$numeric_value_operator <- ''
  defaults$flags <- ''
  assign('genlab', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$apr_drg <- ''
  defaults$apr_drg_desc <- ''
  assign('aprdrg', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$prov_id <- ''
  defaults$urban_rural <- 'URBAN'
  defaults$teaching <- 'NO'
  defaults$beds_grp <- '000-099'
  defaults$prov_region <- 'SOUTH'
  defaults$prov_division <- 'SOUTH ATLANTIC'
  defaults$cost_type <- 'PROCEDURAL'
  assign('providers', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$pat_key <- ''
  defaults$icd_version <- '9'
  defaults$icd_code <- '99.29'
  defaults$icd_pri_sec <- 'S'
  defaults$proc_date <- ''
  defaults$proc_phy <- '999999999'
  defaults$procphy_spec <- '900'
  assign('paticd_proc', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$cpt_code <- ''
  defaults$cpt_desc <- 'RADIATION TREATMENT DELIVERY'
  assign('cptcode', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$icd_poa <- ''
  defaults$icd_poa_desc <- ''
  defaults$icd_poa_sum_desc <- ''
  assign('icdpoa', defaults, envir = frameworkContext$defaultValues)

  frameworkContext$sourceFieldsMapped <- c(
  )

  frameworkContext$targetFieldsMapped <- c(
  )

  frameworkContext$sourceFieldsTested <- c()
  frameworkContext$targetFieldsTested <- c()
}

initFramework()

set_defaults_poorigin <- function(point_of_origin, point_of_origin_desc) {
  defaults <- get('poorigin', envir = frameworkContext$defaultValues)
  if (!missing(point_of_origin)) {
    defaults$point_of_origin <- point_of_origin
  }
  if (!missing(point_of_origin_desc)) {
    defaults$point_of_origin_desc <- point_of_origin_desc
  }
  assign('poorigin', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_lookup_datadictionary <- function() {
  defaults <- get('lookup_datadictionary', envir = frameworkContext$defaultValues)
  assign('lookup_datadictionary', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_admtype <- function(adm_type, adm_type_desc) {
  defaults <- get('admtype', envir = frameworkContext$defaultValues)
  if (!missing(adm_type)) {
    defaults$adm_type <- adm_type
  }
  if (!missing(adm_type_desc)) {
    defaults$adm_type_desc <- adm_type_desc
  }
  assign('admtype', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_hospchg <- function(hosp_chg_id, hosp_chg_desc) {
  defaults <- get('hospchg', envir = frameworkContext$defaultValues)
  if (!missing(hosp_chg_id)) {
    defaults$hosp_chg_id <- hosp_chg_id
  }
  if (!missing(hosp_chg_desc)) {
    defaults$hosp_chg_desc <- hosp_chg_desc
  }
  assign('hospchg', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_pataprdrg <- function(pat_key, medrec_key, apr_drg, apr_sev, apr_mort) {
  defaults <- get('pataprdrg', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(medrec_key)) {
    defaults$medrec_key <- medrec_key
  }
  if (!missing(apr_drg)) {
    defaults$apr_drg <- apr_drg
  }
  if (!missing(apr_sev)) {
    defaults$apr_sev <- apr_sev
  }
  if (!missing(apr_mort)) {
    defaults$apr_mort <- apr_mort
  }
  assign('pataprdrg', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_disstat <- function(disc_status, disc_status_desc) {
  defaults <- get('disstat', envir = frameworkContext$defaultValues)
  if (!missing(disc_status)) {
    defaults$disc_status <- disc_status
  }
  if (!missing(disc_status_desc)) {
    defaults$disc_status_desc <- disc_status_desc
  }
  assign('disstat', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_msdrg <- function(ms_drg, ms_drg_desc) {
  defaults <- get('msdrg', envir = frameworkContext$defaultValues)
  if (!missing(ms_drg)) {
    defaults$ms_drg <- ms_drg
  }
  if (!missing(ms_drg_desc)) {
    defaults$ms_drg_desc <- ms_drg_desc
  }
  assign('msdrg', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_lab_sens_result <- function(pat_key, specimen_id, collection_datetime, result_organism, susc_test_method_code, test_method, susc_test_method_code_type, medication, susc_test_result_datetime, rsv_result, interpretation, data_source_ind) {
  defaults <- get('lab_sens_result', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(specimen_id)) {
    defaults$specimen_id <- specimen_id
  }
  if (!missing(collection_datetime)) {
    defaults$collection_datetime <- collection_datetime
  }
  if (!missing(result_organism)) {
    defaults$result_organism <- result_organism
  }
  if (!missing(susc_test_method_code)) {
    defaults$susc_test_method_code <- susc_test_method_code
  }
  if (!missing(test_method)) {
    defaults$test_method <- test_method
  }
  if (!missing(susc_test_method_code_type)) {
    defaults$susc_test_method_code_type <- susc_test_method_code_type
  }
  if (!missing(medication)) {
    defaults$medication <- medication
  }
  if (!missing(susc_test_result_datetime)) {
    defaults$susc_test_result_datetime <- susc_test_result_datetime
  }
  if (!missing(rsv_result)) {
    defaults$rsv_result <- rsv_result
  }
  if (!missing(interpretation)) {
    defaults$interpretation <- interpretation
  }
  if (!missing(data_source_ind)) {
    defaults$data_source_ind <- data_source_ind
  }
  assign('lab_sens_result', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_physpec <- function(phy_spec, phy_spec_desc) {
  defaults <- get('physpec', envir = frameworkContext$defaultValues)
  if (!missing(phy_spec)) {
    defaults$phy_spec <- phy_spec
  }
  if (!missing(phy_spec_desc)) {
    defaults$phy_spec_desc <- phy_spec_desc
  }
  assign('physpec', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_pat <- function(pat_key, adm_date, disc_mon, disc_date, prov_id, i_o_ind, pat_type, point_of_origin, adm_type, disc_status, mart_status, age, gender, race, admphy_spec, adm_phy, attphy_spec, att_phy, std_payor, los, pat_charges, pat_cost, pat_fix_cost, pat_var_cost, medrec_key, ms_drg, ms_drg_mdc, hispanic_ind, publish_type) {
  defaults <- get('pat', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(adm_date)) {
    defaults$adm_date <- adm_date
  }
  if (!missing(disc_mon)) {
    defaults$disc_mon <- disc_mon
  }
  if (!missing(disc_date)) {
    defaults$disc_date <- disc_date
  }
  if (!missing(prov_id)) {
    defaults$prov_id <- prov_id
  }
  if (!missing(i_o_ind)) {
    defaults$i_o_ind <- i_o_ind
  }
  if (!missing(pat_type)) {
    defaults$pat_type <- pat_type
  }
  if (!missing(point_of_origin)) {
    defaults$point_of_origin <- point_of_origin
  }
  if (!missing(adm_type)) {
    defaults$adm_type <- adm_type
  }
  if (!missing(disc_status)) {
    defaults$disc_status <- disc_status
  }
  if (!missing(mart_status)) {
    defaults$mart_status <- mart_status
  }
  if (!missing(age)) {
    defaults$age <- age
  }
  if (!missing(gender)) {
    defaults$gender <- gender
  }
  if (!missing(race)) {
    defaults$race <- race
  }
  if (!missing(admphy_spec)) {
    defaults$admphy_spec <- admphy_spec
  }
  if (!missing(adm_phy)) {
    defaults$adm_phy <- adm_phy
  }
  if (!missing(attphy_spec)) {
    defaults$attphy_spec <- attphy_spec
  }
  if (!missing(att_phy)) {
    defaults$att_phy <- att_phy
  }
  if (!missing(std_payor)) {
    defaults$std_payor <- std_payor
  }
  if (!missing(los)) {
    defaults$los <- los
  }
  if (!missing(pat_charges)) {
    defaults$pat_charges <- pat_charges
  }
  if (!missing(pat_cost)) {
    defaults$pat_cost <- pat_cost
  }
  if (!missing(pat_fix_cost)) {
    defaults$pat_fix_cost <- pat_fix_cost
  }
  if (!missing(pat_var_cost)) {
    defaults$pat_var_cost <- pat_var_cost
  }
  if (!missing(medrec_key)) {
    defaults$medrec_key <- medrec_key
  }
  if (!missing(ms_drg)) {
    defaults$ms_drg <- ms_drg
  }
  if (!missing(ms_drg_mdc)) {
    defaults$ms_drg_mdc <- ms_drg_mdc
  }
  if (!missing(hispanic_ind)) {
    defaults$hispanic_ind <- hispanic_ind
  }
  if (!missing(publish_type)) {
    defaults$publish_type <- publish_type
  }
  assign('pat', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_lab_result <- function(pat_key, specimen_id, collection_datetime, specimen_source_code, specimen_source, body_site_category_code, body_site_category_desc, lab_test_code, test, lab_test_code_type, lab_test_result_datetime, observation, observation_category, data_source_ind) {
  defaults <- get('lab_result', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(specimen_id)) {
    defaults$specimen_id <- specimen_id
  }
  if (!missing(collection_datetime)) {
    defaults$collection_datetime <- collection_datetime
  }
  if (!missing(specimen_source_code)) {
    defaults$specimen_source_code <- specimen_source_code
  }
  if (!missing(specimen_source)) {
    defaults$specimen_source <- specimen_source
  }
  if (!missing(body_site_category_code)) {
    defaults$body_site_category_code <- body_site_category_code
  }
  if (!missing(body_site_category_desc)) {
    defaults$body_site_category_desc <- body_site_category_desc
  }
  if (!missing(lab_test_code)) {
    defaults$lab_test_code <- lab_test_code
  }
  if (!missing(test)) {
    defaults$test <- test
  }
  if (!missing(lab_test_code_type)) {
    defaults$lab_test_code_type <- lab_test_code_type
  }
  if (!missing(lab_test_result_datetime)) {
    defaults$lab_test_result_datetime <- lab_test_result_datetime
  }
  if (!missing(observation)) {
    defaults$observation <- observation
  }
  if (!missing(observation_category)) {
    defaults$observation_category <- observation_category
  }
  if (!missing(data_source_ind)) {
    defaults$data_source_ind <- data_source_ind
  }
  assign('lab_result', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_patcpt <- function(pat_key, cpt_code, cpt_pos, proc_date, cpt_order_phy, cpt_order_phy_spec, cpt_proc_phy, cpt_proc_phy_spec, cpt_mod_code_1, cpt_mod_code_2, cpt_mod_code_3, cpt_mod_code_4) {
  defaults <- get('patcpt', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(cpt_code)) {
    defaults$cpt_code <- cpt_code
  }
  if (!missing(cpt_pos)) {
    defaults$cpt_pos <- cpt_pos
  }
  if (!missing(proc_date)) {
    defaults$proc_date <- proc_date
  }
  if (!missing(cpt_order_phy)) {
    defaults$cpt_order_phy <- cpt_order_phy
  }
  if (!missing(cpt_order_phy_spec)) {
    defaults$cpt_order_phy_spec <- cpt_order_phy_spec
  }
  if (!missing(cpt_proc_phy)) {
    defaults$cpt_proc_phy <- cpt_proc_phy
  }
  if (!missing(cpt_proc_phy_spec)) {
    defaults$cpt_proc_phy_spec <- cpt_proc_phy_spec
  }
  if (!missing(cpt_mod_code_1)) {
    defaults$cpt_mod_code_1 <- cpt_mod_code_1
  }
  if (!missing(cpt_mod_code_2)) {
    defaults$cpt_mod_code_2 <- cpt_mod_code_2
  }
  if (!missing(cpt_mod_code_3)) {
    defaults$cpt_mod_code_3 <- cpt_mod_code_3
  }
  if (!missing(cpt_mod_code_4)) {
    defaults$cpt_mod_code_4 <- cpt_mod_code_4
  }
  assign('patcpt', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_chgmstr <- function(std_chg_code, std_chg_desc, clin_dtl_code, clin_dtl_desc, clin_sum_code, clin_sum_desc, std_dept_code, std_dept_desc, sum_dept_desc, prod_cat_code, prod_cat_desc, prod_class_code, prod_class_desc, prod_name_code, prod_name_desc, prod_name_meth_code, prod_name_meth_desc) {
  defaults <- get('chgmstr', envir = frameworkContext$defaultValues)
  if (!missing(std_chg_code)) {
    defaults$std_chg_code <- std_chg_code
  }
  if (!missing(std_chg_desc)) {
    defaults$std_chg_desc <- std_chg_desc
  }
  if (!missing(clin_dtl_code)) {
    defaults$clin_dtl_code <- clin_dtl_code
  }
  if (!missing(clin_dtl_desc)) {
    defaults$clin_dtl_desc <- clin_dtl_desc
  }
  if (!missing(clin_sum_code)) {
    defaults$clin_sum_code <- clin_sum_code
  }
  if (!missing(clin_sum_desc)) {
    defaults$clin_sum_desc <- clin_sum_desc
  }
  if (!missing(std_dept_code)) {
    defaults$std_dept_code <- std_dept_code
  }
  if (!missing(std_dept_desc)) {
    defaults$std_dept_desc <- std_dept_desc
  }
  if (!missing(sum_dept_desc)) {
    defaults$sum_dept_desc <- sum_dept_desc
  }
  if (!missing(prod_cat_code)) {
    defaults$prod_cat_code <- prod_cat_code
  }
  if (!missing(prod_cat_desc)) {
    defaults$prod_cat_desc <- prod_cat_desc
  }
  if (!missing(prod_class_code)) {
    defaults$prod_class_code <- prod_class_code
  }
  if (!missing(prod_class_desc)) {
    defaults$prod_class_desc <- prod_class_desc
  }
  if (!missing(prod_name_code)) {
    defaults$prod_name_code <- prod_name_code
  }
  if (!missing(prod_name_desc)) {
    defaults$prod_name_desc <- prod_name_desc
  }
  if (!missing(prod_name_meth_code)) {
    defaults$prod_name_meth_code <- prod_name_meth_code
  }
  if (!missing(prod_name_meth_desc)) {
    defaults$prod_name_meth_desc <- prod_name_meth_desc
  }
  assign('chgmstr', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_pattype <- function(pat_type, pat_type_desc) {
  defaults <- get('pattype', envir = frameworkContext$defaultValues)
  if (!missing(pat_type)) {
    defaults$pat_type <- pat_type
  }
  if (!missing(pat_type_desc)) {
    defaults$pat_type_desc <- pat_type_desc
  }
  assign('pattype', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_version <- function(version_id, version_date) {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  if (!missing(version_id)) {
    defaults$version_id <- version_id
  }
  if (!missing(version_date)) {
    defaults$version_date <- version_date
  }
  assign('version', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_paticd_diag <- function(pat_key, icd_version, icd_code, icd_pri_sec, icd_poa) {
  defaults <- get('paticd_diag', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(icd_version)) {
    defaults$icd_version <- icd_version
  }
  if (!missing(icd_code)) {
    defaults$icd_code <- icd_code
  }
  if (!missing(icd_pri_sec)) {
    defaults$icd_pri_sec <- icd_pri_sec
  }
  if (!missing(icd_poa)) {
    defaults$icd_poa <- icd_poa
  }
  assign('paticd_diag', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_patbill <- function(pat_key, std_chg_code, hosp_chg_id, serv_date, hosp_qty, std_qty, bill_charges, bill_cost, bill_var_cost, bill_fix_cost) {
  defaults <- get('patbill', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(std_chg_code)) {
    defaults$std_chg_code <- std_chg_code
  }
  if (!missing(hosp_chg_id)) {
    defaults$hosp_chg_id <- hosp_chg_id
  }
  if (!missing(serv_date)) {
    defaults$serv_date <- serv_date
  }
  if (!missing(hosp_qty)) {
    defaults$hosp_qty <- hosp_qty
  }
  if (!missing(std_qty)) {
    defaults$std_qty <- std_qty
  }
  if (!missing(bill_charges)) {
    defaults$bill_charges <- bill_charges
  }
  if (!missing(bill_cost)) {
    defaults$bill_cost <- bill_cost
  }
  if (!missing(bill_var_cost)) {
    defaults$bill_var_cost <- bill_var_cost
  }
  if (!missing(bill_fix_cost)) {
    defaults$bill_fix_cost <- bill_fix_cost
  }
  assign('patbill', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_msdrgmdc <- function(ms_drg_mdc, ms_drg_mdc_desc) {
  defaults <- get('msdrgmdc', envir = frameworkContext$defaultValues)
  if (!missing(ms_drg_mdc)) {
    defaults$ms_drg_mdc <- ms_drg_mdc
  }
  if (!missing(ms_drg_mdc_desc)) {
    defaults$ms_drg_mdc_desc <- ms_drg_mdc_desc
  }
  assign('msdrgmdc', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_payor <- function(std_payor, std_payor_desc) {
  defaults <- get('payor', envir = frameworkContext$defaultValues)
  if (!missing(std_payor)) {
    defaults$std_payor <- std_payor
  }
  if (!missing(std_payor_desc)) {
    defaults$std_payor_desc <- std_payor_desc
  }
  assign('payor', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_vitals <- function(pat_key, facility_test_name, observation_datetime, result_datetime, lab_test_loinc_code, lab_test, lab_test_code_type, lab_test_result, lab_test_result_unit, lab_test_result_status, numeric_value_operator, test_result_numeric_value, abnormal_flag) {
  defaults <- get('vitals', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(facility_test_name)) {
    defaults$facility_test_name <- facility_test_name
  }
  if (!missing(observation_datetime)) {
    defaults$observation_datetime <- observation_datetime
  }
  if (!missing(result_datetime)) {
    defaults$result_datetime <- result_datetime
  }
  if (!missing(lab_test_loinc_code)) {
    defaults$lab_test_loinc_code <- lab_test_loinc_code
  }
  if (!missing(lab_test)) {
    defaults$lab_test <- lab_test
  }
  if (!missing(lab_test_code_type)) {
    defaults$lab_test_code_type <- lab_test_code_type
  }
  if (!missing(lab_test_result)) {
    defaults$lab_test_result <- lab_test_result
  }
  if (!missing(lab_test_result_unit)) {
    defaults$lab_test_result_unit <- lab_test_result_unit
  }
  if (!missing(lab_test_result_status)) {
    defaults$lab_test_result_status <- lab_test_result_status
  }
  if (!missing(numeric_value_operator)) {
    defaults$numeric_value_operator <- numeric_value_operator
  }
  if (!missing(test_result_numeric_value)) {
    defaults$test_result_numeric_value <- test_result_numeric_value
  }
  if (!missing(abnormal_flag)) {
    defaults$abnormal_flag <- abnormal_flag
  }
  assign('vitals', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_icdcode <- function(icd_version, icd_code, icd_desc, ccs_cat_level1_code, ccs_cat_level1_desc, ccs_cat_level2_code, ccs_cat_level2_desc, icd_diag_proc, icd_diag_proc_desc) {
  defaults <- get('icdcode', envir = frameworkContext$defaultValues)
  if (!missing(icd_version)) {
    defaults$icd_version <- icd_version
  }
  if (!missing(icd_code)) {
    defaults$icd_code <- icd_code
  }
  if (!missing(icd_desc)) {
    defaults$icd_desc <- icd_desc
  }
  if (!missing(ccs_cat_level1_code)) {
    defaults$ccs_cat_level1_code <- ccs_cat_level1_code
  }
  if (!missing(ccs_cat_level1_desc)) {
    defaults$ccs_cat_level1_desc <- ccs_cat_level1_desc
  }
  if (!missing(ccs_cat_level2_code)) {
    defaults$ccs_cat_level2_code <- ccs_cat_level2_code
  }
  if (!missing(ccs_cat_level2_desc)) {
    defaults$ccs_cat_level2_desc <- ccs_cat_level2_desc
  }
  if (!missing(icd_diag_proc)) {
    defaults$icd_diag_proc <- icd_diag_proc
  }
  if (!missing(icd_diag_proc_desc)) {
    defaults$icd_diag_proc_desc <- icd_diag_proc_desc
  }
  assign('icdcode', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_prov_enrollment <- function(prov_id, disc_mon, ip_dx_count, op_dx_count, all_dx_count, ip_min_dx_date, op_min_dx_date, all_min_dx_date, ip_max_dx_date, op_max_dx_date, all_max_dx_date, ip_proj_wgt) {
  defaults <- get('prov_enrollment', envir = frameworkContext$defaultValues)
  if (!missing(prov_id)) {
    defaults$prov_id <- prov_id
  }
  if (!missing(disc_mon)) {
    defaults$disc_mon <- disc_mon
  }
  if (!missing(ip_dx_count)) {
    defaults$ip_dx_count <- ip_dx_count
  }
  if (!missing(op_dx_count)) {
    defaults$op_dx_count <- op_dx_count
  }
  if (!missing(all_dx_count)) {
    defaults$all_dx_count <- all_dx_count
  }
  if (!missing(ip_min_dx_date)) {
    defaults$ip_min_dx_date <- ip_min_dx_date
  }
  if (!missing(op_min_dx_date)) {
    defaults$op_min_dx_date <- op_min_dx_date
  }
  if (!missing(all_min_dx_date)) {
    defaults$all_min_dx_date <- all_min_dx_date
  }
  if (!missing(ip_max_dx_date)) {
    defaults$ip_max_dx_date <- ip_max_dx_date
  }
  if (!missing(op_max_dx_date)) {
    defaults$op_max_dx_date <- op_max_dx_date
  }
  if (!missing(all_max_dx_date)) {
    defaults$all_max_dx_date <- all_max_dx_date
  }
  if (!missing(ip_proj_wgt)) {
    defaults$ip_proj_wgt <- ip_proj_wgt
  }
  assign('prov_enrollment', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_genlab <- function(pat_key, order_key, collection_datetime, specimen_source_snomed_code, specimen_source_snomed_desc, lab_test_loinc_code, lab_test_loinc_desc, lab_test_code_type, lab_test_result_datetime, lab_test_result, result_unit, lab_test_result_status, reference_interval, numeric_value, numeric_value_operator, flags) {
  defaults <- get('genlab', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(order_key)) {
    defaults$order_key <- order_key
  }
  if (!missing(collection_datetime)) {
    defaults$collection_datetime <- collection_datetime
  }
  if (!missing(specimen_source_snomed_code)) {
    defaults$specimen_source_snomed_code <- specimen_source_snomed_code
  }
  if (!missing(specimen_source_snomed_desc)) {
    defaults$specimen_source_snomed_desc <- specimen_source_snomed_desc
  }
  if (!missing(lab_test_loinc_code)) {
    defaults$lab_test_loinc_code <- lab_test_loinc_code
  }
  if (!missing(lab_test_loinc_desc)) {
    defaults$lab_test_loinc_desc <- lab_test_loinc_desc
  }
  if (!missing(lab_test_code_type)) {
    defaults$lab_test_code_type <- lab_test_code_type
  }
  if (!missing(lab_test_result_datetime)) {
    defaults$lab_test_result_datetime <- lab_test_result_datetime
  }
  if (!missing(lab_test_result)) {
    defaults$lab_test_result <- lab_test_result
  }
  if (!missing(result_unit)) {
    defaults$result_unit <- result_unit
  }
  if (!missing(lab_test_result_status)) {
    defaults$lab_test_result_status <- lab_test_result_status
  }
  if (!missing(reference_interval)) {
    defaults$reference_interval <- reference_interval
  }
  if (!missing(numeric_value)) {
    defaults$numeric_value <- numeric_value
  }
  if (!missing(numeric_value_operator)) {
    defaults$numeric_value_operator <- numeric_value_operator
  }
  if (!missing(flags)) {
    defaults$flags <- flags
  }
  assign('genlab', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_aprdrg <- function(apr_drg, apr_drg_desc) {
  defaults <- get('aprdrg', envir = frameworkContext$defaultValues)
  if (!missing(apr_drg)) {
    defaults$apr_drg <- apr_drg
  }
  if (!missing(apr_drg_desc)) {
    defaults$apr_drg_desc <- apr_drg_desc
  }
  assign('aprdrg', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_providers <- function(prov_id, urban_rural, teaching, beds_grp, prov_region, prov_division, cost_type) {
  defaults <- get('providers', envir = frameworkContext$defaultValues)
  if (!missing(prov_id)) {
    defaults$prov_id <- prov_id
  }
  if (!missing(urban_rural)) {
    defaults$urban_rural <- urban_rural
  }
  if (!missing(teaching)) {
    defaults$teaching <- teaching
  }
  if (!missing(beds_grp)) {
    defaults$beds_grp <- beds_grp
  }
  if (!missing(prov_region)) {
    defaults$prov_region <- prov_region
  }
  if (!missing(prov_division)) {
    defaults$prov_division <- prov_division
  }
  if (!missing(cost_type)) {
    defaults$cost_type <- cost_type
  }
  assign('providers', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_paticd_proc <- function(pat_key, icd_version, icd_code, icd_pri_sec, proc_date, proc_phy, procphy_spec) {
  defaults <- get('paticd_proc', envir = frameworkContext$defaultValues)
  if (!missing(pat_key)) {
    defaults$pat_key <- pat_key
  }
  if (!missing(icd_version)) {
    defaults$icd_version <- icd_version
  }
  if (!missing(icd_code)) {
    defaults$icd_code <- icd_code
  }
  if (!missing(icd_pri_sec)) {
    defaults$icd_pri_sec <- icd_pri_sec
  }
  if (!missing(proc_date)) {
    defaults$proc_date <- proc_date
  }
  if (!missing(proc_phy)) {
    defaults$proc_phy <- proc_phy
  }
  if (!missing(procphy_spec)) {
    defaults$procphy_spec <- procphy_spec
  }
  assign('paticd_proc', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_cptcode <- function(cpt_code, cpt_desc) {
  defaults <- get('cptcode', envir = frameworkContext$defaultValues)
  if (!missing(cpt_code)) {
    defaults$cpt_code <- cpt_code
  }
  if (!missing(cpt_desc)) {
    defaults$cpt_desc <- cpt_desc
  }
  assign('cptcode', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_icdpoa <- function(icd_poa, icd_poa_desc, icd_poa_sum_desc) {
  defaults <- get('icdpoa', envir = frameworkContext$defaultValues)
  if (!missing(icd_poa)) {
    defaults$icd_poa <- icd_poa
  }
  if (!missing(icd_poa_desc)) {
    defaults$icd_poa_desc <- icd_poa_desc
  }
  if (!missing(icd_poa_sum_desc)) {
    defaults$icd_poa_sum_desc <- icd_poa_sum_desc
  }
  assign('icdpoa', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

get_defaults_poorigin <- function() {
  defaults <- get('poorigin', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_lookup_datadictionary <- function() {
  defaults <- get('lookup_datadictionary', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_admtype <- function() {
  defaults <- get('admtype', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_hospchg <- function() {
  defaults <- get('hospchg', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_pataprdrg <- function() {
  defaults <- get('pataprdrg', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_disstat <- function() {
  defaults <- get('disstat', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_msdrg <- function() {
  defaults <- get('msdrg', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_lab_sens_result <- function() {
  defaults <- get('lab_sens_result', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_physpec <- function() {
  defaults <- get('physpec', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_pat <- function() {
  defaults <- get('pat', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_lab_result <- function() {
  defaults <- get('lab_result', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_patcpt <- function() {
  defaults <- get('patcpt', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_chgmstr <- function() {
  defaults <- get('chgmstr', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_pattype <- function() {
  defaults <- get('pattype', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_version <- function() {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_paticd_diag <- function() {
  defaults <- get('paticd_diag', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_patbill <- function() {
  defaults <- get('patbill', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_msdrgmdc <- function() {
  defaults <- get('msdrgmdc', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_payor <- function() {
  defaults <- get('payor', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_vitals <- function() {
  defaults <- get('vitals', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_icdcode <- function() {
  defaults <- get('icdcode', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_prov_enrollment <- function() {
  defaults <- get('prov_enrollment', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_genlab <- function() {
  defaults <- get('genlab', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_aprdrg <- function() {
  defaults <- get('aprdrg', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_providers <- function() {
  defaults <- get('providers', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_paticd_proc <- function() {
  defaults <- get('paticd_proc', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_cptcode <- function() {
  defaults <- get('cptcode', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_icdpoa <- function() {
  defaults <- get('icdpoa', envir = frameworkContext$defaultValues)
  return(defaults)
}

declareTest <- function(id, description) {
  frameworkContext$testId <- id
  frameworkContext$testDescription <- description
}

add_poorigin <- function(point_of_origin, point_of_origin_desc) {
  defaults <- get('poorigin', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(point_of_origin)) {
    point_of_origin <- defaults$point_of_origin
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'poorigin.point_of_origin')
  }
  fields <- c(fields, "point_of_origin")
  values <- c(values, if (is.null(point_of_origin)) "NULL" else if (is(point_of_origin, "subQuery")) paste0("(", as.character(point_of_origin), ")") else paste0("'", as.character(point_of_origin), "'"))

  if (missing(point_of_origin_desc)) {
    point_of_origin_desc <- defaults$point_of_origin_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'poorigin.point_of_origin_desc')
  }
  fields <- c(fields, "point_of_origin_desc")
  values <- c(values, if (is.null(point_of_origin_desc)) "NULL" else if (is(point_of_origin_desc, "subQuery")) paste0("(", as.character(point_of_origin_desc), ")") else paste0("'", as.character(point_of_origin_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "poorigin", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_lookup_datadictionary <- function() {
  defaults <- get('lookup_datadictionary', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "_lookup_datadictionary", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_admtype <- function(adm_type, adm_type_desc) {
  defaults <- get('admtype', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(adm_type)) {
    adm_type <- defaults$adm_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'admtype.adm_type')
  }
  fields <- c(fields, "adm_type")
  values <- c(values, if (is.null(adm_type)) "NULL" else if (is(adm_type, "subQuery")) paste0("(", as.character(adm_type), ")") else paste0("'", as.character(adm_type), "'"))

  if (missing(adm_type_desc)) {
    adm_type_desc <- defaults$adm_type_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'admtype.adm_type_desc')
  }
  fields <- c(fields, "adm_type_desc")
  values <- c(values, if (is.null(adm_type_desc)) "NULL" else if (is(adm_type_desc, "subQuery")) paste0("(", as.character(adm_type_desc), ")") else paste0("'", as.character(adm_type_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "admtype", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_hospchg <- function(hosp_chg_id, hosp_chg_desc) {
  defaults <- get('hospchg', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(hosp_chg_id)) {
    hosp_chg_id <- defaults$hosp_chg_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hospchg.hosp_chg_id')
  }
  fields <- c(fields, "hosp_chg_id")
  values <- c(values, if (is.null(hosp_chg_id)) "NULL" else if (is(hosp_chg_id, "subQuery")) paste0("(", as.character(hosp_chg_id), ")") else paste0("'", as.character(hosp_chg_id), "'"))

  if (missing(hosp_chg_desc)) {
    hosp_chg_desc <- defaults$hosp_chg_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hospchg.hosp_chg_desc')
  }
  fields <- c(fields, "hosp_chg_desc")
  values <- c(values, if (is.null(hosp_chg_desc)) "NULL" else if (is(hosp_chg_desc, "subQuery")) paste0("(", as.character(hosp_chg_desc), ")") else paste0("'", as.character(hosp_chg_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "hospchg", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_pataprdrg <- function(pat_key, medrec_key, apr_drg, apr_sev, apr_mort) {
  defaults <- get('pataprdrg', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pataprdrg.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(medrec_key)) {
    medrec_key <- defaults$medrec_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pataprdrg.medrec_key')
  }
  fields <- c(fields, "medrec_key")
  values <- c(values, if (is.null(medrec_key)) "NULL" else if (is(medrec_key, "subQuery")) paste0("(", as.character(medrec_key), ")") else paste0("'", as.character(medrec_key), "'"))

  if (missing(apr_drg)) {
    apr_drg <- defaults$apr_drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pataprdrg.apr_drg')
  }
  fields <- c(fields, "apr_drg")
  values <- c(values, if (is.null(apr_drg)) "NULL" else if (is(apr_drg, "subQuery")) paste0("(", as.character(apr_drg), ")") else paste0("'", as.character(apr_drg), "'"))

  if (missing(apr_sev)) {
    apr_sev <- defaults$apr_sev
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pataprdrg.apr_sev')
  }
  fields <- c(fields, "apr_sev")
  values <- c(values, if (is.null(apr_sev)) "NULL" else if (is(apr_sev, "subQuery")) paste0("(", as.character(apr_sev), ")") else paste0("'", as.character(apr_sev), "'"))

  if (missing(apr_mort)) {
    apr_mort <- defaults$apr_mort
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pataprdrg.apr_mort')
  }
  fields <- c(fields, "apr_mort")
  values <- c(values, if (is.null(apr_mort)) "NULL" else if (is(apr_mort, "subQuery")) paste0("(", as.character(apr_mort), ")") else paste0("'", as.character(apr_mort), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "pataprdrg", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_disstat <- function(disc_status, disc_status_desc) {
  defaults <- get('disstat', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(disc_status)) {
    disc_status <- defaults$disc_status
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'disstat.disc_status')
  }
  fields <- c(fields, "disc_status")
  values <- c(values, if (is.null(disc_status)) "NULL" else if (is(disc_status, "subQuery")) paste0("(", as.character(disc_status), ")") else paste0("'", as.character(disc_status), "'"))

  if (missing(disc_status_desc)) {
    disc_status_desc <- defaults$disc_status_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'disstat.disc_status_desc')
  }
  fields <- c(fields, "disc_status_desc")
  values <- c(values, if (is.null(disc_status_desc)) "NULL" else if (is(disc_status_desc, "subQuery")) paste0("(", as.character(disc_status_desc), ")") else paste0("'", as.character(disc_status_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "disstat", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_msdrg <- function(ms_drg, ms_drg_desc) {
  defaults <- get('msdrg', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(ms_drg)) {
    ms_drg <- defaults$ms_drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'msdrg.ms_drg')
  }
  fields <- c(fields, "ms_drg")
  values <- c(values, if (is.null(ms_drg)) "NULL" else if (is(ms_drg, "subQuery")) paste0("(", as.character(ms_drg), ")") else paste0("'", as.character(ms_drg), "'"))

  if (missing(ms_drg_desc)) {
    ms_drg_desc <- defaults$ms_drg_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'msdrg.ms_drg_desc')
  }
  fields <- c(fields, "ms_drg_desc")
  values <- c(values, if (is.null(ms_drg_desc)) "NULL" else if (is(ms_drg_desc, "subQuery")) paste0("(", as.character(ms_drg_desc), ")") else paste0("'", as.character(ms_drg_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "msdrg", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_lab_sens_result <- function(pat_key, specimen_id, collection_datetime, result_organism, susc_test_method_code, test_method, susc_test_method_code_type, medication, susc_test_result_datetime, rsv_result, interpretation, data_source_ind) {
  defaults <- get('lab_sens_result', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(specimen_id)) {
    specimen_id <- defaults$specimen_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.specimen_id')
  }
  fields <- c(fields, "specimen_id")
  values <- c(values, if (is.null(specimen_id)) "NULL" else if (is(specimen_id, "subQuery")) paste0("(", as.character(specimen_id), ")") else paste0("'", as.character(specimen_id), "'"))

  if (missing(collection_datetime)) {
    collection_datetime <- defaults$collection_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.collection_datetime')
  }
  fields <- c(fields, "collection_datetime")
  values <- c(values, if (is.null(collection_datetime)) "NULL" else if (is(collection_datetime, "subQuery")) paste0("(", as.character(collection_datetime), ")") else paste0("'", as.character(collection_datetime), "'"))

  if (missing(result_organism)) {
    result_organism <- defaults$result_organism
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.result_organism')
  }
  fields <- c(fields, "result_organism")
  values <- c(values, if (is.null(result_organism)) "NULL" else if (is(result_organism, "subQuery")) paste0("(", as.character(result_organism), ")") else paste0("'", as.character(result_organism), "'"))

  if (missing(susc_test_method_code)) {
    susc_test_method_code <- defaults$susc_test_method_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.susc_test_method_code')
  }
  fields <- c(fields, "susc_test_method_code")
  values <- c(values, if (is.null(susc_test_method_code)) "NULL" else if (is(susc_test_method_code, "subQuery")) paste0("(", as.character(susc_test_method_code), ")") else paste0("'", as.character(susc_test_method_code), "'"))

  if (missing(test_method)) {
    test_method <- defaults$test_method
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.test_method')
  }
  fields <- c(fields, "test_method")
  values <- c(values, if (is.null(test_method)) "NULL" else if (is(test_method, "subQuery")) paste0("(", as.character(test_method), ")") else paste0("'", as.character(test_method), "'"))

  if (missing(susc_test_method_code_type)) {
    susc_test_method_code_type <- defaults$susc_test_method_code_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.susc_test_method_code_type')
  }
  fields <- c(fields, "susc_test_method_code_type")
  values <- c(values, if (is.null(susc_test_method_code_type)) "NULL" else if (is(susc_test_method_code_type, "subQuery")) paste0("(", as.character(susc_test_method_code_type), ")") else paste0("'", as.character(susc_test_method_code_type), "'"))

  if (missing(medication)) {
    medication <- defaults$medication
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.medication')
  }
  fields <- c(fields, "medication")
  values <- c(values, if (is.null(medication)) "NULL" else if (is(medication, "subQuery")) paste0("(", as.character(medication), ")") else paste0("'", as.character(medication), "'"))

  if (missing(susc_test_result_datetime)) {
    susc_test_result_datetime <- defaults$susc_test_result_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.susc_test_result_datetime')
  }
  fields <- c(fields, "susc_test_result_datetime")
  values <- c(values, if (is.null(susc_test_result_datetime)) "NULL" else if (is(susc_test_result_datetime, "subQuery")) paste0("(", as.character(susc_test_result_datetime), ")") else paste0("'", as.character(susc_test_result_datetime), "'"))

  if (missing(rsv_result)) {
    rsv_result <- defaults$rsv_result
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.rsv_result')
  }
  fields <- c(fields, "rsv_result")
  values <- c(values, if (is.null(rsv_result)) "NULL" else if (is(rsv_result, "subQuery")) paste0("(", as.character(rsv_result), ")") else paste0("'", as.character(rsv_result), "'"))

  if (missing(interpretation)) {
    interpretation <- defaults$interpretation
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.interpretation')
  }
  fields <- c(fields, "interpretation")
  values <- c(values, if (is.null(interpretation)) "NULL" else if (is(interpretation, "subQuery")) paste0("(", as.character(interpretation), ")") else paste0("'", as.character(interpretation), "'"))

  if (missing(data_source_ind)) {
    data_source_ind <- defaults$data_source_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_sens_result.data_source_ind')
  }
  fields <- c(fields, "data_source_ind")
  values <- c(values, if (is.null(data_source_ind)) "NULL" else if (is(data_source_ind, "subQuery")) paste0("(", as.character(data_source_ind), ")") else paste0("'", as.character(data_source_ind), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "lab_sens_result", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_physpec <- function(phy_spec, phy_spec_desc) {
  defaults <- get('physpec', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(phy_spec)) {
    phy_spec <- defaults$phy_spec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'physpec.phy_spec')
  }
  fields <- c(fields, "phy_spec")
  values <- c(values, if (is.null(phy_spec)) "NULL" else if (is(phy_spec, "subQuery")) paste0("(", as.character(phy_spec), ")") else paste0("'", as.character(phy_spec), "'"))

  if (missing(phy_spec_desc)) {
    phy_spec_desc <- defaults$phy_spec_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'physpec.phy_spec_desc')
  }
  fields <- c(fields, "phy_spec_desc")
  values <- c(values, if (is.null(phy_spec_desc)) "NULL" else if (is(phy_spec_desc, "subQuery")) paste0("(", as.character(phy_spec_desc), ")") else paste0("'", as.character(phy_spec_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "physpec", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_pat <- function(pat_key, adm_date, disc_mon, disc_date, prov_id, i_o_ind, pat_type, point_of_origin, adm_type, disc_status, mart_status, age, gender, race, admphy_spec, adm_phy, attphy_spec, att_phy, std_payor, los, pat_charges, pat_cost, pat_fix_cost, pat_var_cost, medrec_key, ms_drg, ms_drg_mdc, hispanic_ind, publish_type) {
  defaults <- get('pat', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(adm_date)) {
    adm_date <- defaults$adm_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.adm_date')
  }
  fields <- c(fields, "adm_date")
  values <- c(values, if (is.null(adm_date)) "NULL" else if (is(adm_date, "subQuery")) paste0("(", as.character(adm_date), ")") else paste0("'", as.character(adm_date), "'"))

  if (missing(disc_mon)) {
    disc_mon <- defaults$disc_mon
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.disc_mon')
  }
  fields <- c(fields, "disc_mon")
  values <- c(values, if (is.null(disc_mon)) "NULL" else if (is(disc_mon, "subQuery")) paste0("(", as.character(disc_mon), ")") else paste0("'", as.character(disc_mon), "'"))

  if (missing(disc_date)) {
    disc_date <- defaults$disc_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.disc_date')
  }
  fields <- c(fields, "disc_date")
  values <- c(values, if (is.null(disc_date)) "NULL" else if (is(disc_date, "subQuery")) paste0("(", as.character(disc_date), ")") else paste0("'", as.character(disc_date), "'"))

  if (missing(prov_id)) {
    prov_id <- defaults$prov_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.prov_id')
  }
  fields <- c(fields, "prov_id")
  values <- c(values, if (is.null(prov_id)) "NULL" else if (is(prov_id, "subQuery")) paste0("(", as.character(prov_id), ")") else paste0("'", as.character(prov_id), "'"))

  if (missing(i_o_ind)) {
    i_o_ind <- defaults$i_o_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.i_o_ind')
  }
  fields <- c(fields, "i_o_ind")
  values <- c(values, if (is.null(i_o_ind)) "NULL" else if (is(i_o_ind, "subQuery")) paste0("(", as.character(i_o_ind), ")") else paste0("'", as.character(i_o_ind), "'"))

  if (missing(pat_type)) {
    pat_type <- defaults$pat_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.pat_type')
  }
  fields <- c(fields, "pat_type")
  values <- c(values, if (is.null(pat_type)) "NULL" else if (is(pat_type, "subQuery")) paste0("(", as.character(pat_type), ")") else paste0("'", as.character(pat_type), "'"))

  if (missing(point_of_origin)) {
    point_of_origin <- defaults$point_of_origin
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.point_of_origin')
  }
  fields <- c(fields, "point_of_origin")
  values <- c(values, if (is.null(point_of_origin)) "NULL" else if (is(point_of_origin, "subQuery")) paste0("(", as.character(point_of_origin), ")") else paste0("'", as.character(point_of_origin), "'"))

  if (missing(adm_type)) {
    adm_type <- defaults$adm_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.adm_type')
  }
  fields <- c(fields, "adm_type")
  values <- c(values, if (is.null(adm_type)) "NULL" else if (is(adm_type, "subQuery")) paste0("(", as.character(adm_type), ")") else paste0("'", as.character(adm_type), "'"))

  if (missing(disc_status)) {
    disc_status <- defaults$disc_status
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.disc_status')
  }
  fields <- c(fields, "disc_status")
  values <- c(values, if (is.null(disc_status)) "NULL" else if (is(disc_status, "subQuery")) paste0("(", as.character(disc_status), ")") else paste0("'", as.character(disc_status), "'"))

  if (missing(mart_status)) {
    mart_status <- defaults$mart_status
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.mart_status')
  }
  fields <- c(fields, "mart_status")
  values <- c(values, if (is.null(mart_status)) "NULL" else if (is(mart_status, "subQuery")) paste0("(", as.character(mart_status), ")") else paste0("'", as.character(mart_status), "'"))

  if (missing(age)) {
    age <- defaults$age
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.age')
  }
  fields <- c(fields, "age")
  values <- c(values, if (is.null(age)) "NULL" else if (is(age, "subQuery")) paste0("(", as.character(age), ")") else paste0("'", as.character(age), "'"))

  if (missing(gender)) {
    gender <- defaults$gender
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.gender')
  }
  fields <- c(fields, "gender")
  values <- c(values, if (is.null(gender)) "NULL" else if (is(gender, "subQuery")) paste0("(", as.character(gender), ")") else paste0("'", as.character(gender), "'"))

  if (missing(race)) {
    race <- defaults$race
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.race')
  }
  fields <- c(fields, "race")
  values <- c(values, if (is.null(race)) "NULL" else if (is(race, "subQuery")) paste0("(", as.character(race), ")") else paste0("'", as.character(race), "'"))

  if (missing(admphy_spec)) {
    admphy_spec <- defaults$admphy_spec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.admphy_spec')
  }
  fields <- c(fields, "admphy_spec")
  values <- c(values, if (is.null(admphy_spec)) "NULL" else if (is(admphy_spec, "subQuery")) paste0("(", as.character(admphy_spec), ")") else paste0("'", as.character(admphy_spec), "'"))

  if (missing(adm_phy)) {
    adm_phy <- defaults$adm_phy
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.adm_phy')
  }
  fields <- c(fields, "adm_phy")
  values <- c(values, if (is.null(adm_phy)) "NULL" else if (is(adm_phy, "subQuery")) paste0("(", as.character(adm_phy), ")") else paste0("'", as.character(adm_phy), "'"))

  if (missing(attphy_spec)) {
    attphy_spec <- defaults$attphy_spec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.attphy_spec')
  }
  fields <- c(fields, "attphy_spec")
  values <- c(values, if (is.null(attphy_spec)) "NULL" else if (is(attphy_spec, "subQuery")) paste0("(", as.character(attphy_spec), ")") else paste0("'", as.character(attphy_spec), "'"))

  if (missing(att_phy)) {
    att_phy <- defaults$att_phy
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.att_phy')
  }
  fields <- c(fields, "att_phy")
  values <- c(values, if (is.null(att_phy)) "NULL" else if (is(att_phy, "subQuery")) paste0("(", as.character(att_phy), ")") else paste0("'", as.character(att_phy), "'"))

  if (missing(std_payor)) {
    std_payor <- defaults$std_payor
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.std_payor')
  }
  fields <- c(fields, "std_payor")
  values <- c(values, if (is.null(std_payor)) "NULL" else if (is(std_payor, "subQuery")) paste0("(", as.character(std_payor), ")") else paste0("'", as.character(std_payor), "'"))

  if (missing(los)) {
    los <- defaults$los
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.los')
  }
  fields <- c(fields, "los")
  values <- c(values, if (is.null(los)) "NULL" else if (is(los, "subQuery")) paste0("(", as.character(los), ")") else paste0("'", as.character(los), "'"))

  if (missing(pat_charges)) {
    pat_charges <- defaults$pat_charges
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.pat_charges')
  }
  fields <- c(fields, "pat_charges")
  values <- c(values, if (is.null(pat_charges)) "NULL" else if (is(pat_charges, "subQuery")) paste0("(", as.character(pat_charges), ")") else paste0("'", as.character(pat_charges), "'"))

  if (missing(pat_cost)) {
    pat_cost <- defaults$pat_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.pat_cost')
  }
  fields <- c(fields, "pat_cost")
  values <- c(values, if (is.null(pat_cost)) "NULL" else if (is(pat_cost, "subQuery")) paste0("(", as.character(pat_cost), ")") else paste0("'", as.character(pat_cost), "'"))

  if (missing(pat_fix_cost)) {
    pat_fix_cost <- defaults$pat_fix_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.pat_fix_cost')
  }
  fields <- c(fields, "pat_fix_cost")
  values <- c(values, if (is.null(pat_fix_cost)) "NULL" else if (is(pat_fix_cost, "subQuery")) paste0("(", as.character(pat_fix_cost), ")") else paste0("'", as.character(pat_fix_cost), "'"))

  if (missing(pat_var_cost)) {
    pat_var_cost <- defaults$pat_var_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.pat_var_cost')
  }
  fields <- c(fields, "pat_var_cost")
  values <- c(values, if (is.null(pat_var_cost)) "NULL" else if (is(pat_var_cost, "subQuery")) paste0("(", as.character(pat_var_cost), ")") else paste0("'", as.character(pat_var_cost), "'"))

  if (missing(medrec_key)) {
    medrec_key <- defaults$medrec_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.medrec_key')
  }
  fields <- c(fields, "medrec_key")
  values <- c(values, if (is.null(medrec_key)) "NULL" else if (is(medrec_key, "subQuery")) paste0("(", as.character(medrec_key), ")") else paste0("'", as.character(medrec_key), "'"))

  if (missing(ms_drg)) {
    ms_drg <- defaults$ms_drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.ms_drg')
  }
  fields <- c(fields, "ms_drg")
  values <- c(values, if (is.null(ms_drg)) "NULL" else if (is(ms_drg, "subQuery")) paste0("(", as.character(ms_drg), ")") else paste0("'", as.character(ms_drg), "'"))

  if (missing(ms_drg_mdc)) {
    ms_drg_mdc <- defaults$ms_drg_mdc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.ms_drg_mdc')
  }
  fields <- c(fields, "ms_drg_mdc")
  values <- c(values, if (is.null(ms_drg_mdc)) "NULL" else if (is(ms_drg_mdc, "subQuery")) paste0("(", as.character(ms_drg_mdc), ")") else paste0("'", as.character(ms_drg_mdc), "'"))

  if (missing(hispanic_ind)) {
    hispanic_ind <- defaults$hispanic_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.hispanic_ind')
  }
  fields <- c(fields, "hispanic_ind")
  values <- c(values, if (is.null(hispanic_ind)) "NULL" else if (is(hispanic_ind, "subQuery")) paste0("(", as.character(hispanic_ind), ")") else paste0("'", as.character(hispanic_ind), "'"))

  if (missing(publish_type)) {
    publish_type <- defaults$publish_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pat.publish_type')
  }
  fields <- c(fields, "publish_type")
  values <- c(values, if (is.null(publish_type)) "NULL" else if (is(publish_type, "subQuery")) paste0("(", as.character(publish_type), ")") else paste0("'", as.character(publish_type), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "pat", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_lab_result <- function(pat_key, specimen_id, collection_datetime, specimen_source_code, specimen_source, body_site_category_code, body_site_category_desc, lab_test_code, test, lab_test_code_type, lab_test_result_datetime, observation, observation_category, data_source_ind) {
  defaults <- get('lab_result', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(specimen_id)) {
    specimen_id <- defaults$specimen_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.specimen_id')
  }
  fields <- c(fields, "specimen_id")
  values <- c(values, if (is.null(specimen_id)) "NULL" else if (is(specimen_id, "subQuery")) paste0("(", as.character(specimen_id), ")") else paste0("'", as.character(specimen_id), "'"))

  if (missing(collection_datetime)) {
    collection_datetime <- defaults$collection_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.collection_datetime')
  }
  fields <- c(fields, "collection_datetime")
  values <- c(values, if (is.null(collection_datetime)) "NULL" else if (is(collection_datetime, "subQuery")) paste0("(", as.character(collection_datetime), ")") else paste0("'", as.character(collection_datetime), "'"))

  if (missing(specimen_source_code)) {
    specimen_source_code <- defaults$specimen_source_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.specimen_source_code')
  }
  fields <- c(fields, "specimen_source_code")
  values <- c(values, if (is.null(specimen_source_code)) "NULL" else if (is(specimen_source_code, "subQuery")) paste0("(", as.character(specimen_source_code), ")") else paste0("'", as.character(specimen_source_code), "'"))

  if (missing(specimen_source)) {
    specimen_source <- defaults$specimen_source
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.specimen_source')
  }
  fields <- c(fields, "specimen_source")
  values <- c(values, if (is.null(specimen_source)) "NULL" else if (is(specimen_source, "subQuery")) paste0("(", as.character(specimen_source), ")") else paste0("'", as.character(specimen_source), "'"))

  if (missing(body_site_category_code)) {
    body_site_category_code <- defaults$body_site_category_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.body_site_category_code')
  }
  fields <- c(fields, "body_site_category_code")
  values <- c(values, if (is.null(body_site_category_code)) "NULL" else if (is(body_site_category_code, "subQuery")) paste0("(", as.character(body_site_category_code), ")") else paste0("'", as.character(body_site_category_code), "'"))

  if (missing(body_site_category_desc)) {
    body_site_category_desc <- defaults$body_site_category_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.body_site_category_desc')
  }
  fields <- c(fields, "body_site_category_desc")
  values <- c(values, if (is.null(body_site_category_desc)) "NULL" else if (is(body_site_category_desc, "subQuery")) paste0("(", as.character(body_site_category_desc), ")") else paste0("'", as.character(body_site_category_desc), "'"))

  if (missing(lab_test_code)) {
    lab_test_code <- defaults$lab_test_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.lab_test_code')
  }
  fields <- c(fields, "lab_test_code")
  values <- c(values, if (is.null(lab_test_code)) "NULL" else if (is(lab_test_code, "subQuery")) paste0("(", as.character(lab_test_code), ")") else paste0("'", as.character(lab_test_code), "'"))

  if (missing(test)) {
    test <- defaults$test
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.test')
  }
  fields <- c(fields, "test")
  values <- c(values, if (is.null(test)) "NULL" else if (is(test, "subQuery")) paste0("(", as.character(test), ")") else paste0("'", as.character(test), "'"))

  if (missing(lab_test_code_type)) {
    lab_test_code_type <- defaults$lab_test_code_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.lab_test_code_type')
  }
  fields <- c(fields, "lab_test_code_type")
  values <- c(values, if (is.null(lab_test_code_type)) "NULL" else if (is(lab_test_code_type, "subQuery")) paste0("(", as.character(lab_test_code_type), ")") else paste0("'", as.character(lab_test_code_type), "'"))

  if (missing(lab_test_result_datetime)) {
    lab_test_result_datetime <- defaults$lab_test_result_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.lab_test_result_datetime')
  }
  fields <- c(fields, "lab_test_result_datetime")
  values <- c(values, if (is.null(lab_test_result_datetime)) "NULL" else if (is(lab_test_result_datetime, "subQuery")) paste0("(", as.character(lab_test_result_datetime), ")") else paste0("'", as.character(lab_test_result_datetime), "'"))

  if (missing(observation)) {
    observation <- defaults$observation
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.observation')
  }
  fields <- c(fields, "observation")
  values <- c(values, if (is.null(observation)) "NULL" else if (is(observation, "subQuery")) paste0("(", as.character(observation), ")") else paste0("'", as.character(observation), "'"))

  if (missing(observation_category)) {
    observation_category <- defaults$observation_category
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.observation_category')
  }
  fields <- c(fields, "observation_category")
  values <- c(values, if (is.null(observation_category)) "NULL" else if (is(observation_category, "subQuery")) paste0("(", as.character(observation_category), ")") else paste0("'", as.character(observation_category), "'"))

  if (missing(data_source_ind)) {
    data_source_ind <- defaults$data_source_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_result.data_source_ind')
  }
  fields <- c(fields, "data_source_ind")
  values <- c(values, if (is.null(data_source_ind)) "NULL" else if (is(data_source_ind, "subQuery")) paste0("(", as.character(data_source_ind), ")") else paste0("'", as.character(data_source_ind), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "lab_result", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_patcpt <- function(pat_key, cpt_code, cpt_pos, proc_date, cpt_order_phy, cpt_order_phy_spec, cpt_proc_phy, cpt_proc_phy_spec, cpt_mod_code_1, cpt_mod_code_2, cpt_mod_code_3, cpt_mod_code_4) {
  defaults <- get('patcpt', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(cpt_code)) {
    cpt_code <- defaults$cpt_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_code')
  }
  fields <- c(fields, "cpt_code")
  values <- c(values, if (is.null(cpt_code)) "NULL" else if (is(cpt_code, "subQuery")) paste0("(", as.character(cpt_code), ")") else paste0("'", as.character(cpt_code), "'"))

  if (missing(cpt_pos)) {
    cpt_pos <- defaults$cpt_pos
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_pos')
  }
  fields <- c(fields, "cpt_pos")
  values <- c(values, if (is.null(cpt_pos)) "NULL" else if (is(cpt_pos, "subQuery")) paste0("(", as.character(cpt_pos), ")") else paste0("'", as.character(cpt_pos), "'"))

  if (missing(proc_date)) {
    proc_date <- defaults$proc_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.proc_date')
  }
  fields <- c(fields, "proc_date")
  values <- c(values, if (is.null(proc_date)) "NULL" else if (is(proc_date, "subQuery")) paste0("(", as.character(proc_date), ")") else paste0("'", as.character(proc_date), "'"))

  if (missing(cpt_order_phy)) {
    cpt_order_phy <- defaults$cpt_order_phy
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_order_phy')
  }
  fields <- c(fields, "cpt_order_phy")
  values <- c(values, if (is.null(cpt_order_phy)) "NULL" else if (is(cpt_order_phy, "subQuery")) paste0("(", as.character(cpt_order_phy), ")") else paste0("'", as.character(cpt_order_phy), "'"))

  if (missing(cpt_order_phy_spec)) {
    cpt_order_phy_spec <- defaults$cpt_order_phy_spec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_order_phy_spec')
  }
  fields <- c(fields, "cpt_order_phy_spec")
  values <- c(values, if (is.null(cpt_order_phy_spec)) "NULL" else if (is(cpt_order_phy_spec, "subQuery")) paste0("(", as.character(cpt_order_phy_spec), ")") else paste0("'", as.character(cpt_order_phy_spec), "'"))

  if (missing(cpt_proc_phy)) {
    cpt_proc_phy <- defaults$cpt_proc_phy
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_proc_phy')
  }
  fields <- c(fields, "cpt_proc_phy")
  values <- c(values, if (is.null(cpt_proc_phy)) "NULL" else if (is(cpt_proc_phy, "subQuery")) paste0("(", as.character(cpt_proc_phy), ")") else paste0("'", as.character(cpt_proc_phy), "'"))

  if (missing(cpt_proc_phy_spec)) {
    cpt_proc_phy_spec <- defaults$cpt_proc_phy_spec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_proc_phy_spec')
  }
  fields <- c(fields, "cpt_proc_phy_spec")
  values <- c(values, if (is.null(cpt_proc_phy_spec)) "NULL" else if (is(cpt_proc_phy_spec, "subQuery")) paste0("(", as.character(cpt_proc_phy_spec), ")") else paste0("'", as.character(cpt_proc_phy_spec), "'"))

  if (missing(cpt_mod_code_1)) {
    cpt_mod_code_1 <- defaults$cpt_mod_code_1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_mod_code_1')
  }
  fields <- c(fields, "cpt_mod_code_1")
  values <- c(values, if (is.null(cpt_mod_code_1)) "NULL" else if (is(cpt_mod_code_1, "subQuery")) paste0("(", as.character(cpt_mod_code_1), ")") else paste0("'", as.character(cpt_mod_code_1), "'"))

  if (missing(cpt_mod_code_2)) {
    cpt_mod_code_2 <- defaults$cpt_mod_code_2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_mod_code_2')
  }
  fields <- c(fields, "cpt_mod_code_2")
  values <- c(values, if (is.null(cpt_mod_code_2)) "NULL" else if (is(cpt_mod_code_2, "subQuery")) paste0("(", as.character(cpt_mod_code_2), ")") else paste0("'", as.character(cpt_mod_code_2), "'"))

  if (missing(cpt_mod_code_3)) {
    cpt_mod_code_3 <- defaults$cpt_mod_code_3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_mod_code_3')
  }
  fields <- c(fields, "cpt_mod_code_3")
  values <- c(values, if (is.null(cpt_mod_code_3)) "NULL" else if (is(cpt_mod_code_3, "subQuery")) paste0("(", as.character(cpt_mod_code_3), ")") else paste0("'", as.character(cpt_mod_code_3), "'"))

  if (missing(cpt_mod_code_4)) {
    cpt_mod_code_4 <- defaults$cpt_mod_code_4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patcpt.cpt_mod_code_4')
  }
  fields <- c(fields, "cpt_mod_code_4")
  values <- c(values, if (is.null(cpt_mod_code_4)) "NULL" else if (is(cpt_mod_code_4, "subQuery")) paste0("(", as.character(cpt_mod_code_4), ")") else paste0("'", as.character(cpt_mod_code_4), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "patcpt", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_chgmstr <- function(std_chg_code, std_chg_desc, clin_dtl_code, clin_dtl_desc, clin_sum_code, clin_sum_desc, std_dept_code, std_dept_desc, sum_dept_desc, prod_cat_code, prod_cat_desc, prod_class_code, prod_class_desc, prod_name_code, prod_name_desc, prod_name_meth_code, prod_name_meth_desc) {
  defaults <- get('chgmstr', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(std_chg_code)) {
    std_chg_code <- defaults$std_chg_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.std_chg_code')
  }
  fields <- c(fields, "std_chg_code")
  values <- c(values, if (is.null(std_chg_code)) "NULL" else if (is(std_chg_code, "subQuery")) paste0("(", as.character(std_chg_code), ")") else paste0("'", as.character(std_chg_code), "'"))

  if (missing(std_chg_desc)) {
    std_chg_desc <- defaults$std_chg_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.std_chg_desc')
  }
  fields <- c(fields, "std_chg_desc")
  values <- c(values, if (is.null(std_chg_desc)) "NULL" else if (is(std_chg_desc, "subQuery")) paste0("(", as.character(std_chg_desc), ")") else paste0("'", as.character(std_chg_desc), "'"))

  if (missing(clin_dtl_code)) {
    clin_dtl_code <- defaults$clin_dtl_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.clin_dtl_code')
  }
  fields <- c(fields, "clin_dtl_code")
  values <- c(values, if (is.null(clin_dtl_code)) "NULL" else if (is(clin_dtl_code, "subQuery")) paste0("(", as.character(clin_dtl_code), ")") else paste0("'", as.character(clin_dtl_code), "'"))

  if (missing(clin_dtl_desc)) {
    clin_dtl_desc <- defaults$clin_dtl_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.clin_dtl_desc')
  }
  fields <- c(fields, "clin_dtl_desc")
  values <- c(values, if (is.null(clin_dtl_desc)) "NULL" else if (is(clin_dtl_desc, "subQuery")) paste0("(", as.character(clin_dtl_desc), ")") else paste0("'", as.character(clin_dtl_desc), "'"))

  if (missing(clin_sum_code)) {
    clin_sum_code <- defaults$clin_sum_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.clin_sum_code')
  }
  fields <- c(fields, "clin_sum_code")
  values <- c(values, if (is.null(clin_sum_code)) "NULL" else if (is(clin_sum_code, "subQuery")) paste0("(", as.character(clin_sum_code), ")") else paste0("'", as.character(clin_sum_code), "'"))

  if (missing(clin_sum_desc)) {
    clin_sum_desc <- defaults$clin_sum_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.clin_sum_desc')
  }
  fields <- c(fields, "clin_sum_desc")
  values <- c(values, if (is.null(clin_sum_desc)) "NULL" else if (is(clin_sum_desc, "subQuery")) paste0("(", as.character(clin_sum_desc), ")") else paste0("'", as.character(clin_sum_desc), "'"))

  if (missing(std_dept_code)) {
    std_dept_code <- defaults$std_dept_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.std_dept_code')
  }
  fields <- c(fields, "std_dept_code")
  values <- c(values, if (is.null(std_dept_code)) "NULL" else if (is(std_dept_code, "subQuery")) paste0("(", as.character(std_dept_code), ")") else paste0("'", as.character(std_dept_code), "'"))

  if (missing(std_dept_desc)) {
    std_dept_desc <- defaults$std_dept_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.std_dept_desc')
  }
  fields <- c(fields, "std_dept_desc")
  values <- c(values, if (is.null(std_dept_desc)) "NULL" else if (is(std_dept_desc, "subQuery")) paste0("(", as.character(std_dept_desc), ")") else paste0("'", as.character(std_dept_desc), "'"))

  if (missing(sum_dept_desc)) {
    sum_dept_desc <- defaults$sum_dept_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.sum_dept_desc')
  }
  fields <- c(fields, "sum_dept_desc")
  values <- c(values, if (is.null(sum_dept_desc)) "NULL" else if (is(sum_dept_desc, "subQuery")) paste0("(", as.character(sum_dept_desc), ")") else paste0("'", as.character(sum_dept_desc), "'"))

  if (missing(prod_cat_code)) {
    prod_cat_code <- defaults$prod_cat_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_cat_code')
  }
  fields <- c(fields, "prod_cat_code")
  values <- c(values, if (is.null(prod_cat_code)) "NULL" else if (is(prod_cat_code, "subQuery")) paste0("(", as.character(prod_cat_code), ")") else paste0("'", as.character(prod_cat_code), "'"))

  if (missing(prod_cat_desc)) {
    prod_cat_desc <- defaults$prod_cat_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_cat_desc')
  }
  fields <- c(fields, "prod_cat_desc")
  values <- c(values, if (is.null(prod_cat_desc)) "NULL" else if (is(prod_cat_desc, "subQuery")) paste0("(", as.character(prod_cat_desc), ")") else paste0("'", as.character(prod_cat_desc), "'"))

  if (missing(prod_class_code)) {
    prod_class_code <- defaults$prod_class_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_class_code')
  }
  fields <- c(fields, "prod_class_code")
  values <- c(values, if (is.null(prod_class_code)) "NULL" else if (is(prod_class_code, "subQuery")) paste0("(", as.character(prod_class_code), ")") else paste0("'", as.character(prod_class_code), "'"))

  if (missing(prod_class_desc)) {
    prod_class_desc <- defaults$prod_class_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_class_desc')
  }
  fields <- c(fields, "prod_class_desc")
  values <- c(values, if (is.null(prod_class_desc)) "NULL" else if (is(prod_class_desc, "subQuery")) paste0("(", as.character(prod_class_desc), ")") else paste0("'", as.character(prod_class_desc), "'"))

  if (missing(prod_name_code)) {
    prod_name_code <- defaults$prod_name_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_name_code')
  }
  fields <- c(fields, "prod_name_code")
  values <- c(values, if (is.null(prod_name_code)) "NULL" else if (is(prod_name_code, "subQuery")) paste0("(", as.character(prod_name_code), ")") else paste0("'", as.character(prod_name_code), "'"))

  if (missing(prod_name_desc)) {
    prod_name_desc <- defaults$prod_name_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_name_desc')
  }
  fields <- c(fields, "prod_name_desc")
  values <- c(values, if (is.null(prod_name_desc)) "NULL" else if (is(prod_name_desc, "subQuery")) paste0("(", as.character(prod_name_desc), ")") else paste0("'", as.character(prod_name_desc), "'"))

  if (missing(prod_name_meth_code)) {
    prod_name_meth_code <- defaults$prod_name_meth_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_name_meth_code')
  }
  fields <- c(fields, "prod_name_meth_code")
  values <- c(values, if (is.null(prod_name_meth_code)) "NULL" else if (is(prod_name_meth_code, "subQuery")) paste0("(", as.character(prod_name_meth_code), ")") else paste0("'", as.character(prod_name_meth_code), "'"))

  if (missing(prod_name_meth_desc)) {
    prod_name_meth_desc <- defaults$prod_name_meth_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'chgmstr.prod_name_meth_desc')
  }
  fields <- c(fields, "prod_name_meth_desc")
  values <- c(values, if (is.null(prod_name_meth_desc)) "NULL" else if (is(prod_name_meth_desc, "subQuery")) paste0("(", as.character(prod_name_meth_desc), ")") else paste0("'", as.character(prod_name_meth_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "chgmstr", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_pattype <- function(pat_type, pat_type_desc) {
  defaults <- get('pattype', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_type)) {
    pat_type <- defaults$pat_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pattype.pat_type')
  }
  fields <- c(fields, "pat_type")
  values <- c(values, if (is.null(pat_type)) "NULL" else if (is(pat_type, "subQuery")) paste0("(", as.character(pat_type), ")") else paste0("'", as.character(pat_type), "'"))

  if (missing(pat_type_desc)) {
    pat_type_desc <- defaults$pat_type_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pattype.pat_type_desc')
  }
  fields <- c(fields, "pat_type_desc")
  values <- c(values, if (is.null(pat_type_desc)) "NULL" else if (is(pat_type_desc, "subQuery")) paste0("(", as.character(pat_type_desc), ")") else paste0("'", as.character(pat_type_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "pattype", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_version <- function(version_id, version_date) {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(version_id)) {
    version_id <- defaults$version_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'version.version_id')
  }
  fields <- c(fields, "version_id")
  values <- c(values, if (is.null(version_id)) "NULL" else if (is(version_id, "subQuery")) paste0("(", as.character(version_id), ")") else paste0("'", as.character(version_id), "'"))

  if (missing(version_date)) {
    version_date <- defaults$version_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'version.version_date')
  }
  fields <- c(fields, "version_date")
  values <- c(values, if (is.null(version_date)) "NULL" else if (is(version_date, "subQuery")) paste0("(", as.character(version_date), ")") else paste0("'", as.character(version_date), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "_version", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_paticd_diag <- function(pat_key, icd_version, icd_code, icd_pri_sec, icd_poa) {
  defaults <- get('paticd_diag', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_diag.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(icd_version)) {
    icd_version <- defaults$icd_version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_diag.icd_version')
  }
  fields <- c(fields, "icd_version")
  values <- c(values, if (is.null(icd_version)) "NULL" else if (is(icd_version, "subQuery")) paste0("(", as.character(icd_version), ")") else paste0("'", as.character(icd_version), "'"))

  if (missing(icd_code)) {
    icd_code <- defaults$icd_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_diag.icd_code')
  }
  fields <- c(fields, "icd_code")
  values <- c(values, if (is.null(icd_code)) "NULL" else if (is(icd_code, "subQuery")) paste0("(", as.character(icd_code), ")") else paste0("'", as.character(icd_code), "'"))

  if (missing(icd_pri_sec)) {
    icd_pri_sec <- defaults$icd_pri_sec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_diag.icd_pri_sec')
  }
  fields <- c(fields, "icd_pri_sec")
  values <- c(values, if (is.null(icd_pri_sec)) "NULL" else if (is(icd_pri_sec, "subQuery")) paste0("(", as.character(icd_pri_sec), ")") else paste0("'", as.character(icd_pri_sec), "'"))

  if (missing(icd_poa)) {
    icd_poa <- defaults$icd_poa
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_diag.icd_poa')
  }
  fields <- c(fields, "icd_poa")
  values <- c(values, if (is.null(icd_poa)) "NULL" else if (is(icd_poa, "subQuery")) paste0("(", as.character(icd_poa), ")") else paste0("'", as.character(icd_poa), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "paticd_diag", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_patbill <- function(pat_key, std_chg_code, hosp_chg_id, serv_date, hosp_qty, std_qty, bill_charges, bill_cost, bill_var_cost, bill_fix_cost) {
  defaults <- get('patbill', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(std_chg_code)) {
    std_chg_code <- defaults$std_chg_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.std_chg_code')
  }
  fields <- c(fields, "std_chg_code")
  values <- c(values, if (is.null(std_chg_code)) "NULL" else if (is(std_chg_code, "subQuery")) paste0("(", as.character(std_chg_code), ")") else paste0("'", as.character(std_chg_code), "'"))

  if (missing(hosp_chg_id)) {
    hosp_chg_id <- defaults$hosp_chg_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.hosp_chg_id')
  }
  fields <- c(fields, "hosp_chg_id")
  values <- c(values, if (is.null(hosp_chg_id)) "NULL" else if (is(hosp_chg_id, "subQuery")) paste0("(", as.character(hosp_chg_id), ")") else paste0("'", as.character(hosp_chg_id), "'"))

  if (missing(serv_date)) {
    serv_date <- defaults$serv_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.serv_date')
  }
  fields <- c(fields, "serv_date")
  values <- c(values, if (is.null(serv_date)) "NULL" else if (is(serv_date, "subQuery")) paste0("(", as.character(serv_date), ")") else paste0("'", as.character(serv_date), "'"))

  if (missing(hosp_qty)) {
    hosp_qty <- defaults$hosp_qty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.hosp_qty')
  }
  fields <- c(fields, "hosp_qty")
  values <- c(values, if (is.null(hosp_qty)) "NULL" else if (is(hosp_qty, "subQuery")) paste0("(", as.character(hosp_qty), ")") else paste0("'", as.character(hosp_qty), "'"))

  if (missing(std_qty)) {
    std_qty <- defaults$std_qty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.std_qty')
  }
  fields <- c(fields, "std_qty")
  values <- c(values, if (is.null(std_qty)) "NULL" else if (is(std_qty, "subQuery")) paste0("(", as.character(std_qty), ")") else paste0("'", as.character(std_qty), "'"))

  if (missing(bill_charges)) {
    bill_charges <- defaults$bill_charges
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.bill_charges')
  }
  fields <- c(fields, "bill_charges")
  values <- c(values, if (is.null(bill_charges)) "NULL" else if (is(bill_charges, "subQuery")) paste0("(", as.character(bill_charges), ")") else paste0("'", as.character(bill_charges), "'"))

  if (missing(bill_cost)) {
    bill_cost <- defaults$bill_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.bill_cost')
  }
  fields <- c(fields, "bill_cost")
  values <- c(values, if (is.null(bill_cost)) "NULL" else if (is(bill_cost, "subQuery")) paste0("(", as.character(bill_cost), ")") else paste0("'", as.character(bill_cost), "'"))

  if (missing(bill_var_cost)) {
    bill_var_cost <- defaults$bill_var_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.bill_var_cost')
  }
  fields <- c(fields, "bill_var_cost")
  values <- c(values, if (is.null(bill_var_cost)) "NULL" else if (is(bill_var_cost, "subQuery")) paste0("(", as.character(bill_var_cost), ")") else paste0("'", as.character(bill_var_cost), "'"))

  if (missing(bill_fix_cost)) {
    bill_fix_cost <- defaults$bill_fix_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'patbill.bill_fix_cost')
  }
  fields <- c(fields, "bill_fix_cost")
  values <- c(values, if (is.null(bill_fix_cost)) "NULL" else if (is(bill_fix_cost, "subQuery")) paste0("(", as.character(bill_fix_cost), ")") else paste0("'", as.character(bill_fix_cost), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "patbill", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_msdrgmdc <- function(ms_drg_mdc, ms_drg_mdc_desc) {
  defaults <- get('msdrgmdc', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(ms_drg_mdc)) {
    ms_drg_mdc <- defaults$ms_drg_mdc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'msdrgmdc.ms_drg_mdc')
  }
  fields <- c(fields, "ms_drg_mdc")
  values <- c(values, if (is.null(ms_drg_mdc)) "NULL" else if (is(ms_drg_mdc, "subQuery")) paste0("(", as.character(ms_drg_mdc), ")") else paste0("'", as.character(ms_drg_mdc), "'"))

  if (missing(ms_drg_mdc_desc)) {
    ms_drg_mdc_desc <- defaults$ms_drg_mdc_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'msdrgmdc.ms_drg_mdc_desc')
  }
  fields <- c(fields, "ms_drg_mdc_desc")
  values <- c(values, if (is.null(ms_drg_mdc_desc)) "NULL" else if (is(ms_drg_mdc_desc, "subQuery")) paste0("(", as.character(ms_drg_mdc_desc), ")") else paste0("'", as.character(ms_drg_mdc_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "msdrgmdc", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_payor <- function(std_payor, std_payor_desc) {
  defaults <- get('payor', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(std_payor)) {
    std_payor <- defaults$std_payor
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'payor.std_payor')
  }
  fields <- c(fields, "std_payor")
  values <- c(values, if (is.null(std_payor)) "NULL" else if (is(std_payor, "subQuery")) paste0("(", as.character(std_payor), ")") else paste0("'", as.character(std_payor), "'"))

  if (missing(std_payor_desc)) {
    std_payor_desc <- defaults$std_payor_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'payor.std_payor_desc')
  }
  fields <- c(fields, "std_payor_desc")
  values <- c(values, if (is.null(std_payor_desc)) "NULL" else if (is(std_payor_desc, "subQuery")) paste0("(", as.character(std_payor_desc), ")") else paste0("'", as.character(std_payor_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "payor", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_vitals <- function(pat_key, facility_test_name, observation_datetime, result_datetime, lab_test_loinc_code, lab_test, lab_test_code_type, lab_test_result, lab_test_result_unit, lab_test_result_status, numeric_value_operator, test_result_numeric_value, abnormal_flag) {
  defaults <- get('vitals', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(facility_test_name)) {
    facility_test_name <- defaults$facility_test_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.facility_test_name')
  }
  fields <- c(fields, "facility_test_name")
  values <- c(values, if (is.null(facility_test_name)) "NULL" else if (is(facility_test_name, "subQuery")) paste0("(", as.character(facility_test_name), ")") else paste0("'", as.character(facility_test_name), "'"))

  if (missing(observation_datetime)) {
    observation_datetime <- defaults$observation_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.observation_datetime')
  }
  fields <- c(fields, "observation_datetime")
  values <- c(values, if (is.null(observation_datetime)) "NULL" else if (is(observation_datetime, "subQuery")) paste0("(", as.character(observation_datetime), ")") else paste0("'", as.character(observation_datetime), "'"))

  if (missing(result_datetime)) {
    result_datetime <- defaults$result_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.result_datetime')
  }
  fields <- c(fields, "result_datetime")
  values <- c(values, if (is.null(result_datetime)) "NULL" else if (is(result_datetime, "subQuery")) paste0("(", as.character(result_datetime), ")") else paste0("'", as.character(result_datetime), "'"))

  if (missing(lab_test_loinc_code)) {
    lab_test_loinc_code <- defaults$lab_test_loinc_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.lab_test_loinc_code')
  }
  fields <- c(fields, "lab_test_loinc_code")
  values <- c(values, if (is.null(lab_test_loinc_code)) "NULL" else if (is(lab_test_loinc_code, "subQuery")) paste0("(", as.character(lab_test_loinc_code), ")") else paste0("'", as.character(lab_test_loinc_code), "'"))

  if (missing(lab_test)) {
    lab_test <- defaults$lab_test
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.lab_test')
  }
  fields <- c(fields, "lab_test")
  values <- c(values, if (is.null(lab_test)) "NULL" else if (is(lab_test, "subQuery")) paste0("(", as.character(lab_test), ")") else paste0("'", as.character(lab_test), "'"))

  if (missing(lab_test_code_type)) {
    lab_test_code_type <- defaults$lab_test_code_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.lab_test_code_type')
  }
  fields <- c(fields, "lab_test_code_type")
  values <- c(values, if (is.null(lab_test_code_type)) "NULL" else if (is(lab_test_code_type, "subQuery")) paste0("(", as.character(lab_test_code_type), ")") else paste0("'", as.character(lab_test_code_type), "'"))

  if (missing(lab_test_result)) {
    lab_test_result <- defaults$lab_test_result
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.lab_test_result')
  }
  fields <- c(fields, "lab_test_result")
  values <- c(values, if (is.null(lab_test_result)) "NULL" else if (is(lab_test_result, "subQuery")) paste0("(", as.character(lab_test_result), ")") else paste0("'", as.character(lab_test_result), "'"))

  if (missing(lab_test_result_unit)) {
    lab_test_result_unit <- defaults$lab_test_result_unit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.lab_test_result_unit')
  }
  fields <- c(fields, "lab_test_result_unit")
  values <- c(values, if (is.null(lab_test_result_unit)) "NULL" else if (is(lab_test_result_unit, "subQuery")) paste0("(", as.character(lab_test_result_unit), ")") else paste0("'", as.character(lab_test_result_unit), "'"))

  if (missing(lab_test_result_status)) {
    lab_test_result_status <- defaults$lab_test_result_status
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.lab_test_result_status')
  }
  fields <- c(fields, "lab_test_result_status")
  values <- c(values, if (is.null(lab_test_result_status)) "NULL" else if (is(lab_test_result_status, "subQuery")) paste0("(", as.character(lab_test_result_status), ")") else paste0("'", as.character(lab_test_result_status), "'"))

  if (missing(numeric_value_operator)) {
    numeric_value_operator <- defaults$numeric_value_operator
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.numeric_value_operator')
  }
  fields <- c(fields, "numeric_value_operator")
  values <- c(values, if (is.null(numeric_value_operator)) "NULL" else if (is(numeric_value_operator, "subQuery")) paste0("(", as.character(numeric_value_operator), ")") else paste0("'", as.character(numeric_value_operator), "'"))

  if (missing(test_result_numeric_value)) {
    test_result_numeric_value <- defaults$test_result_numeric_value
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.test_result_numeric_value')
  }
  fields <- c(fields, "test_result_numeric_value")
  values <- c(values, if (is.null(test_result_numeric_value)) "NULL" else if (is(test_result_numeric_value, "subQuery")) paste0("(", as.character(test_result_numeric_value), ")") else paste0("'", as.character(test_result_numeric_value), "'"))

  if (missing(abnormal_flag)) {
    abnormal_flag <- defaults$abnormal_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'vitals.abnormal_flag')
  }
  fields <- c(fields, "abnormal_flag")
  values <- c(values, if (is.null(abnormal_flag)) "NULL" else if (is(abnormal_flag, "subQuery")) paste0("(", as.character(abnormal_flag), ")") else paste0("'", as.character(abnormal_flag), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "vitals", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_icdcode <- function(icd_version, icd_code, icd_desc, ccs_cat_level1_code, ccs_cat_level1_desc, ccs_cat_level2_code, ccs_cat_level2_desc, icd_diag_proc, icd_diag_proc_desc) {
  defaults <- get('icdcode', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(icd_version)) {
    icd_version <- defaults$icd_version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.icd_version')
  }
  fields <- c(fields, "icd_version")
  values <- c(values, if (is.null(icd_version)) "NULL" else if (is(icd_version, "subQuery")) paste0("(", as.character(icd_version), ")") else paste0("'", as.character(icd_version), "'"))

  if (missing(icd_code)) {
    icd_code <- defaults$icd_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.icd_code')
  }
  fields <- c(fields, "icd_code")
  values <- c(values, if (is.null(icd_code)) "NULL" else if (is(icd_code, "subQuery")) paste0("(", as.character(icd_code), ")") else paste0("'", as.character(icd_code), "'"))

  if (missing(icd_desc)) {
    icd_desc <- defaults$icd_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.icd_desc')
  }
  fields <- c(fields, "icd_desc")
  values <- c(values, if (is.null(icd_desc)) "NULL" else if (is(icd_desc, "subQuery")) paste0("(", as.character(icd_desc), ")") else paste0("'", as.character(icd_desc), "'"))

  if (missing(ccs_cat_level1_code)) {
    ccs_cat_level1_code <- defaults$ccs_cat_level1_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.ccs_cat_level1_code')
  }
  fields <- c(fields, "ccs_cat_level1_code")
  values <- c(values, if (is.null(ccs_cat_level1_code)) "NULL" else if (is(ccs_cat_level1_code, "subQuery")) paste0("(", as.character(ccs_cat_level1_code), ")") else paste0("'", as.character(ccs_cat_level1_code), "'"))

  if (missing(ccs_cat_level1_desc)) {
    ccs_cat_level1_desc <- defaults$ccs_cat_level1_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.ccs_cat_level1_desc')
  }
  fields <- c(fields, "ccs_cat_level1_desc")
  values <- c(values, if (is.null(ccs_cat_level1_desc)) "NULL" else if (is(ccs_cat_level1_desc, "subQuery")) paste0("(", as.character(ccs_cat_level1_desc), ")") else paste0("'", as.character(ccs_cat_level1_desc), "'"))

  if (missing(ccs_cat_level2_code)) {
    ccs_cat_level2_code <- defaults$ccs_cat_level2_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.ccs_cat_level2_code')
  }
  fields <- c(fields, "ccs_cat_level2_code")
  values <- c(values, if (is.null(ccs_cat_level2_code)) "NULL" else if (is(ccs_cat_level2_code, "subQuery")) paste0("(", as.character(ccs_cat_level2_code), ")") else paste0("'", as.character(ccs_cat_level2_code), "'"))

  if (missing(ccs_cat_level2_desc)) {
    ccs_cat_level2_desc <- defaults$ccs_cat_level2_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.ccs_cat_level2_desc')
  }
  fields <- c(fields, "ccs_cat_level2_desc")
  values <- c(values, if (is.null(ccs_cat_level2_desc)) "NULL" else if (is(ccs_cat_level2_desc, "subQuery")) paste0("(", as.character(ccs_cat_level2_desc), ")") else paste0("'", as.character(ccs_cat_level2_desc), "'"))

  if (missing(icd_diag_proc)) {
    icd_diag_proc <- defaults$icd_diag_proc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.icd_diag_proc')
  }
  fields <- c(fields, "icd_diag_proc")
  values <- c(values, if (is.null(icd_diag_proc)) "NULL" else if (is(icd_diag_proc, "subQuery")) paste0("(", as.character(icd_diag_proc), ")") else paste0("'", as.character(icd_diag_proc), "'"))

  if (missing(icd_diag_proc_desc)) {
    icd_diag_proc_desc <- defaults$icd_diag_proc_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdcode.icd_diag_proc_desc')
  }
  fields <- c(fields, "icd_diag_proc_desc")
  values <- c(values, if (is.null(icd_diag_proc_desc)) "NULL" else if (is(icd_diag_proc_desc, "subQuery")) paste0("(", as.character(icd_diag_proc_desc), ")") else paste0("'", as.character(icd_diag_proc_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "icdcode", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_prov_enrollment <- function(prov_id, disc_mon, ip_dx_count, op_dx_count, all_dx_count, ip_min_dx_date, op_min_dx_date, all_min_dx_date, ip_max_dx_date, op_max_dx_date, all_max_dx_date, ip_proj_wgt) {
  defaults <- get('prov_enrollment', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(prov_id)) {
    prov_id <- defaults$prov_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.prov_id')
  }
  fields <- c(fields, "prov_id")
  values <- c(values, if (is.null(prov_id)) "NULL" else if (is(prov_id, "subQuery")) paste0("(", as.character(prov_id), ")") else paste0("'", as.character(prov_id), "'"))

  if (missing(disc_mon)) {
    disc_mon <- defaults$disc_mon
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.disc_mon')
  }
  fields <- c(fields, "disc_mon")
  values <- c(values, if (is.null(disc_mon)) "NULL" else if (is(disc_mon, "subQuery")) paste0("(", as.character(disc_mon), ")") else paste0("'", as.character(disc_mon), "'"))

  if (missing(ip_dx_count)) {
    ip_dx_count <- defaults$ip_dx_count
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.ip_dx_count')
  }
  fields <- c(fields, "ip_dx_count")
  values <- c(values, if (is.null(ip_dx_count)) "NULL" else if (is(ip_dx_count, "subQuery")) paste0("(", as.character(ip_dx_count), ")") else paste0("'", as.character(ip_dx_count), "'"))

  if (missing(op_dx_count)) {
    op_dx_count <- defaults$op_dx_count
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.op_dx_count')
  }
  fields <- c(fields, "op_dx_count")
  values <- c(values, if (is.null(op_dx_count)) "NULL" else if (is(op_dx_count, "subQuery")) paste0("(", as.character(op_dx_count), ")") else paste0("'", as.character(op_dx_count), "'"))

  if (missing(all_dx_count)) {
    all_dx_count <- defaults$all_dx_count
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.all_dx_count')
  }
  fields <- c(fields, "all_dx_count")
  values <- c(values, if (is.null(all_dx_count)) "NULL" else if (is(all_dx_count, "subQuery")) paste0("(", as.character(all_dx_count), ")") else paste0("'", as.character(all_dx_count), "'"))

  if (missing(ip_min_dx_date)) {
    ip_min_dx_date <- defaults$ip_min_dx_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.ip_min_dx_date')
  }
  fields <- c(fields, "ip_min_dx_date")
  values <- c(values, if (is.null(ip_min_dx_date)) "NULL" else if (is(ip_min_dx_date, "subQuery")) paste0("(", as.character(ip_min_dx_date), ")") else paste0("'", as.character(ip_min_dx_date), "'"))

  if (missing(op_min_dx_date)) {
    op_min_dx_date <- defaults$op_min_dx_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.op_min_dx_date')
  }
  fields <- c(fields, "op_min_dx_date")
  values <- c(values, if (is.null(op_min_dx_date)) "NULL" else if (is(op_min_dx_date, "subQuery")) paste0("(", as.character(op_min_dx_date), ")") else paste0("'", as.character(op_min_dx_date), "'"))

  if (missing(all_min_dx_date)) {
    all_min_dx_date <- defaults$all_min_dx_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.all_min_dx_date')
  }
  fields <- c(fields, "all_min_dx_date")
  values <- c(values, if (is.null(all_min_dx_date)) "NULL" else if (is(all_min_dx_date, "subQuery")) paste0("(", as.character(all_min_dx_date), ")") else paste0("'", as.character(all_min_dx_date), "'"))

  if (missing(ip_max_dx_date)) {
    ip_max_dx_date <- defaults$ip_max_dx_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.ip_max_dx_date')
  }
  fields <- c(fields, "ip_max_dx_date")
  values <- c(values, if (is.null(ip_max_dx_date)) "NULL" else if (is(ip_max_dx_date, "subQuery")) paste0("(", as.character(ip_max_dx_date), ")") else paste0("'", as.character(ip_max_dx_date), "'"))

  if (missing(op_max_dx_date)) {
    op_max_dx_date <- defaults$op_max_dx_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.op_max_dx_date')
  }
  fields <- c(fields, "op_max_dx_date")
  values <- c(values, if (is.null(op_max_dx_date)) "NULL" else if (is(op_max_dx_date, "subQuery")) paste0("(", as.character(op_max_dx_date), ")") else paste0("'", as.character(op_max_dx_date), "'"))

  if (missing(all_max_dx_date)) {
    all_max_dx_date <- defaults$all_max_dx_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.all_max_dx_date')
  }
  fields <- c(fields, "all_max_dx_date")
  values <- c(values, if (is.null(all_max_dx_date)) "NULL" else if (is(all_max_dx_date, "subQuery")) paste0("(", as.character(all_max_dx_date), ")") else paste0("'", as.character(all_max_dx_date), "'"))

  if (missing(ip_proj_wgt)) {
    ip_proj_wgt <- defaults$ip_proj_wgt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'prov_enrollment.ip_proj_wgt')
  }
  fields <- c(fields, "ip_proj_wgt")
  values <- c(values, if (is.null(ip_proj_wgt)) "NULL" else if (is(ip_proj_wgt, "subQuery")) paste0("(", as.character(ip_proj_wgt), ")") else paste0("'", as.character(ip_proj_wgt), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "prov_enrollment", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_genlab <- function(pat_key, order_key, collection_datetime, specimen_source_snomed_code, specimen_source_snomed_desc, lab_test_loinc_code, lab_test_loinc_desc, lab_test_code_type, lab_test_result_datetime, lab_test_result, result_unit, lab_test_result_status, reference_interval, numeric_value, numeric_value_operator, flags) {
  defaults <- get('genlab', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(order_key)) {
    order_key <- defaults$order_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.order_key')
  }
  fields <- c(fields, "order_key")
  values <- c(values, if (is.null(order_key)) "NULL" else if (is(order_key, "subQuery")) paste0("(", as.character(order_key), ")") else paste0("'", as.character(order_key), "'"))

  if (missing(collection_datetime)) {
    collection_datetime <- defaults$collection_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.collection_datetime')
  }
  fields <- c(fields, "collection_datetime")
  values <- c(values, if (is.null(collection_datetime)) "NULL" else if (is(collection_datetime, "subQuery")) paste0("(", as.character(collection_datetime), ")") else paste0("'", as.character(collection_datetime), "'"))

  if (missing(specimen_source_snomed_code)) {
    specimen_source_snomed_code <- defaults$specimen_source_snomed_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.specimen_source_snomed_code')
  }
  fields <- c(fields, "specimen_source_snomed_code")
  values <- c(values, if (is.null(specimen_source_snomed_code)) "NULL" else if (is(specimen_source_snomed_code, "subQuery")) paste0("(", as.character(specimen_source_snomed_code), ")") else paste0("'", as.character(specimen_source_snomed_code), "'"))

  if (missing(specimen_source_snomed_desc)) {
    specimen_source_snomed_desc <- defaults$specimen_source_snomed_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.specimen_source_snomed_desc')
  }
  fields <- c(fields, "specimen_source_snomed_desc")
  values <- c(values, if (is.null(specimen_source_snomed_desc)) "NULL" else if (is(specimen_source_snomed_desc, "subQuery")) paste0("(", as.character(specimen_source_snomed_desc), ")") else paste0("'", as.character(specimen_source_snomed_desc), "'"))

  if (missing(lab_test_loinc_code)) {
    lab_test_loinc_code <- defaults$lab_test_loinc_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.lab_test_loinc_code')
  }
  fields <- c(fields, "lab_test_loinc_code")
  values <- c(values, if (is.null(lab_test_loinc_code)) "NULL" else if (is(lab_test_loinc_code, "subQuery")) paste0("(", as.character(lab_test_loinc_code), ")") else paste0("'", as.character(lab_test_loinc_code), "'"))

  if (missing(lab_test_loinc_desc)) {
    lab_test_loinc_desc <- defaults$lab_test_loinc_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.lab_test_loinc_desc')
  }
  fields <- c(fields, "lab_test_loinc_desc")
  values <- c(values, if (is.null(lab_test_loinc_desc)) "NULL" else if (is(lab_test_loinc_desc, "subQuery")) paste0("(", as.character(lab_test_loinc_desc), ")") else paste0("'", as.character(lab_test_loinc_desc), "'"))

  if (missing(lab_test_code_type)) {
    lab_test_code_type <- defaults$lab_test_code_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.lab_test_code_type')
  }
  fields <- c(fields, "lab_test_code_type")
  values <- c(values, if (is.null(lab_test_code_type)) "NULL" else if (is(lab_test_code_type, "subQuery")) paste0("(", as.character(lab_test_code_type), ")") else paste0("'", as.character(lab_test_code_type), "'"))

  if (missing(lab_test_result_datetime)) {
    lab_test_result_datetime <- defaults$lab_test_result_datetime
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.lab_test_result_datetime')
  }
  fields <- c(fields, "lab_test_result_datetime")
  values <- c(values, if (is.null(lab_test_result_datetime)) "NULL" else if (is(lab_test_result_datetime, "subQuery")) paste0("(", as.character(lab_test_result_datetime), ")") else paste0("'", as.character(lab_test_result_datetime), "'"))

  if (missing(lab_test_result)) {
    lab_test_result <- defaults$lab_test_result
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.lab_test_result')
  }
  fields <- c(fields, "lab_test_result")
  values <- c(values, if (is.null(lab_test_result)) "NULL" else if (is(lab_test_result, "subQuery")) paste0("(", as.character(lab_test_result), ")") else paste0("'", as.character(lab_test_result), "'"))

  if (missing(result_unit)) {
    result_unit <- defaults$result_unit
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.result_unit')
  }
  fields <- c(fields, "result_unit")
  values <- c(values, if (is.null(result_unit)) "NULL" else if (is(result_unit, "subQuery")) paste0("(", as.character(result_unit), ")") else paste0("'", as.character(result_unit), "'"))

  if (missing(lab_test_result_status)) {
    lab_test_result_status <- defaults$lab_test_result_status
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.lab_test_result_status')
  }
  fields <- c(fields, "lab_test_result_status")
  values <- c(values, if (is.null(lab_test_result_status)) "NULL" else if (is(lab_test_result_status, "subQuery")) paste0("(", as.character(lab_test_result_status), ")") else paste0("'", as.character(lab_test_result_status), "'"))

  if (missing(reference_interval)) {
    reference_interval <- defaults$reference_interval
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.reference_interval')
  }
  fields <- c(fields, "reference_interval")
  values <- c(values, if (is.null(reference_interval)) "NULL" else if (is(reference_interval, "subQuery")) paste0("(", as.character(reference_interval), ")") else paste0("'", as.character(reference_interval), "'"))

  if (missing(numeric_value)) {
    numeric_value <- defaults$numeric_value
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.numeric_value')
  }
  fields <- c(fields, "numeric_value")
  values <- c(values, if (is.null(numeric_value)) "NULL" else if (is(numeric_value, "subQuery")) paste0("(", as.character(numeric_value), ")") else paste0("'", as.character(numeric_value), "'"))

  if (missing(numeric_value_operator)) {
    numeric_value_operator <- defaults$numeric_value_operator
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.numeric_value_operator')
  }
  fields <- c(fields, "numeric_value_operator")
  values <- c(values, if (is.null(numeric_value_operator)) "NULL" else if (is(numeric_value_operator, "subQuery")) paste0("(", as.character(numeric_value_operator), ")") else paste0("'", as.character(numeric_value_operator), "'"))

  if (missing(flags)) {
    flags <- defaults$flags
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'genlab.flags')
  }
  fields <- c(fields, "flags")
  values <- c(values, if (is.null(flags)) "NULL" else if (is(flags, "subQuery")) paste0("(", as.character(flags), ")") else paste0("'", as.character(flags), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "genlab", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_aprdrg <- function(apr_drg, apr_drg_desc) {
  defaults <- get('aprdrg', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(apr_drg)) {
    apr_drg <- defaults$apr_drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'aprdrg.apr_drg')
  }
  fields <- c(fields, "apr_drg")
  values <- c(values, if (is.null(apr_drg)) "NULL" else if (is(apr_drg, "subQuery")) paste0("(", as.character(apr_drg), ")") else paste0("'", as.character(apr_drg), "'"))

  if (missing(apr_drg_desc)) {
    apr_drg_desc <- defaults$apr_drg_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'aprdrg.apr_drg_desc')
  }
  fields <- c(fields, "apr_drg_desc")
  values <- c(values, if (is.null(apr_drg_desc)) "NULL" else if (is(apr_drg_desc, "subQuery")) paste0("(", as.character(apr_drg_desc), ")") else paste0("'", as.character(apr_drg_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "aprdrg", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_providers <- function(prov_id, urban_rural, teaching, beds_grp, prov_region, prov_division, cost_type) {
  defaults <- get('providers', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(prov_id)) {
    prov_id <- defaults$prov_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'providers.prov_id')
  }
  fields <- c(fields, "prov_id")
  values <- c(values, if (is.null(prov_id)) "NULL" else if (is(prov_id, "subQuery")) paste0("(", as.character(prov_id), ")") else paste0("'", as.character(prov_id), "'"))

  if (missing(urban_rural)) {
    urban_rural <- defaults$urban_rural
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'providers.urban_rural')
  }
  fields <- c(fields, "urban_rural")
  values <- c(values, if (is.null(urban_rural)) "NULL" else if (is(urban_rural, "subQuery")) paste0("(", as.character(urban_rural), ")") else paste0("'", as.character(urban_rural), "'"))

  if (missing(teaching)) {
    teaching <- defaults$teaching
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'providers.teaching')
  }
  fields <- c(fields, "teaching")
  values <- c(values, if (is.null(teaching)) "NULL" else if (is(teaching, "subQuery")) paste0("(", as.character(teaching), ")") else paste0("'", as.character(teaching), "'"))

  if (missing(beds_grp)) {
    beds_grp <- defaults$beds_grp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'providers.beds_grp')
  }
  fields <- c(fields, "beds_grp")
  values <- c(values, if (is.null(beds_grp)) "NULL" else if (is(beds_grp, "subQuery")) paste0("(", as.character(beds_grp), ")") else paste0("'", as.character(beds_grp), "'"))

  if (missing(prov_region)) {
    prov_region <- defaults$prov_region
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'providers.prov_region')
  }
  fields <- c(fields, "prov_region")
  values <- c(values, if (is.null(prov_region)) "NULL" else if (is(prov_region, "subQuery")) paste0("(", as.character(prov_region), ")") else paste0("'", as.character(prov_region), "'"))

  if (missing(prov_division)) {
    prov_division <- defaults$prov_division
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'providers.prov_division')
  }
  fields <- c(fields, "prov_division")
  values <- c(values, if (is.null(prov_division)) "NULL" else if (is(prov_division, "subQuery")) paste0("(", as.character(prov_division), ")") else paste0("'", as.character(prov_division), "'"))

  if (missing(cost_type)) {
    cost_type <- defaults$cost_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'providers.cost_type')
  }
  fields <- c(fields, "cost_type")
  values <- c(values, if (is.null(cost_type)) "NULL" else if (is(cost_type, "subQuery")) paste0("(", as.character(cost_type), ")") else paste0("'", as.character(cost_type), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "providers", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_paticd_proc <- function(pat_key, icd_version, icd_code, icd_pri_sec, proc_date, proc_phy, procphy_spec) {
  defaults <- get('paticd_proc', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(pat_key)) {
    pat_key <- defaults$pat_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_proc.pat_key')
  }
  fields <- c(fields, "pat_key")
  values <- c(values, if (is.null(pat_key)) "NULL" else if (is(pat_key, "subQuery")) paste0("(", as.character(pat_key), ")") else paste0("'", as.character(pat_key), "'"))

  if (missing(icd_version)) {
    icd_version <- defaults$icd_version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_proc.icd_version')
  }
  fields <- c(fields, "icd_version")
  values <- c(values, if (is.null(icd_version)) "NULL" else if (is(icd_version, "subQuery")) paste0("(", as.character(icd_version), ")") else paste0("'", as.character(icd_version), "'"))

  if (missing(icd_code)) {
    icd_code <- defaults$icd_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_proc.icd_code')
  }
  fields <- c(fields, "icd_code")
  values <- c(values, if (is.null(icd_code)) "NULL" else if (is(icd_code, "subQuery")) paste0("(", as.character(icd_code), ")") else paste0("'", as.character(icd_code), "'"))

  if (missing(icd_pri_sec)) {
    icd_pri_sec <- defaults$icd_pri_sec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_proc.icd_pri_sec')
  }
  fields <- c(fields, "icd_pri_sec")
  values <- c(values, if (is.null(icd_pri_sec)) "NULL" else if (is(icd_pri_sec, "subQuery")) paste0("(", as.character(icd_pri_sec), ")") else paste0("'", as.character(icd_pri_sec), "'"))

  if (missing(proc_date)) {
    proc_date <- defaults$proc_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_proc.proc_date')
  }
  fields <- c(fields, "proc_date")
  values <- c(values, if (is.null(proc_date)) "NULL" else if (is(proc_date, "subQuery")) paste0("(", as.character(proc_date), ")") else paste0("'", as.character(proc_date), "'"))

  if (missing(proc_phy)) {
    proc_phy <- defaults$proc_phy
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_proc.proc_phy')
  }
  fields <- c(fields, "proc_phy")
  values <- c(values, if (is.null(proc_phy)) "NULL" else if (is(proc_phy, "subQuery")) paste0("(", as.character(proc_phy), ")") else paste0("'", as.character(proc_phy), "'"))

  if (missing(procphy_spec)) {
    procphy_spec <- defaults$procphy_spec
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'paticd_proc.procphy_spec')
  }
  fields <- c(fields, "procphy_spec")
  values <- c(values, if (is.null(procphy_spec)) "NULL" else if (is(procphy_spec, "subQuery")) paste0("(", as.character(procphy_spec), ")") else paste0("'", as.character(procphy_spec), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "paticd_proc", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_cptcode <- function(cpt_code, cpt_desc) {
  defaults <- get('cptcode', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(cpt_code)) {
    cpt_code <- defaults$cpt_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'cptcode.cpt_code')
  }
  fields <- c(fields, "cpt_code")
  values <- c(values, if (is.null(cpt_code)) "NULL" else if (is(cpt_code, "subQuery")) paste0("(", as.character(cpt_code), ")") else paste0("'", as.character(cpt_code), "'"))

  if (missing(cpt_desc)) {
    cpt_desc <- defaults$cpt_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'cptcode.cpt_desc')
  }
  fields <- c(fields, "cpt_desc")
  values <- c(values, if (is.null(cpt_desc)) "NULL" else if (is(cpt_desc, "subQuery")) paste0("(", as.character(cpt_desc), ")") else paste0("'", as.character(cpt_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "cptcode", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_icdpoa <- function(icd_poa, icd_poa_desc, icd_poa_sum_desc) {
  defaults <- get('icdpoa', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(icd_poa)) {
    icd_poa <- defaults$icd_poa
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdpoa.icd_poa')
  }
  fields <- c(fields, "icd_poa")
  values <- c(values, if (is.null(icd_poa)) "NULL" else if (is(icd_poa, "subQuery")) paste0("(", as.character(icd_poa), ")") else paste0("'", as.character(icd_poa), "'"))

  if (missing(icd_poa_desc)) {
    icd_poa_desc <- defaults$icd_poa_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdpoa.icd_poa_desc')
  }
  fields <- c(fields, "icd_poa_desc")
  values <- c(values, if (is.null(icd_poa_desc)) "NULL" else if (is(icd_poa_desc, "subQuery")) paste0("(", as.character(icd_poa_desc), ")") else paste0("'", as.character(icd_poa_desc), "'"))

  if (missing(icd_poa_sum_desc)) {
    icd_poa_sum_desc <- defaults$icd_poa_sum_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icdpoa.icd_poa_sum_desc')
  }
  fields <- c(fields, "icd_poa_sum_desc")
  values <- c(values, if (is.null(icd_poa_sum_desc)) "NULL" else if (is(icd_poa_sum_desc, "subQuery")) paste0("(", as.character(icd_poa_sum_desc), ")") else paste0("'", as.character(icd_poa_sum_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "icdpoa", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

expect_person <- function(person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_id')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_concept_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.year_of_birth')
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.month_of_birth')
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.day_of_birth')
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.birth_datetime')
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_concept_id')
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.location_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.care_site_id')
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_source_value')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_concept_id')
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_value')
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_concept_id')
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_value')
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "person", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.person_id')
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_start_date')
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_end_date')
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.period_type_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "observation_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.person_id')
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_concept_id')
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_date')
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_datetime')
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_date')
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_datetime')
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.care_site_id')
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_value')
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_concept_id')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_source_value')
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.preceding_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "visit_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_visit_detail <- function(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.person_id')
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_concept_id')
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_date')
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_datetime')
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_date')
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_datetime')
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.care_site_id')
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_value')
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_source_value')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_concept_id')
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.preceding_visit_detail_id')
  }

  if (!missing(parent_visit_detail_id)) {
    fields <- c(fields, "parent_visit_detail_id")
    values <- c(values, if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.parent_visit_detail_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "visit_detail", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_concept_id')
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_date')
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_datetime')
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_date')
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_datetime')
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_type_concept_id')
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.stop_reason')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_detail_id')
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_value')
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_concept_id')
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "condition_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_concept_id')
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_date')
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_datetime')
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_date')
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_datetime')
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.verbatim_end_date')
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_type_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.stop_reason')
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.refills')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.quantity')
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.days_supply')
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.sig')
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_concept_id')
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.lot_number')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_detail_id')
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_value')
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_concept_id')
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_source_value')
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.dose_unit_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "drug_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.person_id')
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_concept_id')
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_date')
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_datetime')
  }

  if (!missing(procedure_end_date)) {
    fields <- c(fields, "procedure_end_date")
    values <- c(values, if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_date')
  }

  if (!missing(procedure_end_datetime)) {
    fields <- c(fields, "procedure_end_datetime")
    values <- c(values, if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_datetime')
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_type_concept_id')
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_concept_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_detail_id')
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_value')
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_concept_id')
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "procedure_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.person_id')
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_concept_id')
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_date')
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_datetime')
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_date')
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_datetime')
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_type_concept_id')
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unique_device_id')
  }

  if (!missing(production_id)) {
    fields <- c(fields, "production_id")
    values <- c(values, if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.production_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_detail_id')
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_value')
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "device_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.person_id')
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_concept_id')
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_date')
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_datetime')
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_time')
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_type_concept_id')
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.operator_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_number')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_concept_id')
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_low')
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_high')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_detail_id')
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_value')
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_concept_id')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_source_value')
  }

  if (!missing(measurement_event_id)) {
    fields <- c(fields, "measurement_event_id")
    values <- c(values, if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_event_id')
  }

  if (!missing(meas_event_field_concept_id)) {
    fields <- c(fields, "meas_event_field_concept_id")
    values <- c(values, if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.meas_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "measurement", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.person_id')
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_concept_id')
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_date')
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_datetime')
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_type_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_number')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_concept_id')
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_detail_id')
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_value')
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_source_value')
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_source_value')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_source_value')
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_event_id')
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.obs_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "observation", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_death <- function(person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.person_id')
  }

  if (!missing(death_date)) {
    fields <- c(fields, "death_date")
    values <- c(values, if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_date')
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_datetime')
  }

  if (!missing(death_type_concept_id)) {
    fields <- c(fields, "death_type_concept_id")
    values <- c(values, if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_type_concept_id')
  }

  if (!missing(cause_concept_id)) {
    fields <- c(fields, "cause_concept_id")
    values <- c(values, if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_concept_id')
  }

  if (!missing(cause_source_value)) {
    fields <- c(fields, "cause_source_value")
    values <- c(values, if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_value')
  }

  if (!missing(cause_source_concept_id)) {
    fields <- c(fields, "cause_source_concept_id")
    values <- c(values, if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "death", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_note <- function(note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.person_id')
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_date')
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_datetime')
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_type_concept_id')
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_class_concept_id')
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_title')
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_text')
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.encoding_concept_id')
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.language_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_detail_id')
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_source_value')
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_id')
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "note", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_note_nlp <- function(note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_id')
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_id')
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.section_concept_id')
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.snippet')
  }

  if (!missing("offset")) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null("offset")) " IS NULL" else if (is("offset", "subQuery")) paste0(" = (", as.character("offset"), ")") else paste0(" = '", as.character("offset"), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp."offset"')
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.lexical_variant')
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_concept_id')
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_source_concept_id')
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_system')
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_date')
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_datetime')
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_exists')
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_temporal')
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_modifiers')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "note_nlp", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.person_id')
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_concept_id')
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_type_concept_id')
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_date')
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_datetime')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.quantity')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_concept_id')
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_concept_id')
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_concept_id')
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_id')
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_value')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_source_value')
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_source_value')
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "specimen", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_1')
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_1')
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_2')
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_2')
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.relationship_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "fact_relationship", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_location <- function(location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_id')
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_1')
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_2')
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.city')
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.state')
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.zip')
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.county')
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_source_value')
  }

  if (!missing(country_concept_id)) {
    fields <- c(fields, "country_concept_id")
    values <- c(values, if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_concept_id')
  }

  if (!missing(country_source_value)) {
    fields <- c(fields, "country_source_value")
    values <- c(values, if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_source_value')
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.latitude')
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.longitude')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "location", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_id')
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_name')
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.location_id')
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_source_value')
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "care_site", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_id')
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_name')
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.npi')
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.dea')
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_concept_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.care_site_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.year_of_birth')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_concept_id')
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_source_value')
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_value')
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_concept_id')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "provider", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_payer_plan_period <- function(payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.person_id')
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_start_date')
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_end_date')
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_concept_id')
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_value')
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_concept_id')
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_concept_id')
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_value')
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_concept_id')
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_concept_id')
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_value')
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_concept_id')
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.family_source_value')
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_concept_id')
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_value')
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "payer_plan_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cost <- function(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_id')
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_id')
  }

  if (!missing(cost_domain_id)) {
    fields <- c(fields, "cost_domain_id")
    values <- c(values, if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_domain_id')
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_type_concept_id')
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.currency_concept_id')
  }

  if (!missing(total_charge)) {
    fields <- c(fields, "total_charge")
    values <- c(values, if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_charge')
  }

  if (!missing(total_cost)) {
    fields <- c(fields, "total_cost")
    values <- c(values, if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_cost')
  }

  if (!missing(total_paid)) {
    fields <- c(fields, "total_paid")
    values <- c(values, if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_paid')
  }

  if (!missing(paid_by_payer)) {
    fields <- c(fields, "paid_by_payer")
    values <- c(values, if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_payer')
  }

  if (!missing(paid_by_patient)) {
    fields <- c(fields, "paid_by_patient")
    values <- c(values, if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_patient')
  }

  if (!missing(paid_patient_copay)) {
    fields <- c(fields, "paid_patient_copay")
    values <- c(values, if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_copay')
  }

  if (!missing(paid_patient_coinsurance)) {
    fields <- c(fields, "paid_patient_coinsurance")
    values <- c(values, if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_coinsurance')
  }

  if (!missing(paid_patient_deductible)) {
    fields <- c(fields, "paid_patient_deductible")
    values <- c(values, if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_deductible')
  }

  if (!missing(paid_by_primary)) {
    fields <- c(fields, "paid_by_primary")
    values <- c(values, if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_primary')
  }

  if (!missing(paid_ingredient_cost)) {
    fields <- c(fields, "paid_ingredient_cost")
    values <- c(values, if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_ingredient_cost')
  }

  if (!missing(paid_dispensing_fee)) {
    fields <- c(fields, "paid_dispensing_fee")
    values <- c(values, if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_dispensing_fee')
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.payer_plan_period_id')
  }

  if (!missing(amount_allowed)) {
    fields <- c(fields, "amount_allowed")
    values <- c(values, if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.amount_allowed')
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_concept_id')
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_source_value')
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_concept_id')
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cost", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_concept_id')
  }

  if (!missing(drug_era_start_date)) {
    fields <- c(fields, "drug_era_start_date")
    values <- c(values, if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_start_date')
  }

  if (!missing(drug_era_end_date)) {
    fields <- c(fields, "drug_era_end_date")
    values <- c(values, if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_end_date')
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_exposure_count')
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.gap_days')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "drug_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.drug_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.unit_concept_id')
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_value')
  }

  if (!missing(dose_era_start_date)) {
    fields <- c(fields, "dose_era_start_date")
    values <- c(values, if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_start_date')
  }

  if (!missing(dose_era_end_date)) {
    fields <- c(fields, "dose_era_end_date")
    values <- c(values, if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "dose_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_concept_id')
  }

  if (!missing(condition_era_start_date)) {
    fields <- c(fields, "condition_era_start_date")
    values <- c(values, if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_start_date')
  }

  if (!missing(condition_era_end_date)) {
    fields <- c(fields, "condition_era_end_date")
    values <- c(values, if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_end_date')
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_occurrence_count')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "condition_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_episode <- function(episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.person_id')
  }

  if (!missing(episode_concept_id)) {
    fields <- c(fields, "episode_concept_id")
    values <- c(values, if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_concept_id')
  }

  if (!missing(episode_start_date)) {
    fields <- c(fields, "episode_start_date")
    values <- c(values, if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_date')
  }

  if (!missing(episode_start_datetime)) {
    fields <- c(fields, "episode_start_datetime")
    values <- c(values, if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_datetime')
  }

  if (!missing(episode_end_date)) {
    fields <- c(fields, "episode_end_date")
    values <- c(values, if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_date')
  }

  if (!missing(episode_end_datetime)) {
    fields <- c(fields, "episode_end_datetime")
    values <- c(values, if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_datetime')
  }

  if (!missing(episode_parent_id)) {
    fields <- c(fields, "episode_parent_id")
    values <- c(values, if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_parent_id')
  }

  if (!missing(episode_number)) {
    fields <- c(fields, "episode_number")
    values <- c(values, if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_number')
  }

  if (!missing(episode_object_concept_id)) {
    fields <- c(fields, "episode_object_concept_id")
    values <- c(values, if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_object_concept_id')
  }

  if (!missing(episode_type_concept_id)) {
    fields <- c(fields, "episode_type_concept_id")
    values <- c(values, if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_type_concept_id')
  }

  if (!missing(episode_source_value)) {
    fields <- c(fields, "episode_source_value")
    values <- c(values, if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_value')
  }

  if (!missing(episode_source_concept_id)) {
    fields <- c(fields, "episode_source_concept_id")
    values <- c(values, if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "episode", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_episode_event <- function(episode_id, event_id, episode_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_id')
  }

  if (!missing(event_id)) {
    fields <- c(fields, "event_id")
    values <- c(values, if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.event_id')
  }

  if (!missing(episode_event_field_concept_id)) {
    fields <- c(fields, "episode_event_field_concept_id")
    values <- c(values, if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "episode_event", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_metadata <- function(metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_id)) {
    fields <- c(fields, "metadata_id")
    values <- c(values, if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_id')
  }

  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_concept_id')
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_type_concept_id')
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.name')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_number')
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "metadata_date")
    values <- c(values, if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_date')
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "metadata", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_name')
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_abbreviation')
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_holder')
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_description')
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_documentation_reference')
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_etl_reference')
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_release_date')
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_release_date')
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version')
  }

  if (!missing(cdm_version_concept_id)) {
    fields <- c(fields, "cdm_version_concept_id")
    values <- c(values, if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version_concept_id')
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.vocabulary_version')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cdm_source", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cohort <- function(cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_definition_id')
  }

  if (!missing(subject_id)) {
    fields <- c(fields, "subject_id")
    values <- c(values, if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.subject_id')
  }

  if (!missing(cohort_start_date)) {
    fields <- c(fields, "cohort_start_date")
    values <- c(values, if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_start_date')
  }

  if (!missing(cohort_end_date)) {
    fields <- c(fields, "cohort_end_date")
    values <- c(values, if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cohort", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cohort_definition <- function(cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_id')
  }

  if (!missing(cohort_definition_name)) {
    fields <- c(fields, "cohort_definition_name")
    values <- c(values, if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_name')
  }

  if (!missing(cohort_definition_description)) {
    fields <- c(fields, "cohort_definition_description")
    values <- c(values, if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_description')
  }

  if (!missing(definition_type_concept_id)) {
    fields <- c(fields, "definition_type_concept_id")
    values <- c(values, if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.definition_type_concept_id')
  }

  if (!missing(cohort_definition_syntax)) {
    fields <- c(fields, "cohort_definition_syntax")
    values <- c(values, if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_syntax')
  }

  if (!missing(subject_concept_id)) {
    fields <- c(fields, "subject_concept_id")
    values <- c(values, if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.subject_concept_id')
  }

  if (!missing(cohort_initiation_date)) {
    fields <- c(fields, "cohort_initiation_date")
    values <- c(values, if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_initiation_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cohort_definition", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_person <- function(person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "person", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "observation_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "visit_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_visit_detail <- function(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
  }

  if (!missing(parent_visit_detail_id)) {
    fields <- c(fields, "parent_visit_detail_id")
    values <- c(values, if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "visit_detail", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "condition_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "drug_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
  }

  if (!missing(procedure_end_date)) {
    fields <- c(fields, "procedure_end_date")
    values <- c(values, if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
  }

  if (!missing(procedure_end_datetime)) {
    fields <- c(fields, "procedure_end_datetime")
    values <- c(values, if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "procedure_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
  }

  if (!missing(production_id)) {
    fields <- c(fields, "production_id")
    values <- c(values, if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "device_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(measurement_event_id)) {
    fields <- c(fields, "measurement_event_id")
    values <- c(values, if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
  }

  if (!missing(meas_event_field_concept_id)) {
    fields <- c(fields, "meas_event_field_concept_id")
    values <- c(values, if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "measurement", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "observation", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_death <- function(person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(death_date)) {
    fields <- c(fields, "death_date")
    values <- c(values, if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
  }

  if (!missing(death_type_concept_id)) {
    fields <- c(fields, "death_type_concept_id")
    values <- c(values, if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
  }

  if (!missing(cause_concept_id)) {
    fields <- c(fields, "cause_concept_id")
    values <- c(values, if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
  }

  if (!missing(cause_source_value)) {
    fields <- c(fields, "cause_source_value")
    values <- c(values, if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
  }

  if (!missing(cause_source_concept_id)) {
    fields <- c(fields, "cause_source_concept_id")
    values <- c(values, if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "death", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_note <- function(note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "note", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_note_nlp <- function(note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
  }

  if (!missing("offset")) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null("offset")) " IS NULL" else if (is("offset", "subQuery")) paste0(" = (", as.character("offset"), ")") else paste0(" = '", as.character("offset"), "'"))
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "note_nlp", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "specimen", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "fact_relationship", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_location <- function(location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
  }

  if (!missing(country_concept_id)) {
    fields <- c(fields, "country_concept_id")
    values <- c(values, if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
  }

  if (!missing(country_source_value)) {
    fields <- c(fields, "country_source_value")
    values <- c(values, if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "location", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "care_site", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "provider", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_payer_plan_period <- function(payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "payer_plan_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cost <- function(cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
  }

  if (!missing(cost_domain_id)) {
    fields <- c(fields, "cost_domain_id")
    values <- c(values, if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
  }

  if (!missing(total_charge)) {
    fields <- c(fields, "total_charge")
    values <- c(values, if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
  }

  if (!missing(total_cost)) {
    fields <- c(fields, "total_cost")
    values <- c(values, if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
  }

  if (!missing(total_paid)) {
    fields <- c(fields, "total_paid")
    values <- c(values, if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
  }

  if (!missing(paid_by_payer)) {
    fields <- c(fields, "paid_by_payer")
    values <- c(values, if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
  }

  if (!missing(paid_by_patient)) {
    fields <- c(fields, "paid_by_patient")
    values <- c(values, if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
  }

  if (!missing(paid_patient_copay)) {
    fields <- c(fields, "paid_patient_copay")
    values <- c(values, if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
  }

  if (!missing(paid_patient_coinsurance)) {
    fields <- c(fields, "paid_patient_coinsurance")
    values <- c(values, if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
  }

  if (!missing(paid_patient_deductible)) {
    fields <- c(fields, "paid_patient_deductible")
    values <- c(values, if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
  }

  if (!missing(paid_by_primary)) {
    fields <- c(fields, "paid_by_primary")
    values <- c(values, if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
  }

  if (!missing(paid_ingredient_cost)) {
    fields <- c(fields, "paid_ingredient_cost")
    values <- c(values, if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
  }

  if (!missing(paid_dispensing_fee)) {
    fields <- c(fields, "paid_dispensing_fee")
    values <- c(values, if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(amount_allowed)) {
    fields <- c(fields, "amount_allowed")
    values <- c(values, if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cost", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_era_start_date)) {
    fields <- c(fields, "drug_era_start_date")
    values <- c(values, if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
  }

  if (!missing(drug_era_end_date)) {
    fields <- c(fields, "drug_era_end_date")
    values <- c(values, if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "drug_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
  }

  if (!missing(dose_era_start_date)) {
    fields <- c(fields, "dose_era_start_date")
    values <- c(values, if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
  }

  if (!missing(dose_era_end_date)) {
    fields <- c(fields, "dose_era_end_date")
    values <- c(values, if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "dose_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_era_start_date)) {
    fields <- c(fields, "condition_era_start_date")
    values <- c(values, if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
  }

  if (!missing(condition_era_end_date)) {
    fields <- c(fields, "condition_era_end_date")
    values <- c(values, if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "condition_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_episode <- function(episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(episode_concept_id)) {
    fields <- c(fields, "episode_concept_id")
    values <- c(values, if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
  }

  if (!missing(episode_start_date)) {
    fields <- c(fields, "episode_start_date")
    values <- c(values, if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
  }

  if (!missing(episode_start_datetime)) {
    fields <- c(fields, "episode_start_datetime")
    values <- c(values, if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
  }

  if (!missing(episode_end_date)) {
    fields <- c(fields, "episode_end_date")
    values <- c(values, if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
  }

  if (!missing(episode_end_datetime)) {
    fields <- c(fields, "episode_end_datetime")
    values <- c(values, if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
  }

  if (!missing(episode_parent_id)) {
    fields <- c(fields, "episode_parent_id")
    values <- c(values, if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
  }

  if (!missing(episode_number)) {
    fields <- c(fields, "episode_number")
    values <- c(values, if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
  }

  if (!missing(episode_object_concept_id)) {
    fields <- c(fields, "episode_object_concept_id")
    values <- c(values, if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
  }

  if (!missing(episode_type_concept_id)) {
    fields <- c(fields, "episode_type_concept_id")
    values <- c(values, if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
  }

  if (!missing(episode_source_value)) {
    fields <- c(fields, "episode_source_value")
    values <- c(values, if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
  }

  if (!missing(episode_source_concept_id)) {
    fields <- c(fields, "episode_source_concept_id")
    values <- c(values, if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "episode", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_episode_event <- function(episode_id, event_id, episode_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(event_id)) {
    fields <- c(fields, "event_id")
    values <- c(values, if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
  }

  if (!missing(episode_event_field_concept_id)) {
    fields <- c(fields, "episode_event_field_concept_id")
    values <- c(values, if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "episode_event", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_metadata <- function(metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_id)) {
    fields <- c(fields, "metadata_id")
    values <- c(values, if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
  }

  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "metadata_date")
    values <- c(values, if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "metadata", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
  }

  if (!missing(cdm_version_concept_id)) {
    fields <- c(fields, "cdm_version_concept_id")
    values <- c(values, if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cdm_source", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cohort <- function(cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(subject_id)) {
    fields <- c(fields, "subject_id")
    values <- c(values, if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
  }

  if (!missing(cohort_start_date)) {
    fields <- c(fields, "cohort_start_date")
    values <- c(values, if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
  }

  if (!missing(cohort_end_date)) {
    fields <- c(fields, "cohort_end_date")
    values <- c(values, if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cohort", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cohort_definition <- function(cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(cohort_definition_name)) {
    fields <- c(fields, "cohort_definition_name")
    values <- c(values, if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
  }

  if (!missing(cohort_definition_description)) {
    fields <- c(fields, "cohort_definition_description")
    values <- c(values, if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
  }

  if (!missing(definition_type_concept_id)) {
    fields <- c(fields, "definition_type_concept_id")
    values <- c(values, if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
  }

  if (!missing(cohort_definition_syntax)) {
    fields <- c(fields, "cohort_definition_syntax")
    values <- c(values, if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
  }

  if (!missing(subject_concept_id)) {
    fields <- c(fields, "subject_concept_id")
    values <- c(values, if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
  }

  if (!missing(cohort_initiation_date)) {
    fields <- c(fields, "cohort_initiation_date")
    values <- c(values, if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cohort_definition", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_person <- function(rowCount, person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_id')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_concept_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.year_of_birth')
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.month_of_birth')
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.day_of_birth')
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.birth_datetime')
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_concept_id')
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.location_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.care_site_id')
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_source_value')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_concept_id')
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_value')
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_concept_id')
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_value')
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "person", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_observation_period <- function(rowCount, observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.person_id')
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_start_date')
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_end_date')
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.period_type_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "observation_period", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_visit_occurrence <- function(rowCount, visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.person_id')
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_concept_id')
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_date')
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_datetime')
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_date')
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_datetime')
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.care_site_id')
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_value')
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitted_from_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_concept_id')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharged_to_source_value')
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.preceding_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "visit_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_visit_detail <- function(rowCount, visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.person_id')
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_concept_id')
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_date')
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_datetime')
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_date')
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_datetime')
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.care_site_id')
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_value')
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_concept_id')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_source_value')
  }

  if (!missing(discharged_to_source_value)) {
    fields <- c(fields, "discharged_to_source_value")
    values <- c(values, if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_source_value')
  }

  if (!missing(discharged_to_concept_id)) {
    fields <- c(fields, "discharged_to_concept_id")
    values <- c(values, if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharged_to_concept_id')
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.preceding_visit_detail_id')
  }

  if (!missing(parent_visit_detail_id)) {
    fields <- c(fields, "parent_visit_detail_id")
    values <- c(values, if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.parent_visit_detail_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "visit_detail", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_condition_occurrence <- function(rowCount, condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_concept_id')
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_date')
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_datetime')
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_date')
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_datetime')
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_type_concept_id')
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.stop_reason')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_detail_id')
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_value')
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_concept_id')
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "condition_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_drug_exposure <- function(rowCount, drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_concept_id')
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_date')
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_datetime')
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_date')
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_datetime')
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.verbatim_end_date')
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_type_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.stop_reason')
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.refills')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.quantity')
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.days_supply')
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.sig')
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_concept_id')
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.lot_number')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_detail_id')
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_value')
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_concept_id')
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_source_value')
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.dose_unit_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "drug_exposure", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_procedure_occurrence <- function(rowCount, procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.person_id')
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_concept_id')
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_date')
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_datetime')
  }

  if (!missing(procedure_end_date)) {
    fields <- c(fields, "procedure_end_date")
    values <- c(values, if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_date')
  }

  if (!missing(procedure_end_datetime)) {
    fields <- c(fields, "procedure_end_datetime")
    values <- c(values, if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_end_datetime')
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_type_concept_id')
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_concept_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_detail_id')
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_value')
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_concept_id')
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "procedure_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_device_exposure <- function(rowCount, device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.person_id')
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_concept_id')
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_date')
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_datetime')
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_date')
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_datetime')
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_type_concept_id')
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unique_device_id')
  }

  if (!missing(production_id)) {
    fields <- c(fields, "production_id")
    values <- c(values, if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.production_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_detail_id')
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_value')
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unit_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "device_exposure", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_measurement <- function(rowCount, measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.person_id')
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_concept_id')
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_date')
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_datetime')
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_time')
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_type_concept_id')
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.operator_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_number')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_concept_id')
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_low')
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_high')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_detail_id')
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_value')
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_value')
  }

  if (!missing(unit_source_concept_id)) {
    fields <- c(fields, "unit_source_concept_id")
    values <- c(values, if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_concept_id')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_source_value')
  }

  if (!missing(measurement_event_id)) {
    fields <- c(fields, "measurement_event_id")
    values <- c(values, if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_event_id')
  }

  if (!missing(meas_event_field_concept_id)) {
    fields <- c(fields, "meas_event_field_concept_id")
    values <- c(values, if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.meas_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "measurement", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_observation <- function(rowCount, observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.person_id')
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_concept_id')
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_date')
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_datetime')
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_type_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_number')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_concept_id')
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_detail_id')
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_value')
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_source_value')
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_source_value')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_source_value')
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_event_id')
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.obs_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "observation", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_death <- function(rowCount, person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.person_id')
  }

  if (!missing(death_date)) {
    fields <- c(fields, "death_date")
    values <- c(values, if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_date')
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_datetime')
  }

  if (!missing(death_type_concept_id)) {
    fields <- c(fields, "death_type_concept_id")
    values <- c(values, if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.death_type_concept_id')
  }

  if (!missing(cause_concept_id)) {
    fields <- c(fields, "cause_concept_id")
    values <- c(values, if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_concept_id')
  }

  if (!missing(cause_source_value)) {
    fields <- c(fields, "cause_source_value")
    values <- c(values, if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_value')
  }

  if (!missing(cause_source_concept_id)) {
    fields <- c(fields, "cause_source_concept_id")
    values <- c(values, if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'death.cause_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "death", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_note <- function(rowCount, note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.person_id')
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_date')
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_datetime')
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_type_concept_id')
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_class_concept_id')
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_title')
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_text')
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.encoding_concept_id')
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.language_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_detail_id')
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_source_value')
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_id')
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "note", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_note_nlp <- function(rowCount, note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_id')
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_id')
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.section_concept_id')
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.snippet')
  }

  if (!missing("offset")) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null("offset")) " IS NULL" else if (is("offset", "subQuery")) paste0(" = (", as.character("offset"), ")") else paste0(" = '", as.character("offset"), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp."offset"')
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.lexical_variant')
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_concept_id')
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_source_concept_id')
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_system')
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_date')
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_datetime')
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_exists')
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_temporal')
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_modifiers')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "note_nlp", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_specimen <- function(rowCount, specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.person_id')
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_concept_id')
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_type_concept_id')
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_date')
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_datetime')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.quantity')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_concept_id')
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_concept_id')
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_concept_id')
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_id')
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_value')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_source_value')
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_source_value')
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "specimen", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_fact_relationship <- function(rowCount, domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_1')
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_1')
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_2')
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_2')
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.relationship_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "fact_relationship", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_location <- function(rowCount, location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_id')
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_1')
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_2')
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.city')
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.state')
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.zip')
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.county')
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_source_value')
  }

  if (!missing(country_concept_id)) {
    fields <- c(fields, "country_concept_id")
    values <- c(values, if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_concept_id')
  }

  if (!missing(country_source_value)) {
    fields <- c(fields, "country_source_value")
    values <- c(values, if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country_source_value')
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.latitude')
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.longitude')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "location", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_care_site <- function(rowCount, care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_id')
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_name')
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.location_id')
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_source_value')
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "care_site", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_provider <- function(rowCount, provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_id')
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_name')
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.npi')
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.dea')
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_concept_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.care_site_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.year_of_birth')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_concept_id')
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_source_value')
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_value')
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_concept_id')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "provider", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_payer_plan_period <- function(rowCount, payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.person_id')
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_start_date')
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_end_date')
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_concept_id')
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_value')
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_concept_id')
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_concept_id')
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_value')
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_concept_id')
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_concept_id')
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_value')
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_concept_id')
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.family_source_value')
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_concept_id')
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_value')
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "payer_plan_period", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cost <- function(rowCount, cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_id')
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_id')
  }

  if (!missing(cost_domain_id)) {
    fields <- c(fields, "cost_domain_id")
    values <- c(values, if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_domain_id')
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_type_concept_id')
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.currency_concept_id')
  }

  if (!missing(total_charge)) {
    fields <- c(fields, "total_charge")
    values <- c(values, if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_charge')
  }

  if (!missing(total_cost)) {
    fields <- c(fields, "total_cost")
    values <- c(values, if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_cost')
  }

  if (!missing(total_paid)) {
    fields <- c(fields, "total_paid")
    values <- c(values, if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.total_paid')
  }

  if (!missing(paid_by_payer)) {
    fields <- c(fields, "paid_by_payer")
    values <- c(values, if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_payer')
  }

  if (!missing(paid_by_patient)) {
    fields <- c(fields, "paid_by_patient")
    values <- c(values, if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_patient')
  }

  if (!missing(paid_patient_copay)) {
    fields <- c(fields, "paid_patient_copay")
    values <- c(values, if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_copay')
  }

  if (!missing(paid_patient_coinsurance)) {
    fields <- c(fields, "paid_patient_coinsurance")
    values <- c(values, if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_coinsurance')
  }

  if (!missing(paid_patient_deductible)) {
    fields <- c(fields, "paid_patient_deductible")
    values <- c(values, if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_patient_deductible')
  }

  if (!missing(paid_by_primary)) {
    fields <- c(fields, "paid_by_primary")
    values <- c(values, if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_by_primary')
  }

  if (!missing(paid_ingredient_cost)) {
    fields <- c(fields, "paid_ingredient_cost")
    values <- c(values, if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_ingredient_cost')
  }

  if (!missing(paid_dispensing_fee)) {
    fields <- c(fields, "paid_dispensing_fee")
    values <- c(values, if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_dispensing_fee')
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.payer_plan_period_id')
  }

  if (!missing(amount_allowed)) {
    fields <- c(fields, "amount_allowed")
    values <- c(values, if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.amount_allowed')
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_concept_id')
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_source_value')
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_concept_id')
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cost", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_drug_era <- function(rowCount, drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_concept_id')
  }

  if (!missing(drug_era_start_date)) {
    fields <- c(fields, "drug_era_start_date")
    values <- c(values, if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_start_date')
  }

  if (!missing(drug_era_end_date)) {
    fields <- c(fields, "drug_era_end_date")
    values <- c(values, if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_end_date')
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_exposure_count')
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.gap_days')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "drug_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_dose_era <- function(rowCount, dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.drug_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.unit_concept_id')
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_value')
  }

  if (!missing(dose_era_start_date)) {
    fields <- c(fields, "dose_era_start_date")
    values <- c(values, if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_start_date')
  }

  if (!missing(dose_era_end_date)) {
    fields <- c(fields, "dose_era_end_date")
    values <- c(values, if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "dose_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_condition_era <- function(rowCount, condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_concept_id')
  }

  if (!missing(condition_era_start_date)) {
    fields <- c(fields, "condition_era_start_date")
    values <- c(values, if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_start_date')
  }

  if (!missing(condition_era_end_date)) {
    fields <- c(fields, "condition_era_end_date")
    values <- c(values, if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_end_date')
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_occurrence_count')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "condition_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_episode <- function(rowCount, episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.person_id')
  }

  if (!missing(episode_concept_id)) {
    fields <- c(fields, "episode_concept_id")
    values <- c(values, if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_concept_id')
  }

  if (!missing(episode_start_date)) {
    fields <- c(fields, "episode_start_date")
    values <- c(values, if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_date')
  }

  if (!missing(episode_start_datetime)) {
    fields <- c(fields, "episode_start_datetime")
    values <- c(values, if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_start_datetime')
  }

  if (!missing(episode_end_date)) {
    fields <- c(fields, "episode_end_date")
    values <- c(values, if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_date')
  }

  if (!missing(episode_end_datetime)) {
    fields <- c(fields, "episode_end_datetime")
    values <- c(values, if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_end_datetime')
  }

  if (!missing(episode_parent_id)) {
    fields <- c(fields, "episode_parent_id")
    values <- c(values, if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_parent_id')
  }

  if (!missing(episode_number)) {
    fields <- c(fields, "episode_number")
    values <- c(values, if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_number')
  }

  if (!missing(episode_object_concept_id)) {
    fields <- c(fields, "episode_object_concept_id")
    values <- c(values, if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_object_concept_id')
  }

  if (!missing(episode_type_concept_id)) {
    fields <- c(fields, "episode_type_concept_id")
    values <- c(values, if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_type_concept_id')
  }

  if (!missing(episode_source_value)) {
    fields <- c(fields, "episode_source_value")
    values <- c(values, if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_value')
  }

  if (!missing(episode_source_concept_id)) {
    fields <- c(fields, "episode_source_concept_id")
    values <- c(values, if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode.episode_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "episode", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_episode_event <- function(rowCount, episode_id, event_id, episode_event_field_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(episode_id)) {
    fields <- c(fields, "episode_id")
    values <- c(values, if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_id')
  }

  if (!missing(event_id)) {
    fields <- c(fields, "event_id")
    values <- c(values, if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.event_id')
  }

  if (!missing(episode_event_field_concept_id)) {
    fields <- c(fields, "episode_event_field_concept_id")
    values <- c(values, if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'episode_event.episode_event_field_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "episode_event", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_metadata <- function(rowCount, metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_id)) {
    fields <- c(fields, "metadata_id")
    values <- c(values, if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_id')
  }

  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_concept_id')
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_type_concept_id')
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.name')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_number')
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "metadata_date")
    values <- c(values, if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_date')
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "metadata", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cdm_source <- function(rowCount, cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_name')
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_abbreviation')
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_holder')
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_description')
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_documentation_reference')
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_etl_reference')
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_release_date')
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_release_date')
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version')
  }

  if (!missing(cdm_version_concept_id)) {
    fields <- c(fields, "cdm_version_concept_id")
    values <- c(values, if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version_concept_id')
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.vocabulary_version')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cdm_source", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cohort <- function(rowCount, cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_definition_id')
  }

  if (!missing(subject_id)) {
    fields <- c(fields, "subject_id")
    values <- c(values, if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.subject_id')
  }

  if (!missing(cohort_start_date)) {
    fields <- c(fields, "cohort_start_date")
    values <- c(values, if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_start_date')
  }

  if (!missing(cohort_end_date)) {
    fields <- c(fields, "cohort_end_date")
    values <- c(values, if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort.cohort_end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cohort", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cohort_definition <- function(rowCount, cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  fields <- c()
  values <- c()
  if (!missing(cohort_definition_id)) {
    fields <- c(fields, "cohort_definition_id")
    values <- c(values, if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_id')
  }

  if (!missing(cohort_definition_name)) {
    fields <- c(fields, "cohort_definition_name")
    values <- c(values, if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_name')
  }

  if (!missing(cohort_definition_description)) {
    fields <- c(fields, "cohort_definition_description")
    values <- c(values, if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_description')
  }

  if (!missing(definition_type_concept_id)) {
    fields <- c(fields, "definition_type_concept_id")
    values <- c(values, if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.definition_type_concept_id')
  }

  if (!missing(cohort_definition_syntax)) {
    fields <- c(fields, "cohort_definition_syntax")
    values <- c(values, if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_definition_syntax')
  }

  if (!missing(subject_concept_id)) {
    fields <- c(fields, "subject_concept_id")
    values <- c(values, if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.subject_concept_id')
  }

  if (!missing(cohort_initiation_date)) {
    fields <- c(fields, "cohort_initiation_date")
    values <- c(values, if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cohort_definition.cohort_initiation_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cohort_definition", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

lookup_person <- function(fetchField, person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.person WHERE')
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_concept_id",if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " year_of_birth",if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(month_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " month_of_birth",if (is.null(month_of_birth)) " IS NULL" else if (is(month_of_birth, "subQuery")) paste0(" = (", as.character(month_of_birth), ")") else paste0(" = '", as.character(month_of_birth), "'"))
  }

  if (!missing(day_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " day_of_birth",if (is.null(day_of_birth)) " IS NULL" else if (is(day_of_birth, "subQuery")) paste0(" = (", as.character(day_of_birth), ")") else paste0(" = '", as.character(day_of_birth), "'"))
  }

  if (!missing(birth_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " birth_datetime",if (is.null(birth_datetime)) " IS NULL" else if (is(birth_datetime, "subQuery")) paste0(" = (", as.character(birth_datetime), ")") else paste0(" = '", as.character(birth_datetime), "'"))
  }

  if (!missing(race_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_concept_id",if (is.null(race_concept_id)) " IS NULL" else if (is(race_concept_id, "subQuery")) paste0(" = (", as.character(race_concept_id), ")") else paste0(" = '", as.character(race_concept_id), "'"))
  }

  if (!missing(ethnicity_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_concept_id",if (is.null(ethnicity_concept_id)) " IS NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_concept_id), ")") else paste0(" = '", as.character(ethnicity_concept_id), "'"))
  }

  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id",if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(person_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_source_value",if (is.null(person_source_value)) " IS NULL" else if (is(person_source_value, "subQuery")) paste0(" = (", as.character(person_source_value), ")") else paste0(" = '", as.character(person_source_value), "'"))
  }

  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_value",if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_concept_id",if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  if (!missing(race_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_source_value",if (is.null(race_source_value)) " IS NULL" else if (is(race_source_value, "subQuery")) paste0(" = (", as.character(race_source_value), ")") else paste0(" = '", as.character(race_source_value), "'"))
  }

  if (!missing(race_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_source_concept_id",if (is.null(race_source_concept_id)) " IS NULL" else if (is(race_source_concept_id, "subQuery")) paste0(" = (", as.character(race_source_concept_id), ")") else paste0(" = '", as.character(race_source_concept_id), "'"))
  }

  if (!missing(ethnicity_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_source_value",if (is.null(ethnicity_source_value)) " IS NULL" else if (is(ethnicity_source_value, "subQuery")) paste0(" = (", as.character(ethnicity_source_value), ")") else paste0(" = '", as.character(ethnicity_source_value), "'"))
  }

  if (!missing(ethnicity_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_source_concept_id",if (is.null(ethnicity_source_concept_id)) " IS NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0(" = (", as.character(ethnicity_source_concept_id), ")") else paste0(" = '", as.character(ethnicity_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_observation_period <- function(fetchField, observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.observation_period WHERE')
  first <- TRUE
  if (!missing(observation_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_id",if (is.null(observation_period_id)) " IS NULL" else if (is(observation_period_id, "subQuery")) paste0(" = (", as.character(observation_period_id), ")") else paste0(" = '", as.character(observation_period_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_start_date",if (is.null(observation_period_start_date)) " IS NULL" else if (is(observation_period_start_date, "subQuery")) paste0(" = (", as.character(observation_period_start_date), ")") else paste0(" = '", as.character(observation_period_start_date), "'"))
  }

  if (!missing(observation_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_end_date",if (is.null(observation_period_end_date)) " IS NULL" else if (is(observation_period_end_date, "subQuery")) paste0(" = (", as.character(observation_period_end_date), ")") else paste0(" = '", as.character(observation_period_end_date), "'"))
  }

  if (!missing(period_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " period_type_concept_id",if (is.null(period_type_concept_id)) " IS NULL" else if (is(period_type_concept_id, "subQuery")) paste0(" = (", as.character(period_type_concept_id), ")") else paste0(" = '", as.character(period_type_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_visit_occurrence <- function(fetchField, visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_concept_id, discharged_to_source_value, preceding_visit_occurrence_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.visit_occurrence WHERE')
  first <- TRUE
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_concept_id",if (is.null(visit_concept_id)) " IS NULL" else if (is(visit_concept_id, "subQuery")) paste0(" = (", as.character(visit_concept_id), ")") else paste0(" = '", as.character(visit_concept_id), "'"))
  }

  if (!missing(visit_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_start_date",if (is.null(visit_start_date)) " IS NULL" else if (is(visit_start_date, "subQuery")) paste0(" = (", as.character(visit_start_date), ")") else paste0(" = '", as.character(visit_start_date), "'"))
  }

  if (!missing(visit_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_start_datetime",if (is.null(visit_start_datetime)) " IS NULL" else if (is(visit_start_datetime, "subQuery")) paste0(" = (", as.character(visit_start_datetime), ")") else paste0(" = '", as.character(visit_start_datetime), "'"))
  }

  if (!missing(visit_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_end_date",if (is.null(visit_end_date)) " IS NULL" else if (is(visit_end_date, "subQuery")) paste0(" = (", as.character(visit_end_date), ")") else paste0(" = '", as.character(visit_end_date), "'"))
  }

  if (!missing(visit_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_end_datetime",if (is.null(visit_end_datetime)) " IS NULL" else if (is(visit_end_datetime, "subQuery")) paste0(" = (", as.character(visit_end_datetime), ")") else paste0(" = '", as.character(visit_end_datetime), "'"))
  }

  if (!missing(visit_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_type_concept_id",if (is.null(visit_type_concept_id)) " IS NULL" else if (is(visit_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_type_concept_id), ")") else paste0(" = '", as.character(visit_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_source_value",if (is.null(visit_source_value)) " IS NULL" else if (is(visit_source_value, "subQuery")) paste0(" = (", as.character(visit_source_value), ")") else paste0(" = '", as.character(visit_source_value), "'"))
  }

  if (!missing(visit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_source_concept_id",if (is.null(visit_source_concept_id)) " IS NULL" else if (is(visit_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_source_concept_id), ")") else paste0(" = '", as.character(visit_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_concept_id",if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_source_value",if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_concept_id",if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_source_value",if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(preceding_visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " preceding_visit_occurrence_id",if (is.null(preceding_visit_occurrence_id)) " IS NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0(" = (", as.character(preceding_visit_occurrence_id), ")") else paste0(" = '", as.character(preceding_visit_occurrence_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_visit_detail <- function(fetchField, visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_concept_id, admitted_from_source_value, discharged_to_source_value, discharged_to_concept_id, preceding_visit_detail_id, parent_visit_detail_id, visit_occurrence_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.visit_detail WHERE')
  first <- TRUE
  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(visit_detail_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_concept_id",if (is.null(visit_detail_concept_id)) " IS NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_concept_id), ")") else paste0(" = '", as.character(visit_detail_concept_id), "'"))
  }

  if (!missing(visit_detail_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_start_date",if (is.null(visit_detail_start_date)) " IS NULL" else if (is(visit_detail_start_date, "subQuery")) paste0(" = (", as.character(visit_detail_start_date), ")") else paste0(" = '", as.character(visit_detail_start_date), "'"))
  }

  if (!missing(visit_detail_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_start_datetime",if (is.null(visit_detail_start_datetime)) " IS NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_start_datetime), ")") else paste0(" = '", as.character(visit_detail_start_datetime), "'"))
  }

  if (!missing(visit_detail_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_end_date",if (is.null(visit_detail_end_date)) " IS NULL" else if (is(visit_detail_end_date, "subQuery")) paste0(" = (", as.character(visit_detail_end_date), ")") else paste0(" = '", as.character(visit_detail_end_date), "'"))
  }

  if (!missing(visit_detail_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_end_datetime",if (is.null(visit_detail_end_datetime)) " IS NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0(" = (", as.character(visit_detail_end_datetime), ")") else paste0(" = '", as.character(visit_detail_end_datetime), "'"))
  }

  if (!missing(visit_detail_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_type_concept_id",if (is.null(visit_detail_type_concept_id)) " IS NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_type_concept_id), ")") else paste0(" = '", as.character(visit_detail_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(visit_detail_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_source_value",if (is.null(visit_detail_source_value)) " IS NULL" else if (is(visit_detail_source_value, "subQuery")) paste0(" = (", as.character(visit_detail_source_value), ")") else paste0(" = '", as.character(visit_detail_source_value), "'"))
  }

  if (!missing(visit_detail_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_source_concept_id",if (is.null(visit_detail_source_concept_id)) " IS NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0(" = (", as.character(visit_detail_source_concept_id), ")") else paste0(" = '", as.character(visit_detail_source_concept_id), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_concept_id",if (is.null(admitted_from_concept_id)) " IS NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0(" = (", as.character(admitted_from_concept_id), ")") else paste0(" = '", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_source_value",if (is.null(admitted_from_source_value)) " IS NULL" else if (is(admitted_from_source_value, "subQuery")) paste0(" = (", as.character(admitted_from_source_value), ")") else paste0(" = '", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(discharged_to_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_source_value",if (is.null(discharged_to_source_value)) " IS NULL" else if (is(discharged_to_source_value, "subQuery")) paste0(" = (", as.character(discharged_to_source_value), ")") else paste0(" = '", as.character(discharged_to_source_value), "'"))
  }

  if (!missing(discharged_to_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharged_to_concept_id",if (is.null(discharged_to_concept_id)) " IS NULL" else if (is(discharged_to_concept_id, "subQuery")) paste0(" = (", as.character(discharged_to_concept_id), ")") else paste0(" = '", as.character(discharged_to_concept_id), "'"))
  }

  if (!missing(preceding_visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " preceding_visit_detail_id",if (is.null(preceding_visit_detail_id)) " IS NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0(" = (", as.character(preceding_visit_detail_id), ")") else paste0(" = '", as.character(preceding_visit_detail_id), "'"))
  }

  if (!missing(parent_visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " parent_visit_detail_id",if (is.null(parent_visit_detail_id)) " IS NULL" else if (is(parent_visit_detail_id, "subQuery")) paste0(" = (", as.character(parent_visit_detail_id), ")") else paste0(" = '", as.character(parent_visit_detail_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_condition_occurrence <- function(fetchField, condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.condition_occurrence WHERE')
  first <- TRUE
  if (!missing(condition_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_occurrence_id",if (is.null(condition_occurrence_id)) " IS NULL" else if (is(condition_occurrence_id, "subQuery")) paste0(" = (", as.character(condition_occurrence_id), ")") else paste0(" = '", as.character(condition_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_concept_id",if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_start_date",if (is.null(condition_start_date)) " IS NULL" else if (is(condition_start_date, "subQuery")) paste0(" = (", as.character(condition_start_date), ")") else paste0(" = '", as.character(condition_start_date), "'"))
  }

  if (!missing(condition_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_start_datetime",if (is.null(condition_start_datetime)) " IS NULL" else if (is(condition_start_datetime, "subQuery")) paste0(" = (", as.character(condition_start_datetime), ")") else paste0(" = '", as.character(condition_start_datetime), "'"))
  }

  if (!missing(condition_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_end_date",if (is.null(condition_end_date)) " IS NULL" else if (is(condition_end_date, "subQuery")) paste0(" = (", as.character(condition_end_date), ")") else paste0(" = '", as.character(condition_end_date), "'"))
  }

  if (!missing(condition_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_end_datetime",if (is.null(condition_end_datetime)) " IS NULL" else if (is(condition_end_datetime, "subQuery")) paste0(" = (", as.character(condition_end_datetime), ")") else paste0(" = '", as.character(condition_end_datetime), "'"))
  }

  if (!missing(condition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_type_concept_id",if (is.null(condition_type_concept_id)) " IS NULL" else if (is(condition_type_concept_id, "subQuery")) paste0(" = (", as.character(condition_type_concept_id), ")") else paste0(" = '", as.character(condition_type_concept_id), "'"))
  }

  if (!missing(condition_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_status_concept_id",if (is.null(condition_status_concept_id)) " IS NULL" else if (is(condition_status_concept_id, "subQuery")) paste0(" = (", as.character(condition_status_concept_id), ")") else paste0(" = '", as.character(condition_status_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason",if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(condition_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_source_value",if (is.null(condition_source_value)) " IS NULL" else if (is(condition_source_value, "subQuery")) paste0(" = (", as.character(condition_source_value), ")") else paste0(" = '", as.character(condition_source_value), "'"))
  }

  if (!missing(condition_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_source_concept_id",if (is.null(condition_source_concept_id)) " IS NULL" else if (is(condition_source_concept_id, "subQuery")) paste0(" = (", as.character(condition_source_concept_id), ")") else paste0(" = '", as.character(condition_source_concept_id), "'"))
  }

  if (!missing(condition_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_status_source_value",if (is.null(condition_status_source_value)) " IS NULL" else if (is(condition_status_source_value, "subQuery")) paste0(" = (", as.character(condition_status_source_value), ")") else paste0(" = '", as.character(condition_status_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_drug_exposure <- function(fetchField, drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.drug_exposure WHERE')
  first <- TRUE
  if (!missing(drug_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_id",if (is.null(drug_exposure_id)) " IS NULL" else if (is(drug_exposure_id, "subQuery")) paste0(" = (", as.character(drug_exposure_id), ")") else paste0(" = '", as.character(drug_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id",if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_start_date",if (is.null(drug_exposure_start_date)) " IS NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0(" = (", as.character(drug_exposure_start_date), ")") else paste0(" = '", as.character(drug_exposure_start_date), "'"))
  }

  if (!missing(drug_exposure_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_start_datetime",if (is.null(drug_exposure_start_datetime)) " IS NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_start_datetime), ")") else paste0(" = '", as.character(drug_exposure_start_datetime), "'"))
  }

  if (!missing(drug_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_end_date",if (is.null(drug_exposure_end_date)) " IS NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0(" = (", as.character(drug_exposure_end_date), ")") else paste0(" = '", as.character(drug_exposure_end_date), "'"))
  }

  if (!missing(drug_exposure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_end_datetime",if (is.null(drug_exposure_end_datetime)) " IS NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(drug_exposure_end_datetime), ")") else paste0(" = '", as.character(drug_exposure_end_datetime), "'"))
  }

  if (!missing(verbatim_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " verbatim_end_date",if (is.null(verbatim_end_date)) " IS NULL" else if (is(verbatim_end_date, "subQuery")) paste0(" = (", as.character(verbatim_end_date), ")") else paste0(" = '", as.character(verbatim_end_date), "'"))
  }

  if (!missing(drug_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_type_concept_id",if (is.null(drug_type_concept_id)) " IS NULL" else if (is(drug_type_concept_id, "subQuery")) paste0(" = (", as.character(drug_type_concept_id), ")") else paste0(" = '", as.character(drug_type_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason",if (is.null(stop_reason)) " IS NULL" else if (is(stop_reason, "subQuery")) paste0(" = (", as.character(stop_reason), ")") else paste0(" = '", as.character(stop_reason), "'"))
  }

  if (!missing(refills)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " refills",if (is.null(refills)) " IS NULL" else if (is(refills, "subQuery")) paste0(" = (", as.character(refills), ")") else paste0(" = '", as.character(refills), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(days_supply)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " days_supply",if (is.null(days_supply)) " IS NULL" else if (is(days_supply, "subQuery")) paste0(" = (", as.character(days_supply), ")") else paste0(" = '", as.character(days_supply), "'"))
  }

  if (!missing(sig)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sig",if (is.null(sig)) " IS NULL" else if (is(sig, "subQuery")) paste0(" = (", as.character(sig), ")") else paste0(" = '", as.character(sig), "'"))
  }

  if (!missing(route_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " route_concept_id",if (is.null(route_concept_id)) " IS NULL" else if (is(route_concept_id, "subQuery")) paste0(" = (", as.character(route_concept_id), ")") else paste0(" = '", as.character(route_concept_id), "'"))
  }

  if (!missing(lot_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " lot_number",if (is.null(lot_number)) " IS NULL" else if (is(lot_number, "subQuery")) paste0(" = (", as.character(lot_number), ")") else paste0(" = '", as.character(lot_number), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(drug_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_source_value",if (is.null(drug_source_value)) " IS NULL" else if (is(drug_source_value, "subQuery")) paste0(" = (", as.character(drug_source_value), ")") else paste0(" = '", as.character(drug_source_value), "'"))
  }

  if (!missing(drug_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_source_concept_id",if (is.null(drug_source_concept_id)) " IS NULL" else if (is(drug_source_concept_id, "subQuery")) paste0(" = (", as.character(drug_source_concept_id), ")") else paste0(" = '", as.character(drug_source_concept_id), "'"))
  }

  if (!missing(route_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " route_source_value",if (is.null(route_source_value)) " IS NULL" else if (is(route_source_value, "subQuery")) paste0(" = (", as.character(route_source_value), ")") else paste0(" = '", as.character(route_source_value), "'"))
  }

  if (!missing(dose_unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_unit_source_value",if (is.null(dose_unit_source_value)) " IS NULL" else if (is(dose_unit_source_value, "subQuery")) paste0(" = (", as.character(dose_unit_source_value), ")") else paste0(" = '", as.character(dose_unit_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_procedure_occurrence <- function(fetchField, procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_end_date, procedure_end_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.procedure_occurrence WHERE')
  first <- TRUE
  if (!missing(procedure_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_occurrence_id",if (is.null(procedure_occurrence_id)) " IS NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0(" = (", as.character(procedure_occurrence_id), ")") else paste0(" = '", as.character(procedure_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(procedure_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_concept_id",if (is.null(procedure_concept_id)) " IS NULL" else if (is(procedure_concept_id, "subQuery")) paste0(" = (", as.character(procedure_concept_id), ")") else paste0(" = '", as.character(procedure_concept_id), "'"))
  }

  if (!missing(procedure_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_date",if (is.null(procedure_date)) " IS NULL" else if (is(procedure_date, "subQuery")) paste0(" = (", as.character(procedure_date), ")") else paste0(" = '", as.character(procedure_date), "'"))
  }

  if (!missing(procedure_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_datetime",if (is.null(procedure_datetime)) " IS NULL" else if (is(procedure_datetime, "subQuery")) paste0(" = (", as.character(procedure_datetime), ")") else paste0(" = '", as.character(procedure_datetime), "'"))
  }

  if (!missing(procedure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_end_date",if (is.null(procedure_end_date)) " IS NULL" else if (is(procedure_end_date, "subQuery")) paste0(" = (", as.character(procedure_end_date), ")") else paste0(" = '", as.character(procedure_end_date), "'"))
  }

  if (!missing(procedure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_end_datetime",if (is.null(procedure_end_datetime)) " IS NULL" else if (is(procedure_end_datetime, "subQuery")) paste0(" = (", as.character(procedure_end_datetime), ")") else paste0(" = '", as.character(procedure_end_datetime), "'"))
  }

  if (!missing(procedure_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_type_concept_id",if (is.null(procedure_type_concept_id)) " IS NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0(" = (", as.character(procedure_type_concept_id), ")") else paste0(" = '", as.character(procedure_type_concept_id), "'"))
  }

  if (!missing(modifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " modifier_concept_id",if (is.null(modifier_concept_id)) " IS NULL" else if (is(modifier_concept_id, "subQuery")) paste0(" = (", as.character(modifier_concept_id), ")") else paste0(" = '", as.character(modifier_concept_id), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(procedure_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_source_value",if (is.null(procedure_source_value)) " IS NULL" else if (is(procedure_source_value, "subQuery")) paste0(" = (", as.character(procedure_source_value), ")") else paste0(" = '", as.character(procedure_source_value), "'"))
  }

  if (!missing(procedure_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_source_concept_id",if (is.null(procedure_source_concept_id)) " IS NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0(" = (", as.character(procedure_source_concept_id), ")") else paste0(" = '", as.character(procedure_source_concept_id), "'"))
  }

  if (!missing(modifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " modifier_source_value",if (is.null(modifier_source_value)) " IS NULL" else if (is(modifier_source_value, "subQuery")) paste0(" = (", as.character(modifier_source_value), ")") else paste0(" = '", as.character(modifier_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_device_exposure <- function(fetchField, device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, production_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id, unit_concept_id, unit_source_value, unit_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.device_exposure WHERE')
  first <- TRUE
  if (!missing(device_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_id",if (is.null(device_exposure_id)) " IS NULL" else if (is(device_exposure_id, "subQuery")) paste0(" = (", as.character(device_exposure_id), ")") else paste0(" = '", as.character(device_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(device_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_concept_id",if (is.null(device_concept_id)) " IS NULL" else if (is(device_concept_id, "subQuery")) paste0(" = (", as.character(device_concept_id), ")") else paste0(" = '", as.character(device_concept_id), "'"))
  }

  if (!missing(device_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_start_date",if (is.null(device_exposure_start_date)) " IS NULL" else if (is(device_exposure_start_date, "subQuery")) paste0(" = (", as.character(device_exposure_start_date), ")") else paste0(" = '", as.character(device_exposure_start_date), "'"))
  }

  if (!missing(device_exposure_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_start_datetime",if (is.null(device_exposure_start_datetime)) " IS NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_start_datetime), ")") else paste0(" = '", as.character(device_exposure_start_datetime), "'"))
  }

  if (!missing(device_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_end_date",if (is.null(device_exposure_end_date)) " IS NULL" else if (is(device_exposure_end_date, "subQuery")) paste0(" = (", as.character(device_exposure_end_date), ")") else paste0(" = '", as.character(device_exposure_end_date), "'"))
  }

  if (!missing(device_exposure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_end_datetime",if (is.null(device_exposure_end_datetime)) " IS NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0(" = (", as.character(device_exposure_end_datetime), ")") else paste0(" = '", as.character(device_exposure_end_datetime), "'"))
  }

  if (!missing(device_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_type_concept_id",if (is.null(device_type_concept_id)) " IS NULL" else if (is(device_type_concept_id, "subQuery")) paste0(" = (", as.character(device_type_concept_id), ")") else paste0(" = '", as.character(device_type_concept_id), "'"))
  }

  if (!missing(unique_device_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unique_device_id",if (is.null(unique_device_id)) " IS NULL" else if (is(unique_device_id, "subQuery")) paste0(" = (", as.character(unique_device_id), ")") else paste0(" = '", as.character(unique_device_id), "'"))
  }

  if (!missing(production_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " production_id",if (is.null(production_id)) " IS NULL" else if (is(production_id, "subQuery")) paste0(" = (", as.character(production_id), ")") else paste0(" = '", as.character(production_id), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(device_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_source_value",if (is.null(device_source_value)) " IS NULL" else if (is(device_source_value, "subQuery")) paste0(" = (", as.character(device_source_value), ")") else paste0(" = '", as.character(device_source_value), "'"))
  }

  if (!missing(device_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_source_concept_id",if (is.null(device_source_concept_id)) " IS NULL" else if (is(device_source_concept_id, "subQuery")) paste0(" = (", as.character(device_source_concept_id), ")") else paste0(" = '", as.character(device_source_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_concept_id",if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_measurement <- function(fetchField, measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, unit_source_concept_id, value_source_value, measurement_event_id, meas_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.measurement WHERE')
  first <- TRUE
  if (!missing(measurement_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_id",if (is.null(measurement_id)) " IS NULL" else if (is(measurement_id, "subQuery")) paste0(" = (", as.character(measurement_id), ")") else paste0(" = '", as.character(measurement_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(measurement_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_concept_id",if (is.null(measurement_concept_id)) " IS NULL" else if (is(measurement_concept_id, "subQuery")) paste0(" = (", as.character(measurement_concept_id), ")") else paste0(" = '", as.character(measurement_concept_id), "'"))
  }

  if (!missing(measurement_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_date",if (is.null(measurement_date)) " IS NULL" else if (is(measurement_date, "subQuery")) paste0(" = (", as.character(measurement_date), ")") else paste0(" = '", as.character(measurement_date), "'"))
  }

  if (!missing(measurement_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_datetime",if (is.null(measurement_datetime)) " IS NULL" else if (is(measurement_datetime, "subQuery")) paste0(" = (", as.character(measurement_datetime), ")") else paste0(" = '", as.character(measurement_datetime), "'"))
  }

  if (!missing(measurement_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_time",if (is.null(measurement_time)) " IS NULL" else if (is(measurement_time, "subQuery")) paste0(" = (", as.character(measurement_time), ")") else paste0(" = '", as.character(measurement_time), "'"))
  }

  if (!missing(measurement_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_type_concept_id",if (is.null(measurement_type_concept_id)) " IS NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0(" = (", as.character(measurement_type_concept_id), ")") else paste0(" = '", as.character(measurement_type_concept_id), "'"))
  }

  if (!missing(operator_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " operator_concept_id",if (is.null(operator_concept_id)) " IS NULL" else if (is(operator_concept_id, "subQuery")) paste0(" = (", as.character(operator_concept_id), ")") else paste0(" = '", as.character(operator_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number",if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id",if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(range_low)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " range_low",if (is.null(range_low)) " IS NULL" else if (is(range_low, "subQuery")) paste0(" = (", as.character(range_low), ")") else paste0(" = '", as.character(range_low), "'"))
  }

  if (!missing(range_high)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " range_high",if (is.null(range_high)) " IS NULL" else if (is(range_high, "subQuery")) paste0(" = (", as.character(range_high), ")") else paste0(" = '", as.character(range_high), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(measurement_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_source_value",if (is.null(measurement_source_value)) " IS NULL" else if (is(measurement_source_value, "subQuery")) paste0(" = (", as.character(measurement_source_value), ")") else paste0(" = '", as.character(measurement_source_value), "'"))
  }

  if (!missing(measurement_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_source_concept_id",if (is.null(measurement_source_concept_id)) " IS NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0(" = (", as.character(measurement_source_concept_id), ")") else paste0(" = '", as.character(measurement_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(unit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_concept_id",if (is.null(unit_source_concept_id)) " IS NULL" else if (is(unit_source_concept_id, "subQuery")) paste0(" = (", as.character(unit_source_concept_id), ")") else paste0(" = '", as.character(unit_source_concept_id), "'"))
  }

  if (!missing(value_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_source_value",if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(measurement_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_event_id",if (is.null(measurement_event_id)) " IS NULL" else if (is(measurement_event_id, "subQuery")) paste0(" = (", as.character(measurement_event_id), ")") else paste0(" = '", as.character(measurement_event_id), "'"))
  }

  if (!missing(meas_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " meas_event_field_concept_id",if (is.null(meas_event_field_concept_id)) " IS NULL" else if (is(meas_event_field_concept_id, "subQuery")) paste0(" = (", as.character(meas_event_field_concept_id), ")") else paste0(" = '", as.character(meas_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_observation <- function(fetchField, observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, value_source_value, observation_event_id, obs_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.observation WHERE')
  first <- TRUE
  if (!missing(observation_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_id",if (is.null(observation_id)) " IS NULL" else if (is(observation_id, "subQuery")) paste0(" = (", as.character(observation_id), ")") else paste0(" = '", as.character(observation_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(observation_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_concept_id",if (is.null(observation_concept_id)) " IS NULL" else if (is(observation_concept_id, "subQuery")) paste0(" = (", as.character(observation_concept_id), ")") else paste0(" = '", as.character(observation_concept_id), "'"))
  }

  if (!missing(observation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_date",if (is.null(observation_date)) " IS NULL" else if (is(observation_date, "subQuery")) paste0(" = (", as.character(observation_date), ")") else paste0(" = '", as.character(observation_date), "'"))
  }

  if (!missing(observation_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_datetime",if (is.null(observation_datetime)) " IS NULL" else if (is(observation_datetime, "subQuery")) paste0(" = (", as.character(observation_datetime), ")") else paste0(" = '", as.character(observation_datetime), "'"))
  }

  if (!missing(observation_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_type_concept_id",if (is.null(observation_type_concept_id)) " IS NULL" else if (is(observation_type_concept_id, "subQuery")) paste0(" = (", as.character(observation_type_concept_id), ")") else paste0(" = '", as.character(observation_type_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number",if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_string",if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id",if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(qualifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " qualifier_concept_id",if (is.null(qualifier_concept_id)) " IS NULL" else if (is(qualifier_concept_id, "subQuery")) paste0(" = (", as.character(qualifier_concept_id), ")") else paste0(" = '", as.character(qualifier_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(observation_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_source_value",if (is.null(observation_source_value)) " IS NULL" else if (is(observation_source_value, "subQuery")) paste0(" = (", as.character(observation_source_value), ")") else paste0(" = '", as.character(observation_source_value), "'"))
  }

  if (!missing(observation_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_source_concept_id",if (is.null(observation_source_concept_id)) " IS NULL" else if (is(observation_source_concept_id, "subQuery")) paste0(" = (", as.character(observation_source_concept_id), ")") else paste0(" = '", as.character(observation_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(qualifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " qualifier_source_value",if (is.null(qualifier_source_value)) " IS NULL" else if (is(qualifier_source_value, "subQuery")) paste0(" = (", as.character(qualifier_source_value), ")") else paste0(" = '", as.character(qualifier_source_value), "'"))
  }

  if (!missing(value_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_source_value",if (is.null(value_source_value)) " IS NULL" else if (is(value_source_value, "subQuery")) paste0(" = (", as.character(value_source_value), ")") else paste0(" = '", as.character(value_source_value), "'"))
  }

  if (!missing(observation_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_event_id",if (is.null(observation_event_id)) " IS NULL" else if (is(observation_event_id, "subQuery")) paste0(" = (", as.character(observation_event_id), ")") else paste0(" = '", as.character(observation_event_id), "'"))
  }

  if (!missing(obs_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " obs_event_field_concept_id",if (is.null(obs_event_field_concept_id)) " IS NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0(" = (", as.character(obs_event_field_concept_id), ")") else paste0(" = '", as.character(obs_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_death <- function(fetchField, person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.death WHERE')
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(death_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " death_date",if (is.null(death_date)) " IS NULL" else if (is(death_date, "subQuery")) paste0(" = (", as.character(death_date), ")") else paste0(" = '", as.character(death_date), "'"))
  }

  if (!missing(death_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " death_datetime",if (is.null(death_datetime)) " IS NULL" else if (is(death_datetime, "subQuery")) paste0(" = (", as.character(death_datetime), ")") else paste0(" = '", as.character(death_datetime), "'"))
  }

  if (!missing(death_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " death_type_concept_id",if (is.null(death_type_concept_id)) " IS NULL" else if (is(death_type_concept_id, "subQuery")) paste0(" = (", as.character(death_type_concept_id), ")") else paste0(" = '", as.character(death_type_concept_id), "'"))
  }

  if (!missing(cause_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cause_concept_id",if (is.null(cause_concept_id)) " IS NULL" else if (is(cause_concept_id, "subQuery")) paste0(" = (", as.character(cause_concept_id), ")") else paste0(" = '", as.character(cause_concept_id), "'"))
  }

  if (!missing(cause_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cause_source_value",if (is.null(cause_source_value)) " IS NULL" else if (is(cause_source_value, "subQuery")) paste0(" = (", as.character(cause_source_value), ")") else paste0(" = '", as.character(cause_source_value), "'"))
  }

  if (!missing(cause_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cause_source_concept_id",if (is.null(cause_source_concept_id)) " IS NULL" else if (is(cause_source_concept_id, "subQuery")) paste0(" = (", as.character(cause_source_concept_id), ")") else paste0(" = '", as.character(cause_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_note <- function(fetchField, note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value, note_event_id, note_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.note WHERE')
  first <- TRUE
  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_id",if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(note_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_date",if (is.null(note_date)) " IS NULL" else if (is(note_date, "subQuery")) paste0(" = (", as.character(note_date), ")") else paste0(" = '", as.character(note_date), "'"))
  }

  if (!missing(note_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_datetime",if (is.null(note_datetime)) " IS NULL" else if (is(note_datetime, "subQuery")) paste0(" = (", as.character(note_datetime), ")") else paste0(" = '", as.character(note_datetime), "'"))
  }

  if (!missing(note_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_type_concept_id",if (is.null(note_type_concept_id)) " IS NULL" else if (is(note_type_concept_id, "subQuery")) paste0(" = (", as.character(note_type_concept_id), ")") else paste0(" = '", as.character(note_type_concept_id), "'"))
  }

  if (!missing(note_class_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_class_concept_id",if (is.null(note_class_concept_id)) " IS NULL" else if (is(note_class_concept_id, "subQuery")) paste0(" = (", as.character(note_class_concept_id), ")") else paste0(" = '", as.character(note_class_concept_id), "'"))
  }

  if (!missing(note_title)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_title",if (is.null(note_title)) " IS NULL" else if (is(note_title, "subQuery")) paste0(" = (", as.character(note_title), ")") else paste0(" = '", as.character(note_title), "'"))
  }

  if (!missing(note_text)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_text",if (is.null(note_text)) " IS NULL" else if (is(note_text, "subQuery")) paste0(" = (", as.character(note_text), ")") else paste0(" = '", as.character(note_text), "'"))
  }

  if (!missing(encoding_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " encoding_concept_id",if (is.null(encoding_concept_id)) " IS NULL" else if (is(encoding_concept_id, "subQuery")) paste0(" = (", as.character(encoding_concept_id), ")") else paste0(" = '", as.character(encoding_concept_id), "'"))
  }

  if (!missing(language_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " language_concept_id",if (is.null(language_concept_id)) " IS NULL" else if (is(language_concept_id, "subQuery")) paste0(" = (", as.character(language_concept_id), ")") else paste0(" = '", as.character(language_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id",if (is.null(visit_occurrence_id)) " IS NULL" else if (is(visit_occurrence_id, "subQuery")) paste0(" = (", as.character(visit_occurrence_id), ")") else paste0(" = '", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id",if (is.null(visit_detail_id)) " IS NULL" else if (is(visit_detail_id, "subQuery")) paste0(" = (", as.character(visit_detail_id), ")") else paste0(" = '", as.character(visit_detail_id), "'"))
  }

  if (!missing(note_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_source_value",if (is.null(note_source_value)) " IS NULL" else if (is(note_source_value, "subQuery")) paste0(" = (", as.character(note_source_value), ")") else paste0(" = '", as.character(note_source_value), "'"))
  }

  if (!missing(note_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_event_id",if (is.null(note_event_id)) " IS NULL" else if (is(note_event_id, "subQuery")) paste0(" = (", as.character(note_event_id), ")") else paste0(" = '", as.character(note_event_id), "'"))
  }

  if (!missing(note_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_event_field_concept_id",if (is.null(note_event_field_concept_id)) " IS NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0(" = (", as.character(note_event_field_concept_id), ")") else paste0(" = '", as.character(note_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_note_nlp <- function(fetchField, note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.note_nlp WHERE')
  first <- TRUE
  if (!missing(note_nlp_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_id",if (is.null(note_nlp_id)) " IS NULL" else if (is(note_nlp_id, "subQuery")) paste0(" = (", as.character(note_nlp_id), ")") else paste0(" = '", as.character(note_nlp_id), "'"))
  }

  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_id",if (is.null(note_id)) " IS NULL" else if (is(note_id, "subQuery")) paste0(" = (", as.character(note_id), ")") else paste0(" = '", as.character(note_id), "'"))
  }

  if (!missing(section_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " section_concept_id",if (is.null(section_concept_id)) " IS NULL" else if (is(section_concept_id, "subQuery")) paste0(" = (", as.character(section_concept_id), ")") else paste0(" = '", as.character(section_concept_id), "'"))
  }

  if (!missing(snippet)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " snippet",if (is.null(snippet)) " IS NULL" else if (is(snippet, "subQuery")) paste0(" = (", as.character(snippet), ")") else paste0(" = '", as.character(snippet), "'"))
  }

  if (!missing("offset")) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " offset",if (is.null("offset")) " IS NULL" else if (is("offset", "subQuery")) paste0(" = (", as.character("offset"), ")") else paste0(" = '", as.character("offset"), "'"))
  }

  if (!missing(lexical_variant)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " lexical_variant",if (is.null(lexical_variant)) " IS NULL" else if (is(lexical_variant, "subQuery")) paste0(" = (", as.character(lexical_variant), ")") else paste0(" = '", as.character(lexical_variant), "'"))
  }

  if (!missing(note_nlp_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_concept_id",if (is.null(note_nlp_concept_id)) " IS NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_concept_id), ")") else paste0(" = '", as.character(note_nlp_concept_id), "'"))
  }

  if (!missing(note_nlp_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_source_concept_id",if (is.null(note_nlp_source_concept_id)) " IS NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0(" = (", as.character(note_nlp_source_concept_id), ")") else paste0(" = '", as.character(note_nlp_source_concept_id), "'"))
  }

  if (!missing(nlp_system)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_system",if (is.null(nlp_system)) " IS NULL" else if (is(nlp_system, "subQuery")) paste0(" = (", as.character(nlp_system), ")") else paste0(" = '", as.character(nlp_system), "'"))
  }

  if (!missing(nlp_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_date",if (is.null(nlp_date)) " IS NULL" else if (is(nlp_date, "subQuery")) paste0(" = (", as.character(nlp_date), ")") else paste0(" = '", as.character(nlp_date), "'"))
  }

  if (!missing(nlp_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_datetime",if (is.null(nlp_datetime)) " IS NULL" else if (is(nlp_datetime, "subQuery")) paste0(" = (", as.character(nlp_datetime), ")") else paste0(" = '", as.character(nlp_datetime), "'"))
  }

  if (!missing(term_exists)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_exists",if (is.null(term_exists)) " IS NULL" else if (is(term_exists, "subQuery")) paste0(" = (", as.character(term_exists), ")") else paste0(" = '", as.character(term_exists), "'"))
  }

  if (!missing(term_temporal)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_temporal",if (is.null(term_temporal)) " IS NULL" else if (is(term_temporal, "subQuery")) paste0(" = (", as.character(term_temporal), ")") else paste0(" = '", as.character(term_temporal), "'"))
  }

  if (!missing(term_modifiers)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_modifiers",if (is.null(term_modifiers)) " IS NULL" else if (is(term_modifiers, "subQuery")) paste0(" = (", as.character(term_modifiers), ")") else paste0(" = '", as.character(term_modifiers), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_specimen <- function(fetchField, specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.specimen WHERE')
  first <- TRUE
  if (!missing(specimen_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_id",if (is.null(specimen_id)) " IS NULL" else if (is(specimen_id, "subQuery")) paste0(" = (", as.character(specimen_id), ")") else paste0(" = '", as.character(specimen_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(specimen_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_concept_id",if (is.null(specimen_concept_id)) " IS NULL" else if (is(specimen_concept_id, "subQuery")) paste0(" = (", as.character(specimen_concept_id), ")") else paste0(" = '", as.character(specimen_concept_id), "'"))
  }

  if (!missing(specimen_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_type_concept_id",if (is.null(specimen_type_concept_id)) " IS NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0(" = (", as.character(specimen_type_concept_id), ")") else paste0(" = '", as.character(specimen_type_concept_id), "'"))
  }

  if (!missing(specimen_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_date",if (is.null(specimen_date)) " IS NULL" else if (is(specimen_date, "subQuery")) paste0(" = (", as.character(specimen_date), ")") else paste0(" = '", as.character(specimen_date), "'"))
  }

  if (!missing(specimen_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_datetime",if (is.null(specimen_datetime)) " IS NULL" else if (is(specimen_datetime, "subQuery")) paste0(" = (", as.character(specimen_datetime), ")") else paste0(" = '", as.character(specimen_datetime), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity",if (is.null(quantity)) " IS NULL" else if (is(quantity, "subQuery")) paste0(" = (", as.character(quantity), ")") else paste0(" = '", as.character(quantity), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(anatomic_site_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " anatomic_site_concept_id",if (is.null(anatomic_site_concept_id)) " IS NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0(" = (", as.character(anatomic_site_concept_id), ")") else paste0(" = '", as.character(anatomic_site_concept_id), "'"))
  }

  if (!missing(disease_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " disease_status_concept_id",if (is.null(disease_status_concept_id)) " IS NULL" else if (is(disease_status_concept_id, "subQuery")) paste0(" = (", as.character(disease_status_concept_id), ")") else paste0(" = '", as.character(disease_status_concept_id), "'"))
  }

  if (!missing(specimen_source_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_source_id",if (is.null(specimen_source_id)) " IS NULL" else if (is(specimen_source_id, "subQuery")) paste0(" = (", as.character(specimen_source_id), ")") else paste0(" = '", as.character(specimen_source_id), "'"))
  }

  if (!missing(specimen_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_source_value",if (is.null(specimen_source_value)) " IS NULL" else if (is(specimen_source_value, "subQuery")) paste0(" = (", as.character(specimen_source_value), ")") else paste0(" = '", as.character(specimen_source_value), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value",if (is.null(unit_source_value)) " IS NULL" else if (is(unit_source_value, "subQuery")) paste0(" = (", as.character(unit_source_value), ")") else paste0(" = '", as.character(unit_source_value), "'"))
  }

  if (!missing(anatomic_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " anatomic_site_source_value",if (is.null(anatomic_site_source_value)) " IS NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0(" = (", as.character(anatomic_site_source_value), ")") else paste0(" = '", as.character(anatomic_site_source_value), "'"))
  }

  if (!missing(disease_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " disease_status_source_value",if (is.null(disease_status_source_value)) " IS NULL" else if (is(disease_status_source_value, "subQuery")) paste0(" = (", as.character(disease_status_source_value), ")") else paste0(" = '", as.character(disease_status_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_fact_relationship <- function(fetchField, domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.fact_relationship WHERE')
  first <- TRUE
  if (!missing(domain_concept_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " domain_concept_id_1",if (is.null(domain_concept_id_1)) " IS NULL" else if (is(domain_concept_id_1, "subQuery")) paste0(" = (", as.character(domain_concept_id_1), ")") else paste0(" = '", as.character(domain_concept_id_1), "'"))
  }

  if (!missing(fact_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " fact_id_1",if (is.null(fact_id_1)) " IS NULL" else if (is(fact_id_1, "subQuery")) paste0(" = (", as.character(fact_id_1), ")") else paste0(" = '", as.character(fact_id_1), "'"))
  }

  if (!missing(domain_concept_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " domain_concept_id_2",if (is.null(domain_concept_id_2)) " IS NULL" else if (is(domain_concept_id_2, "subQuery")) paste0(" = (", as.character(domain_concept_id_2), ")") else paste0(" = '", as.character(domain_concept_id_2), "'"))
  }

  if (!missing(fact_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " fact_id_2",if (is.null(fact_id_2)) " IS NULL" else if (is(fact_id_2, "subQuery")) paste0(" = (", as.character(fact_id_2), ")") else paste0(" = '", as.character(fact_id_2), "'"))
  }

  if (!missing(relationship_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " relationship_concept_id",if (is.null(relationship_concept_id)) " IS NULL" else if (is(relationship_concept_id, "subQuery")) paste0(" = (", as.character(relationship_concept_id), ")") else paste0(" = '", as.character(relationship_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_location <- function(fetchField, location_id, address_1, address_2, city, state, zip, county, location_source_value, country_concept_id, country_source_value, latitude, longitude) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.location WHERE')
  first <- TRUE
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id",if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(address_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " address_1",if (is.null(address_1)) " IS NULL" else if (is(address_1, "subQuery")) paste0(" = (", as.character(address_1), ")") else paste0(" = '", as.character(address_1), "'"))
  }

  if (!missing(address_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " address_2",if (is.null(address_2)) " IS NULL" else if (is(address_2, "subQuery")) paste0(" = (", as.character(address_2), ")") else paste0(" = '", as.character(address_2), "'"))
  }

  if (!missing(city)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " city",if (is.null(city)) " IS NULL" else if (is(city, "subQuery")) paste0(" = (", as.character(city), ")") else paste0(" = '", as.character(city), "'"))
  }

  if (!missing(state)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " state",if (is.null(state)) " IS NULL" else if (is(state, "subQuery")) paste0(" = (", as.character(state), ")") else paste0(" = '", as.character(state), "'"))
  }

  if (!missing(zip)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " zip",if (is.null(zip)) " IS NULL" else if (is(zip, "subQuery")) paste0(" = (", as.character(zip), ")") else paste0(" = '", as.character(zip), "'"))
  }

  if (!missing(county)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " county",if (is.null(county)) " IS NULL" else if (is(county, "subQuery")) paste0(" = (", as.character(county), ")") else paste0(" = '", as.character(county), "'"))
  }

  if (!missing(location_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_source_value",if (is.null(location_source_value)) " IS NULL" else if (is(location_source_value, "subQuery")) paste0(" = (", as.character(location_source_value), ")") else paste0(" = '", as.character(location_source_value), "'"))
  }

  if (!missing(country_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " country_concept_id",if (is.null(country_concept_id)) " IS NULL" else if (is(country_concept_id, "subQuery")) paste0(" = (", as.character(country_concept_id), ")") else paste0(" = '", as.character(country_concept_id), "'"))
  }

  if (!missing(country_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " country_source_value",if (is.null(country_source_value)) " IS NULL" else if (is(country_source_value, "subQuery")) paste0(" = (", as.character(country_source_value), ")") else paste0(" = '", as.character(country_source_value), "'"))
  }

  if (!missing(latitude)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " latitude",if (is.null(latitude)) " IS NULL" else if (is(latitude, "subQuery")) paste0(" = (", as.character(latitude), ")") else paste0(" = '", as.character(latitude), "'"))
  }

  if (!missing(longitude)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " longitude",if (is.null(longitude)) " IS NULL" else if (is(longitude, "subQuery")) paste0(" = (", as.character(longitude), ")") else paste0(" = '", as.character(longitude), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_care_site <- function(fetchField, care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.care_site WHERE')
  first <- TRUE
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(care_site_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_name",if (is.null(care_site_name)) " IS NULL" else if (is(care_site_name, "subQuery")) paste0(" = (", as.character(care_site_name), ")") else paste0(" = '", as.character(care_site_name), "'"))
  }

  if (!missing(place_of_service_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " place_of_service_concept_id",if (is.null(place_of_service_concept_id)) " IS NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0(" = (", as.character(place_of_service_concept_id), ")") else paste0(" = '", as.character(place_of_service_concept_id), "'"))
  }

  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id",if (is.null(location_id)) " IS NULL" else if (is(location_id, "subQuery")) paste0(" = (", as.character(location_id), ")") else paste0(" = '", as.character(location_id), "'"))
  }

  if (!missing(care_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_source_value",if (is.null(care_site_source_value)) " IS NULL" else if (is(care_site_source_value, "subQuery")) paste0(" = (", as.character(care_site_source_value), ")") else paste0(" = '", as.character(care_site_source_value), "'"))
  }

  if (!missing(place_of_service_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " place_of_service_source_value",if (is.null(place_of_service_source_value)) " IS NULL" else if (is(place_of_service_source_value, "subQuery")) paste0(" = (", as.character(place_of_service_source_value), ")") else paste0(" = '", as.character(place_of_service_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_provider <- function(fetchField, provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.provider WHERE')
  first <- TRUE
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id",if (is.null(provider_id)) " IS NULL" else if (is(provider_id, "subQuery")) paste0(" = (", as.character(provider_id), ")") else paste0(" = '", as.character(provider_id), "'"))
  }

  if (!missing(provider_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_name",if (is.null(provider_name)) " IS NULL" else if (is(provider_name, "subQuery")) paste0(" = (", as.character(provider_name), ")") else paste0(" = '", as.character(provider_name), "'"))
  }

  if (!missing(npi)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " npi",if (is.null(npi)) " IS NULL" else if (is(npi, "subQuery")) paste0(" = (", as.character(npi), ")") else paste0(" = '", as.character(npi), "'"))
  }

  if (!missing(dea)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dea",if (is.null(dea)) " IS NULL" else if (is(dea, "subQuery")) paste0(" = (", as.character(dea), ")") else paste0(" = '", as.character(dea), "'"))
  }

  if (!missing(specialty_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_concept_id",if (is.null(specialty_concept_id)) " IS NULL" else if (is(specialty_concept_id, "subQuery")) paste0(" = (", as.character(specialty_concept_id), ")") else paste0(" = '", as.character(specialty_concept_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id",if (is.null(care_site_id)) " IS NULL" else if (is(care_site_id, "subQuery")) paste0(" = (", as.character(care_site_id), ")") else paste0(" = '", as.character(care_site_id), "'"))
  }

  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " year_of_birth",if (is.null(year_of_birth)) " IS NULL" else if (is(year_of_birth, "subQuery")) paste0(" = (", as.character(year_of_birth), ")") else paste0(" = '", as.character(year_of_birth), "'"))
  }

  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_concept_id",if (is.null(gender_concept_id)) " IS NULL" else if (is(gender_concept_id, "subQuery")) paste0(" = (", as.character(gender_concept_id), ")") else paste0(" = '", as.character(gender_concept_id), "'"))
  }

  if (!missing(provider_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_source_value",if (is.null(provider_source_value)) " IS NULL" else if (is(provider_source_value, "subQuery")) paste0(" = (", as.character(provider_source_value), ")") else paste0(" = '", as.character(provider_source_value), "'"))
  }

  if (!missing(specialty_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_source_value",if (is.null(specialty_source_value)) " IS NULL" else if (is(specialty_source_value, "subQuery")) paste0(" = (", as.character(specialty_source_value), ")") else paste0(" = '", as.character(specialty_source_value), "'"))
  }

  if (!missing(specialty_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_source_concept_id",if (is.null(specialty_source_concept_id)) " IS NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0(" = (", as.character(specialty_source_concept_id), ")") else paste0(" = '", as.character(specialty_source_concept_id), "'"))
  }

  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_value",if (is.null(gender_source_value)) " IS NULL" else if (is(gender_source_value, "subQuery")) paste0(" = (", as.character(gender_source_value), ")") else paste0(" = '", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_concept_id",if (is.null(gender_source_concept_id)) " IS NULL" else if (is(gender_source_concept_id, "subQuery")) paste0(" = (", as.character(gender_source_concept_id), ")") else paste0(" = '", as.character(gender_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_payer_plan_period <- function(fetchField, payer_plan_period_id, person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.payer_plan_period WHERE')
  first <- TRUE
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_id",if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(payer_plan_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_start_date",if (is.null(payer_plan_period_start_date)) " IS NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_start_date), ")") else paste0(" = '", as.character(payer_plan_period_start_date), "'"))
  }

  if (!missing(payer_plan_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_end_date",if (is.null(payer_plan_period_end_date)) " IS NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0(" = (", as.character(payer_plan_period_end_date), ")") else paste0(" = '", as.character(payer_plan_period_end_date), "'"))
  }

  if (!missing(payer_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_concept_id",if (is.null(payer_concept_id)) " IS NULL" else if (is(payer_concept_id, "subQuery")) paste0(" = (", as.character(payer_concept_id), ")") else paste0(" = '", as.character(payer_concept_id), "'"))
  }

  if (!missing(payer_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_source_value",if (is.null(payer_source_value)) " IS NULL" else if (is(payer_source_value, "subQuery")) paste0(" = (", as.character(payer_source_value), ")") else paste0(" = '", as.character(payer_source_value), "'"))
  }

  if (!missing(payer_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_source_concept_id",if (is.null(payer_source_concept_id)) " IS NULL" else if (is(payer_source_concept_id, "subQuery")) paste0(" = (", as.character(payer_source_concept_id), ")") else paste0(" = '", as.character(payer_source_concept_id), "'"))
  }

  if (!missing(plan_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_concept_id",if (is.null(plan_concept_id)) " IS NULL" else if (is(plan_concept_id, "subQuery")) paste0(" = (", as.character(plan_concept_id), ")") else paste0(" = '", as.character(plan_concept_id), "'"))
  }

  if (!missing(plan_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_source_value",if (is.null(plan_source_value)) " IS NULL" else if (is(plan_source_value, "subQuery")) paste0(" = (", as.character(plan_source_value), ")") else paste0(" = '", as.character(plan_source_value), "'"))
  }

  if (!missing(plan_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_source_concept_id",if (is.null(plan_source_concept_id)) " IS NULL" else if (is(plan_source_concept_id, "subQuery")) paste0(" = (", as.character(plan_source_concept_id), ")") else paste0(" = '", as.character(plan_source_concept_id), "'"))
  }

  if (!missing(sponsor_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_concept_id",if (is.null(sponsor_concept_id)) " IS NULL" else if (is(sponsor_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_concept_id), ")") else paste0(" = '", as.character(sponsor_concept_id), "'"))
  }

  if (!missing(sponsor_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_source_value",if (is.null(sponsor_source_value)) " IS NULL" else if (is(sponsor_source_value, "subQuery")) paste0(" = (", as.character(sponsor_source_value), ")") else paste0(" = '", as.character(sponsor_source_value), "'"))
  }

  if (!missing(sponsor_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_source_concept_id",if (is.null(sponsor_source_concept_id)) " IS NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0(" = (", as.character(sponsor_source_concept_id), ")") else paste0(" = '", as.character(sponsor_source_concept_id), "'"))
  }

  if (!missing(family_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " family_source_value",if (is.null(family_source_value)) " IS NULL" else if (is(family_source_value, "subQuery")) paste0(" = (", as.character(family_source_value), ")") else paste0(" = '", as.character(family_source_value), "'"))
  }

  if (!missing(stop_reason_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_concept_id",if (is.null(stop_reason_concept_id)) " IS NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_concept_id), ")") else paste0(" = '", as.character(stop_reason_concept_id), "'"))
  }

  if (!missing(stop_reason_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_source_value",if (is.null(stop_reason_source_value)) " IS NULL" else if (is(stop_reason_source_value, "subQuery")) paste0(" = (", as.character(stop_reason_source_value), ")") else paste0(" = '", as.character(stop_reason_source_value), "'"))
  }

  if (!missing(stop_reason_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_source_concept_id",if (is.null(stop_reason_source_concept_id)) " IS NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0(" = (", as.character(stop_reason_source_concept_id), ")") else paste0(" = '", as.character(stop_reason_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cost <- function(fetchField, cost_id, cost_event_id, cost_domain_id, cost_type_concept_id, currency_concept_id, total_charge, total_cost, total_paid, paid_by_payer, paid_by_patient, paid_patient_copay, paid_patient_coinsurance, paid_patient_deductible, paid_by_primary, paid_ingredient_cost, paid_dispensing_fee, payer_plan_period_id, amount_allowed, revenue_code_concept_id, revenue_code_source_value, drg_concept_id, drg_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cost WHERE')
  first <- TRUE
  if (!missing(cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_id",if (is.null(cost_id)) " IS NULL" else if (is(cost_id, "subQuery")) paste0(" = (", as.character(cost_id), ")") else paste0(" = '", as.character(cost_id), "'"))
  }

  if (!missing(cost_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_event_id",if (is.null(cost_event_id)) " IS NULL" else if (is(cost_event_id, "subQuery")) paste0(" = (", as.character(cost_event_id), ")") else paste0(" = '", as.character(cost_event_id), "'"))
  }

  if (!missing(cost_domain_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_domain_id",if (is.null(cost_domain_id)) " IS NULL" else if (is(cost_domain_id, "subQuery")) paste0(" = (", as.character(cost_domain_id), ")") else paste0(" = '", as.character(cost_domain_id), "'"))
  }

  if (!missing(cost_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_type_concept_id",if (is.null(cost_type_concept_id)) " IS NULL" else if (is(cost_type_concept_id, "subQuery")) paste0(" = (", as.character(cost_type_concept_id), ")") else paste0(" = '", as.character(cost_type_concept_id), "'"))
  }

  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " currency_concept_id",if (is.null(currency_concept_id)) " IS NULL" else if (is(currency_concept_id, "subQuery")) paste0(" = (", as.character(currency_concept_id), ")") else paste0(" = '", as.character(currency_concept_id), "'"))
  }

  if (!missing(total_charge)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " total_charge",if (is.null(total_charge)) " IS NULL" else if (is(total_charge, "subQuery")) paste0(" = (", as.character(total_charge), ")") else paste0(" = '", as.character(total_charge), "'"))
  }

  if (!missing(total_cost)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " total_cost",if (is.null(total_cost)) " IS NULL" else if (is(total_cost, "subQuery")) paste0(" = (", as.character(total_cost), ")") else paste0(" = '", as.character(total_cost), "'"))
  }

  if (!missing(total_paid)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " total_paid",if (is.null(total_paid)) " IS NULL" else if (is(total_paid, "subQuery")) paste0(" = (", as.character(total_paid), ")") else paste0(" = '", as.character(total_paid), "'"))
  }

  if (!missing(paid_by_payer)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_by_payer",if (is.null(paid_by_payer)) " IS NULL" else if (is(paid_by_payer, "subQuery")) paste0(" = (", as.character(paid_by_payer), ")") else paste0(" = '", as.character(paid_by_payer), "'"))
  }

  if (!missing(paid_by_patient)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_by_patient",if (is.null(paid_by_patient)) " IS NULL" else if (is(paid_by_patient, "subQuery")) paste0(" = (", as.character(paid_by_patient), ")") else paste0(" = '", as.character(paid_by_patient), "'"))
  }

  if (!missing(paid_patient_copay)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_patient_copay",if (is.null(paid_patient_copay)) " IS NULL" else if (is(paid_patient_copay, "subQuery")) paste0(" = (", as.character(paid_patient_copay), ")") else paste0(" = '", as.character(paid_patient_copay), "'"))
  }

  if (!missing(paid_patient_coinsurance)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_patient_coinsurance",if (is.null(paid_patient_coinsurance)) " IS NULL" else if (is(paid_patient_coinsurance, "subQuery")) paste0(" = (", as.character(paid_patient_coinsurance), ")") else paste0(" = '", as.character(paid_patient_coinsurance), "'"))
  }

  if (!missing(paid_patient_deductible)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_patient_deductible",if (is.null(paid_patient_deductible)) " IS NULL" else if (is(paid_patient_deductible, "subQuery")) paste0(" = (", as.character(paid_patient_deductible), ")") else paste0(" = '", as.character(paid_patient_deductible), "'"))
  }

  if (!missing(paid_by_primary)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_by_primary",if (is.null(paid_by_primary)) " IS NULL" else if (is(paid_by_primary, "subQuery")) paste0(" = (", as.character(paid_by_primary), ")") else paste0(" = '", as.character(paid_by_primary), "'"))
  }

  if (!missing(paid_ingredient_cost)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_ingredient_cost",if (is.null(paid_ingredient_cost)) " IS NULL" else if (is(paid_ingredient_cost, "subQuery")) paste0(" = (", as.character(paid_ingredient_cost), ")") else paste0(" = '", as.character(paid_ingredient_cost), "'"))
  }

  if (!missing(paid_dispensing_fee)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_dispensing_fee",if (is.null(paid_dispensing_fee)) " IS NULL" else if (is(paid_dispensing_fee, "subQuery")) paste0(" = (", as.character(paid_dispensing_fee), ")") else paste0(" = '", as.character(paid_dispensing_fee), "'"))
  }

  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_id",if (is.null(payer_plan_period_id)) " IS NULL" else if (is(payer_plan_period_id, "subQuery")) paste0(" = (", as.character(payer_plan_period_id), ")") else paste0(" = '", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(amount_allowed)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " amount_allowed",if (is.null(amount_allowed)) " IS NULL" else if (is(amount_allowed, "subQuery")) paste0(" = (", as.character(amount_allowed), ")") else paste0(" = '", as.character(amount_allowed), "'"))
  }

  if (!missing(revenue_code_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " revenue_code_concept_id",if (is.null(revenue_code_concept_id)) " IS NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0(" = (", as.character(revenue_code_concept_id), ")") else paste0(" = '", as.character(revenue_code_concept_id), "'"))
  }

  if (!missing(revenue_code_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " revenue_code_source_value",if (is.null(revenue_code_source_value)) " IS NULL" else if (is(revenue_code_source_value, "subQuery")) paste0(" = (", as.character(revenue_code_source_value), ")") else paste0(" = '", as.character(revenue_code_source_value), "'"))
  }

  if (!missing(drg_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drg_concept_id",if (is.null(drg_concept_id)) " IS NULL" else if (is(drg_concept_id, "subQuery")) paste0(" = (", as.character(drg_concept_id), ")") else paste0(" = '", as.character(drg_concept_id), "'"))
  }

  if (!missing(drg_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drg_source_value",if (is.null(drg_source_value)) " IS NULL" else if (is(drg_source_value, "subQuery")) paste0(" = (", as.character(drg_source_value), ")") else paste0(" = '", as.character(drg_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_drug_era <- function(fetchField, drug_era_id, person_id, drug_concept_id, drug_era_start_date, drug_era_end_date, drug_exposure_count, gap_days) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.drug_era WHERE')
  first <- TRUE
  if (!missing(drug_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_id",if (is.null(drug_era_id)) " IS NULL" else if (is(drug_era_id, "subQuery")) paste0(" = (", as.character(drug_era_id), ")") else paste0(" = '", as.character(drug_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id",if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_start_date",if (is.null(drug_era_start_date)) " IS NULL" else if (is(drug_era_start_date, "subQuery")) paste0(" = (", as.character(drug_era_start_date), ")") else paste0(" = '", as.character(drug_era_start_date), "'"))
  }

  if (!missing(drug_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_end_date",if (is.null(drug_era_end_date)) " IS NULL" else if (is(drug_era_end_date, "subQuery")) paste0(" = (", as.character(drug_era_end_date), ")") else paste0(" = '", as.character(drug_era_end_date), "'"))
  }

  if (!missing(drug_exposure_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_count",if (is.null(drug_exposure_count)) " IS NULL" else if (is(drug_exposure_count, "subQuery")) paste0(" = (", as.character(drug_exposure_count), ")") else paste0(" = '", as.character(drug_exposure_count), "'"))
  }

  if (!missing(gap_days)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gap_days",if (is.null(gap_days)) " IS NULL" else if (is(gap_days, "subQuery")) paste0(" = (", as.character(gap_days), ")") else paste0(" = '", as.character(gap_days), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_dose_era <- function(fetchField, dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_date, dose_era_end_date) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.dose_era WHERE')
  first <- TRUE
  if (!missing(dose_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_id",if (is.null(dose_era_id)) " IS NULL" else if (is(dose_era_id, "subQuery")) paste0(" = (", as.character(dose_era_id), ")") else paste0(" = '", as.character(dose_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id",if (is.null(drug_concept_id)) " IS NULL" else if (is(drug_concept_id, "subQuery")) paste0(" = (", as.character(drug_concept_id), ")") else paste0(" = '", as.character(drug_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id",if (is.null(unit_concept_id)) " IS NULL" else if (is(unit_concept_id, "subQuery")) paste0(" = (", as.character(unit_concept_id), ")") else paste0(" = '", as.character(unit_concept_id), "'"))
  }

  if (!missing(dose_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_value",if (is.null(dose_value)) " IS NULL" else if (is(dose_value, "subQuery")) paste0(" = (", as.character(dose_value), ")") else paste0(" = '", as.character(dose_value), "'"))
  }

  if (!missing(dose_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_start_date",if (is.null(dose_era_start_date)) " IS NULL" else if (is(dose_era_start_date, "subQuery")) paste0(" = (", as.character(dose_era_start_date), ")") else paste0(" = '", as.character(dose_era_start_date), "'"))
  }

  if (!missing(dose_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_end_date",if (is.null(dose_era_end_date)) " IS NULL" else if (is(dose_era_end_date, "subQuery")) paste0(" = (", as.character(dose_era_end_date), ")") else paste0(" = '", as.character(dose_era_end_date), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_condition_era <- function(fetchField, condition_era_id, person_id, condition_concept_id, condition_era_start_date, condition_era_end_date, condition_occurrence_count) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.condition_era WHERE')
  first <- TRUE
  if (!missing(condition_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_id",if (is.null(condition_era_id)) " IS NULL" else if (is(condition_era_id, "subQuery")) paste0(" = (", as.character(condition_era_id), ")") else paste0(" = '", as.character(condition_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_concept_id",if (is.null(condition_concept_id)) " IS NULL" else if (is(condition_concept_id, "subQuery")) paste0(" = (", as.character(condition_concept_id), ")") else paste0(" = '", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_start_date",if (is.null(condition_era_start_date)) " IS NULL" else if (is(condition_era_start_date, "subQuery")) paste0(" = (", as.character(condition_era_start_date), ")") else paste0(" = '", as.character(condition_era_start_date), "'"))
  }

  if (!missing(condition_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_end_date",if (is.null(condition_era_end_date)) " IS NULL" else if (is(condition_era_end_date, "subQuery")) paste0(" = (", as.character(condition_era_end_date), ")") else paste0(" = '", as.character(condition_era_end_date), "'"))
  }

  if (!missing(condition_occurrence_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_occurrence_count",if (is.null(condition_occurrence_count)) " IS NULL" else if (is(condition_occurrence_count, "subQuery")) paste0(" = (", as.character(condition_occurrence_count), ")") else paste0(" = '", as.character(condition_occurrence_count), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_episode <- function(fetchField, episode_id, person_id, episode_concept_id, episode_start_date, episode_start_datetime, episode_end_date, episode_end_datetime, episode_parent_id, episode_number, episode_object_concept_id, episode_type_concept_id, episode_source_value, episode_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.episode WHERE')
  first <- TRUE
  if (!missing(episode_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_id",if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id",if (is.null(person_id)) " IS NULL" else if (is(person_id, "subQuery")) paste0(" = (", as.character(person_id), ")") else paste0(" = '", as.character(person_id), "'"))
  }

  if (!missing(episode_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_concept_id",if (is.null(episode_concept_id)) " IS NULL" else if (is(episode_concept_id, "subQuery")) paste0(" = (", as.character(episode_concept_id), ")") else paste0(" = '", as.character(episode_concept_id), "'"))
  }

  if (!missing(episode_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_start_date",if (is.null(episode_start_date)) " IS NULL" else if (is(episode_start_date, "subQuery")) paste0(" = (", as.character(episode_start_date), ")") else paste0(" = '", as.character(episode_start_date), "'"))
  }

  if (!missing(episode_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_start_datetime",if (is.null(episode_start_datetime)) " IS NULL" else if (is(episode_start_datetime, "subQuery")) paste0(" = (", as.character(episode_start_datetime), ")") else paste0(" = '", as.character(episode_start_datetime), "'"))
  }

  if (!missing(episode_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_end_date",if (is.null(episode_end_date)) " IS NULL" else if (is(episode_end_date, "subQuery")) paste0(" = (", as.character(episode_end_date), ")") else paste0(" = '", as.character(episode_end_date), "'"))
  }

  if (!missing(episode_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_end_datetime",if (is.null(episode_end_datetime)) " IS NULL" else if (is(episode_end_datetime, "subQuery")) paste0(" = (", as.character(episode_end_datetime), ")") else paste0(" = '", as.character(episode_end_datetime), "'"))
  }

  if (!missing(episode_parent_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_parent_id",if (is.null(episode_parent_id)) " IS NULL" else if (is(episode_parent_id, "subQuery")) paste0(" = (", as.character(episode_parent_id), ")") else paste0(" = '", as.character(episode_parent_id), "'"))
  }

  if (!missing(episode_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_number",if (is.null(episode_number)) " IS NULL" else if (is(episode_number, "subQuery")) paste0(" = (", as.character(episode_number), ")") else paste0(" = '", as.character(episode_number), "'"))
  }

  if (!missing(episode_object_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_object_concept_id",if (is.null(episode_object_concept_id)) " IS NULL" else if (is(episode_object_concept_id, "subQuery")) paste0(" = (", as.character(episode_object_concept_id), ")") else paste0(" = '", as.character(episode_object_concept_id), "'"))
  }

  if (!missing(episode_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_type_concept_id",if (is.null(episode_type_concept_id)) " IS NULL" else if (is(episode_type_concept_id, "subQuery")) paste0(" = (", as.character(episode_type_concept_id), ")") else paste0(" = '", as.character(episode_type_concept_id), "'"))
  }

  if (!missing(episode_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_source_value",if (is.null(episode_source_value)) " IS NULL" else if (is(episode_source_value, "subQuery")) paste0(" = (", as.character(episode_source_value), ")") else paste0(" = '", as.character(episode_source_value), "'"))
  }

  if (!missing(episode_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_source_concept_id",if (is.null(episode_source_concept_id)) " IS NULL" else if (is(episode_source_concept_id, "subQuery")) paste0(" = (", as.character(episode_source_concept_id), ")") else paste0(" = '", as.character(episode_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_episode_event <- function(fetchField, episode_id, event_id, episode_event_field_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.episode_event WHERE')
  first <- TRUE
  if (!missing(episode_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_id",if (is.null(episode_id)) " IS NULL" else if (is(episode_id, "subQuery")) paste0(" = (", as.character(episode_id), ")") else paste0(" = '", as.character(episode_id), "'"))
  }

  if (!missing(event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " event_id",if (is.null(event_id)) " IS NULL" else if (is(event_id, "subQuery")) paste0(" = (", as.character(event_id), ")") else paste0(" = '", as.character(event_id), "'"))
  }

  if (!missing(episode_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " episode_event_field_concept_id",if (is.null(episode_event_field_concept_id)) " IS NULL" else if (is(episode_event_field_concept_id, "subQuery")) paste0(" = (", as.character(episode_event_field_concept_id), ")") else paste0(" = '", as.character(episode_event_field_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_metadata <- function(fetchField, metadata_id, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, value_as_number, metadata_date, metadata_datetime) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.metadata WHERE')
  first <- TRUE
  if (!missing(metadata_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_id",if (is.null(metadata_id)) " IS NULL" else if (is(metadata_id, "subQuery")) paste0(" = (", as.character(metadata_id), ")") else paste0(" = '", as.character(metadata_id), "'"))
  }

  if (!missing(metadata_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_concept_id",if (is.null(metadata_concept_id)) " IS NULL" else if (is(metadata_concept_id, "subQuery")) paste0(" = (", as.character(metadata_concept_id), ")") else paste0(" = '", as.character(metadata_concept_id), "'"))
  }

  if (!missing(metadata_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_type_concept_id",if (is.null(metadata_type_concept_id)) " IS NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0(" = (", as.character(metadata_type_concept_id), ")") else paste0(" = '", as.character(metadata_type_concept_id), "'"))
  }

  if (!missing(name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " name",if (is.null(name)) " IS NULL" else if (is(name, "subQuery")) paste0(" = (", as.character(name), ")") else paste0(" = '", as.character(name), "'"))
  }

  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_string",if (is.null(value_as_string)) " IS NULL" else if (is(value_as_string, "subQuery")) paste0(" = (", as.character(value_as_string), ")") else paste0(" = '", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id",if (is.null(value_as_concept_id)) " IS NULL" else if (is(value_as_concept_id, "subQuery")) paste0(" = (", as.character(value_as_concept_id), ")") else paste0(" = '", as.character(value_as_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number",if (is.null(value_as_number)) " IS NULL" else if (is(value_as_number, "subQuery")) paste0(" = (", as.character(value_as_number), ")") else paste0(" = '", as.character(value_as_number), "'"))
  }

  if (!missing(metadata_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_date",if (is.null(metadata_date)) " IS NULL" else if (is(metadata_date, "subQuery")) paste0(" = (", as.character(metadata_date), ")") else paste0(" = '", as.character(metadata_date), "'"))
  }

  if (!missing(metadata_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_datetime",if (is.null(metadata_datetime)) " IS NULL" else if (is(metadata_datetime, "subQuery")) paste0(" = (", as.character(metadata_datetime), ")") else paste0(" = '", as.character(metadata_datetime), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cdm_source <- function(fetchField, cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, cdm_version_concept_id, vocabulary_version) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cdm_source WHERE')
  first <- TRUE
  if (!missing(cdm_source_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_source_name",if (is.null(cdm_source_name)) " IS NULL" else if (is(cdm_source_name, "subQuery")) paste0(" = (", as.character(cdm_source_name), ")") else paste0(" = '", as.character(cdm_source_name), "'"))
  }

  if (!missing(cdm_source_abbreviation)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_source_abbreviation",if (is.null(cdm_source_abbreviation)) " IS NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0(" = (", as.character(cdm_source_abbreviation), ")") else paste0(" = '", as.character(cdm_source_abbreviation), "'"))
  }

  if (!missing(cdm_holder)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_holder",if (is.null(cdm_holder)) " IS NULL" else if (is(cdm_holder, "subQuery")) paste0(" = (", as.character(cdm_holder), ")") else paste0(" = '", as.character(cdm_holder), "'"))
  }

  if (!missing(source_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_description",if (is.null(source_description)) " IS NULL" else if (is(source_description, "subQuery")) paste0(" = (", as.character(source_description), ")") else paste0(" = '", as.character(source_description), "'"))
  }

  if (!missing(source_documentation_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_documentation_reference",if (is.null(source_documentation_reference)) " IS NULL" else if (is(source_documentation_reference, "subQuery")) paste0(" = (", as.character(source_documentation_reference), ")") else paste0(" = '", as.character(source_documentation_reference), "'"))
  }

  if (!missing(cdm_etl_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_etl_reference",if (is.null(cdm_etl_reference)) " IS NULL" else if (is(cdm_etl_reference, "subQuery")) paste0(" = (", as.character(cdm_etl_reference), ")") else paste0(" = '", as.character(cdm_etl_reference), "'"))
  }

  if (!missing(source_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_release_date",if (is.null(source_release_date)) " IS NULL" else if (is(source_release_date, "subQuery")) paste0(" = (", as.character(source_release_date), ")") else paste0(" = '", as.character(source_release_date), "'"))
  }

  if (!missing(cdm_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_release_date",if (is.null(cdm_release_date)) " IS NULL" else if (is(cdm_release_date, "subQuery")) paste0(" = (", as.character(cdm_release_date), ")") else paste0(" = '", as.character(cdm_release_date), "'"))
  }

  if (!missing(cdm_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_version",if (is.null(cdm_version)) " IS NULL" else if (is(cdm_version, "subQuery")) paste0(" = (", as.character(cdm_version), ")") else paste0(" = '", as.character(cdm_version), "'"))
  }

  if (!missing(cdm_version_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_version_concept_id",if (is.null(cdm_version_concept_id)) " IS NULL" else if (is(cdm_version_concept_id, "subQuery")) paste0(" = (", as.character(cdm_version_concept_id), ")") else paste0(" = '", as.character(cdm_version_concept_id), "'"))
  }

  if (!missing(vocabulary_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " vocabulary_version",if (is.null(vocabulary_version)) " IS NULL" else if (is(vocabulary_version, "subQuery")) paste0(" = (", as.character(vocabulary_version), ")") else paste0(" = '", as.character(vocabulary_version), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cohort <- function(fetchField, cohort_definition_id, subject_id, cohort_start_date, cohort_end_date) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cohort WHERE')
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_id",if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(subject_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " subject_id",if (is.null(subject_id)) " IS NULL" else if (is(subject_id, "subQuery")) paste0(" = (", as.character(subject_id), ")") else paste0(" = '", as.character(subject_id), "'"))
  }

  if (!missing(cohort_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_start_date",if (is.null(cohort_start_date)) " IS NULL" else if (is(cohort_start_date, "subQuery")) paste0(" = (", as.character(cohort_start_date), ")") else paste0(" = '", as.character(cohort_start_date), "'"))
  }

  if (!missing(cohort_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_end_date",if (is.null(cohort_end_date)) " IS NULL" else if (is(cohort_end_date, "subQuery")) paste0(" = (", as.character(cohort_end_date), ")") else paste0(" = '", as.character(cohort_end_date), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cohort_definition <- function(fetchField, cohort_definition_id, cohort_definition_name, cohort_definition_description, definition_type_concept_id, cohort_definition_syntax, subject_concept_id, cohort_initiation_date) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cohort_definition WHERE')
  first <- TRUE
  if (!missing(cohort_definition_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_id",if (is.null(cohort_definition_id)) " IS NULL" else if (is(cohort_definition_id, "subQuery")) paste0(" = (", as.character(cohort_definition_id), ")") else paste0(" = '", as.character(cohort_definition_id), "'"))
  }

  if (!missing(cohort_definition_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_name",if (is.null(cohort_definition_name)) " IS NULL" else if (is(cohort_definition_name, "subQuery")) paste0(" = (", as.character(cohort_definition_name), ")") else paste0(" = '", as.character(cohort_definition_name), "'"))
  }

  if (!missing(cohort_definition_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_description",if (is.null(cohort_definition_description)) " IS NULL" else if (is(cohort_definition_description, "subQuery")) paste0(" = (", as.character(cohort_definition_description), ")") else paste0(" = '", as.character(cohort_definition_description), "'"))
  }

  if (!missing(definition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " definition_type_concept_id",if (is.null(definition_type_concept_id)) " IS NULL" else if (is(definition_type_concept_id, "subQuery")) paste0(" = (", as.character(definition_type_concept_id), ")") else paste0(" = '", as.character(definition_type_concept_id), "'"))
  }

  if (!missing(cohort_definition_syntax)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_definition_syntax",if (is.null(cohort_definition_syntax)) " IS NULL" else if (is(cohort_definition_syntax, "subQuery")) paste0(" = (", as.character(cohort_definition_syntax), ")") else paste0(" = '", as.character(cohort_definition_syntax), "'"))
  }

  if (!missing(subject_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " subject_concept_id",if (is.null(subject_concept_id)) " IS NULL" else if (is(subject_concept_id, "subQuery")) paste0(" = (", as.character(subject_concept_id), ")") else paste0(" = '", as.character(subject_concept_id), "'"))
  }

  if (!missing(cohort_initiation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cohort_initiation_date",if (is.null(cohort_initiation_date)) " IS NULL" else if (is(cohort_initiation_date, "subQuery")) paste0(" = (", as.character(cohort_initiation_date), ")") else paste0(" = '", as.character(cohort_initiation_date), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

generateInsertSql <- function(databaseSchema = NULL) {
  insertSql <- c()
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.poorigin;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema._lookup_datadictionary;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.admtype;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.hospchg;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.pataprdrg;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.disstat;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.msdrg;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.lab_sens_result;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.physpec;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.pat;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.lab_result;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.patcpt;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.chgmstr;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.pattype;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema._version;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.paticd_diag;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.patbill;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.msdrgmdc;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.payor;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.vitals;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.icdcode;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.prov_enrollment;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.genlab;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.aprdrg;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.providers;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.paticd_proc;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.cptcode;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.icdpoa;")
  createInsertStatement <- function(insert, env) {
    s <- c()
    if (env$testId != insert$testId) {
      s <- c(s, paste0('-- ', insert$testId, ': ', insert$testDescription))
      env$testId <- insert$testId
    }
    s <- c(s, paste0("INSERT INTO @cdm_database_schema.",
                     insert$table,
                     "(",
                     paste(insert$fields, collapse = ", "),
                     ") VALUES (",
                     paste(insert$values, collapse = ", "), 
                     ");"))
    return(s)
  }
  env <- new.env()
  env$testId <- -1
  insertSql <- c(insertSql, do.call(c, lapply(frameworkContext$inserts, createInsertStatement, env)))
  if (is.null(databaseSchema)) {
  	insertSql <- gsub('@cdm_database_schema.', '', insertSql)
  } else {
  	insertSql <- gsub('@cdm_database_schema', databaseSchema, insertSql)
  }
  return(insertSql)
}

writeSourceCsv <- function(directory = NULL, separator = ',') {
  clean_value <- function(x) {
    if (x == 'NULL') {
      return('')
    }
    value <- substring(x, 2, nchar(x)-1)
    value <- gsub('"', '""', value)
    if (grepl(separator, value)) {
      return(paste0('"', value, '"'))
    }
    return(value)
  }

  clean_fields <- function(x) {
    if (grepl("^\\[.+?\\]$", x)) {
      return(substring(x, 2, nchar(x)-1))
    }
    return(x)
  }
  dir.create(directory, showWarnings = F)
  
  seen_tables <- c()
  for (insert in frameworkContext$inserts) {
    filename <- file.path(directory, paste0(insert$table, '.csv'))
    if (!(insert$table %in% seen_tables)) {
      write(paste(sapply(insert$fields, clean_fields), collapse = separator), filename, append=F)
      seen_tables <- c(seen_tables, insert$table)
    }
    write(paste(sapply(insert$values, clean_value), collapse = separator), filename, append=T)
  }
  
  for (table_name in names(frameworkContext$defaultValues)) {
    if (!(table_name %in% seen_tables)) {
      filename <- file.path(directory, paste0(table_name, '.csv'))
      write(paste(names(frameworkContext$defaultValues[[table_name]]), collapse = separator), filename, append=F)
    }
  }
}

extractTestTypeString <- function(x) {
  if (x$type == 0) {
    return('Expect')
  } else if (x$type==1) {
    return('Expect No')
  } else if (x$type==2) {
    return(paste('Expect', x$rowCount))
  }
}

generateTestSql <- function(databaseSchema = NULL) {
  testSql <- c()
  testSql <- c(testSql, "IF OBJECT_ID('@cdm_database_schema.test_results', 'U') IS NOT NULL DROP TABLE @cdm_database_schema.test_results;")
  testSql <- c(testSql, "CREATE TABLE @cdm_database_schema.test_results (id INT, description VARCHAR(512), test VARCHAR(256), status VARCHAR(5));")
  createExpectStatement <- function(expect, env) {
    s <- c()
    if (env$testId != expect$testId) {
      s <- c(s, paste0('-- ', expect$testId, ': ', expect$testDescription))
      env$testId <- expect$testId
    }
    operators <- rep("=", length(expect$fields))
    operators[expect$values == "NULL"] <- rep("IS", sum(expect$values == "NULL"))
    s <- c(s, paste0("INSERT INTO @cdm_database_schema.test_results SELECT ",
                     expect$testId,
                     " AS id, '",
                     expect$testDescription,
                     "' AS description, '",
                     extractTestTypeString(expect), " ", expect$table,
                     "' AS test, CASE WHEN (SELECT COUNT(*) FROM @cdm_database_schema.",
                     expect$table,
                     " WHERE ",
                     paste(paste(expect$fields, expect$values), collapse = " AND "),
                     ") ",
                     if (expect$type == 0) "= 0" else if (expect$type == 1) "!= 0" else paste("!=", expect$rowCount),
                     " THEN 'FAIL' ELSE 'PASS' END AS status;"))
    return(s)
  }
  env <- new.env()
  env$testId <- -1
  testSql <- c(testSql, do.call(c, lapply(frameworkContext$expects, createExpectStatement, env)))
  if (is.null(databaseSchema)) {
  	testSql <- gsub('@cdm_database_schema.', '', testSql)
  } else {
  	testSql <- gsub('@cdm_database_schema', databaseSchema, testSql)
  }
  return(testSql)
}

getTestsOverview <- function() {
  df <- data.frame(
    testId = sapply(frameworkContext$expects, function(x) x$testId),
    testDescription = sapply(frameworkContext$expects, function(x) x$testDescription),
    testType = sapply(frameworkContext$expects, extractTestTypeString),
    testTable = sapply(frameworkContext$expects, function(x) x$table)
  )
  return(df)
}

exportTestsOverviewToFile <- function(filename) {
  df <- getTestsOverview()
  write.csv(unique(df), filename, row.names=F)
}

summary.frameworkContext <- function(object, ...) {
  nSourceFieldsTested <- length(intersect(object$sourceFieldsMapped, object$sourceFieldsTested))
  nTargetFieldsTested <- length(intersect(object$targetFieldsMapped, object$targetFieldsTested))
  nTotalSourceFields <- length(object$sourceFieldsMapped)
  nTotalTargetFields <- length(object$targetFieldsMapped)
  summary <- c(
    length(object$expects),
    length(unique(sapply(object$expects, function(x) x$testId))),
    nSourceFieldsTested,
    nTotalSourceFields,
    round(100*nSourceFieldsTested/nTotalSourceFields, 2),
    nTargetFieldsTested,
    nTotalTargetFields,
    round(100*nTargetFieldsTested/nTotalTargetFields, 2)
  )
  names(summary) <- c('n_tests', 'n_cases', 'n_source_fields_tested', 'n_source_fields_mapped_from', 'source_coverage (%)', 'n_target_fields_tested', 'n_target_fields_mapped_to', 'target_coverage (%)')
  return(as.data.frame(summary))
}

summaryTestFramework <- function() {
  return(summary(frameworkContext));
}

getUntestedSourceFields <- function() {
  sort(setdiff(frameworkContext$sourceFieldsMapped, frameworkContext$sourceFieldsTested))
}

getUntestedTargetFields <- function() {
  sort(setdiff(frameworkContext$targetFieldsMapped, frameworkContext$targetFieldsTested))
}

outputTestResultsSummary <- function(connection, databaseSchema = NULL) {
  suppressWarnings(require(DatabaseConnector, quietly = TRUE))
  query = 'SELECT * FROM @cdm_database_schema.test_results;'
  if (is.null(databaseSchema)) {
    query <- gsub('@cdm_database_schema.', '', query)
  } else {
    query <- gsub('@cdm_database_schema', databaseSchema, query)
  }
  df_results <- DatabaseConnector::querySql(connection, query)
  n_tests <- nrow(df_results)
  n_failed_tests <- sum(df_results$'STATUS' == 'FAIL')
  if (n_failed_tests > 0) {
    write(sprintf('FAILED unit tests: %d/%d (%.1f%%)', n_failed_tests, n_tests, n_failed_tests/n_tests * 100), file='')
    print(df_results[df_results$'STATUS' == 'FAIL',])
  } else {
    write(sprintf('All %d tests PASSED', n_tests), file='')
  }
}

