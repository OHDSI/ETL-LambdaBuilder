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
  assign('pos_episode_visit', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$pat_planid <- ''
  defaults$clmid <- ''
  defaults$diag <- 'I10'
  defaults$diag_position <- '01'
  defaults$icd_flag <- '10'
  defaults$loc_cd <- '2'
  defaults$poa <- '0'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$fst_dt <- '2023-03-14'
  assign('med_diagnosis', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$tos <- 'PROF  '
  defaults$tos_desc <- 'Facility Outpatient'
  defaults$cdm_std_price_year <- '2012'
  defaults$cumulative_factor <- '1.00000000000000'
  assign('cost_factor', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$pat_planid <- ''
  defaults$ahfsclss <- '24060800'
  defaults$avgwhlsl <- '0.00'
  defaults$brnd_nm <- 'LISINOPRIL'
  defaults$charge <- '0.00'
  defaults$chk_dt <- '1900-01-01'
  defaults$clmid <- ''
  defaults$copay <- '0.00'
  defaults$daw <- '0'
  defaults$days_sup <- '30'
  defaults$dea <- ''
  defaults$deduct <- '0.00'
  defaults$dispfee <- '1.50'
  defaults$fill_dt <- '2021-10-15'
  defaults$form_ind <- 'Y'
  defaults$form_typ <- '2'
  defaults$fst_fill <- 'Y'
  defaults$gnrc_ind <- 'Y'
  defaults$gnrc_nm <- 'LEVOTHYROXINE SODIUM'
  defaults$mail_ind <- 'N'
  defaults$ndc <- '00406035705'
  defaults$npi <- ''
  defaults$pharm <- '100016067'
  defaults$prc_typ <- '9'
  defaults$quantity <- '30.000'
  defaults$rfl_nbr <- '00'
  defaults$spclt_ind <- 'N'
  defaults$specclss <- 'M4D'
  defaults$std_cost <- '0.00'
  defaults$std_cost_yr <- '2013'
  defaults$strength <- '10 MG'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$prescriber_prov <- '0'
  defaults$prescript_id <- ''
  assign('rx_claims', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$pat_planid <- ''
  defaults$admit_date <- '2016-03-01'
  defaults$charge <- '0.00'
  defaults$coins <- '0.00'
  defaults$conf_id <- ''
  defaults$copay <- '0.00'
  defaults$deduct <- '0.00'
  defaults$diag1 <- 'V3000'
  defaults$diag2 <- ''
  defaults$diag3 <- ''
  defaults$diag4 <- ''
  defaults$diag5 <- ''
  defaults$disch_date <- '2019-12-31'
  defaults$drg <- ''
  defaults$dstatus <- '01'
  defaults$icd_flag <- '10'
  defaults$ipstatus <- 'N'
  defaults$los <- '2'
  defaults$pos <- '21'
  defaults$proc1 <- '0000000'
  defaults$proc2 <- '0000000'
  defaults$proc3 <- '0000000'
  defaults$proc4 <- '0000000'
  defaults$proc5 <- '0000000'
  defaults$prov <- '4778994474'
  defaults$std_cost <- '0.00'
  defaults$std_cost_yr <- '2019'
  defaults$tos_cd <- 'FAC_IP.ACUTE'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$icu_ind <- 'N'
  defaults$icu_surg_ind <- 'N'
  defaults$maj_surg_ind <- 'N'
  defaults$maternity_ind <- 'N'
  defaults$newborn_ind <- 'N'
  defaults$tos_ext <- 'FAC_IP.ACUTE.ACUTE.ACUTE.ACUTE'
  assign('inpatient_confinement', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- '33039731330'
  defaults$pat_planid <- '53297024904'
  defaults$abnl_cd <- ''
  defaults$anlytseq <- '01'
  defaults$fst_dt <- '2021-01-27'
  defaults$hi_nrml <- '0.0000'
  defaults$labclmid <- ''
  defaults$loinc_cd <- 'UNLOINC'
  defaults$low_nrml <- '0.0000'
  defaults$proc_cd <- '99999'
  defaults$rslt_nbr <- '0.000000'
  defaults$rslt_txt <- ''
  defaults$rslt_unit_nm <- ''
  defaults$source <- 'LC'
  defaults$tst_desc <- ''
  defaults$tst_nbr <- ''
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  assign('lab_results', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- '33284663955'
  defaults$pat_planid <- '53018529348'
  defaults$clmid <- ''
  defaults$icd_flag <- '9'
  defaults$proc <- '9999'
  defaults$proc_position <- '01'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$fst_dt <- '2022-01-01'
  assign('med_procedure', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$pat_planid <- ''
  defaults$aso <- 'N'
  defaults$bus <- 'COM'
  defaults$cdhp <- '3'
  defaults$eligeff <- '2018-01-01'
  defaults$eligend <- '2023-06-30'
  defaults$family_id <- ''
  defaults$gdr_cd <- 'F'
  defaults$group_nbr <- '444O4KT6Z'
  defaults$health_exch <- '0'
  defaults$lis_dual <- ''
  defaults$product <- 'POS'
  defaults$race <- 'W'
  defaults$state <- 'TX'
  defaults$yrdob <- '1933'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$ethnicity <- ''
  defaults$race_source <- 'Derived'
  assign('member_enrollment', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  assign('version', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$ymdod <- '202201'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$mbr_match_type <- '1'
  assign('death', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$h_bmi <- ''
  defaults$h_bsa <- ''
  defaults$h_chronic_pain <- '0'
  defaults$h_height <- '64.00'
  defaults$h_smoking_status <- '3'
  defaults$h_weight <- '180.00'
  defaults$hra_compltd_dt <- '2014-10-01'
  defaults$isa10008 <- ''
  defaults$isa1006 <- '0'
  defaults$isa13021 <- 'No'
  defaults$isa13022 <- ''
  defaults$isa13023 <- ''
  defaults$isa13040 <- 'No'
  defaults$isa16010 <- ''
  defaults$isa16016 <- 'Sometimes'
  defaults$isa16040 <- '7 Hours'
  defaults$isa17001 <- 'Never Used'
  defaults$isa17015 <- 'Never Used'
  defaults$isa17021 <- ''
  defaults$isa17023 <- 'Never Used'
  defaults$isa18015 <- ''
  defaults$isa19004 <- 'Good'
  defaults$isa19005 <- ''
  defaults$isa20061 <- 'Unknown'
  defaults$isa20064 <- ''
  defaults$isa20069 <- 'No Response'
  defaults$isa20072 <- ''
  defaults$isa21001 <- ''
  defaults$isa21003 <- ''
  defaults$isa21009 <- ''
  defaults$isa21015 <- ''
  defaults$isa21020 <- ''
  defaults$isa21021 <- ''
  defaults$isa21025 <- ''
  defaults$isa3010 <- 'Yes'
  defaults$isa5001 <- 'Very Good'
  defaults$isa5004 <- 'No Response'
  defaults$isa5010 <- ''
  defaults$isa5018 <- 'No Response'
  defaults$isa7018 <- ''
  defaults$isa8016 <- ''
  defaults$isa9009 <- ''
  defaults$isa9063 <- ''
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  assign('hra', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$prov_unique <- ''
  defaults$bed_sz_range <- ''
  defaults$cred_type <- ''
  defaults$grp_practice <- ''
  defaults$hosp_affil <- ''
  defaults$prov_state <- 'CA'
  defaults$prov_type <- ''
  defaults$provcat <- '0209'
  defaults$taxonomy1 <- ''
  defaults$taxonomy2 <- ''
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  assign('provider', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$pat_planid <- ''
  defaults$admit_chan <- ''
  defaults$admit_type <- ''
  defaults$bill_prov <- '7777777774'
  defaults$charge <- '0.00'
  defaults$clmid <- ''
  defaults$clmseq <- '001'
  defaults$cob <- ''
  defaults$coins <- '0.00'
  defaults$conf_id <- ''
  defaults$copay <- '0.00'
  defaults$deduct <- '0.00'
  defaults$drg <- ''
  defaults$dstatus <- ''
  defaults$enctr <- '0'
  defaults$fst_dt <- '2022-09-15'
  defaults$hccc <- '07'
  defaults$icd_flag <- '10'
  defaults$loc_cd <- '2'
  defaults$lst_dt <- ''
  defaults$ndc <- ''
  defaults$paid_dt <- ''
  defaults$paid_status <- 'P '
  defaults$pos <- '11'
  defaults$proc_cd <- ''
  defaults$procmod <- 'NONE'
  defaults$prov <- '4777572248'
  defaults$prov_par <- 'P'
  defaults$provcat <- '0001'
  defaults$refer_prov <- '0'
  defaults$rvnu_cd <- ''
  defaults$service_prov <- '7777777774'
  defaults$std_cost <- '0.00'
  defaults$std_cost_yr <- '2019'
  defaults$tos_cd <- 'PROF.LAB'
  defaults$units <- '1'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$alt_units <- '1'
  defaults$bill_type <- ''
  defaults$ndc_uom <- ''
  defaults$ndc_qty <- ''
  defaults$op_visit_id <- ''
  defaults$procmod2 <- 'NONE'
  defaults$procmod3 <- 'NONE'
  defaults$procmod4 <- 'NONE'
  defaults$tos_ext <- 'PROF.OFFVIS.ESTPAT.ESTPAT.ESTPAT'
  defaults$bill_proc_cd <- ''
  assign('medical_claims', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$diag_cd <- ''
  defaults$diag_desc <- 'UNKNOWN DIAGNOSIS'
  defaults$diag_fst3_cd <- 'S82'
  defaults$diag_fst3_desc <- 'UNKNOWN DIAGNOSIS'
  defaults$diag_fst4_cd <- ''
  defaults$diag_fst4_desc <- 'UNKNOWN DIAGNOSIS'
  defaults$gdr_spec_cd <- ''
  defaults$mdc_cd_desc <- 'UNKNOWN MAJOR DIAGNOSTIC CATEGORY'
  defaults$mdc_code <- '00'
  defaults$icd_ver_cd <- '10'
  assign('lu_diagnosis', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$patid <- ''
  defaults$eligeff <- '2000-05-01'
  defaults$eligend <- '2023-06-30'
  defaults$gdr_cd <- 'F'
  defaults$race <- 'W'
  defaults$yrdob <- '1981'
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  defaults$ethnicity <- ''
  defaults$race_source <- 'Derived'
  assign('member_continuous_enrollment', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$ahfsclss <- 'UNK'
  defaults$ahfsclss_desc <- 'UNKNOWN'
  defaults$brnd_nm <- ''
  defaults$dosage_fm_desc <- 'TABLET'
  defaults$drg_strgth_desc <- ''
  defaults$drg_strgth_nbr <- '0.0'
  defaults$drg_strgth_unit_desc <- 'mg'
  defaults$drg_strgth_vol_nbr <- '0.0'
  defaults$drg_strgth_vol_unit_desc <- ''
  defaults$gnrc_ind <- 'Y'
  defaults$gnrc_nbr <- '094200'
  defaults$gnrc_nm <- ''
  defaults$gnrc_sqnc_nbr <- '000000'
  defaults$ndc <- ''
  defaults$ndc_drg_row_eff_dt <- '2018-03-29'
  defaults$ndc_drg_row_end_dt <- '9999-12-31'
  defaults$usc_id <- ''
  defaults$usc_med_desc <- ''
  assign('lu_ndc', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$category_dtl_cd <- '999  '
  defaults$category_dtl_code_desc <- 'NOT ASSIGNED'
  defaults$category_genl_cd <- '16   '
  defaults$category_genl_code_desc <- 'MISC DIAG THERAPEUTIC'
  defaults$proc_cd <- ''
  defaults$proc_desc <- 'UNKNOWN PROCEDURE'
  defaults$proc_end_date <- '9999-12-31'
  defaults$proc_typ_cd <- 'UNKN '
  assign('lu_procedure', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$prov_unique <- '13001663'
  defaults$dea <- ''
  defaults$npi <- ''
  defaults$prov <- ''
  defaults$extract_ym <- '202309'
  defaults$version <- '9.0'
  assign('provider_bridge', defaults, envir = frameworkContext$defaultValues)

  frameworkContext$sourceFieldsMapped <- c(
  )

  frameworkContext$targetFieldsMapped <- c(
  )

  frameworkContext$sourceFieldsTested <- c()
  frameworkContext$targetFieldsTested <- c()
}

initFramework()

set_defaults_pos_episode_visit <- function() {
  defaults <- get('pos_episode_visit', envir = frameworkContext$defaultValues)
  assign('pos_episode_visit', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_med_diagnosis <- function(patid, pat_planid, clmid, diag, diag_position, icd_flag, loc_cd, poa, extract_ym, version, fst_dt) {
  defaults <- get('med_diagnosis', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(pat_planid)) {
    defaults$pat_planid <- pat_planid
  }
  if (!missing(clmid)) {
    defaults$clmid <- clmid
  }
  if (!missing(diag)) {
    defaults$diag <- diag
  }
  if (!missing(diag_position)) {
    defaults$diag_position <- diag_position
  }
  if (!missing(icd_flag)) {
    defaults$icd_flag <- icd_flag
  }
  if (!missing(loc_cd)) {
    defaults$loc_cd <- loc_cd
  }
  if (!missing(poa)) {
    defaults$poa <- poa
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(fst_dt)) {
    defaults$fst_dt <- fst_dt
  }
  assign('med_diagnosis', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_cost_factor <- function(tos, tos_desc, cdm_std_price_year, cumulative_factor) {
  defaults <- get('cost_factor', envir = frameworkContext$defaultValues)
  if (!missing(tos)) {
    defaults$tos <- tos
  }
  if (!missing(tos_desc)) {
    defaults$tos_desc <- tos_desc
  }
  if (!missing(cdm_std_price_year)) {
    defaults$cdm_std_price_year <- cdm_std_price_year
  }
  if (!missing(cumulative_factor)) {
    defaults$cumulative_factor <- cumulative_factor
  }
  assign('cost_factor', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_rx_claims <- function(patid, pat_planid, ahfsclss, avgwhlsl, brnd_nm, charge, chk_dt, clmid, copay, daw, days_sup, dea, deduct, dispfee, fill_dt, form_ind, form_typ, fst_fill, gnrc_ind, gnrc_nm, mail_ind, ndc, npi, pharm, prc_typ, quantity, rfl_nbr, spclt_ind, specclss, std_cost, std_cost_yr, strength, extract_ym, version, prescriber_prov, prescript_id) {
  defaults <- get('rx_claims', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(pat_planid)) {
    defaults$pat_planid <- pat_planid
  }
  if (!missing(ahfsclss)) {
    defaults$ahfsclss <- ahfsclss
  }
  if (!missing(avgwhlsl)) {
    defaults$avgwhlsl <- avgwhlsl
  }
  if (!missing(brnd_nm)) {
    defaults$brnd_nm <- brnd_nm
  }
  if (!missing(charge)) {
    defaults$charge <- charge
  }
  if (!missing(chk_dt)) {
    defaults$chk_dt <- chk_dt
  }
  if (!missing(clmid)) {
    defaults$clmid <- clmid
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(daw)) {
    defaults$daw <- daw
  }
  if (!missing(days_sup)) {
    defaults$days_sup <- days_sup
  }
  if (!missing(dea)) {
    defaults$dea <- dea
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(dispfee)) {
    defaults$dispfee <- dispfee
  }
  if (!missing(fill_dt)) {
    defaults$fill_dt <- fill_dt
  }
  if (!missing(form_ind)) {
    defaults$form_ind <- form_ind
  }
  if (!missing(form_typ)) {
    defaults$form_typ <- form_typ
  }
  if (!missing(fst_fill)) {
    defaults$fst_fill <- fst_fill
  }
  if (!missing(gnrc_ind)) {
    defaults$gnrc_ind <- gnrc_ind
  }
  if (!missing(gnrc_nm)) {
    defaults$gnrc_nm <- gnrc_nm
  }
  if (!missing(mail_ind)) {
    defaults$mail_ind <- mail_ind
  }
  if (!missing(ndc)) {
    defaults$ndc <- ndc
  }
  if (!missing(npi)) {
    defaults$npi <- npi
  }
  if (!missing(pharm)) {
    defaults$pharm <- pharm
  }
  if (!missing(prc_typ)) {
    defaults$prc_typ <- prc_typ
  }
  if (!missing(quantity)) {
    defaults$quantity <- quantity
  }
  if (!missing(rfl_nbr)) {
    defaults$rfl_nbr <- rfl_nbr
  }
  if (!missing(spclt_ind)) {
    defaults$spclt_ind <- spclt_ind
  }
  if (!missing(specclss)) {
    defaults$specclss <- specclss
  }
  if (!missing(std_cost)) {
    defaults$std_cost <- std_cost
  }
  if (!missing(std_cost_yr)) {
    defaults$std_cost_yr <- std_cost_yr
  }
  if (!missing(strength)) {
    defaults$strength <- strength
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(prescriber_prov)) {
    defaults$prescriber_prov <- prescriber_prov
  }
  if (!missing(prescript_id)) {
    defaults$prescript_id <- prescript_id
  }
  assign('rx_claims', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_inpatient_confinement <- function(patid, pat_planid, admit_date, charge, coins, conf_id, copay, deduct, diag1, diag2, diag3, diag4, diag5, disch_date, drg, dstatus, icd_flag, ipstatus, los, pos, proc1, proc2, proc3, proc4, proc5, prov, std_cost, std_cost_yr, tos_cd, extract_ym, version, icu_ind, icu_surg_ind, maj_surg_ind, maternity_ind, newborn_ind, tos_ext) {
  defaults <- get('inpatient_confinement', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(pat_planid)) {
    defaults$pat_planid <- pat_planid
  }
  if (!missing(admit_date)) {
    defaults$admit_date <- admit_date
  }
  if (!missing(charge)) {
    defaults$charge <- charge
  }
  if (!missing(coins)) {
    defaults$coins <- coins
  }
  if (!missing(conf_id)) {
    defaults$conf_id <- conf_id
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(diag1)) {
    defaults$diag1 <- diag1
  }
  if (!missing(diag2)) {
    defaults$diag2 <- diag2
  }
  if (!missing(diag3)) {
    defaults$diag3 <- diag3
  }
  if (!missing(diag4)) {
    defaults$diag4 <- diag4
  }
  if (!missing(diag5)) {
    defaults$diag5 <- diag5
  }
  if (!missing(disch_date)) {
    defaults$disch_date <- disch_date
  }
  if (!missing(drg)) {
    defaults$drg <- drg
  }
  if (!missing(dstatus)) {
    defaults$dstatus <- dstatus
  }
  if (!missing(icd_flag)) {
    defaults$icd_flag <- icd_flag
  }
  if (!missing(ipstatus)) {
    defaults$ipstatus <- ipstatus
  }
  if (!missing(los)) {
    defaults$los <- los
  }
  if (!missing(pos)) {
    defaults$pos <- pos
  }
  if (!missing(proc1)) {
    defaults$proc1 <- proc1
  }
  if (!missing(proc2)) {
    defaults$proc2 <- proc2
  }
  if (!missing(proc3)) {
    defaults$proc3 <- proc3
  }
  if (!missing(proc4)) {
    defaults$proc4 <- proc4
  }
  if (!missing(proc5)) {
    defaults$proc5 <- proc5
  }
  if (!missing(prov)) {
    defaults$prov <- prov
  }
  if (!missing(std_cost)) {
    defaults$std_cost <- std_cost
  }
  if (!missing(std_cost_yr)) {
    defaults$std_cost_yr <- std_cost_yr
  }
  if (!missing(tos_cd)) {
    defaults$tos_cd <- tos_cd
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(icu_ind)) {
    defaults$icu_ind <- icu_ind
  }
  if (!missing(icu_surg_ind)) {
    defaults$icu_surg_ind <- icu_surg_ind
  }
  if (!missing(maj_surg_ind)) {
    defaults$maj_surg_ind <- maj_surg_ind
  }
  if (!missing(maternity_ind)) {
    defaults$maternity_ind <- maternity_ind
  }
  if (!missing(newborn_ind)) {
    defaults$newborn_ind <- newborn_ind
  }
  if (!missing(tos_ext)) {
    defaults$tos_ext <- tos_ext
  }
  assign('inpatient_confinement', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_lab_results <- function(patid, pat_planid, abnl_cd, anlytseq, fst_dt, hi_nrml, labclmid, loinc_cd, low_nrml, proc_cd, rslt_nbr, rslt_txt, rslt_unit_nm, source, tst_desc, tst_nbr, extract_ym, version) {
  defaults <- get('lab_results', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(pat_planid)) {
    defaults$pat_planid <- pat_planid
  }
  if (!missing(abnl_cd)) {
    defaults$abnl_cd <- abnl_cd
  }
  if (!missing(anlytseq)) {
    defaults$anlytseq <- anlytseq
  }
  if (!missing(fst_dt)) {
    defaults$fst_dt <- fst_dt
  }
  if (!missing(hi_nrml)) {
    defaults$hi_nrml <- hi_nrml
  }
  if (!missing(labclmid)) {
    defaults$labclmid <- labclmid
  }
  if (!missing(loinc_cd)) {
    defaults$loinc_cd <- loinc_cd
  }
  if (!missing(low_nrml)) {
    defaults$low_nrml <- low_nrml
  }
  if (!missing(proc_cd)) {
    defaults$proc_cd <- proc_cd
  }
  if (!missing(rslt_nbr)) {
    defaults$rslt_nbr <- rslt_nbr
  }
  if (!missing(rslt_txt)) {
    defaults$rslt_txt <- rslt_txt
  }
  if (!missing(rslt_unit_nm)) {
    defaults$rslt_unit_nm <- rslt_unit_nm
  }
  if (!missing(source)) {
    defaults$source <- source
  }
  if (!missing(tst_desc)) {
    defaults$tst_desc <- tst_desc
  }
  if (!missing(tst_nbr)) {
    defaults$tst_nbr <- tst_nbr
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  assign('lab_results', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_med_procedure <- function(patid, pat_planid, clmid, icd_flag, proc, proc_position, extract_ym, version, fst_dt) {
  defaults <- get('med_procedure', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(pat_planid)) {
    defaults$pat_planid <- pat_planid
  }
  if (!missing(clmid)) {
    defaults$clmid <- clmid
  }
  if (!missing(icd_flag)) {
    defaults$icd_flag <- icd_flag
  }
  if (!missing(proc)) {
    defaults$proc <- proc
  }
  if (!missing(proc_position)) {
    defaults$proc_position <- proc_position
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(fst_dt)) {
    defaults$fst_dt <- fst_dt
  }
  assign('med_procedure', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_member_enrollment <- function(patid, pat_planid, aso, bus, cdhp, eligeff, eligend, family_id, gdr_cd, group_nbr, health_exch, lis_dual, product, race, state, yrdob, extract_ym, version, ethnicity, race_source) {
  defaults <- get('member_enrollment', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(pat_planid)) {
    defaults$pat_planid <- pat_planid
  }
  if (!missing(aso)) {
    defaults$aso <- aso
  }
  if (!missing(bus)) {
    defaults$bus <- bus
  }
  if (!missing(cdhp)) {
    defaults$cdhp <- cdhp
  }
  if (!missing(eligeff)) {
    defaults$eligeff <- eligeff
  }
  if (!missing(eligend)) {
    defaults$eligend <- eligend
  }
  if (!missing(family_id)) {
    defaults$family_id <- family_id
  }
  if (!missing(gdr_cd)) {
    defaults$gdr_cd <- gdr_cd
  }
  if (!missing(group_nbr)) {
    defaults$group_nbr <- group_nbr
  }
  if (!missing(health_exch)) {
    defaults$health_exch <- health_exch
  }
  if (!missing(lis_dual)) {
    defaults$lis_dual <- lis_dual
  }
  if (!missing(product)) {
    defaults$product <- product
  }
  if (!missing(race)) {
    defaults$race <- race
  }
  if (!missing(state)) {
    defaults$state <- state
  }
  if (!missing(yrdob)) {
    defaults$yrdob <- yrdob
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(ethnicity)) {
    defaults$ethnicity <- ethnicity
  }
  if (!missing(race_source)) {
    defaults$race_source <- race_source
  }
  assign('member_enrollment', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_version <- function() {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  assign('version', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_death <- function(patid, ymdod, extract_ym, version, mbr_match_type) {
  defaults <- get('death', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(ymdod)) {
    defaults$ymdod <- ymdod
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(mbr_match_type)) {
    defaults$mbr_match_type <- mbr_match_type
  }
  assign('death', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_hra <- function(patid, h_bmi, h_bsa, h_chronic_pain, h_height, h_smoking_status, h_weight, hra_compltd_dt, isa10008, isa1006, isa13021, isa13022, isa13023, isa13040, isa16010, isa16016, isa16040, isa17001, isa17015, isa17021, isa17023, isa18015, isa19004, isa19005, isa20061, isa20064, isa20069, isa20072, isa21001, isa21003, isa21009, isa21015, isa21020, isa21021, isa21025, isa3010, isa5001, isa5004, isa5010, isa5018, isa7018, isa8016, isa9009, isa9063, extract_ym, version) {
  defaults <- get('hra', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(h_bmi)) {
    defaults$h_bmi <- h_bmi
  }
  if (!missing(h_bsa)) {
    defaults$h_bsa <- h_bsa
  }
  if (!missing(h_chronic_pain)) {
    defaults$h_chronic_pain <- h_chronic_pain
  }
  if (!missing(h_height)) {
    defaults$h_height <- h_height
  }
  if (!missing(h_smoking_status)) {
    defaults$h_smoking_status <- h_smoking_status
  }
  if (!missing(h_weight)) {
    defaults$h_weight <- h_weight
  }
  if (!missing(hra_compltd_dt)) {
    defaults$hra_compltd_dt <- hra_compltd_dt
  }
  if (!missing(isa10008)) {
    defaults$isa10008 <- isa10008
  }
  if (!missing(isa1006)) {
    defaults$isa1006 <- isa1006
  }
  if (!missing(isa13021)) {
    defaults$isa13021 <- isa13021
  }
  if (!missing(isa13022)) {
    defaults$isa13022 <- isa13022
  }
  if (!missing(isa13023)) {
    defaults$isa13023 <- isa13023
  }
  if (!missing(isa13040)) {
    defaults$isa13040 <- isa13040
  }
  if (!missing(isa16010)) {
    defaults$isa16010 <- isa16010
  }
  if (!missing(isa16016)) {
    defaults$isa16016 <- isa16016
  }
  if (!missing(isa16040)) {
    defaults$isa16040 <- isa16040
  }
  if (!missing(isa17001)) {
    defaults$isa17001 <- isa17001
  }
  if (!missing(isa17015)) {
    defaults$isa17015 <- isa17015
  }
  if (!missing(isa17021)) {
    defaults$isa17021 <- isa17021
  }
  if (!missing(isa17023)) {
    defaults$isa17023 <- isa17023
  }
  if (!missing(isa18015)) {
    defaults$isa18015 <- isa18015
  }
  if (!missing(isa19004)) {
    defaults$isa19004 <- isa19004
  }
  if (!missing(isa19005)) {
    defaults$isa19005 <- isa19005
  }
  if (!missing(isa20061)) {
    defaults$isa20061 <- isa20061
  }
  if (!missing(isa20064)) {
    defaults$isa20064 <- isa20064
  }
  if (!missing(isa20069)) {
    defaults$isa20069 <- isa20069
  }
  if (!missing(isa20072)) {
    defaults$isa20072 <- isa20072
  }
  if (!missing(isa21001)) {
    defaults$isa21001 <- isa21001
  }
  if (!missing(isa21003)) {
    defaults$isa21003 <- isa21003
  }
  if (!missing(isa21009)) {
    defaults$isa21009 <- isa21009
  }
  if (!missing(isa21015)) {
    defaults$isa21015 <- isa21015
  }
  if (!missing(isa21020)) {
    defaults$isa21020 <- isa21020
  }
  if (!missing(isa21021)) {
    defaults$isa21021 <- isa21021
  }
  if (!missing(isa21025)) {
    defaults$isa21025 <- isa21025
  }
  if (!missing(isa3010)) {
    defaults$isa3010 <- isa3010
  }
  if (!missing(isa5001)) {
    defaults$isa5001 <- isa5001
  }
  if (!missing(isa5004)) {
    defaults$isa5004 <- isa5004
  }
  if (!missing(isa5010)) {
    defaults$isa5010 <- isa5010
  }
  if (!missing(isa5018)) {
    defaults$isa5018 <- isa5018
  }
  if (!missing(isa7018)) {
    defaults$isa7018 <- isa7018
  }
  if (!missing(isa8016)) {
    defaults$isa8016 <- isa8016
  }
  if (!missing(isa9009)) {
    defaults$isa9009 <- isa9009
  }
  if (!missing(isa9063)) {
    defaults$isa9063 <- isa9063
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  assign('hra', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_provider <- function(prov_unique, bed_sz_range, cred_type, grp_practice, hosp_affil, prov_state, prov_type, provcat, taxonomy1, taxonomy2, extract_ym, version) {
  defaults <- get('provider', envir = frameworkContext$defaultValues)
  if (!missing(prov_unique)) {
    defaults$prov_unique <- prov_unique
  }
  if (!missing(bed_sz_range)) {
    defaults$bed_sz_range <- bed_sz_range
  }
  if (!missing(cred_type)) {
    defaults$cred_type <- cred_type
  }
  if (!missing(grp_practice)) {
    defaults$grp_practice <- grp_practice
  }
  if (!missing(hosp_affil)) {
    defaults$hosp_affil <- hosp_affil
  }
  if (!missing(prov_state)) {
    defaults$prov_state <- prov_state
  }
  if (!missing(prov_type)) {
    defaults$prov_type <- prov_type
  }
  if (!missing(provcat)) {
    defaults$provcat <- provcat
  }
  if (!missing(taxonomy1)) {
    defaults$taxonomy1 <- taxonomy1
  }
  if (!missing(taxonomy2)) {
    defaults$taxonomy2 <- taxonomy2
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  assign('provider', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_medical_claims <- function(patid, pat_planid, admit_chan, admit_type, bill_prov, charge, clmid, clmseq, cob, coins, conf_id, copay, deduct, drg, dstatus, enctr, fst_dt, hccc, icd_flag, loc_cd, lst_dt, ndc, paid_dt, paid_status, pos, proc_cd, procmod, prov, prov_par, provcat, refer_prov, rvnu_cd, service_prov, std_cost, std_cost_yr, tos_cd, units, extract_ym, version, alt_units, bill_type, ndc_uom, ndc_qty, op_visit_id, procmod2, procmod3, procmod4, tos_ext, bill_proc_cd) {
  defaults <- get('medical_claims', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(pat_planid)) {
    defaults$pat_planid <- pat_planid
  }
  if (!missing(admit_chan)) {
    defaults$admit_chan <- admit_chan
  }
  if (!missing(admit_type)) {
    defaults$admit_type <- admit_type
  }
  if (!missing(bill_prov)) {
    defaults$bill_prov <- bill_prov
  }
  if (!missing(charge)) {
    defaults$charge <- charge
  }
  if (!missing(clmid)) {
    defaults$clmid <- clmid
  }
  if (!missing(clmseq)) {
    defaults$clmseq <- clmseq
  }
  if (!missing(cob)) {
    defaults$cob <- cob
  }
  if (!missing(coins)) {
    defaults$coins <- coins
  }
  if (!missing(conf_id)) {
    defaults$conf_id <- conf_id
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(drg)) {
    defaults$drg <- drg
  }
  if (!missing(dstatus)) {
    defaults$dstatus <- dstatus
  }
  if (!missing(enctr)) {
    defaults$enctr <- enctr
  }
  if (!missing(fst_dt)) {
    defaults$fst_dt <- fst_dt
  }
  if (!missing(hccc)) {
    defaults$hccc <- hccc
  }
  if (!missing(icd_flag)) {
    defaults$icd_flag <- icd_flag
  }
  if (!missing(loc_cd)) {
    defaults$loc_cd <- loc_cd
  }
  if (!missing(lst_dt)) {
    defaults$lst_dt <- lst_dt
  }
  if (!missing(ndc)) {
    defaults$ndc <- ndc
  }
  if (!missing(paid_dt)) {
    defaults$paid_dt <- paid_dt
  }
  if (!missing(paid_status)) {
    defaults$paid_status <- paid_status
  }
  if (!missing(pos)) {
    defaults$pos <- pos
  }
  if (!missing(proc_cd)) {
    defaults$proc_cd <- proc_cd
  }
  if (!missing(procmod)) {
    defaults$procmod <- procmod
  }
  if (!missing(prov)) {
    defaults$prov <- prov
  }
  if (!missing(prov_par)) {
    defaults$prov_par <- prov_par
  }
  if (!missing(provcat)) {
    defaults$provcat <- provcat
  }
  if (!missing(refer_prov)) {
    defaults$refer_prov <- refer_prov
  }
  if (!missing(rvnu_cd)) {
    defaults$rvnu_cd <- rvnu_cd
  }
  if (!missing(service_prov)) {
    defaults$service_prov <- service_prov
  }
  if (!missing(std_cost)) {
    defaults$std_cost <- std_cost
  }
  if (!missing(std_cost_yr)) {
    defaults$std_cost_yr <- std_cost_yr
  }
  if (!missing(tos_cd)) {
    defaults$tos_cd <- tos_cd
  }
  if (!missing(units)) {
    defaults$units <- units
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(alt_units)) {
    defaults$alt_units <- alt_units
  }
  if (!missing(bill_type)) {
    defaults$bill_type <- bill_type
  }
  if (!missing(ndc_uom)) {
    defaults$ndc_uom <- ndc_uom
  }
  if (!missing(ndc_qty)) {
    defaults$ndc_qty <- ndc_qty
  }
  if (!missing(op_visit_id)) {
    defaults$op_visit_id <- op_visit_id
  }
  if (!missing(procmod2)) {
    defaults$procmod2 <- procmod2
  }
  if (!missing(procmod3)) {
    defaults$procmod3 <- procmod3
  }
  if (!missing(procmod4)) {
    defaults$procmod4 <- procmod4
  }
  if (!missing(tos_ext)) {
    defaults$tos_ext <- tos_ext
  }
  if (!missing(bill_proc_cd)) {
    defaults$bill_proc_cd <- bill_proc_cd
  }
  assign('medical_claims', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_lu_diagnosis <- function(diag_cd, diag_desc, diag_fst3_cd, diag_fst3_desc, diag_fst4_cd, diag_fst4_desc, gdr_spec_cd, mdc_cd_desc, mdc_code, icd_ver_cd) {
  defaults <- get('lu_diagnosis', envir = frameworkContext$defaultValues)
  if (!missing(diag_cd)) {
    defaults$diag_cd <- diag_cd
  }
  if (!missing(diag_desc)) {
    defaults$diag_desc <- diag_desc
  }
  if (!missing(diag_fst3_cd)) {
    defaults$diag_fst3_cd <- diag_fst3_cd
  }
  if (!missing(diag_fst3_desc)) {
    defaults$diag_fst3_desc <- diag_fst3_desc
  }
  if (!missing(diag_fst4_cd)) {
    defaults$diag_fst4_cd <- diag_fst4_cd
  }
  if (!missing(diag_fst4_desc)) {
    defaults$diag_fst4_desc <- diag_fst4_desc
  }
  if (!missing(gdr_spec_cd)) {
    defaults$gdr_spec_cd <- gdr_spec_cd
  }
  if (!missing(mdc_cd_desc)) {
    defaults$mdc_cd_desc <- mdc_cd_desc
  }
  if (!missing(mdc_code)) {
    defaults$mdc_code <- mdc_code
  }
  if (!missing(icd_ver_cd)) {
    defaults$icd_ver_cd <- icd_ver_cd
  }
  assign('lu_diagnosis', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_member_continuous_enrollment <- function(patid, eligeff, eligend, gdr_cd, race, yrdob, extract_ym, version, ethnicity, race_source) {
  defaults <- get('member_continuous_enrollment', envir = frameworkContext$defaultValues)
  if (!missing(patid)) {
    defaults$patid <- patid
  }
  if (!missing(eligeff)) {
    defaults$eligeff <- eligeff
  }
  if (!missing(eligend)) {
    defaults$eligend <- eligend
  }
  if (!missing(gdr_cd)) {
    defaults$gdr_cd <- gdr_cd
  }
  if (!missing(race)) {
    defaults$race <- race
  }
  if (!missing(yrdob)) {
    defaults$yrdob <- yrdob
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(ethnicity)) {
    defaults$ethnicity <- ethnicity
  }
  if (!missing(race_source)) {
    defaults$race_source <- race_source
  }
  assign('member_continuous_enrollment', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_lu_ndc <- function(ahfsclss, ahfsclss_desc, brnd_nm, dosage_fm_desc, drg_strgth_desc, drg_strgth_nbr, drg_strgth_unit_desc, drg_strgth_vol_nbr, drg_strgth_vol_unit_desc, gnrc_ind, gnrc_nbr, gnrc_nm, gnrc_sqnc_nbr, ndc, ndc_drg_row_eff_dt, ndc_drg_row_end_dt, usc_id, usc_med_desc) {
  defaults <- get('lu_ndc', envir = frameworkContext$defaultValues)
  if (!missing(ahfsclss)) {
    defaults$ahfsclss <- ahfsclss
  }
  if (!missing(ahfsclss_desc)) {
    defaults$ahfsclss_desc <- ahfsclss_desc
  }
  if (!missing(brnd_nm)) {
    defaults$brnd_nm <- brnd_nm
  }
  if (!missing(dosage_fm_desc)) {
    defaults$dosage_fm_desc <- dosage_fm_desc
  }
  if (!missing(drg_strgth_desc)) {
    defaults$drg_strgth_desc <- drg_strgth_desc
  }
  if (!missing(drg_strgth_nbr)) {
    defaults$drg_strgth_nbr <- drg_strgth_nbr
  }
  if (!missing(drg_strgth_unit_desc)) {
    defaults$drg_strgth_unit_desc <- drg_strgth_unit_desc
  }
  if (!missing(drg_strgth_vol_nbr)) {
    defaults$drg_strgth_vol_nbr <- drg_strgth_vol_nbr
  }
  if (!missing(drg_strgth_vol_unit_desc)) {
    defaults$drg_strgth_vol_unit_desc <- drg_strgth_vol_unit_desc
  }
  if (!missing(gnrc_ind)) {
    defaults$gnrc_ind <- gnrc_ind
  }
  if (!missing(gnrc_nbr)) {
    defaults$gnrc_nbr <- gnrc_nbr
  }
  if (!missing(gnrc_nm)) {
    defaults$gnrc_nm <- gnrc_nm
  }
  if (!missing(gnrc_sqnc_nbr)) {
    defaults$gnrc_sqnc_nbr <- gnrc_sqnc_nbr
  }
  if (!missing(ndc)) {
    defaults$ndc <- ndc
  }
  if (!missing(ndc_drg_row_eff_dt)) {
    defaults$ndc_drg_row_eff_dt <- ndc_drg_row_eff_dt
  }
  if (!missing(ndc_drg_row_end_dt)) {
    defaults$ndc_drg_row_end_dt <- ndc_drg_row_end_dt
  }
  if (!missing(usc_id)) {
    defaults$usc_id <- usc_id
  }
  if (!missing(usc_med_desc)) {
    defaults$usc_med_desc <- usc_med_desc
  }
  assign('lu_ndc', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_lu_procedure <- function(category_dtl_cd, category_dtl_code_desc, category_genl_cd, category_genl_code_desc, proc_cd, proc_desc, proc_end_date, proc_typ_cd) {
  defaults <- get('lu_procedure', envir = frameworkContext$defaultValues)
  if (!missing(category_dtl_cd)) {
    defaults$category_dtl_cd <- category_dtl_cd
  }
  if (!missing(category_dtl_code_desc)) {
    defaults$category_dtl_code_desc <- category_dtl_code_desc
  }
  if (!missing(category_genl_cd)) {
    defaults$category_genl_cd <- category_genl_cd
  }
  if (!missing(category_genl_code_desc)) {
    defaults$category_genl_code_desc <- category_genl_code_desc
  }
  if (!missing(proc_cd)) {
    defaults$proc_cd <- proc_cd
  }
  if (!missing(proc_desc)) {
    defaults$proc_desc <- proc_desc
  }
  if (!missing(proc_end_date)) {
    defaults$proc_end_date <- proc_end_date
  }
  if (!missing(proc_typ_cd)) {
    defaults$proc_typ_cd <- proc_typ_cd
  }
  assign('lu_procedure', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_provider_bridge <- function(prov_unique, dea, npi, prov, extract_ym, version) {
  defaults <- get('provider_bridge', envir = frameworkContext$defaultValues)
  if (!missing(prov_unique)) {
    defaults$prov_unique <- prov_unique
  }
  if (!missing(dea)) {
    defaults$dea <- dea
  }
  if (!missing(npi)) {
    defaults$npi <- npi
  }
  if (!missing(prov)) {
    defaults$prov <- prov
  }
  if (!missing(extract_ym)) {
    defaults$extract_ym <- extract_ym
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  assign('provider_bridge', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

get_defaults_pos_episode_visit <- function() {
  defaults <- get('pos_episode_visit', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_med_diagnosis <- function() {
  defaults <- get('med_diagnosis', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_cost_factor <- function() {
  defaults <- get('cost_factor', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_rx_claims <- function() {
  defaults <- get('rx_claims', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_inpatient_confinement <- function() {
  defaults <- get('inpatient_confinement', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_lab_results <- function() {
  defaults <- get('lab_results', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_med_procedure <- function() {
  defaults <- get('med_procedure', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_member_enrollment <- function() {
  defaults <- get('member_enrollment', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_version <- function() {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_death <- function() {
  defaults <- get('death', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_hra <- function() {
  defaults <- get('hra', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_provider <- function() {
  defaults <- get('provider', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_medical_claims <- function() {
  defaults <- get('medical_claims', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_lu_diagnosis <- function() {
  defaults <- get('lu_diagnosis', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_member_continuous_enrollment <- function() {
  defaults <- get('member_continuous_enrollment', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_lu_ndc <- function() {
  defaults <- get('lu_ndc', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_lu_procedure <- function() {
  defaults <- get('lu_procedure', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_provider_bridge <- function() {
  defaults <- get('provider_bridge', envir = frameworkContext$defaultValues)
  return(defaults)
}

declareTest <- function(id, description) {
  frameworkContext$testId <- id
  frameworkContext$testDescription <- description
}

add_pos_episode_visit <- function() {
  defaults <- get('pos_episode_visit', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "_pos_episode_visit", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_med_diagnosis <- function(patid, pat_planid, clmid, diag, diag_position, icd_flag, loc_cd, poa, extract_ym, version, fst_dt) {
  defaults <- get('med_diagnosis', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(pat_planid)) {
    pat_planid <- defaults$pat_planid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.pat_planid')
  }
  fields <- c(fields, "pat_planid")
  values <- c(values, if (is.null(pat_planid)) "NULL" else if (is(pat_planid, "subQuery")) paste0("(", as.character(pat_planid), ")") else paste0("'", as.character(pat_planid), "'"))

  if (missing(clmid)) {
    clmid <- defaults$clmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.clmid')
  }
  fields <- c(fields, "clmid")
  values <- c(values, if (is.null(clmid)) "NULL" else if (is(clmid, "subQuery")) paste0("(", as.character(clmid), ")") else paste0("'", as.character(clmid), "'"))

  if (missing(diag)) {
    diag <- defaults$diag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.diag')
  }
  fields <- c(fields, "diag")
  values <- c(values, if (is.null(diag)) "NULL" else if (is(diag, "subQuery")) paste0("(", as.character(diag), ")") else paste0("'", as.character(diag), "'"))

  if (missing(diag_position)) {
    diag_position <- defaults$diag_position
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.diag_position')
  }
  fields <- c(fields, "diag_position")
  values <- c(values, if (is.null(diag_position)) "NULL" else if (is(diag_position, "subQuery")) paste0("(", as.character(diag_position), ")") else paste0("'", as.character(diag_position), "'"))

  if (missing(icd_flag)) {
    icd_flag <- defaults$icd_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.icd_flag')
  }
  fields <- c(fields, "icd_flag")
  values <- c(values, if (is.null(icd_flag)) "NULL" else if (is(icd_flag, "subQuery")) paste0("(", as.character(icd_flag), ")") else paste0("'", as.character(icd_flag), "'"))

  if (missing(loc_cd)) {
    loc_cd <- defaults$loc_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.loc_cd')
  }
  fields <- c(fields, "loc_cd")
  values <- c(values, if (is.null(loc_cd)) "NULL" else if (is(loc_cd, "subQuery")) paste0("(", as.character(loc_cd), ")") else paste0("'", as.character(loc_cd), "'"))

  if (missing(poa)) {
    poa <- defaults$poa
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.poa')
  }
  fields <- c(fields, "poa")
  values <- c(values, if (is.null(poa)) "NULL" else if (is(poa, "subQuery")) paste0("(", as.character(poa), ")") else paste0("'", as.character(poa), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(fst_dt)) {
    fst_dt <- defaults$fst_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_diagnosis.fst_dt')
  }
  fields <- c(fields, "fst_dt")
  values <- c(values, if (is.null(fst_dt)) "NULL" else if (is(fst_dt, "subQuery")) paste0("(", as.character(fst_dt), ")") else paste0("'", as.character(fst_dt), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "med_diagnosis", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_cost_factor <- function(tos, tos_desc, cdm_std_price_year, cumulative_factor) {
  defaults <- get('cost_factor', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(tos)) {
    tos <- defaults$tos
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'cost_factor.tos')
  }
  fields <- c(fields, "tos")
  values <- c(values, if (is.null(tos)) "NULL" else if (is(tos, "subQuery")) paste0("(", as.character(tos), ")") else paste0("'", as.character(tos), "'"))

  if (missing(tos_desc)) {
    tos_desc <- defaults$tos_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'cost_factor.tos_desc')
  }
  fields <- c(fields, "tos_desc")
  values <- c(values, if (is.null(tos_desc)) "NULL" else if (is(tos_desc, "subQuery")) paste0("(", as.character(tos_desc), ")") else paste0("'", as.character(tos_desc), "'"))

  if (missing(cdm_std_price_year)) {
    cdm_std_price_year <- defaults$cdm_std_price_year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'cost_factor.cdm_std_price_year')
  }
  fields <- c(fields, "cdm_std_price_year")
  values <- c(values, if (is.null(cdm_std_price_year)) "NULL" else if (is(cdm_std_price_year, "subQuery")) paste0("(", as.character(cdm_std_price_year), ")") else paste0("'", as.character(cdm_std_price_year), "'"))

  if (missing(cumulative_factor)) {
    cumulative_factor <- defaults$cumulative_factor
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'cost_factor.cumulative_factor')
  }
  fields <- c(fields, "cumulative_factor")
  values <- c(values, if (is.null(cumulative_factor)) "NULL" else if (is(cumulative_factor, "subQuery")) paste0("(", as.character(cumulative_factor), ")") else paste0("'", as.character(cumulative_factor), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "cost_factor", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_rx_claims <- function(patid, pat_planid, ahfsclss, avgwhlsl, brnd_nm, charge, chk_dt, clmid, copay, daw, days_sup, dea, deduct, dispfee, fill_dt, form_ind, form_typ, fst_fill, gnrc_ind, gnrc_nm, mail_ind, ndc, npi, pharm, prc_typ, quantity, rfl_nbr, spclt_ind, specclss, std_cost, std_cost_yr, strength, extract_ym, version, prescriber_prov, prescript_id) {
  defaults <- get('rx_claims', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(pat_planid)) {
    pat_planid <- defaults$pat_planid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.pat_planid')
  }
  fields <- c(fields, "pat_planid")
  values <- c(values, if (is.null(pat_planid)) "NULL" else if (is(pat_planid, "subQuery")) paste0("(", as.character(pat_planid), ")") else paste0("'", as.character(pat_planid), "'"))

  if (missing(ahfsclss)) {
    ahfsclss <- defaults$ahfsclss
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.ahfsclss')
  }
  fields <- c(fields, "ahfsclss")
  values <- c(values, if (is.null(ahfsclss)) "NULL" else if (is(ahfsclss, "subQuery")) paste0("(", as.character(ahfsclss), ")") else paste0("'", as.character(ahfsclss), "'"))

  if (missing(avgwhlsl)) {
    avgwhlsl <- defaults$avgwhlsl
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.avgwhlsl')
  }
  fields <- c(fields, "avgwhlsl")
  values <- c(values, if (is.null(avgwhlsl)) "NULL" else if (is(avgwhlsl, "subQuery")) paste0("(", as.character(avgwhlsl), ")") else paste0("'", as.character(avgwhlsl), "'"))

  if (missing(brnd_nm)) {
    brnd_nm <- defaults$brnd_nm
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.brnd_nm')
  }
  fields <- c(fields, "brnd_nm")
  values <- c(values, if (is.null(brnd_nm)) "NULL" else if (is(brnd_nm, "subQuery")) paste0("(", as.character(brnd_nm), ")") else paste0("'", as.character(brnd_nm), "'"))

  if (missing(charge)) {
    charge <- defaults$charge
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.charge')
  }
  fields <- c(fields, "charge")
  values <- c(values, if (is.null(charge)) "NULL" else if (is(charge, "subQuery")) paste0("(", as.character(charge), ")") else paste0("'", as.character(charge), "'"))

  if (missing(chk_dt)) {
    chk_dt <- defaults$chk_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.chk_dt')
  }
  fields <- c(fields, "chk_dt")
  values <- c(values, if (is.null(chk_dt)) "NULL" else if (is(chk_dt, "subQuery")) paste0("(", as.character(chk_dt), ")") else paste0("'", as.character(chk_dt), "'"))

  if (missing(clmid)) {
    clmid <- defaults$clmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.clmid')
  }
  fields <- c(fields, "clmid")
  values <- c(values, if (is.null(clmid)) "NULL" else if (is(clmid, "subQuery")) paste0("(", as.character(clmid), ")") else paste0("'", as.character(clmid), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(daw)) {
    daw <- defaults$daw
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.daw')
  }
  fields <- c(fields, "daw")
  values <- c(values, if (is.null(daw)) "NULL" else if (is(daw, "subQuery")) paste0("(", as.character(daw), ")") else paste0("'", as.character(daw), "'"))

  if (missing(days_sup)) {
    days_sup <- defaults$days_sup
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.days_sup')
  }
  fields <- c(fields, "days_sup")
  values <- c(values, if (is.null(days_sup)) "NULL" else if (is(days_sup, "subQuery")) paste0("(", as.character(days_sup), ")") else paste0("'", as.character(days_sup), "'"))

  if (missing(dea)) {
    dea <- defaults$dea
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.dea')
  }
  fields <- c(fields, "dea")
  values <- c(values, if (is.null(dea)) "NULL" else if (is(dea, "subQuery")) paste0("(", as.character(dea), ")") else paste0("'", as.character(dea), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(dispfee)) {
    dispfee <- defaults$dispfee
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.dispfee')
  }
  fields <- c(fields, "dispfee")
  values <- c(values, if (is.null(dispfee)) "NULL" else if (is(dispfee, "subQuery")) paste0("(", as.character(dispfee), ")") else paste0("'", as.character(dispfee), "'"))

  if (missing(fill_dt)) {
    fill_dt <- defaults$fill_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.fill_dt')
  }
  fields <- c(fields, "fill_dt")
  values <- c(values, if (is.null(fill_dt)) "NULL" else if (is(fill_dt, "subQuery")) paste0("(", as.character(fill_dt), ")") else paste0("'", as.character(fill_dt), "'"))

  if (missing(form_ind)) {
    form_ind <- defaults$form_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.form_ind')
  }
  fields <- c(fields, "form_ind")
  values <- c(values, if (is.null(form_ind)) "NULL" else if (is(form_ind, "subQuery")) paste0("(", as.character(form_ind), ")") else paste0("'", as.character(form_ind), "'"))

  if (missing(form_typ)) {
    form_typ <- defaults$form_typ
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.form_typ')
  }
  fields <- c(fields, "form_typ")
  values <- c(values, if (is.null(form_typ)) "NULL" else if (is(form_typ, "subQuery")) paste0("(", as.character(form_typ), ")") else paste0("'", as.character(form_typ), "'"))

  if (missing(fst_fill)) {
    fst_fill <- defaults$fst_fill
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.fst_fill')
  }
  fields <- c(fields, "fst_fill")
  values <- c(values, if (is.null(fst_fill)) "NULL" else if (is(fst_fill, "subQuery")) paste0("(", as.character(fst_fill), ")") else paste0("'", as.character(fst_fill), "'"))

  if (missing(gnrc_ind)) {
    gnrc_ind <- defaults$gnrc_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.gnrc_ind')
  }
  fields <- c(fields, "gnrc_ind")
  values <- c(values, if (is.null(gnrc_ind)) "NULL" else if (is(gnrc_ind, "subQuery")) paste0("(", as.character(gnrc_ind), ")") else paste0("'", as.character(gnrc_ind), "'"))

  if (missing(gnrc_nm)) {
    gnrc_nm <- defaults$gnrc_nm
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.gnrc_nm')
  }
  fields <- c(fields, "gnrc_nm")
  values <- c(values, if (is.null(gnrc_nm)) "NULL" else if (is(gnrc_nm, "subQuery")) paste0("(", as.character(gnrc_nm), ")") else paste0("'", as.character(gnrc_nm), "'"))

  if (missing(mail_ind)) {
    mail_ind <- defaults$mail_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.mail_ind')
  }
  fields <- c(fields, "mail_ind")
  values <- c(values, if (is.null(mail_ind)) "NULL" else if (is(mail_ind, "subQuery")) paste0("(", as.character(mail_ind), ")") else paste0("'", as.character(mail_ind), "'"))

  if (missing(ndc)) {
    ndc <- defaults$ndc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.ndc')
  }
  fields <- c(fields, "ndc")
  values <- c(values, if (is.null(ndc)) "NULL" else if (is(ndc, "subQuery")) paste0("(", as.character(ndc), ")") else paste0("'", as.character(ndc), "'"))

  if (missing(npi)) {
    npi <- defaults$npi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.npi')
  }
  fields <- c(fields, "npi")
  values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))

  if (missing(pharm)) {
    pharm <- defaults$pharm
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.pharm')
  }
  fields <- c(fields, "pharm")
  values <- c(values, if (is.null(pharm)) "NULL" else if (is(pharm, "subQuery")) paste0("(", as.character(pharm), ")") else paste0("'", as.character(pharm), "'"))

  if (missing(prc_typ)) {
    prc_typ <- defaults$prc_typ
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.prc_typ')
  }
  fields <- c(fields, "prc_typ")
  values <- c(values, if (is.null(prc_typ)) "NULL" else if (is(prc_typ, "subQuery")) paste0("(", as.character(prc_typ), ")") else paste0("'", as.character(prc_typ), "'"))

  if (missing(quantity)) {
    quantity <- defaults$quantity
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.quantity')
  }
  fields <- c(fields, "quantity")
  values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))

  if (missing(rfl_nbr)) {
    rfl_nbr <- defaults$rfl_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.rfl_nbr')
  }
  fields <- c(fields, "rfl_nbr")
  values <- c(values, if (is.null(rfl_nbr)) "NULL" else if (is(rfl_nbr, "subQuery")) paste0("(", as.character(rfl_nbr), ")") else paste0("'", as.character(rfl_nbr), "'"))

  if (missing(spclt_ind)) {
    spclt_ind <- defaults$spclt_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.spclt_ind')
  }
  fields <- c(fields, "spclt_ind")
  values <- c(values, if (is.null(spclt_ind)) "NULL" else if (is(spclt_ind, "subQuery")) paste0("(", as.character(spclt_ind), ")") else paste0("'", as.character(spclt_ind), "'"))

  if (missing(specclss)) {
    specclss <- defaults$specclss
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.specclss')
  }
  fields <- c(fields, "specclss")
  values <- c(values, if (is.null(specclss)) "NULL" else if (is(specclss, "subQuery")) paste0("(", as.character(specclss), ")") else paste0("'", as.character(specclss), "'"))

  if (missing(std_cost)) {
    std_cost <- defaults$std_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.std_cost')
  }
  fields <- c(fields, "std_cost")
  values <- c(values, if (is.null(std_cost)) "NULL" else if (is(std_cost, "subQuery")) paste0("(", as.character(std_cost), ")") else paste0("'", as.character(std_cost), "'"))

  if (missing(std_cost_yr)) {
    std_cost_yr <- defaults$std_cost_yr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.std_cost_yr')
  }
  fields <- c(fields, "std_cost_yr")
  values <- c(values, if (is.null(std_cost_yr)) "NULL" else if (is(std_cost_yr, "subQuery")) paste0("(", as.character(std_cost_yr), ")") else paste0("'", as.character(std_cost_yr), "'"))

  if (missing(strength)) {
    strength <- defaults$strength
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.strength')
  }
  fields <- c(fields, "strength")
  values <- c(values, if (is.null(strength)) "NULL" else if (is(strength, "subQuery")) paste0("(", as.character(strength), ")") else paste0("'", as.character(strength), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(prescriber_prov)) {
    prescriber_prov <- defaults$prescriber_prov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.prescriber_prov')
  }
  fields <- c(fields, "prescriber_prov")
  values <- c(values, if (is.null(prescriber_prov)) "NULL" else if (is(prescriber_prov, "subQuery")) paste0("(", as.character(prescriber_prov), ")") else paste0("'", as.character(prescriber_prov), "'"))

  if (missing(prescript_id)) {
    prescript_id <- defaults$prescript_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'rx_claims.prescript_id')
  }
  fields <- c(fields, "prescript_id")
  values <- c(values, if (is.null(prescript_id)) "NULL" else if (is(prescript_id, "subQuery")) paste0("(", as.character(prescript_id), ")") else paste0("'", as.character(prescript_id), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "rx_claims", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_inpatient_confinement <- function(patid, pat_planid, admit_date, charge, coins, conf_id, copay, deduct, diag1, diag2, diag3, diag4, diag5, disch_date, drg, dstatus, icd_flag, ipstatus, los, pos, proc1, proc2, proc3, proc4, proc5, prov, std_cost, std_cost_yr, tos_cd, extract_ym, version, icu_ind, icu_surg_ind, maj_surg_ind, maternity_ind, newborn_ind, tos_ext) {
  defaults <- get('inpatient_confinement', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(pat_planid)) {
    pat_planid <- defaults$pat_planid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.pat_planid')
  }
  fields <- c(fields, "pat_planid")
  values <- c(values, if (is.null(pat_planid)) "NULL" else if (is(pat_planid, "subQuery")) paste0("(", as.character(pat_planid), ")") else paste0("'", as.character(pat_planid), "'"))

  if (missing(admit_date)) {
    admit_date <- defaults$admit_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.admit_date')
  }
  fields <- c(fields, "admit_date")
  values <- c(values, if (is.null(admit_date)) "NULL" else if (is(admit_date, "subQuery")) paste0("(", as.character(admit_date), ")") else paste0("'", as.character(admit_date), "'"))

  if (missing(charge)) {
    charge <- defaults$charge
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.charge')
  }
  fields <- c(fields, "charge")
  values <- c(values, if (is.null(charge)) "NULL" else if (is(charge, "subQuery")) paste0("(", as.character(charge), ")") else paste0("'", as.character(charge), "'"))

  if (missing(coins)) {
    coins <- defaults$coins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.coins')
  }
  fields <- c(fields, "coins")
  values <- c(values, if (is.null(coins)) "NULL" else if (is(coins, "subQuery")) paste0("(", as.character(coins), ")") else paste0("'", as.character(coins), "'"))

  if (missing(conf_id)) {
    conf_id <- defaults$conf_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.conf_id')
  }
  fields <- c(fields, "conf_id")
  values <- c(values, if (is.null(conf_id)) "NULL" else if (is(conf_id, "subQuery")) paste0("(", as.character(conf_id), ")") else paste0("'", as.character(conf_id), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(diag1)) {
    diag1 <- defaults$diag1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.diag1')
  }
  fields <- c(fields, "diag1")
  values <- c(values, if (is.null(diag1)) "NULL" else if (is(diag1, "subQuery")) paste0("(", as.character(diag1), ")") else paste0("'", as.character(diag1), "'"))

  if (missing(diag2)) {
    diag2 <- defaults$diag2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.diag2')
  }
  fields <- c(fields, "diag2")
  values <- c(values, if (is.null(diag2)) "NULL" else if (is(diag2, "subQuery")) paste0("(", as.character(diag2), ")") else paste0("'", as.character(diag2), "'"))

  if (missing(diag3)) {
    diag3 <- defaults$diag3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.diag3')
  }
  fields <- c(fields, "diag3")
  values <- c(values, if (is.null(diag3)) "NULL" else if (is(diag3, "subQuery")) paste0("(", as.character(diag3), ")") else paste0("'", as.character(diag3), "'"))

  if (missing(diag4)) {
    diag4 <- defaults$diag4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.diag4')
  }
  fields <- c(fields, "diag4")
  values <- c(values, if (is.null(diag4)) "NULL" else if (is(diag4, "subQuery")) paste0("(", as.character(diag4), ")") else paste0("'", as.character(diag4), "'"))

  if (missing(diag5)) {
    diag5 <- defaults$diag5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.diag5')
  }
  fields <- c(fields, "diag5")
  values <- c(values, if (is.null(diag5)) "NULL" else if (is(diag5, "subQuery")) paste0("(", as.character(diag5), ")") else paste0("'", as.character(diag5), "'"))

  if (missing(disch_date)) {
    disch_date <- defaults$disch_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.disch_date')
  }
  fields <- c(fields, "disch_date")
  values <- c(values, if (is.null(disch_date)) "NULL" else if (is(disch_date, "subQuery")) paste0("(", as.character(disch_date), ")") else paste0("'", as.character(disch_date), "'"))

  if (missing(drg)) {
    drg <- defaults$drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.drg')
  }
  fields <- c(fields, "drg")
  values <- c(values, if (is.null(drg)) "NULL" else if (is(drg, "subQuery")) paste0("(", as.character(drg), ")") else paste0("'", as.character(drg), "'"))

  if (missing(dstatus)) {
    dstatus <- defaults$dstatus
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.dstatus')
  }
  fields <- c(fields, "dstatus")
  values <- c(values, if (is.null(dstatus)) "NULL" else if (is(dstatus, "subQuery")) paste0("(", as.character(dstatus), ")") else paste0("'", as.character(dstatus), "'"))

  if (missing(icd_flag)) {
    icd_flag <- defaults$icd_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.icd_flag')
  }
  fields <- c(fields, "icd_flag")
  values <- c(values, if (is.null(icd_flag)) "NULL" else if (is(icd_flag, "subQuery")) paste0("(", as.character(icd_flag), ")") else paste0("'", as.character(icd_flag), "'"))

  if (missing(ipstatus)) {
    ipstatus <- defaults$ipstatus
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.ipstatus')
  }
  fields <- c(fields, "ipstatus")
  values <- c(values, if (is.null(ipstatus)) "NULL" else if (is(ipstatus, "subQuery")) paste0("(", as.character(ipstatus), ")") else paste0("'", as.character(ipstatus), "'"))

  if (missing(los)) {
    los <- defaults$los
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.los')
  }
  fields <- c(fields, "los")
  values <- c(values, if (is.null(los)) "NULL" else if (is(los, "subQuery")) paste0("(", as.character(los), ")") else paste0("'", as.character(los), "'"))

  if (missing(pos)) {
    pos <- defaults$pos
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.pos')
  }
  fields <- c(fields, "pos")
  values <- c(values, if (is.null(pos)) "NULL" else if (is(pos, "subQuery")) paste0("(", as.character(pos), ")") else paste0("'", as.character(pos), "'"))

  if (missing(proc1)) {
    proc1 <- defaults$proc1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.proc1')
  }
  fields <- c(fields, "proc1")
  values <- c(values, if (is.null(proc1)) "NULL" else if (is(proc1, "subQuery")) paste0("(", as.character(proc1), ")") else paste0("'", as.character(proc1), "'"))

  if (missing(proc2)) {
    proc2 <- defaults$proc2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.proc2')
  }
  fields <- c(fields, "proc2")
  values <- c(values, if (is.null(proc2)) "NULL" else if (is(proc2, "subQuery")) paste0("(", as.character(proc2), ")") else paste0("'", as.character(proc2), "'"))

  if (missing(proc3)) {
    proc3 <- defaults$proc3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.proc3')
  }
  fields <- c(fields, "proc3")
  values <- c(values, if (is.null(proc3)) "NULL" else if (is(proc3, "subQuery")) paste0("(", as.character(proc3), ")") else paste0("'", as.character(proc3), "'"))

  if (missing(proc4)) {
    proc4 <- defaults$proc4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.proc4')
  }
  fields <- c(fields, "proc4")
  values <- c(values, if (is.null(proc4)) "NULL" else if (is(proc4, "subQuery")) paste0("(", as.character(proc4), ")") else paste0("'", as.character(proc4), "'"))

  if (missing(proc5)) {
    proc5 <- defaults$proc5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.proc5')
  }
  fields <- c(fields, "proc5")
  values <- c(values, if (is.null(proc5)) "NULL" else if (is(proc5, "subQuery")) paste0("(", as.character(proc5), ")") else paste0("'", as.character(proc5), "'"))

  if (missing(prov)) {
    prov <- defaults$prov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.prov')
  }
  fields <- c(fields, "prov")
  values <- c(values, if (is.null(prov)) "NULL" else if (is(prov, "subQuery")) paste0("(", as.character(prov), ")") else paste0("'", as.character(prov), "'"))

  if (missing(std_cost)) {
    std_cost <- defaults$std_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.std_cost')
  }
  fields <- c(fields, "std_cost")
  values <- c(values, if (is.null(std_cost)) "NULL" else if (is(std_cost, "subQuery")) paste0("(", as.character(std_cost), ")") else paste0("'", as.character(std_cost), "'"))

  if (missing(std_cost_yr)) {
    std_cost_yr <- defaults$std_cost_yr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.std_cost_yr')
  }
  fields <- c(fields, "std_cost_yr")
  values <- c(values, if (is.null(std_cost_yr)) "NULL" else if (is(std_cost_yr, "subQuery")) paste0("(", as.character(std_cost_yr), ")") else paste0("'", as.character(std_cost_yr), "'"))

  if (missing(tos_cd)) {
    tos_cd <- defaults$tos_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.tos_cd')
  }
  fields <- c(fields, "tos_cd")
  values <- c(values, if (is.null(tos_cd)) "NULL" else if (is(tos_cd, "subQuery")) paste0("(", as.character(tos_cd), ")") else paste0("'", as.character(tos_cd), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(icu_ind)) {
    icu_ind <- defaults$icu_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.icu_ind')
  }
  fields <- c(fields, "icu_ind")
  values <- c(values, if (is.null(icu_ind)) "NULL" else if (is(icu_ind, "subQuery")) paste0("(", as.character(icu_ind), ")") else paste0("'", as.character(icu_ind), "'"))

  if (missing(icu_surg_ind)) {
    icu_surg_ind <- defaults$icu_surg_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.icu_surg_ind')
  }
  fields <- c(fields, "icu_surg_ind")
  values <- c(values, if (is.null(icu_surg_ind)) "NULL" else if (is(icu_surg_ind, "subQuery")) paste0("(", as.character(icu_surg_ind), ")") else paste0("'", as.character(icu_surg_ind), "'"))

  if (missing(maj_surg_ind)) {
    maj_surg_ind <- defaults$maj_surg_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.maj_surg_ind')
  }
  fields <- c(fields, "maj_surg_ind")
  values <- c(values, if (is.null(maj_surg_ind)) "NULL" else if (is(maj_surg_ind, "subQuery")) paste0("(", as.character(maj_surg_ind), ")") else paste0("'", as.character(maj_surg_ind), "'"))

  if (missing(maternity_ind)) {
    maternity_ind <- defaults$maternity_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.maternity_ind')
  }
  fields <- c(fields, "maternity_ind")
  values <- c(values, if (is.null(maternity_ind)) "NULL" else if (is(maternity_ind, "subQuery")) paste0("(", as.character(maternity_ind), ")") else paste0("'", as.character(maternity_ind), "'"))

  if (missing(newborn_ind)) {
    newborn_ind <- defaults$newborn_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.newborn_ind')
  }
  fields <- c(fields, "newborn_ind")
  values <- c(values, if (is.null(newborn_ind)) "NULL" else if (is(newborn_ind, "subQuery")) paste0("(", as.character(newborn_ind), ")") else paste0("'", as.character(newborn_ind), "'"))

  if (missing(tos_ext)) {
    tos_ext <- defaults$tos_ext
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_confinement.tos_ext')
  }
  fields <- c(fields, "tos_ext")
  values <- c(values, if (is.null(tos_ext)) "NULL" else if (is(tos_ext, "subQuery")) paste0("(", as.character(tos_ext), ")") else paste0("'", as.character(tos_ext), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "inpatient_confinement", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_lab_results <- function(patid, pat_planid, abnl_cd, anlytseq, fst_dt, hi_nrml, labclmid, loinc_cd, low_nrml, proc_cd, rslt_nbr, rslt_txt, rslt_unit_nm, source, tst_desc, tst_nbr, extract_ym, version) {
  defaults <- get('lab_results', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(pat_planid)) {
    pat_planid <- defaults$pat_planid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.pat_planid')
  }
  fields <- c(fields, "pat_planid")
  values <- c(values, if (is.null(pat_planid)) "NULL" else if (is(pat_planid, "subQuery")) paste0("(", as.character(pat_planid), ")") else paste0("'", as.character(pat_planid), "'"))

  if (missing(abnl_cd)) {
    abnl_cd <- defaults$abnl_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.abnl_cd')
  }
  fields <- c(fields, "abnl_cd")
  values <- c(values, if (is.null(abnl_cd)) "NULL" else if (is(abnl_cd, "subQuery")) paste0("(", as.character(abnl_cd), ")") else paste0("'", as.character(abnl_cd), "'"))

  if (missing(anlytseq)) {
    anlytseq <- defaults$anlytseq
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.anlytseq')
  }
  fields <- c(fields, "anlytseq")
  values <- c(values, if (is.null(anlytseq)) "NULL" else if (is(anlytseq, "subQuery")) paste0("(", as.character(anlytseq), ")") else paste0("'", as.character(anlytseq), "'"))

  if (missing(fst_dt)) {
    fst_dt <- defaults$fst_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.fst_dt')
  }
  fields <- c(fields, "fst_dt")
  values <- c(values, if (is.null(fst_dt)) "NULL" else if (is(fst_dt, "subQuery")) paste0("(", as.character(fst_dt), ")") else paste0("'", as.character(fst_dt), "'"))

  if (missing(hi_nrml)) {
    hi_nrml <- defaults$hi_nrml
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.hi_nrml')
  }
  fields <- c(fields, "hi_nrml")
  values <- c(values, if (is.null(hi_nrml)) "NULL" else if (is(hi_nrml, "subQuery")) paste0("(", as.character(hi_nrml), ")") else paste0("'", as.character(hi_nrml), "'"))

  if (missing(labclmid)) {
    labclmid <- defaults$labclmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.labclmid')
  }
  fields <- c(fields, "labclmid")
  values <- c(values, if (is.null(labclmid)) "NULL" else if (is(labclmid, "subQuery")) paste0("(", as.character(labclmid), ")") else paste0("'", as.character(labclmid), "'"))

  if (missing(loinc_cd)) {
    loinc_cd <- defaults$loinc_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.loinc_cd')
  }
  fields <- c(fields, "loinc_cd")
  values <- c(values, if (is.null(loinc_cd)) "NULL" else if (is(loinc_cd, "subQuery")) paste0("(", as.character(loinc_cd), ")") else paste0("'", as.character(loinc_cd), "'"))

  if (missing(low_nrml)) {
    low_nrml <- defaults$low_nrml
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.low_nrml')
  }
  fields <- c(fields, "low_nrml")
  values <- c(values, if (is.null(low_nrml)) "NULL" else if (is(low_nrml, "subQuery")) paste0("(", as.character(low_nrml), ")") else paste0("'", as.character(low_nrml), "'"))

  if (missing(proc_cd)) {
    proc_cd <- defaults$proc_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.proc_cd')
  }
  fields <- c(fields, "proc_cd")
  values <- c(values, if (is.null(proc_cd)) "NULL" else if (is(proc_cd, "subQuery")) paste0("(", as.character(proc_cd), ")") else paste0("'", as.character(proc_cd), "'"))

  if (missing(rslt_nbr)) {
    rslt_nbr <- defaults$rslt_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.rslt_nbr')
  }
  fields <- c(fields, "rslt_nbr")
  values <- c(values, if (is.null(rslt_nbr)) "NULL" else if (is(rslt_nbr, "subQuery")) paste0("(", as.character(rslt_nbr), ")") else paste0("'", as.character(rslt_nbr), "'"))

  if (missing(rslt_txt)) {
    rslt_txt <- defaults$rslt_txt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.rslt_txt')
  }
  fields <- c(fields, "rslt_txt")
  values <- c(values, if (is.null(rslt_txt)) "NULL" else if (is(rslt_txt, "subQuery")) paste0("(", as.character(rslt_txt), ")") else paste0("'", as.character(rslt_txt), "'"))

  if (missing(rslt_unit_nm)) {
    rslt_unit_nm <- defaults$rslt_unit_nm
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.rslt_unit_nm')
  }
  fields <- c(fields, "rslt_unit_nm")
  values <- c(values, if (is.null(rslt_unit_nm)) "NULL" else if (is(rslt_unit_nm, "subQuery")) paste0("(", as.character(rslt_unit_nm), ")") else paste0("'", as.character(rslt_unit_nm), "'"))

  if (missing(source)) {
    source <- defaults$source
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.source')
  }
  fields <- c(fields, "source")
  values <- c(values, if (is.null(source)) "NULL" else if (is(source, "subQuery")) paste0("(", as.character(source), ")") else paste0("'", as.character(source), "'"))

  if (missing(tst_desc)) {
    tst_desc <- defaults$tst_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.tst_desc')
  }
  fields <- c(fields, "tst_desc")
  values <- c(values, if (is.null(tst_desc)) "NULL" else if (is(tst_desc, "subQuery")) paste0("(", as.character(tst_desc), ")") else paste0("'", as.character(tst_desc), "'"))

  if (missing(tst_nbr)) {
    tst_nbr <- defaults$tst_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.tst_nbr')
  }
  fields <- c(fields, "tst_nbr")
  values <- c(values, if (is.null(tst_nbr)) "NULL" else if (is(tst_nbr, "subQuery")) paste0("(", as.character(tst_nbr), ")") else paste0("'", as.character(tst_nbr), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lab_results.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "lab_results", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_med_procedure <- function(patid, pat_planid, clmid, icd_flag, proc, proc_position, extract_ym, version, fst_dt) {
  defaults <- get('med_procedure', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(pat_planid)) {
    pat_planid <- defaults$pat_planid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.pat_planid')
  }
  fields <- c(fields, "pat_planid")
  values <- c(values, if (is.null(pat_planid)) "NULL" else if (is(pat_planid, "subQuery")) paste0("(", as.character(pat_planid), ")") else paste0("'", as.character(pat_planid), "'"))

  if (missing(clmid)) {
    clmid <- defaults$clmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.clmid')
  }
  fields <- c(fields, "clmid")
  values <- c(values, if (is.null(clmid)) "NULL" else if (is(clmid, "subQuery")) paste0("(", as.character(clmid), ")") else paste0("'", as.character(clmid), "'"))

  if (missing(icd_flag)) {
    icd_flag <- defaults$icd_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.icd_flag')
  }
  fields <- c(fields, "icd_flag")
  values <- c(values, if (is.null(icd_flag)) "NULL" else if (is(icd_flag, "subQuery")) paste0("(", as.character(icd_flag), ")") else paste0("'", as.character(icd_flag), "'"))

  if (missing(proc)) {
    proc <- defaults$proc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.proc')
  }
  fields <- c(fields, "proc")
  values <- c(values, if (is.null(proc)) "NULL" else if (is(proc, "subQuery")) paste0("(", as.character(proc), ")") else paste0("'", as.character(proc), "'"))

  if (missing(proc_position)) {
    proc_position <- defaults$proc_position
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.proc_position')
  }
  fields <- c(fields, "proc_position")
  values <- c(values, if (is.null(proc_position)) "NULL" else if (is(proc_position, "subQuery")) paste0("(", as.character(proc_position), ")") else paste0("'", as.character(proc_position), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(fst_dt)) {
    fst_dt <- defaults$fst_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'med_procedure.fst_dt')
  }
  fields <- c(fields, "fst_dt")
  values <- c(values, if (is.null(fst_dt)) "NULL" else if (is(fst_dt, "subQuery")) paste0("(", as.character(fst_dt), ")") else paste0("'", as.character(fst_dt), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "med_procedure", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_member_enrollment <- function(patid, pat_planid, aso, bus, cdhp, eligeff, eligend, family_id, gdr_cd, group_nbr, health_exch, lis_dual, product, race, state, yrdob, extract_ym, version, ethnicity, race_source) {
  defaults <- get('member_enrollment', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(pat_planid)) {
    pat_planid <- defaults$pat_planid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.pat_planid')
  }
  fields <- c(fields, "pat_planid")
  values <- c(values, if (is.null(pat_planid)) "NULL" else if (is(pat_planid, "subQuery")) paste0("(", as.character(pat_planid), ")") else paste0("'", as.character(pat_planid), "'"))

  if (missing(aso)) {
    aso <- defaults$aso
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.aso')
  }
  fields <- c(fields, "aso")
  values <- c(values, if (is.null(aso)) "NULL" else if (is(aso, "subQuery")) paste0("(", as.character(aso), ")") else paste0("'", as.character(aso), "'"))

  if (missing(bus)) {
    bus <- defaults$bus
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.bus')
  }
  fields <- c(fields, "bus")
  values <- c(values, if (is.null(bus)) "NULL" else if (is(bus, "subQuery")) paste0("(", as.character(bus), ")") else paste0("'", as.character(bus), "'"))

  if (missing(cdhp)) {
    cdhp <- defaults$cdhp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.cdhp')
  }
  fields <- c(fields, "cdhp")
  values <- c(values, if (is.null(cdhp)) "NULL" else if (is(cdhp, "subQuery")) paste0("(", as.character(cdhp), ")") else paste0("'", as.character(cdhp), "'"))

  if (missing(eligeff)) {
    eligeff <- defaults$eligeff
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.eligeff')
  }
  fields <- c(fields, "eligeff")
  values <- c(values, if (is.null(eligeff)) "NULL" else if (is(eligeff, "subQuery")) paste0("(", as.character(eligeff), ")") else paste0("'", as.character(eligeff), "'"))

  if (missing(eligend)) {
    eligend <- defaults$eligend
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.eligend')
  }
  fields <- c(fields, "eligend")
  values <- c(values, if (is.null(eligend)) "NULL" else if (is(eligend, "subQuery")) paste0("(", as.character(eligend), ")") else paste0("'", as.character(eligend), "'"))

  if (missing(family_id)) {
    family_id <- defaults$family_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.family_id')
  }
  fields <- c(fields, "family_id")
  values <- c(values, if (is.null(family_id)) "NULL" else if (is(family_id, "subQuery")) paste0("(", as.character(family_id), ")") else paste0("'", as.character(family_id), "'"))

  if (missing(gdr_cd)) {
    gdr_cd <- defaults$gdr_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.gdr_cd')
  }
  fields <- c(fields, "gdr_cd")
  values <- c(values, if (is.null(gdr_cd)) "NULL" else if (is(gdr_cd, "subQuery")) paste0("(", as.character(gdr_cd), ")") else paste0("'", as.character(gdr_cd), "'"))

  if (missing(group_nbr)) {
    group_nbr <- defaults$group_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.group_nbr')
  }
  fields <- c(fields, "group_nbr")
  values <- c(values, if (is.null(group_nbr)) "NULL" else if (is(group_nbr, "subQuery")) paste0("(", as.character(group_nbr), ")") else paste0("'", as.character(group_nbr), "'"))

  if (missing(health_exch)) {
    health_exch <- defaults$health_exch
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.health_exch')
  }
  fields <- c(fields, "health_exch")
  values <- c(values, if (is.null(health_exch)) "NULL" else if (is(health_exch, "subQuery")) paste0("(", as.character(health_exch), ")") else paste0("'", as.character(health_exch), "'"))

  if (missing(lis_dual)) {
    lis_dual <- defaults$lis_dual
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.lis_dual')
  }
  fields <- c(fields, "lis_dual")
  values <- c(values, if (is.null(lis_dual)) "NULL" else if (is(lis_dual, "subQuery")) paste0("(", as.character(lis_dual), ")") else paste0("'", as.character(lis_dual), "'"))

  if (missing(product)) {
    product <- defaults$product
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.product')
  }
  fields <- c(fields, "product")
  values <- c(values, if (is.null(product)) "NULL" else if (is(product, "subQuery")) paste0("(", as.character(product), ")") else paste0("'", as.character(product), "'"))

  if (missing(race)) {
    race <- defaults$race
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.race')
  }
  fields <- c(fields, "race")
  values <- c(values, if (is.null(race)) "NULL" else if (is(race, "subQuery")) paste0("(", as.character(race), ")") else paste0("'", as.character(race), "'"))

  if (missing(state)) {
    state <- defaults$state
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.state')
  }
  fields <- c(fields, "state")
  values <- c(values, if (is.null(state)) "NULL" else if (is(state, "subQuery")) paste0("(", as.character(state), ")") else paste0("'", as.character(state), "'"))

  if (missing(yrdob)) {
    yrdob <- defaults$yrdob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.yrdob')
  }
  fields <- c(fields, "yrdob")
  values <- c(values, if (is.null(yrdob)) "NULL" else if (is(yrdob, "subQuery")) paste0("(", as.character(yrdob), ")") else paste0("'", as.character(yrdob), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(ethnicity)) {
    ethnicity <- defaults$ethnicity
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.ethnicity')
  }
  fields <- c(fields, "ethnicity")
  values <- c(values, if (is.null(ethnicity)) "NULL" else if (is(ethnicity, "subQuery")) paste0("(", as.character(ethnicity), ")") else paste0("'", as.character(ethnicity), "'"))

  if (missing(race_source)) {
    race_source <- defaults$race_source
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_enrollment.race_source')
  }
  fields <- c(fields, "race_source")
  values <- c(values, if (is.null(race_source)) "NULL" else if (is(race_source, "subQuery")) paste0("(", as.character(race_source), ")") else paste0("'", as.character(race_source), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "member_enrollment", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_version <- function() {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "_version", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_death <- function(patid, ymdod, extract_ym, version, mbr_match_type) {
  defaults <- get('death', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(ymdod)) {
    ymdod <- defaults$ymdod
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.ymdod')
  }
  fields <- c(fields, "ymdod")
  values <- c(values, if (is.null(ymdod)) "NULL" else if (is(ymdod, "subQuery")) paste0("(", as.character(ymdod), ")") else paste0("'", as.character(ymdod), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(mbr_match_type)) {
    mbr_match_type <- defaults$mbr_match_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.mbr_match_type')
  }
  fields <- c(fields, "mbr_match_type")
  values <- c(values, if (is.null(mbr_match_type)) "NULL" else if (is(mbr_match_type, "subQuery")) paste0("(", as.character(mbr_match_type), ")") else paste0("'", as.character(mbr_match_type), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "death", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_hra <- function(patid, h_bmi, h_bsa, h_chronic_pain, h_height, h_smoking_status, h_weight, hra_compltd_dt, isa10008, isa1006, isa13021, isa13022, isa13023, isa13040, isa16010, isa16016, isa16040, isa17001, isa17015, isa17021, isa17023, isa18015, isa19004, isa19005, isa20061, isa20064, isa20069, isa20072, isa21001, isa21003, isa21009, isa21015, isa21020, isa21021, isa21025, isa3010, isa5001, isa5004, isa5010, isa5018, isa7018, isa8016, isa9009, isa9063, extract_ym, version) {
  defaults <- get('hra', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(h_bmi)) {
    h_bmi <- defaults$h_bmi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.h_bmi')
  }
  fields <- c(fields, "h_bmi")
  values <- c(values, if (is.null(h_bmi)) "NULL" else if (is(h_bmi, "subQuery")) paste0("(", as.character(h_bmi), ")") else paste0("'", as.character(h_bmi), "'"))

  if (missing(h_bsa)) {
    h_bsa <- defaults$h_bsa
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.h_bsa')
  }
  fields <- c(fields, "h_bsa")
  values <- c(values, if (is.null(h_bsa)) "NULL" else if (is(h_bsa, "subQuery")) paste0("(", as.character(h_bsa), ")") else paste0("'", as.character(h_bsa), "'"))

  if (missing(h_chronic_pain)) {
    h_chronic_pain <- defaults$h_chronic_pain
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.h_chronic_pain')
  }
  fields <- c(fields, "h_chronic_pain")
  values <- c(values, if (is.null(h_chronic_pain)) "NULL" else if (is(h_chronic_pain, "subQuery")) paste0("(", as.character(h_chronic_pain), ")") else paste0("'", as.character(h_chronic_pain), "'"))

  if (missing(h_height)) {
    h_height <- defaults$h_height
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.h_height')
  }
  fields <- c(fields, "h_height")
  values <- c(values, if (is.null(h_height)) "NULL" else if (is(h_height, "subQuery")) paste0("(", as.character(h_height), ")") else paste0("'", as.character(h_height), "'"))

  if (missing(h_smoking_status)) {
    h_smoking_status <- defaults$h_smoking_status
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.h_smoking_status')
  }
  fields <- c(fields, "h_smoking_status")
  values <- c(values, if (is.null(h_smoking_status)) "NULL" else if (is(h_smoking_status, "subQuery")) paste0("(", as.character(h_smoking_status), ")") else paste0("'", as.character(h_smoking_status), "'"))

  if (missing(h_weight)) {
    h_weight <- defaults$h_weight
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.h_weight')
  }
  fields <- c(fields, "h_weight")
  values <- c(values, if (is.null(h_weight)) "NULL" else if (is(h_weight, "subQuery")) paste0("(", as.character(h_weight), ")") else paste0("'", as.character(h_weight), "'"))

  if (missing(hra_compltd_dt)) {
    hra_compltd_dt <- defaults$hra_compltd_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.hra_compltd_dt')
  }
  fields <- c(fields, "hra_compltd_dt")
  values <- c(values, if (is.null(hra_compltd_dt)) "NULL" else if (is(hra_compltd_dt, "subQuery")) paste0("(", as.character(hra_compltd_dt), ")") else paste0("'", as.character(hra_compltd_dt), "'"))

  if (missing(isa10008)) {
    isa10008 <- defaults$isa10008
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa10008')
  }
  fields <- c(fields, "isa10008")
  values <- c(values, if (is.null(isa10008)) "NULL" else if (is(isa10008, "subQuery")) paste0("(", as.character(isa10008), ")") else paste0("'", as.character(isa10008), "'"))

  if (missing(isa1006)) {
    isa1006 <- defaults$isa1006
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa1006')
  }
  fields <- c(fields, "isa1006")
  values <- c(values, if (is.null(isa1006)) "NULL" else if (is(isa1006, "subQuery")) paste0("(", as.character(isa1006), ")") else paste0("'", as.character(isa1006), "'"))

  if (missing(isa13021)) {
    isa13021 <- defaults$isa13021
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa13021')
  }
  fields <- c(fields, "isa13021")
  values <- c(values, if (is.null(isa13021)) "NULL" else if (is(isa13021, "subQuery")) paste0("(", as.character(isa13021), ")") else paste0("'", as.character(isa13021), "'"))

  if (missing(isa13022)) {
    isa13022 <- defaults$isa13022
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa13022')
  }
  fields <- c(fields, "isa13022")
  values <- c(values, if (is.null(isa13022)) "NULL" else if (is(isa13022, "subQuery")) paste0("(", as.character(isa13022), ")") else paste0("'", as.character(isa13022), "'"))

  if (missing(isa13023)) {
    isa13023 <- defaults$isa13023
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa13023')
  }
  fields <- c(fields, "isa13023")
  values <- c(values, if (is.null(isa13023)) "NULL" else if (is(isa13023, "subQuery")) paste0("(", as.character(isa13023), ")") else paste0("'", as.character(isa13023), "'"))

  if (missing(isa13040)) {
    isa13040 <- defaults$isa13040
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa13040')
  }
  fields <- c(fields, "isa13040")
  values <- c(values, if (is.null(isa13040)) "NULL" else if (is(isa13040, "subQuery")) paste0("(", as.character(isa13040), ")") else paste0("'", as.character(isa13040), "'"))

  if (missing(isa16010)) {
    isa16010 <- defaults$isa16010
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa16010')
  }
  fields <- c(fields, "isa16010")
  values <- c(values, if (is.null(isa16010)) "NULL" else if (is(isa16010, "subQuery")) paste0("(", as.character(isa16010), ")") else paste0("'", as.character(isa16010), "'"))

  if (missing(isa16016)) {
    isa16016 <- defaults$isa16016
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa16016')
  }
  fields <- c(fields, "isa16016")
  values <- c(values, if (is.null(isa16016)) "NULL" else if (is(isa16016, "subQuery")) paste0("(", as.character(isa16016), ")") else paste0("'", as.character(isa16016), "'"))

  if (missing(isa16040)) {
    isa16040 <- defaults$isa16040
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa16040')
  }
  fields <- c(fields, "isa16040")
  values <- c(values, if (is.null(isa16040)) "NULL" else if (is(isa16040, "subQuery")) paste0("(", as.character(isa16040), ")") else paste0("'", as.character(isa16040), "'"))

  if (missing(isa17001)) {
    isa17001 <- defaults$isa17001
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa17001')
  }
  fields <- c(fields, "isa17001")
  values <- c(values, if (is.null(isa17001)) "NULL" else if (is(isa17001, "subQuery")) paste0("(", as.character(isa17001), ")") else paste0("'", as.character(isa17001), "'"))

  if (missing(isa17015)) {
    isa17015 <- defaults$isa17015
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa17015')
  }
  fields <- c(fields, "isa17015")
  values <- c(values, if (is.null(isa17015)) "NULL" else if (is(isa17015, "subQuery")) paste0("(", as.character(isa17015), ")") else paste0("'", as.character(isa17015), "'"))

  if (missing(isa17021)) {
    isa17021 <- defaults$isa17021
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa17021')
  }
  fields <- c(fields, "isa17021")
  values <- c(values, if (is.null(isa17021)) "NULL" else if (is(isa17021, "subQuery")) paste0("(", as.character(isa17021), ")") else paste0("'", as.character(isa17021), "'"))

  if (missing(isa17023)) {
    isa17023 <- defaults$isa17023
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa17023')
  }
  fields <- c(fields, "isa17023")
  values <- c(values, if (is.null(isa17023)) "NULL" else if (is(isa17023, "subQuery")) paste0("(", as.character(isa17023), ")") else paste0("'", as.character(isa17023), "'"))

  if (missing(isa18015)) {
    isa18015 <- defaults$isa18015
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa18015')
  }
  fields <- c(fields, "isa18015")
  values <- c(values, if (is.null(isa18015)) "NULL" else if (is(isa18015, "subQuery")) paste0("(", as.character(isa18015), ")") else paste0("'", as.character(isa18015), "'"))

  if (missing(isa19004)) {
    isa19004 <- defaults$isa19004
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa19004')
  }
  fields <- c(fields, "isa19004")
  values <- c(values, if (is.null(isa19004)) "NULL" else if (is(isa19004, "subQuery")) paste0("(", as.character(isa19004), ")") else paste0("'", as.character(isa19004), "'"))

  if (missing(isa19005)) {
    isa19005 <- defaults$isa19005
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa19005')
  }
  fields <- c(fields, "isa19005")
  values <- c(values, if (is.null(isa19005)) "NULL" else if (is(isa19005, "subQuery")) paste0("(", as.character(isa19005), ")") else paste0("'", as.character(isa19005), "'"))

  if (missing(isa20061)) {
    isa20061 <- defaults$isa20061
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa20061')
  }
  fields <- c(fields, "isa20061")
  values <- c(values, if (is.null(isa20061)) "NULL" else if (is(isa20061, "subQuery")) paste0("(", as.character(isa20061), ")") else paste0("'", as.character(isa20061), "'"))

  if (missing(isa20064)) {
    isa20064 <- defaults$isa20064
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa20064')
  }
  fields <- c(fields, "isa20064")
  values <- c(values, if (is.null(isa20064)) "NULL" else if (is(isa20064, "subQuery")) paste0("(", as.character(isa20064), ")") else paste0("'", as.character(isa20064), "'"))

  if (missing(isa20069)) {
    isa20069 <- defaults$isa20069
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa20069')
  }
  fields <- c(fields, "isa20069")
  values <- c(values, if (is.null(isa20069)) "NULL" else if (is(isa20069, "subQuery")) paste0("(", as.character(isa20069), ")") else paste0("'", as.character(isa20069), "'"))

  if (missing(isa20072)) {
    isa20072 <- defaults$isa20072
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa20072')
  }
  fields <- c(fields, "isa20072")
  values <- c(values, if (is.null(isa20072)) "NULL" else if (is(isa20072, "subQuery")) paste0("(", as.character(isa20072), ")") else paste0("'", as.character(isa20072), "'"))

  if (missing(isa21001)) {
    isa21001 <- defaults$isa21001
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa21001')
  }
  fields <- c(fields, "isa21001")
  values <- c(values, if (is.null(isa21001)) "NULL" else if (is(isa21001, "subQuery")) paste0("(", as.character(isa21001), ")") else paste0("'", as.character(isa21001), "'"))

  if (missing(isa21003)) {
    isa21003 <- defaults$isa21003
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa21003')
  }
  fields <- c(fields, "isa21003")
  values <- c(values, if (is.null(isa21003)) "NULL" else if (is(isa21003, "subQuery")) paste0("(", as.character(isa21003), ")") else paste0("'", as.character(isa21003), "'"))

  if (missing(isa21009)) {
    isa21009 <- defaults$isa21009
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa21009')
  }
  fields <- c(fields, "isa21009")
  values <- c(values, if (is.null(isa21009)) "NULL" else if (is(isa21009, "subQuery")) paste0("(", as.character(isa21009), ")") else paste0("'", as.character(isa21009), "'"))

  if (missing(isa21015)) {
    isa21015 <- defaults$isa21015
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa21015')
  }
  fields <- c(fields, "isa21015")
  values <- c(values, if (is.null(isa21015)) "NULL" else if (is(isa21015, "subQuery")) paste0("(", as.character(isa21015), ")") else paste0("'", as.character(isa21015), "'"))

  if (missing(isa21020)) {
    isa21020 <- defaults$isa21020
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa21020')
  }
  fields <- c(fields, "isa21020")
  values <- c(values, if (is.null(isa21020)) "NULL" else if (is(isa21020, "subQuery")) paste0("(", as.character(isa21020), ")") else paste0("'", as.character(isa21020), "'"))

  if (missing(isa21021)) {
    isa21021 <- defaults$isa21021
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa21021')
  }
  fields <- c(fields, "isa21021")
  values <- c(values, if (is.null(isa21021)) "NULL" else if (is(isa21021, "subQuery")) paste0("(", as.character(isa21021), ")") else paste0("'", as.character(isa21021), "'"))

  if (missing(isa21025)) {
    isa21025 <- defaults$isa21025
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa21025')
  }
  fields <- c(fields, "isa21025")
  values <- c(values, if (is.null(isa21025)) "NULL" else if (is(isa21025, "subQuery")) paste0("(", as.character(isa21025), ")") else paste0("'", as.character(isa21025), "'"))

  if (missing(isa3010)) {
    isa3010 <- defaults$isa3010
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa3010')
  }
  fields <- c(fields, "isa3010")
  values <- c(values, if (is.null(isa3010)) "NULL" else if (is(isa3010, "subQuery")) paste0("(", as.character(isa3010), ")") else paste0("'", as.character(isa3010), "'"))

  if (missing(isa5001)) {
    isa5001 <- defaults$isa5001
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa5001')
  }
  fields <- c(fields, "isa5001")
  values <- c(values, if (is.null(isa5001)) "NULL" else if (is(isa5001, "subQuery")) paste0("(", as.character(isa5001), ")") else paste0("'", as.character(isa5001), "'"))

  if (missing(isa5004)) {
    isa5004 <- defaults$isa5004
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa5004')
  }
  fields <- c(fields, "isa5004")
  values <- c(values, if (is.null(isa5004)) "NULL" else if (is(isa5004, "subQuery")) paste0("(", as.character(isa5004), ")") else paste0("'", as.character(isa5004), "'"))

  if (missing(isa5010)) {
    isa5010 <- defaults$isa5010
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa5010')
  }
  fields <- c(fields, "isa5010")
  values <- c(values, if (is.null(isa5010)) "NULL" else if (is(isa5010, "subQuery")) paste0("(", as.character(isa5010), ")") else paste0("'", as.character(isa5010), "'"))

  if (missing(isa5018)) {
    isa5018 <- defaults$isa5018
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa5018')
  }
  fields <- c(fields, "isa5018")
  values <- c(values, if (is.null(isa5018)) "NULL" else if (is(isa5018, "subQuery")) paste0("(", as.character(isa5018), ")") else paste0("'", as.character(isa5018), "'"))

  if (missing(isa7018)) {
    isa7018 <- defaults$isa7018
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa7018')
  }
  fields <- c(fields, "isa7018")
  values <- c(values, if (is.null(isa7018)) "NULL" else if (is(isa7018, "subQuery")) paste0("(", as.character(isa7018), ")") else paste0("'", as.character(isa7018), "'"))

  if (missing(isa8016)) {
    isa8016 <- defaults$isa8016
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa8016')
  }
  fields <- c(fields, "isa8016")
  values <- c(values, if (is.null(isa8016)) "NULL" else if (is(isa8016, "subQuery")) paste0("(", as.character(isa8016), ")") else paste0("'", as.character(isa8016), "'"))

  if (missing(isa9009)) {
    isa9009 <- defaults$isa9009
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa9009')
  }
  fields <- c(fields, "isa9009")
  values <- c(values, if (is.null(isa9009)) "NULL" else if (is(isa9009, "subQuery")) paste0("(", as.character(isa9009), ")") else paste0("'", as.character(isa9009), "'"))

  if (missing(isa9063)) {
    isa9063 <- defaults$isa9063
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.isa9063')
  }
  fields <- c(fields, "isa9063")
  values <- c(values, if (is.null(isa9063)) "NULL" else if (is(isa9063, "subQuery")) paste0("(", as.character(isa9063), ")") else paste0("'", as.character(isa9063), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hra.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "hra", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_provider <- function(prov_unique, bed_sz_range, cred_type, grp_practice, hosp_affil, prov_state, prov_type, provcat, taxonomy1, taxonomy2, extract_ym, version) {
  defaults <- get('provider', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(prov_unique)) {
    prov_unique <- defaults$prov_unique
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.prov_unique')
  }
  fields <- c(fields, "prov_unique")
  values <- c(values, if (is.null(prov_unique)) "NULL" else if (is(prov_unique, "subQuery")) paste0("(", as.character(prov_unique), ")") else paste0("'", as.character(prov_unique), "'"))

  if (missing(bed_sz_range)) {
    bed_sz_range <- defaults$bed_sz_range
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.bed_sz_range')
  }
  fields <- c(fields, "bed_sz_range")
  values <- c(values, if (is.null(bed_sz_range)) "NULL" else if (is(bed_sz_range, "subQuery")) paste0("(", as.character(bed_sz_range), ")") else paste0("'", as.character(bed_sz_range), "'"))

  if (missing(cred_type)) {
    cred_type <- defaults$cred_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.cred_type')
  }
  fields <- c(fields, "cred_type")
  values <- c(values, if (is.null(cred_type)) "NULL" else if (is(cred_type, "subQuery")) paste0("(", as.character(cred_type), ")") else paste0("'", as.character(cred_type), "'"))

  if (missing(grp_practice)) {
    grp_practice <- defaults$grp_practice
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.grp_practice')
  }
  fields <- c(fields, "grp_practice")
  values <- c(values, if (is.null(grp_practice)) "NULL" else if (is(grp_practice, "subQuery")) paste0("(", as.character(grp_practice), ")") else paste0("'", as.character(grp_practice), "'"))

  if (missing(hosp_affil)) {
    hosp_affil <- defaults$hosp_affil
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.hosp_affil')
  }
  fields <- c(fields, "hosp_affil")
  values <- c(values, if (is.null(hosp_affil)) "NULL" else if (is(hosp_affil, "subQuery")) paste0("(", as.character(hosp_affil), ")") else paste0("'", as.character(hosp_affil), "'"))

  if (missing(prov_state)) {
    prov_state <- defaults$prov_state
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.prov_state')
  }
  fields <- c(fields, "prov_state")
  values <- c(values, if (is.null(prov_state)) "NULL" else if (is(prov_state, "subQuery")) paste0("(", as.character(prov_state), ")") else paste0("'", as.character(prov_state), "'"))

  if (missing(prov_type)) {
    prov_type <- defaults$prov_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.prov_type')
  }
  fields <- c(fields, "prov_type")
  values <- c(values, if (is.null(prov_type)) "NULL" else if (is(prov_type, "subQuery")) paste0("(", as.character(prov_type), ")") else paste0("'", as.character(prov_type), "'"))

  if (missing(provcat)) {
    provcat <- defaults$provcat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.provcat')
  }
  fields <- c(fields, "provcat")
  values <- c(values, if (is.null(provcat)) "NULL" else if (is(provcat, "subQuery")) paste0("(", as.character(provcat), ")") else paste0("'", as.character(provcat), "'"))

  if (missing(taxonomy1)) {
    taxonomy1 <- defaults$taxonomy1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.taxonomy1')
  }
  fields <- c(fields, "taxonomy1")
  values <- c(values, if (is.null(taxonomy1)) "NULL" else if (is(taxonomy1, "subQuery")) paste0("(", as.character(taxonomy1), ")") else paste0("'", as.character(taxonomy1), "'"))

  if (missing(taxonomy2)) {
    taxonomy2 <- defaults$taxonomy2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.taxonomy2')
  }
  fields <- c(fields, "taxonomy2")
  values <- c(values, if (is.null(taxonomy2)) "NULL" else if (is(taxonomy2, "subQuery")) paste0("(", as.character(taxonomy2), ")") else paste0("'", as.character(taxonomy2), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "provider", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_medical_claims <- function(patid, pat_planid, admit_chan, admit_type, bill_prov, charge, clmid, clmseq, cob, coins, conf_id, copay, deduct, drg, dstatus, enctr, fst_dt, hccc, icd_flag, loc_cd, lst_dt, ndc, paid_dt, paid_status, pos, proc_cd, procmod, prov, prov_par, provcat, refer_prov, rvnu_cd, service_prov, std_cost, std_cost_yr, tos_cd, units, extract_ym, version, alt_units, bill_type, ndc_uom, ndc_qty, op_visit_id, procmod2, procmod3, procmod4, tos_ext, bill_proc_cd) {
  defaults <- get('medical_claims', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(pat_planid)) {
    pat_planid <- defaults$pat_planid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.pat_planid')
  }
  fields <- c(fields, "pat_planid")
  values <- c(values, if (is.null(pat_planid)) "NULL" else if (is(pat_planid, "subQuery")) paste0("(", as.character(pat_planid), ")") else paste0("'", as.character(pat_planid), "'"))

  if (missing(admit_chan)) {
    admit_chan <- defaults$admit_chan
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.admit_chan')
  }
  fields <- c(fields, "admit_chan")
  values <- c(values, if (is.null(admit_chan)) "NULL" else if (is(admit_chan, "subQuery")) paste0("(", as.character(admit_chan), ")") else paste0("'", as.character(admit_chan), "'"))

  if (missing(admit_type)) {
    admit_type <- defaults$admit_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.admit_type')
  }
  fields <- c(fields, "admit_type")
  values <- c(values, if (is.null(admit_type)) "NULL" else if (is(admit_type, "subQuery")) paste0("(", as.character(admit_type), ")") else paste0("'", as.character(admit_type), "'"))

  if (missing(bill_prov)) {
    bill_prov <- defaults$bill_prov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.bill_prov')
  }
  fields <- c(fields, "bill_prov")
  values <- c(values, if (is.null(bill_prov)) "NULL" else if (is(bill_prov, "subQuery")) paste0("(", as.character(bill_prov), ")") else paste0("'", as.character(bill_prov), "'"))

  if (missing(charge)) {
    charge <- defaults$charge
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.charge')
  }
  fields <- c(fields, "charge")
  values <- c(values, if (is.null(charge)) "NULL" else if (is(charge, "subQuery")) paste0("(", as.character(charge), ")") else paste0("'", as.character(charge), "'"))

  if (missing(clmid)) {
    clmid <- defaults$clmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.clmid')
  }
  fields <- c(fields, "clmid")
  values <- c(values, if (is.null(clmid)) "NULL" else if (is(clmid, "subQuery")) paste0("(", as.character(clmid), ")") else paste0("'", as.character(clmid), "'"))

  if (missing(clmseq)) {
    clmseq <- defaults$clmseq
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.clmseq')
  }
  fields <- c(fields, "clmseq")
  values <- c(values, if (is.null(clmseq)) "NULL" else if (is(clmseq, "subQuery")) paste0("(", as.character(clmseq), ")") else paste0("'", as.character(clmseq), "'"))

  if (missing(cob)) {
    cob <- defaults$cob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.cob')
  }
  fields <- c(fields, "cob")
  values <- c(values, if (is.null(cob)) "NULL" else if (is(cob, "subQuery")) paste0("(", as.character(cob), ")") else paste0("'", as.character(cob), "'"))

  if (missing(coins)) {
    coins <- defaults$coins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.coins')
  }
  fields <- c(fields, "coins")
  values <- c(values, if (is.null(coins)) "NULL" else if (is(coins, "subQuery")) paste0("(", as.character(coins), ")") else paste0("'", as.character(coins), "'"))

  if (missing(conf_id)) {
    conf_id <- defaults$conf_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.conf_id')
  }
  fields <- c(fields, "conf_id")
  values <- c(values, if (is.null(conf_id)) "NULL" else if (is(conf_id, "subQuery")) paste0("(", as.character(conf_id), ")") else paste0("'", as.character(conf_id), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(drg)) {
    drg <- defaults$drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.drg')
  }
  fields <- c(fields, "drg")
  values <- c(values, if (is.null(drg)) "NULL" else if (is(drg, "subQuery")) paste0("(", as.character(drg), ")") else paste0("'", as.character(drg), "'"))

  if (missing(dstatus)) {
    dstatus <- defaults$dstatus
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.dstatus')
  }
  fields <- c(fields, "dstatus")
  values <- c(values, if (is.null(dstatus)) "NULL" else if (is(dstatus, "subQuery")) paste0("(", as.character(dstatus), ")") else paste0("'", as.character(dstatus), "'"))

  if (missing(enctr)) {
    enctr <- defaults$enctr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.enctr')
  }
  fields <- c(fields, "enctr")
  values <- c(values, if (is.null(enctr)) "NULL" else if (is(enctr, "subQuery")) paste0("(", as.character(enctr), ")") else paste0("'", as.character(enctr), "'"))

  if (missing(fst_dt)) {
    fst_dt <- defaults$fst_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.fst_dt')
  }
  fields <- c(fields, "fst_dt")
  values <- c(values, if (is.null(fst_dt)) "NULL" else if (is(fst_dt, "subQuery")) paste0("(", as.character(fst_dt), ")") else paste0("'", as.character(fst_dt), "'"))

  if (missing(hccc)) {
    hccc <- defaults$hccc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.hccc')
  }
  fields <- c(fields, "hccc")
  values <- c(values, if (is.null(hccc)) "NULL" else if (is(hccc, "subQuery")) paste0("(", as.character(hccc), ")") else paste0("'", as.character(hccc), "'"))

  if (missing(icd_flag)) {
    icd_flag <- defaults$icd_flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.icd_flag')
  }
  fields <- c(fields, "icd_flag")
  values <- c(values, if (is.null(icd_flag)) "NULL" else if (is(icd_flag, "subQuery")) paste0("(", as.character(icd_flag), ")") else paste0("'", as.character(icd_flag), "'"))

  if (missing(loc_cd)) {
    loc_cd <- defaults$loc_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.loc_cd')
  }
  fields <- c(fields, "loc_cd")
  values <- c(values, if (is.null(loc_cd)) "NULL" else if (is(loc_cd, "subQuery")) paste0("(", as.character(loc_cd), ")") else paste0("'", as.character(loc_cd), "'"))

  if (missing(lst_dt)) {
    lst_dt <- defaults$lst_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.lst_dt')
  }
  fields <- c(fields, "lst_dt")
  values <- c(values, if (is.null(lst_dt)) "NULL" else if (is(lst_dt, "subQuery")) paste0("(", as.character(lst_dt), ")") else paste0("'", as.character(lst_dt), "'"))

  if (missing(ndc)) {
    ndc <- defaults$ndc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.ndc')
  }
  fields <- c(fields, "ndc")
  values <- c(values, if (is.null(ndc)) "NULL" else if (is(ndc, "subQuery")) paste0("(", as.character(ndc), ")") else paste0("'", as.character(ndc), "'"))

  if (missing(paid_dt)) {
    paid_dt <- defaults$paid_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.paid_dt')
  }
  fields <- c(fields, "paid_dt")
  values <- c(values, if (is.null(paid_dt)) "NULL" else if (is(paid_dt, "subQuery")) paste0("(", as.character(paid_dt), ")") else paste0("'", as.character(paid_dt), "'"))

  if (missing(paid_status)) {
    paid_status <- defaults$paid_status
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.paid_status')
  }
  fields <- c(fields, "paid_status")
  values <- c(values, if (is.null(paid_status)) "NULL" else if (is(paid_status, "subQuery")) paste0("(", as.character(paid_status), ")") else paste0("'", as.character(paid_status), "'"))

  if (missing(pos)) {
    pos <- defaults$pos
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.pos')
  }
  fields <- c(fields, "pos")
  values <- c(values, if (is.null(pos)) "NULL" else if (is(pos, "subQuery")) paste0("(", as.character(pos), ")") else paste0("'", as.character(pos), "'"))

  if (missing(proc_cd)) {
    proc_cd <- defaults$proc_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.proc_cd')
  }
  fields <- c(fields, "proc_cd")
  values <- c(values, if (is.null(proc_cd)) "NULL" else if (is(proc_cd, "subQuery")) paste0("(", as.character(proc_cd), ")") else paste0("'", as.character(proc_cd), "'"))

  if (missing(procmod)) {
    procmod <- defaults$procmod
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.procmod')
  }
  fields <- c(fields, "procmod")
  values <- c(values, if (is.null(procmod)) "NULL" else if (is(procmod, "subQuery")) paste0("(", as.character(procmod), ")") else paste0("'", as.character(procmod), "'"))

  if (missing(prov)) {
    prov <- defaults$prov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.prov')
  }
  fields <- c(fields, "prov")
  values <- c(values, if (is.null(prov)) "NULL" else if (is(prov, "subQuery")) paste0("(", as.character(prov), ")") else paste0("'", as.character(prov), "'"))

  if (missing(prov_par)) {
    prov_par <- defaults$prov_par
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.prov_par')
  }
  fields <- c(fields, "prov_par")
  values <- c(values, if (is.null(prov_par)) "NULL" else if (is(prov_par, "subQuery")) paste0("(", as.character(prov_par), ")") else paste0("'", as.character(prov_par), "'"))

  if (missing(provcat)) {
    provcat <- defaults$provcat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.provcat')
  }
  fields <- c(fields, "provcat")
  values <- c(values, if (is.null(provcat)) "NULL" else if (is(provcat, "subQuery")) paste0("(", as.character(provcat), ")") else paste0("'", as.character(provcat), "'"))

  if (missing(refer_prov)) {
    refer_prov <- defaults$refer_prov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.refer_prov')
  }
  fields <- c(fields, "refer_prov")
  values <- c(values, if (is.null(refer_prov)) "NULL" else if (is(refer_prov, "subQuery")) paste0("(", as.character(refer_prov), ")") else paste0("'", as.character(refer_prov), "'"))

  if (missing(rvnu_cd)) {
    rvnu_cd <- defaults$rvnu_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.rvnu_cd')
  }
  fields <- c(fields, "rvnu_cd")
  values <- c(values, if (is.null(rvnu_cd)) "NULL" else if (is(rvnu_cd, "subQuery")) paste0("(", as.character(rvnu_cd), ")") else paste0("'", as.character(rvnu_cd), "'"))

  if (missing(service_prov)) {
    service_prov <- defaults$service_prov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.service_prov')
  }
  fields <- c(fields, "service_prov")
  values <- c(values, if (is.null(service_prov)) "NULL" else if (is(service_prov, "subQuery")) paste0("(", as.character(service_prov), ")") else paste0("'", as.character(service_prov), "'"))

  if (missing(std_cost)) {
    std_cost <- defaults$std_cost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.std_cost')
  }
  fields <- c(fields, "std_cost")
  values <- c(values, if (is.null(std_cost)) "NULL" else if (is(std_cost, "subQuery")) paste0("(", as.character(std_cost), ")") else paste0("'", as.character(std_cost), "'"))

  if (missing(std_cost_yr)) {
    std_cost_yr <- defaults$std_cost_yr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.std_cost_yr')
  }
  fields <- c(fields, "std_cost_yr")
  values <- c(values, if (is.null(std_cost_yr)) "NULL" else if (is(std_cost_yr, "subQuery")) paste0("(", as.character(std_cost_yr), ")") else paste0("'", as.character(std_cost_yr), "'"))

  if (missing(tos_cd)) {
    tos_cd <- defaults$tos_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.tos_cd')
  }
  fields <- c(fields, "tos_cd")
  values <- c(values, if (is.null(tos_cd)) "NULL" else if (is(tos_cd, "subQuery")) paste0("(", as.character(tos_cd), ")") else paste0("'", as.character(tos_cd), "'"))

  if (missing(units)) {
    units <- defaults$units
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.units')
  }
  fields <- c(fields, "units")
  values <- c(values, if (is.null(units)) "NULL" else if (is(units, "subQuery")) paste0("(", as.character(units), ")") else paste0("'", as.character(units), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(alt_units)) {
    alt_units <- defaults$alt_units
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.alt_units')
  }
  fields <- c(fields, "alt_units")
  values <- c(values, if (is.null(alt_units)) "NULL" else if (is(alt_units, "subQuery")) paste0("(", as.character(alt_units), ")") else paste0("'", as.character(alt_units), "'"))

  if (missing(bill_type)) {
    bill_type <- defaults$bill_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.bill_type')
  }
  fields <- c(fields, "bill_type")
  values <- c(values, if (is.null(bill_type)) "NULL" else if (is(bill_type, "subQuery")) paste0("(", as.character(bill_type), ")") else paste0("'", as.character(bill_type), "'"))

  if (missing(ndc_uom)) {
    ndc_uom <- defaults$ndc_uom
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.ndc_uom')
  }
  fields <- c(fields, "ndc_uom")
  values <- c(values, if (is.null(ndc_uom)) "NULL" else if (is(ndc_uom, "subQuery")) paste0("(", as.character(ndc_uom), ")") else paste0("'", as.character(ndc_uom), "'"))

  if (missing(ndc_qty)) {
    ndc_qty <- defaults$ndc_qty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.ndc_qty')
  }
  fields <- c(fields, "ndc_qty")
  values <- c(values, if (is.null(ndc_qty)) "NULL" else if (is(ndc_qty, "subQuery")) paste0("(", as.character(ndc_qty), ")") else paste0("'", as.character(ndc_qty), "'"))

  if (missing(op_visit_id)) {
    op_visit_id <- defaults$op_visit_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.op_visit_id')
  }
  fields <- c(fields, "op_visit_id")
  values <- c(values, if (is.null(op_visit_id)) "NULL" else if (is(op_visit_id, "subQuery")) paste0("(", as.character(op_visit_id), ")") else paste0("'", as.character(op_visit_id), "'"))

  if (missing(procmod2)) {
    procmod2 <- defaults$procmod2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.procmod2')
  }
  fields <- c(fields, "procmod2")
  values <- c(values, if (is.null(procmod2)) "NULL" else if (is(procmod2, "subQuery")) paste0("(", as.character(procmod2), ")") else paste0("'", as.character(procmod2), "'"))

  if (missing(procmod3)) {
    procmod3 <- defaults$procmod3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.procmod3')
  }
  fields <- c(fields, "procmod3")
  values <- c(values, if (is.null(procmod3)) "NULL" else if (is(procmod3, "subQuery")) paste0("(", as.character(procmod3), ")") else paste0("'", as.character(procmod3), "'"))

  if (missing(procmod4)) {
    procmod4 <- defaults$procmod4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.procmod4')
  }
  fields <- c(fields, "procmod4")
  values <- c(values, if (is.null(procmod4)) "NULL" else if (is(procmod4, "subQuery")) paste0("(", as.character(procmod4), ")") else paste0("'", as.character(procmod4), "'"))

  if (missing(tos_ext)) {
    tos_ext <- defaults$tos_ext
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.tos_ext')
  }
  fields <- c(fields, "tos_ext")
  values <- c(values, if (is.null(tos_ext)) "NULL" else if (is(tos_ext, "subQuery")) paste0("(", as.character(tos_ext), ")") else paste0("'", as.character(tos_ext), "'"))

  if (missing(bill_proc_cd)) {
    bill_proc_cd <- defaults$bill_proc_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'medical_claims.bill_proc_cd')
  }
  fields <- c(fields, "bill_proc_cd")
  values <- c(values, if (is.null(bill_proc_cd)) "NULL" else if (is(bill_proc_cd, "subQuery")) paste0("(", as.character(bill_proc_cd), ")") else paste0("'", as.character(bill_proc_cd), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "medical_claims", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_lu_diagnosis <- function(diag_cd, diag_desc, diag_fst3_cd, diag_fst3_desc, diag_fst4_cd, diag_fst4_desc, gdr_spec_cd, mdc_cd_desc, mdc_code, icd_ver_cd) {
  defaults <- get('lu_diagnosis', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(diag_cd)) {
    diag_cd <- defaults$diag_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.diag_cd')
  }
  fields <- c(fields, "diag_cd")
  values <- c(values, if (is.null(diag_cd)) "NULL" else if (is(diag_cd, "subQuery")) paste0("(", as.character(diag_cd), ")") else paste0("'", as.character(diag_cd), "'"))

  if (missing(diag_desc)) {
    diag_desc <- defaults$diag_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.diag_desc')
  }
  fields <- c(fields, "diag_desc")
  values <- c(values, if (is.null(diag_desc)) "NULL" else if (is(diag_desc, "subQuery")) paste0("(", as.character(diag_desc), ")") else paste0("'", as.character(diag_desc), "'"))

  if (missing(diag_fst3_cd)) {
    diag_fst3_cd <- defaults$diag_fst3_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.diag_fst3_cd')
  }
  fields <- c(fields, "diag_fst3_cd")
  values <- c(values, if (is.null(diag_fst3_cd)) "NULL" else if (is(diag_fst3_cd, "subQuery")) paste0("(", as.character(diag_fst3_cd), ")") else paste0("'", as.character(diag_fst3_cd), "'"))

  if (missing(diag_fst3_desc)) {
    diag_fst3_desc <- defaults$diag_fst3_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.diag_fst3_desc')
  }
  fields <- c(fields, "diag_fst3_desc")
  values <- c(values, if (is.null(diag_fst3_desc)) "NULL" else if (is(diag_fst3_desc, "subQuery")) paste0("(", as.character(diag_fst3_desc), ")") else paste0("'", as.character(diag_fst3_desc), "'"))

  if (missing(diag_fst4_cd)) {
    diag_fst4_cd <- defaults$diag_fst4_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.diag_fst4_cd')
  }
  fields <- c(fields, "diag_fst4_cd")
  values <- c(values, if (is.null(diag_fst4_cd)) "NULL" else if (is(diag_fst4_cd, "subQuery")) paste0("(", as.character(diag_fst4_cd), ")") else paste0("'", as.character(diag_fst4_cd), "'"))

  if (missing(diag_fst4_desc)) {
    diag_fst4_desc <- defaults$diag_fst4_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.diag_fst4_desc')
  }
  fields <- c(fields, "diag_fst4_desc")
  values <- c(values, if (is.null(diag_fst4_desc)) "NULL" else if (is(diag_fst4_desc, "subQuery")) paste0("(", as.character(diag_fst4_desc), ")") else paste0("'", as.character(diag_fst4_desc), "'"))

  if (missing(gdr_spec_cd)) {
    gdr_spec_cd <- defaults$gdr_spec_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.gdr_spec_cd')
  }
  fields <- c(fields, "gdr_spec_cd")
  values <- c(values, if (is.null(gdr_spec_cd)) "NULL" else if (is(gdr_spec_cd, "subQuery")) paste0("(", as.character(gdr_spec_cd), ")") else paste0("'", as.character(gdr_spec_cd), "'"))

  if (missing(mdc_cd_desc)) {
    mdc_cd_desc <- defaults$mdc_cd_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.mdc_cd_desc')
  }
  fields <- c(fields, "mdc_cd_desc")
  values <- c(values, if (is.null(mdc_cd_desc)) "NULL" else if (is(mdc_cd_desc, "subQuery")) paste0("(", as.character(mdc_cd_desc), ")") else paste0("'", as.character(mdc_cd_desc), "'"))

  if (missing(mdc_code)) {
    mdc_code <- defaults$mdc_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.mdc_code')
  }
  fields <- c(fields, "mdc_code")
  values <- c(values, if (is.null(mdc_code)) "NULL" else if (is(mdc_code, "subQuery")) paste0("(", as.character(mdc_code), ")") else paste0("'", as.character(mdc_code), "'"))

  if (missing(icd_ver_cd)) {
    icd_ver_cd <- defaults$icd_ver_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_diagnosis.icd_ver_cd')
  }
  fields <- c(fields, "icd_ver_cd")
  values <- c(values, if (is.null(icd_ver_cd)) "NULL" else if (is(icd_ver_cd, "subQuery")) paste0("(", as.character(icd_ver_cd), ")") else paste0("'", as.character(icd_ver_cd), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "lu_diagnosis", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_member_continuous_enrollment <- function(patid, eligeff, eligend, gdr_cd, race, yrdob, extract_ym, version, ethnicity, race_source) {
  defaults <- get('member_continuous_enrollment', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(patid)) {
    patid <- defaults$patid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.patid')
  }
  fields <- c(fields, "patid")
  values <- c(values, if (is.null(patid)) "NULL" else if (is(patid, "subQuery")) paste0("(", as.character(patid), ")") else paste0("'", as.character(patid), "'"))

  if (missing(eligeff)) {
    eligeff <- defaults$eligeff
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.eligeff')
  }
  fields <- c(fields, "eligeff")
  values <- c(values, if (is.null(eligeff)) "NULL" else if (is(eligeff, "subQuery")) paste0("(", as.character(eligeff), ")") else paste0("'", as.character(eligeff), "'"))

  if (missing(eligend)) {
    eligend <- defaults$eligend
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.eligend')
  }
  fields <- c(fields, "eligend")
  values <- c(values, if (is.null(eligend)) "NULL" else if (is(eligend, "subQuery")) paste0("(", as.character(eligend), ")") else paste0("'", as.character(eligend), "'"))

  if (missing(gdr_cd)) {
    gdr_cd <- defaults$gdr_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.gdr_cd')
  }
  fields <- c(fields, "gdr_cd")
  values <- c(values, if (is.null(gdr_cd)) "NULL" else if (is(gdr_cd, "subQuery")) paste0("(", as.character(gdr_cd), ")") else paste0("'", as.character(gdr_cd), "'"))

  if (missing(race)) {
    race <- defaults$race
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.race')
  }
  fields <- c(fields, "race")
  values <- c(values, if (is.null(race)) "NULL" else if (is(race, "subQuery")) paste0("(", as.character(race), ")") else paste0("'", as.character(race), "'"))

  if (missing(yrdob)) {
    yrdob <- defaults$yrdob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.yrdob')
  }
  fields <- c(fields, "yrdob")
  values <- c(values, if (is.null(yrdob)) "NULL" else if (is(yrdob, "subQuery")) paste0("(", as.character(yrdob), ")") else paste0("'", as.character(yrdob), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(ethnicity)) {
    ethnicity <- defaults$ethnicity
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.ethnicity')
  }
  fields <- c(fields, "ethnicity")
  values <- c(values, if (is.null(ethnicity)) "NULL" else if (is(ethnicity, "subQuery")) paste0("(", as.character(ethnicity), ")") else paste0("'", as.character(ethnicity), "'"))

  if (missing(race_source)) {
    race_source <- defaults$race_source
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'member_continuous_enrollment.race_source')
  }
  fields <- c(fields, "race_source")
  values <- c(values, if (is.null(race_source)) "NULL" else if (is(race_source, "subQuery")) paste0("(", as.character(race_source), ")") else paste0("'", as.character(race_source), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "member_continuous_enrollment", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_lu_ndc <- function(ahfsclss, ahfsclss_desc, brnd_nm, dosage_fm_desc, drg_strgth_desc, drg_strgth_nbr, drg_strgth_unit_desc, drg_strgth_vol_nbr, drg_strgth_vol_unit_desc, gnrc_ind, gnrc_nbr, gnrc_nm, gnrc_sqnc_nbr, ndc, ndc_drg_row_eff_dt, ndc_drg_row_end_dt, usc_id, usc_med_desc) {
  defaults <- get('lu_ndc', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(ahfsclss)) {
    ahfsclss <- defaults$ahfsclss
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.ahfsclss')
  }
  fields <- c(fields, "ahfsclss")
  values <- c(values, if (is.null(ahfsclss)) "NULL" else if (is(ahfsclss, "subQuery")) paste0("(", as.character(ahfsclss), ")") else paste0("'", as.character(ahfsclss), "'"))

  if (missing(ahfsclss_desc)) {
    ahfsclss_desc <- defaults$ahfsclss_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.ahfsclss_desc')
  }
  fields <- c(fields, "ahfsclss_desc")
  values <- c(values, if (is.null(ahfsclss_desc)) "NULL" else if (is(ahfsclss_desc, "subQuery")) paste0("(", as.character(ahfsclss_desc), ")") else paste0("'", as.character(ahfsclss_desc), "'"))

  if (missing(brnd_nm)) {
    brnd_nm <- defaults$brnd_nm
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.brnd_nm')
  }
  fields <- c(fields, "brnd_nm")
  values <- c(values, if (is.null(brnd_nm)) "NULL" else if (is(brnd_nm, "subQuery")) paste0("(", as.character(brnd_nm), ")") else paste0("'", as.character(brnd_nm), "'"))

  if (missing(dosage_fm_desc)) {
    dosage_fm_desc <- defaults$dosage_fm_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.dosage_fm_desc')
  }
  fields <- c(fields, "dosage_fm_desc")
  values <- c(values, if (is.null(dosage_fm_desc)) "NULL" else if (is(dosage_fm_desc, "subQuery")) paste0("(", as.character(dosage_fm_desc), ")") else paste0("'", as.character(dosage_fm_desc), "'"))

  if (missing(drg_strgth_desc)) {
    drg_strgth_desc <- defaults$drg_strgth_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.drg_strgth_desc')
  }
  fields <- c(fields, "drg_strgth_desc")
  values <- c(values, if (is.null(drg_strgth_desc)) "NULL" else if (is(drg_strgth_desc, "subQuery")) paste0("(", as.character(drg_strgth_desc), ")") else paste0("'", as.character(drg_strgth_desc), "'"))

  if (missing(drg_strgth_nbr)) {
    drg_strgth_nbr <- defaults$drg_strgth_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.drg_strgth_nbr')
  }
  fields <- c(fields, "drg_strgth_nbr")
  values <- c(values, if (is.null(drg_strgth_nbr)) "NULL" else if (is(drg_strgth_nbr, "subQuery")) paste0("(", as.character(drg_strgth_nbr), ")") else paste0("'", as.character(drg_strgth_nbr), "'"))

  if (missing(drg_strgth_unit_desc)) {
    drg_strgth_unit_desc <- defaults$drg_strgth_unit_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.drg_strgth_unit_desc')
  }
  fields <- c(fields, "drg_strgth_unit_desc")
  values <- c(values, if (is.null(drg_strgth_unit_desc)) "NULL" else if (is(drg_strgth_unit_desc, "subQuery")) paste0("(", as.character(drg_strgth_unit_desc), ")") else paste0("'", as.character(drg_strgth_unit_desc), "'"))

  if (missing(drg_strgth_vol_nbr)) {
    drg_strgth_vol_nbr <- defaults$drg_strgth_vol_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.drg_strgth_vol_nbr')
  }
  fields <- c(fields, "drg_strgth_vol_nbr")
  values <- c(values, if (is.null(drg_strgth_vol_nbr)) "NULL" else if (is(drg_strgth_vol_nbr, "subQuery")) paste0("(", as.character(drg_strgth_vol_nbr), ")") else paste0("'", as.character(drg_strgth_vol_nbr), "'"))

  if (missing(drg_strgth_vol_unit_desc)) {
    drg_strgth_vol_unit_desc <- defaults$drg_strgth_vol_unit_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.drg_strgth_vol_unit_desc')
  }
  fields <- c(fields, "drg_strgth_vol_unit_desc")
  values <- c(values, if (is.null(drg_strgth_vol_unit_desc)) "NULL" else if (is(drg_strgth_vol_unit_desc, "subQuery")) paste0("(", as.character(drg_strgth_vol_unit_desc), ")") else paste0("'", as.character(drg_strgth_vol_unit_desc), "'"))

  if (missing(gnrc_ind)) {
    gnrc_ind <- defaults$gnrc_ind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.gnrc_ind')
  }
  fields <- c(fields, "gnrc_ind")
  values <- c(values, if (is.null(gnrc_ind)) "NULL" else if (is(gnrc_ind, "subQuery")) paste0("(", as.character(gnrc_ind), ")") else paste0("'", as.character(gnrc_ind), "'"))

  if (missing(gnrc_nbr)) {
    gnrc_nbr <- defaults$gnrc_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.gnrc_nbr')
  }
  fields <- c(fields, "gnrc_nbr")
  values <- c(values, if (is.null(gnrc_nbr)) "NULL" else if (is(gnrc_nbr, "subQuery")) paste0("(", as.character(gnrc_nbr), ")") else paste0("'", as.character(gnrc_nbr), "'"))

  if (missing(gnrc_nm)) {
    gnrc_nm <- defaults$gnrc_nm
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.gnrc_nm')
  }
  fields <- c(fields, "gnrc_nm")
  values <- c(values, if (is.null(gnrc_nm)) "NULL" else if (is(gnrc_nm, "subQuery")) paste0("(", as.character(gnrc_nm), ")") else paste0("'", as.character(gnrc_nm), "'"))

  if (missing(gnrc_sqnc_nbr)) {
    gnrc_sqnc_nbr <- defaults$gnrc_sqnc_nbr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.gnrc_sqnc_nbr')
  }
  fields <- c(fields, "gnrc_sqnc_nbr")
  values <- c(values, if (is.null(gnrc_sqnc_nbr)) "NULL" else if (is(gnrc_sqnc_nbr, "subQuery")) paste0("(", as.character(gnrc_sqnc_nbr), ")") else paste0("'", as.character(gnrc_sqnc_nbr), "'"))

  if (missing(ndc)) {
    ndc <- defaults$ndc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.ndc')
  }
  fields <- c(fields, "ndc")
  values <- c(values, if (is.null(ndc)) "NULL" else if (is(ndc, "subQuery")) paste0("(", as.character(ndc), ")") else paste0("'", as.character(ndc), "'"))

  if (missing(ndc_drg_row_eff_dt)) {
    ndc_drg_row_eff_dt <- defaults$ndc_drg_row_eff_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.ndc_drg_row_eff_dt')
  }
  fields <- c(fields, "ndc_drg_row_eff_dt")
  values <- c(values, if (is.null(ndc_drg_row_eff_dt)) "NULL" else if (is(ndc_drg_row_eff_dt, "subQuery")) paste0("(", as.character(ndc_drg_row_eff_dt), ")") else paste0("'", as.character(ndc_drg_row_eff_dt), "'"))

  if (missing(ndc_drg_row_end_dt)) {
    ndc_drg_row_end_dt <- defaults$ndc_drg_row_end_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.ndc_drg_row_end_dt')
  }
  fields <- c(fields, "ndc_drg_row_end_dt")
  values <- c(values, if (is.null(ndc_drg_row_end_dt)) "NULL" else if (is(ndc_drg_row_end_dt, "subQuery")) paste0("(", as.character(ndc_drg_row_end_dt), ")") else paste0("'", as.character(ndc_drg_row_end_dt), "'"))

  if (missing(usc_id)) {
    usc_id <- defaults$usc_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.usc_id')
  }
  fields <- c(fields, "usc_id")
  values <- c(values, if (is.null(usc_id)) "NULL" else if (is(usc_id, "subQuery")) paste0("(", as.character(usc_id), ")") else paste0("'", as.character(usc_id), "'"))

  if (missing(usc_med_desc)) {
    usc_med_desc <- defaults$usc_med_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_ndc.usc_med_desc')
  }
  fields <- c(fields, "usc_med_desc")
  values <- c(values, if (is.null(usc_med_desc)) "NULL" else if (is(usc_med_desc, "subQuery")) paste0("(", as.character(usc_med_desc), ")") else paste0("'", as.character(usc_med_desc), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "lu_ndc", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_lu_procedure <- function(category_dtl_cd, category_dtl_code_desc, category_genl_cd, category_genl_code_desc, proc_cd, proc_desc, proc_end_date, proc_typ_cd) {
  defaults <- get('lu_procedure', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(category_dtl_cd)) {
    category_dtl_cd <- defaults$category_dtl_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.category_dtl_cd')
  }
  fields <- c(fields, "category_dtl_cd")
  values <- c(values, if (is.null(category_dtl_cd)) "NULL" else if (is(category_dtl_cd, "subQuery")) paste0("(", as.character(category_dtl_cd), ")") else paste0("'", as.character(category_dtl_cd), "'"))

  if (missing(category_dtl_code_desc)) {
    category_dtl_code_desc <- defaults$category_dtl_code_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.category_dtl_code_desc')
  }
  fields <- c(fields, "category_dtl_code_desc")
  values <- c(values, if (is.null(category_dtl_code_desc)) "NULL" else if (is(category_dtl_code_desc, "subQuery")) paste0("(", as.character(category_dtl_code_desc), ")") else paste0("'", as.character(category_dtl_code_desc), "'"))

  if (missing(category_genl_cd)) {
    category_genl_cd <- defaults$category_genl_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.category_genl_cd')
  }
  fields <- c(fields, "category_genl_cd")
  values <- c(values, if (is.null(category_genl_cd)) "NULL" else if (is(category_genl_cd, "subQuery")) paste0("(", as.character(category_genl_cd), ")") else paste0("'", as.character(category_genl_cd), "'"))

  if (missing(category_genl_code_desc)) {
    category_genl_code_desc <- defaults$category_genl_code_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.category_genl_code_desc')
  }
  fields <- c(fields, "category_genl_code_desc")
  values <- c(values, if (is.null(category_genl_code_desc)) "NULL" else if (is(category_genl_code_desc, "subQuery")) paste0("(", as.character(category_genl_code_desc), ")") else paste0("'", as.character(category_genl_code_desc), "'"))

  if (missing(proc_cd)) {
    proc_cd <- defaults$proc_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.proc_cd')
  }
  fields <- c(fields, "proc_cd")
  values <- c(values, if (is.null(proc_cd)) "NULL" else if (is(proc_cd, "subQuery")) paste0("(", as.character(proc_cd), ")") else paste0("'", as.character(proc_cd), "'"))

  if (missing(proc_desc)) {
    proc_desc <- defaults$proc_desc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.proc_desc')
  }
  fields <- c(fields, "proc_desc")
  values <- c(values, if (is.null(proc_desc)) "NULL" else if (is(proc_desc, "subQuery")) paste0("(", as.character(proc_desc), ")") else paste0("'", as.character(proc_desc), "'"))

  if (missing(proc_end_date)) {
    proc_end_date <- defaults$proc_end_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.proc_end_date')
  }
  fields <- c(fields, "proc_end_date")
  values <- c(values, if (is.null(proc_end_date)) "NULL" else if (is(proc_end_date, "subQuery")) paste0("(", as.character(proc_end_date), ")") else paste0("'", as.character(proc_end_date), "'"))

  if (missing(proc_typ_cd)) {
    proc_typ_cd <- defaults$proc_typ_cd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'lu_procedure.proc_typ_cd')
  }
  fields <- c(fields, "proc_typ_cd")
  values <- c(values, if (is.null(proc_typ_cd)) "NULL" else if (is(proc_typ_cd, "subQuery")) paste0("(", as.character(proc_typ_cd), ")") else paste0("'", as.character(proc_typ_cd), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "lu_procedure", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_provider_bridge <- function(prov_unique, dea, npi, prov, extract_ym, version) {
  defaults <- get('provider_bridge', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(prov_unique)) {
    prov_unique <- defaults$prov_unique
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider_bridge.prov_unique')
  }
  fields <- c(fields, "prov_unique")
  values <- c(values, if (is.null(prov_unique)) "NULL" else if (is(prov_unique, "subQuery")) paste0("(", as.character(prov_unique), ")") else paste0("'", as.character(prov_unique), "'"))

  if (missing(dea)) {
    dea <- defaults$dea
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider_bridge.dea')
  }
  fields <- c(fields, "dea")
  values <- c(values, if (is.null(dea)) "NULL" else if (is(dea, "subQuery")) paste0("(", as.character(dea), ")") else paste0("'", as.character(dea), "'"))

  if (missing(npi)) {
    npi <- defaults$npi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider_bridge.npi')
  }
  fields <- c(fields, "npi")
  values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))

  if (missing(prov)) {
    prov <- defaults$prov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider_bridge.prov')
  }
  fields <- c(fields, "prov")
  values <- c(values, if (is.null(prov)) "NULL" else if (is(prov, "subQuery")) paste0("(", as.character(prov), ")") else paste0("'", as.character(prov), "'"))

  if (missing(extract_ym)) {
    extract_ym <- defaults$extract_ym
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider_bridge.extract_ym')
  }
  fields <- c(fields, "extract_ym")
  values <- c(values, if (is.null(extract_ym)) "NULL" else if (is(extract_ym, "subQuery")) paste0("(", as.character(extract_ym), ")") else paste0("'", as.character(extract_ym), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'provider_bridge.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "provider_bridge", fields = fields, values = values)
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

  if (!missing(offset)) {
    fields <- c(fields, offset)
    values <- c(values, if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.offset')
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

  if (!missing(offset)) {
    fields <- c(fields, offset)
    values <- c(values, if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
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

  if (!missing(offset)) {
    fields <- c(fields, offset)
    values <- c(values, if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.offset')
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

  if (!missing(offset)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " offset",if (is.null(offset)) " IS NULL" else if (is(offset, "subQuery")) paste0(" = (", as.character(offset), ")") else paste0(" = '", as.character(offset), "'"))
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
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema._pos_episode_visit;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.med_diagnosis;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.cost_factor;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.rx_claims;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.inpatient_confinement;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.lab_results;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.med_procedure;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.member_enrollment;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema._version;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.death;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.hra;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.provider;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.medical_claims;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.lu_diagnosis;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.member_continuous_enrollment;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.lu_ndc;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.lu_procedure;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.provider_bridge;")
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

