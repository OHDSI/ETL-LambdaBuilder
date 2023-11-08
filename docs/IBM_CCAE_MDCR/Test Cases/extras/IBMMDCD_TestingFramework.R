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
  defaults$icd_key <- ''
  defaults$icd_code <- ''
  defaults$parent_icd_code <- 'V30-V39'
  defaults$level <- '4'
  defaults$children_count <- '0'
  defaults$children_count_recursive <- '0'
  defaults$description <- 'Other'
  assign('icd9', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$boe <- '4'
  defaults$cap <- '1'
  defaults$dobyr <- '2006'
  defaults$drugcovg <- '1'
  defaults$enrind1 <- '1'
  defaults$enrind10 <- '1'
  defaults$enrind11 <- '1'
  defaults$enrind12 <- '1'
  defaults$enrind2 <- '1'
  defaults$enrind3 <- '1'
  defaults$enrind4 <- '1'
  defaults$enrind5 <- '1'
  defaults$enrind6 <- '1'
  defaults$enrind7 <- '1'
  defaults$enrind8 <- '1'
  defaults$enrind9 <- '1'
  defaults$enrmon <- '12'
  defaults$enrolid <- ''
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$medicare <- '0'
  defaults$memday1 <- '31'
  defaults$memday10 <- '31'
  defaults$memday11 <- '30'
  defaults$memday12 <- '31'
  defaults$memday2 <- '28'
  defaults$memday3 <- '31'
  defaults$memday4 <- '30'
  defaults$memday5 <- '31'
  defaults$memday6 <- '30'
  defaults$memday7 <- '31'
  defaults$memday8 <- '31'
  defaults$memday9 <- '30'
  defaults$memdays <- '365'
  defaults$mhsacovg <- '1'
  defaults$plntyp1 <- '2'
  defaults$plntyp10 <- '4'
  defaults$plntyp11 <- '4'
  defaults$plntyp12 <- '4'
  defaults$plntyp2 <- '2'
  defaults$plntyp3 <- '2'
  defaults$plntyp4 <- '2'
  defaults$plntyp5 <- '4'
  defaults$plntyp6 <- '4'
  defaults$plntyp7 <- '4'
  defaults$plntyp8 <- '4'
  defaults$plntyp9 <- '4'
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdrace <- '1'
  defaults$version <- '10'
  defaults$year <- '2021'
  assign('enrollment_summary', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$version_id <- ''
  defaults$version_date <- ''
  assign('version', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$awp <- '0.0'
  defaults$boe <- '2'
  defaults$cap <- '1'
  defaults$cob <- '0.0'
  defaults$coins <- '0.0'
  defaults$copay <- '0.0'
  defaults$dawind <- '01'
  defaults$daysupp <- '30'
  defaults$deaclas <- '6'
  defaults$deduct <- '0.0'
  defaults$dispfee <- '0.0'
  defaults$dobyr <- '1961'
  defaults$drugcovg <- '1'
  defaults$enrolid <- ''
  defaults$generid <- '999999'
  defaults$genind <- '4'
  defaults$ingcost <- '0.0'
  defaults$maintin <- '2'
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$medicare <- '0'
  defaults$metqty <- '30.0'
  defaults$mhsacovg <- '1'
  defaults$ndcnum <- '00173068220'
  defaults$netpay <- '0.0'
  defaults$pay <- '0.0'
  defaults$pddate <- '2018-11-08'
  defaults$pharmid <- ''
  defaults$plantyp <- '4'
  defaults$qty <- '1'
  defaults$refill <- '0'
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdrace <- '1'
  defaults$svcdate <- '2021-06-14'
  defaults$thercls <- '69'
  defaults$thergrp <- '08'
  defaults$version <- '10'
  defaults$year <- '2017'
  defaults$gpi <- '44201010103410'
  assign('drug_claims', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$billtyp <- '131'
  defaults$boe <- '9'
  defaults$cap <- '0'
  defaults$caseid <- ''
  defaults$cob <- '0.0'
  defaults$coins <- '0.0'
  defaults$copay <- '0.0'
  defaults$deduct <- '0.0'
  defaults$dobyr <- '1989'
  defaults$drugcovg <- '1'
  defaults$dstatus <- '01'
  defaults$dx1 <- 'Z00129 '
  defaults$dx2 <- ''
  defaults$dx3 <- '       '
  defaults$dx4 <- '       '
  defaults$dx5 <- '       '
  defaults$dx6 <- '       '
  defaults$dx7 <- '       '
  defaults$dx8 <- '       '
  defaults$dx9 <- '       '
  defaults$dxver <- '0'
  defaults$enrolid <- ''
  defaults$fachdid <- ''
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$mdc <- '23'
  defaults$medicare <- '0'
  defaults$mhsacovg <- '1'
  defaults$netpay <- '0.0'
  defaults$pddate <- '2022-02-25'
  defaults$plantyp <- '2'
  defaults$poadx1 <- ''
  defaults$poadx2 <- ''
  defaults$poadx3 <- ''
  defaults$poadx4 <- ''
  defaults$poadx5 <- ''
  defaults$poadx6 <- ''
  defaults$poadx7 <- ''
  defaults$poadx8 <- ''
  defaults$poadx9 <- ''
  defaults$proc1 <- '       '
  defaults$proc2 <- '       '
  defaults$proc3 <- '10907zc'
  defaults$proc4 <- '3e033vj'
  defaults$proc5 <- '3e033vj'
  defaults$proc6 <- '5a1955z'
  defaults$prov_id <- ''
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdplac <- '22'
  defaults$stdprov <- '1'
  defaults$stdrace <- '1'
  defaults$svcdate <- '2021-03-01'
  defaults$tsvcdat <- '2019-01-31'
  defaults$version <- '10'
  defaults$year <- '2019'
  defaults$npi <- ''
  defaults$msclmid <- ''
  assign('facility_header', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$boe <- '4'
  defaults$cap <- '1'
  defaults$dobyr <- '2006'
  defaults$drugcovg <- '1'
  defaults$dtend <- '2021-05-31'
  defaults$dtstart <- '2021-05-01'
  defaults$enrolid <- ''
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$medicare <- '0'
  defaults$memdays <- '31'
  defaults$mhsacovg <- '1'
  defaults$plantyp <- '4'
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdrace <- '1'
  defaults$version <- '10'
  defaults$year <- '2020'
  assign('enrollment_detail', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$boe <- '2'
  defaults$cap <- '0'
  defaults$cob <- '0.0'
  defaults$coins <- '0.0'
  defaults$copay <- '0.0'
  defaults$deduct <- '0.0'
  defaults$dental <- '0'
  defaults$dobyr <- '2007'
  defaults$drugcovg <- '1'
  defaults$dx1 <- '       '
  defaults$dx2 <- '       '
  defaults$dx3 <- '       '
  defaults$dx4 <- '       '
  defaults$dxver <- '0'
  defaults$enrolid <- ''
  defaults$fachdid <- ''
  defaults$facprof <- 'P'
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$mdc <- '23'
  defaults$medicare <- '0'
  defaults$mhsacovg <- '1'
  defaults$netpay <- '0.0'
  defaults$pay <- '0.0'
  defaults$pddate <- '2019-09-24'
  defaults$plantyp <- '2'
  defaults$proc1 <- '       '
  defaults$procgrp <- ''
  defaults$proctyp <- '1'
  defaults$prov_id <- ''
  defaults$qty <- '1'
  defaults$revcode <- '    '
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdplac <- '11'
  defaults$stdprov <- '1'
  defaults$stdrace <- '1'
  defaults$stdsvc <- ''
  defaults$svcdate <- '2019-10-01'
  defaults$svcscat <- '12220'
  defaults$tsvcdat <- '2015-06-30'
  defaults$version <- '10'
  defaults$year <- '2019'
  defaults$units <- '1.0'
  defaults$npi <- ''
  defaults$msclmid <- ''
  defaults$procmod <- ''
  assign('outpatient_services', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$flag <- ''
  defaults$deaclas <- '6'
  defaults$deaclds <- 'All other Rx'
  defaults$desidrg <- 'N'
  defaults$excdgds <- ''
  defaults$excldrg <- '00'
  defaults$generid <- '999999'
  defaults$genind <- '4'
  defaults$gennme <- 'Inactive Record'
  defaults$gnindds <- 'Multisource generic'
  defaults$maintds <- 'Primarily acute'
  defaults$maintin <- '3'
  defaults$manfnme <- 'PHYSICIANS TOTAL CARE'
  defaults$mastfrm <- 'TAB'
  defaults$metsize <- 'EA 00100'
  defaults$mstfmds <- 'Tablet'
  defaults$ndcnum <- '87701597680'
  defaults$orgbkcd <- 'NR '
  defaults$orgbkds <- 'Not Rated'
  defaults$orgbkfg <- 'N'
  defaults$pkqtycd <- 'EA '
  defaults$pksize <- '1'
  defaults$prdctds <- 'Rx-only/Generic'
  defaults$prodcat <- '2 '
  defaults$prodnme <- 'IBUPROFEN'
  defaults$siglsrc <- 'N'
  defaults$strngth <- ''
  defaults$roacd <- ''
  defaults$roads <- ''
  defaults$thercls <- '999'
  defaults$therdtl <- '9999999999'
  defaults$thergrp <- '08'
  defaults$thrclds <- ''
  defaults$thrdtds <- ''
  defaults$thrgrds <- 'Central Nervous System'
  defaults$year <- '2015'
  defaults$deactdt <- ''
  defaults$reactdt <- ''
  defaults$actind <- ''
  assign('red_book', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$admdate <- '2017-07-18'
  defaults$admtyp <- '3'
  defaults$boe <- '5'
  defaults$cap <- '0'
  defaults$caseid <- ''
  defaults$days <- '2'
  defaults$disdate <- '2021-03-12'
  defaults$dobyr <- '2015'
  defaults$drg <- '795'
  defaults$drugcovg <- '1'
  defaults$dstatus <- '01'
  defaults$dx1 <- 'V3000  '
  defaults$dx10 <- ''
  defaults$dx11 <- ''
  defaults$dx12 <- ''
  defaults$dx13 <- ''
  defaults$dx14 <- ''
  defaults$dx15 <- ''
  defaults$dx2 <- '25000  '
  defaults$dx3 <- ''
  defaults$dx4 <- ''
  defaults$dx5 <- ''
  defaults$dx6 <- ''
  defaults$dx7 <- ''
  defaults$dx8 <- ''
  defaults$dx9 <- ''
  defaults$dxver <- '0'
  defaults$enrolid <- ''
  defaults$hosp_id <- ''
  defaults$hospnet <- '0.0'
  defaults$hosppay <- '0.0'
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$mdc <- '14'
  defaults$medicare <- '0'
  defaults$mhsacovg <- '1'
  defaults$pddate <- '2008-05-12'
  defaults$pdx <- 'V3000  '
  defaults$phys_id <- ''
  defaults$physnet <- '0.0'
  defaults$physpay <- '0.0'
  defaults$plantyp <- '2'
  defaults$poapdx <- ''
  defaults$poadx1 <- ''
  defaults$poadx2 <- ''
  defaults$poadx3 <- ''
  defaults$poadx4 <- ''
  defaults$poadx5 <- ''
  defaults$poadx6 <- ''
  defaults$poadx7 <- ''
  defaults$poadx8 <- ''
  defaults$poadx9 <- ''
  defaults$poadx10 <- ''
  defaults$poadx11 <- ''
  defaults$poadx12 <- ''
  defaults$poadx13 <- ''
  defaults$poadx14 <- ''
  defaults$poadx15 <- ''
  defaults$pproc <- ''
  defaults$proc1 <- ''
  defaults$proc10 <- ''
  defaults$proc11 <- ''
  defaults$proc12 <- ''
  defaults$proc13 <- ''
  defaults$proc14 <- ''
  defaults$proc15 <- ''
  defaults$proc2 <- '99460  '
  defaults$proc3 <- ''
  defaults$proc4 <- ''
  defaults$proc5 <- ''
  defaults$proc6 <- ''
  defaults$proc7 <- ''
  defaults$proc8 <- ''
  defaults$proc9 <- ''
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdrace <- '1'
  defaults$totcob <- '0.0'
  defaults$totcoins <- '0.0'
  defaults$totcopay <- '0.0'
  defaults$totded <- '0.0'
  defaults$totnet <- '0.0'
  defaults$totpay <- '0.0'
  defaults$version <- '10'
  defaults$year <- '2017'
  assign('inpatient_admissions', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$admdate <- '2019-04-02'
  defaults$admtyp <- '2'
  defaults$boe <- '2'
  defaults$cap <- '0'
  defaults$caseid <- ''
  defaults$cob <- '0.0'
  defaults$coins <- '0.0'
  defaults$copay <- '0.0'
  defaults$deduct <- '0.0'
  defaults$disdate <- '2014-02-28'
  defaults$dobyr <- '1959'
  defaults$drg <- '885'
  defaults$drugcovg <- '1'
  defaults$dstatus <- '01'
  defaults$dx1 <- 'V3000  '
  defaults$dx2 <- ''
  defaults$dx3 <- ''
  defaults$dx4 <- ''
  defaults$dxver <- '0'
  defaults$enrolid <- '20048226494'
  defaults$fachdid <- ''
  defaults$facprof <- 'F'
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$mdc <- '14'
  defaults$medicare <- '0'
  defaults$mhsacovg <- '1'
  defaults$netpay <- '0.0'
  defaults$pay <- '0.0'
  defaults$pddate <- '2015-03-31'
  defaults$pdx <- 'A419   '
  defaults$plantyp <- '2'
  defaults$pproc <- ''
  defaults$proc1 <- '       '
  defaults$proctyp <- '1'
  defaults$prov_id <- ''
  defaults$qty <- '1'
  defaults$revcode <- '    '
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdplac <- '21'
  defaults$stdprov <- '1'
  defaults$stdrace <- '1'
  defaults$stdsvc <- ''
  defaults$svcdate <- '2014-11-03'
  defaults$svcscat <- '20226'
  defaults$tsvcdat <- '2021-04-30'
  defaults$version <- '10'
  defaults$year <- '2019'
  defaults$units <- ''
  defaults$npi <- ''
  defaults$msclmid <- ''
  defaults$procmod <- ''
  assign('inpatient_services', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$episode_id <- ''
  defaults$enrolid <- ''
  defaults$dt_start <- '2017-11-13'
  defaults$dt_end <- '2017-01-09'
  defaults$visit_type <- 'ER'
  assign('pos_episode_visit', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$boe <- '1'
  defaults$cap <- '0'
  defaults$cob <- '0.0'
  defaults$coins <- '0.0'
  defaults$copay <- '0.0'
  defaults$deduct <- '0.0'
  defaults$dobyr <- '1930'
  defaults$drugcovg <- '0'
  defaults$dx1 <- 'M6281  '
  defaults$dx2 <- ''
  defaults$dx3 <- '       '
  defaults$dx4 <- '       '
  defaults$dxver <- '0'
  defaults$enrolid <- '20041645155'
  defaults$fachdid <- ''
  defaults$facprof <- 'F'
  defaults$mas <- '9'
  defaults$mcasenum <- ''
  defaults$mdc <- '01'
  defaults$medicare <- '1'
  defaults$mhsacovg <- '1'
  defaults$netpay <- '0.0'
  defaults$pay <- '0.0'
  defaults$pddate <- '2010-08-30'
  defaults$plantyp <- '2'
  defaults$proc1 <- '       '
  defaults$procgrp <- ''
  defaults$proctyp <- ' '
  defaults$prov_id <- ''
  defaults$qty <- '1'
  defaults$revcode <- '0420'
  defaults$seqnum <- ''
  defaults$sex <- '2'
  defaults$stdplac <- '31'
  defaults$stdprov <- '31'
  defaults$stdrace <- '1'
  defaults$stdsvc <- ''
  defaults$svcdate <- '2019-11-01'
  defaults$svcscat <- '10210'
  defaults$tsvcdat <- '2014-01-31'
  defaults$version <- '10'
  defaults$year <- '2017'
  defaults$units <- ''
  defaults$npi <- ''
  defaults$msclmid <- ''
  defaults$procmod <- ''
  assign('long_term_care', defaults, envir = frameworkContext$defaultValues)

  frameworkContext$sourceFieldsMapped <- c(
  )

  frameworkContext$targetFieldsMapped <- c(
  )

  frameworkContext$sourceFieldsTested <- c()
  frameworkContext$targetFieldsTested <- c()
}

initFramework()

set_defaults_icd9 <- function(icd_key, icd_code, parent_icd_code, level, children_count, children_count_recursive, description) {
  defaults <- get('icd9', envir = frameworkContext$defaultValues)
  if (!missing(icd_key)) {
    defaults$icd_key <- icd_key
  }
  if (!missing(icd_code)) {
    defaults$icd_code <- icd_code
  }
  if (!missing(parent_icd_code)) {
    defaults$parent_icd_code <- parent_icd_code
  }
  if (!missing(level)) {
    defaults$level <- level
  }
  if (!missing(children_count)) {
    defaults$children_count <- children_count
  }
  if (!missing(children_count_recursive)) {
    defaults$children_count_recursive <- children_count_recursive
  }
  if (!missing(description)) {
    defaults$description <- description
  }
  assign('icd9', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_enrollment_summary <- function(boe, cap, dobyr, drugcovg, enrind1, enrind10, enrind11, enrind12, enrind2, enrind3, enrind4, enrind5, enrind6, enrind7, enrind8, enrind9, enrmon, enrolid, mas, mcasenum, medicare, memday1, memday10, memday11, memday12, memday2, memday3, memday4, memday5, memday6, memday7, memday8, memday9, memdays, mhsacovg, plntyp1, plntyp10, plntyp11, plntyp12, plntyp2, plntyp3, plntyp4, plntyp5, plntyp6, plntyp7, plntyp8, plntyp9, seqnum, sex, stdrace, version, year) {
  defaults <- get('enrollment_summary', envir = frameworkContext$defaultValues)
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(enrind1)) {
    defaults$enrind1 <- enrind1
  }
  if (!missing(enrind10)) {
    defaults$enrind10 <- enrind10
  }
  if (!missing(enrind11)) {
    defaults$enrind11 <- enrind11
  }
  if (!missing(enrind12)) {
    defaults$enrind12 <- enrind12
  }
  if (!missing(enrind2)) {
    defaults$enrind2 <- enrind2
  }
  if (!missing(enrind3)) {
    defaults$enrind3 <- enrind3
  }
  if (!missing(enrind4)) {
    defaults$enrind4 <- enrind4
  }
  if (!missing(enrind5)) {
    defaults$enrind5 <- enrind5
  }
  if (!missing(enrind6)) {
    defaults$enrind6 <- enrind6
  }
  if (!missing(enrind7)) {
    defaults$enrind7 <- enrind7
  }
  if (!missing(enrind8)) {
    defaults$enrind8 <- enrind8
  }
  if (!missing(enrind9)) {
    defaults$enrind9 <- enrind9
  }
  if (!missing(enrmon)) {
    defaults$enrmon <- enrmon
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(memday1)) {
    defaults$memday1 <- memday1
  }
  if (!missing(memday10)) {
    defaults$memday10 <- memday10
  }
  if (!missing(memday11)) {
    defaults$memday11 <- memday11
  }
  if (!missing(memday12)) {
    defaults$memday12 <- memday12
  }
  if (!missing(memday2)) {
    defaults$memday2 <- memday2
  }
  if (!missing(memday3)) {
    defaults$memday3 <- memday3
  }
  if (!missing(memday4)) {
    defaults$memday4 <- memday4
  }
  if (!missing(memday5)) {
    defaults$memday5 <- memday5
  }
  if (!missing(memday6)) {
    defaults$memday6 <- memday6
  }
  if (!missing(memday7)) {
    defaults$memday7 <- memday7
  }
  if (!missing(memday8)) {
    defaults$memday8 <- memday8
  }
  if (!missing(memday9)) {
    defaults$memday9 <- memday9
  }
  if (!missing(memdays)) {
    defaults$memdays <- memdays
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(plntyp1)) {
    defaults$plntyp1 <- plntyp1
  }
  if (!missing(plntyp10)) {
    defaults$plntyp10 <- plntyp10
  }
  if (!missing(plntyp11)) {
    defaults$plntyp11 <- plntyp11
  }
  if (!missing(plntyp12)) {
    defaults$plntyp12 <- plntyp12
  }
  if (!missing(plntyp2)) {
    defaults$plntyp2 <- plntyp2
  }
  if (!missing(plntyp3)) {
    defaults$plntyp3 <- plntyp3
  }
  if (!missing(plntyp4)) {
    defaults$plntyp4 <- plntyp4
  }
  if (!missing(plntyp5)) {
    defaults$plntyp5 <- plntyp5
  }
  if (!missing(plntyp6)) {
    defaults$plntyp6 <- plntyp6
  }
  if (!missing(plntyp7)) {
    defaults$plntyp7 <- plntyp7
  }
  if (!missing(plntyp8)) {
    defaults$plntyp8 <- plntyp8
  }
  if (!missing(plntyp9)) {
    defaults$plntyp9 <- plntyp9
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  assign('enrollment_summary', defaults, envir = frameworkContext$defaultValues)
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

set_defaults_drug_claims <- function(awp, boe, cap, cob, coins, copay, dawind, daysupp, deaclas, deduct, dispfee, dobyr, drugcovg, enrolid, generid, genind, ingcost, maintin, mas, mcasenum, medicare, metqty, mhsacovg, ndcnum, netpay, pay, pddate, pharmid, plantyp, qty, refill, seqnum, sex, stdrace, svcdate, thercls, thergrp, version, year, gpi) {
  defaults <- get('drug_claims', envir = frameworkContext$defaultValues)
  if (!missing(awp)) {
    defaults$awp <- awp
  }
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(cob)) {
    defaults$cob <- cob
  }
  if (!missing(coins)) {
    defaults$coins <- coins
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(dawind)) {
    defaults$dawind <- dawind
  }
  if (!missing(daysupp)) {
    defaults$daysupp <- daysupp
  }
  if (!missing(deaclas)) {
    defaults$deaclas <- deaclas
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(dispfee)) {
    defaults$dispfee <- dispfee
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(generid)) {
    defaults$generid <- generid
  }
  if (!missing(genind)) {
    defaults$genind <- genind
  }
  if (!missing(ingcost)) {
    defaults$ingcost <- ingcost
  }
  if (!missing(maintin)) {
    defaults$maintin <- maintin
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(metqty)) {
    defaults$metqty <- metqty
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(ndcnum)) {
    defaults$ndcnum <- ndcnum
  }
  if (!missing(netpay)) {
    defaults$netpay <- netpay
  }
  if (!missing(pay)) {
    defaults$pay <- pay
  }
  if (!missing(pddate)) {
    defaults$pddate <- pddate
  }
  if (!missing(pharmid)) {
    defaults$pharmid <- pharmid
  }
  if (!missing(plantyp)) {
    defaults$plantyp <- plantyp
  }
  if (!missing(qty)) {
    defaults$qty <- qty
  }
  if (!missing(refill)) {
    defaults$refill <- refill
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(svcdate)) {
    defaults$svcdate <- svcdate
  }
  if (!missing(thercls)) {
    defaults$thercls <- thercls
  }
  if (!missing(thergrp)) {
    defaults$thergrp <- thergrp
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  if (!missing(gpi)) {
    defaults$gpi <- gpi
  }
  assign('drug_claims', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_facility_header <- function(billtyp, boe, cap, caseid, cob, coins, copay, deduct, dobyr, drugcovg, dstatus, dx1, dx2, dx3, dx4, dx5, dx6, dx7, dx8, dx9, dxver, enrolid, fachdid, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pddate, plantyp, poadx1, poadx2, poadx3, poadx4, poadx5, poadx6, poadx7, poadx8, poadx9, proc1, proc2, proc3, proc4, proc5, proc6, prov_id, seqnum, sex, stdplac, stdprov, stdrace, svcdate, tsvcdat, version, year, npi, msclmid) {
  defaults <- get('facility_header', envir = frameworkContext$defaultValues)
  if (!missing(billtyp)) {
    defaults$billtyp <- billtyp
  }
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(caseid)) {
    defaults$caseid <- caseid
  }
  if (!missing(cob)) {
    defaults$cob <- cob
  }
  if (!missing(coins)) {
    defaults$coins <- coins
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(dstatus)) {
    defaults$dstatus <- dstatus
  }
  if (!missing(dx1)) {
    defaults$dx1 <- dx1
  }
  if (!missing(dx2)) {
    defaults$dx2 <- dx2
  }
  if (!missing(dx3)) {
    defaults$dx3 <- dx3
  }
  if (!missing(dx4)) {
    defaults$dx4 <- dx4
  }
  if (!missing(dx5)) {
    defaults$dx5 <- dx5
  }
  if (!missing(dx6)) {
    defaults$dx6 <- dx6
  }
  if (!missing(dx7)) {
    defaults$dx7 <- dx7
  }
  if (!missing(dx8)) {
    defaults$dx8 <- dx8
  }
  if (!missing(dx9)) {
    defaults$dx9 <- dx9
  }
  if (!missing(dxver)) {
    defaults$dxver <- dxver
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(fachdid)) {
    defaults$fachdid <- fachdid
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(mdc)) {
    defaults$mdc <- mdc
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(netpay)) {
    defaults$netpay <- netpay
  }
  if (!missing(pddate)) {
    defaults$pddate <- pddate
  }
  if (!missing(plantyp)) {
    defaults$plantyp <- plantyp
  }
  if (!missing(poadx1)) {
    defaults$poadx1 <- poadx1
  }
  if (!missing(poadx2)) {
    defaults$poadx2 <- poadx2
  }
  if (!missing(poadx3)) {
    defaults$poadx3 <- poadx3
  }
  if (!missing(poadx4)) {
    defaults$poadx4 <- poadx4
  }
  if (!missing(poadx5)) {
    defaults$poadx5 <- poadx5
  }
  if (!missing(poadx6)) {
    defaults$poadx6 <- poadx6
  }
  if (!missing(poadx7)) {
    defaults$poadx7 <- poadx7
  }
  if (!missing(poadx8)) {
    defaults$poadx8 <- poadx8
  }
  if (!missing(poadx9)) {
    defaults$poadx9 <- poadx9
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
  if (!missing(proc6)) {
    defaults$proc6 <- proc6
  }
  if (!missing(prov_id)) {
    defaults$prov_id <- prov_id
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdplac)) {
    defaults$stdplac <- stdplac
  }
  if (!missing(stdprov)) {
    defaults$stdprov <- stdprov
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(svcdate)) {
    defaults$svcdate <- svcdate
  }
  if (!missing(tsvcdat)) {
    defaults$tsvcdat <- tsvcdat
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  if (!missing(npi)) {
    defaults$npi <- npi
  }
  if (!missing(msclmid)) {
    defaults$msclmid <- msclmid
  }
  assign('facility_header', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_enrollment_detail <- function(boe, cap, dobyr, drugcovg, dtend, dtstart, enrolid, mas, mcasenum, medicare, memdays, mhsacovg, plantyp, seqnum, sex, stdrace, version, year) {
  defaults <- get('enrollment_detail', envir = frameworkContext$defaultValues)
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(dtend)) {
    defaults$dtend <- dtend
  }
  if (!missing(dtstart)) {
    defaults$dtstart <- dtstart
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(memdays)) {
    defaults$memdays <- memdays
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(plantyp)) {
    defaults$plantyp <- plantyp
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  assign('enrollment_detail', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_outpatient_services <- function(boe, cap, cob, coins, copay, deduct, dental, dobyr, drugcovg, dx1, dx2, dx3, dx4, dxver, enrolid, fachdid, facprof, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pay, pddate, plantyp, proc1, procgrp, proctyp, prov_id, qty, revcode, seqnum, sex, stdplac, stdprov, stdrace, stdsvc, svcdate, svcscat, tsvcdat, version, year, units, npi, msclmid, procmod) {
  defaults <- get('outpatient_services', envir = frameworkContext$defaultValues)
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(cob)) {
    defaults$cob <- cob
  }
  if (!missing(coins)) {
    defaults$coins <- coins
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(dental)) {
    defaults$dental <- dental
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(dx1)) {
    defaults$dx1 <- dx1
  }
  if (!missing(dx2)) {
    defaults$dx2 <- dx2
  }
  if (!missing(dx3)) {
    defaults$dx3 <- dx3
  }
  if (!missing(dx4)) {
    defaults$dx4 <- dx4
  }
  if (!missing(dxver)) {
    defaults$dxver <- dxver
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(fachdid)) {
    defaults$fachdid <- fachdid
  }
  if (!missing(facprof)) {
    defaults$facprof <- facprof
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(mdc)) {
    defaults$mdc <- mdc
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(netpay)) {
    defaults$netpay <- netpay
  }
  if (!missing(pay)) {
    defaults$pay <- pay
  }
  if (!missing(pddate)) {
    defaults$pddate <- pddate
  }
  if (!missing(plantyp)) {
    defaults$plantyp <- plantyp
  }
  if (!missing(proc1)) {
    defaults$proc1 <- proc1
  }
  if (!missing(procgrp)) {
    defaults$procgrp <- procgrp
  }
  if (!missing(proctyp)) {
    defaults$proctyp <- proctyp
  }
  if (!missing(prov_id)) {
    defaults$prov_id <- prov_id
  }
  if (!missing(qty)) {
    defaults$qty <- qty
  }
  if (!missing(revcode)) {
    defaults$revcode <- revcode
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdplac)) {
    defaults$stdplac <- stdplac
  }
  if (!missing(stdprov)) {
    defaults$stdprov <- stdprov
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(stdsvc)) {
    defaults$stdsvc <- stdsvc
  }
  if (!missing(svcdate)) {
    defaults$svcdate <- svcdate
  }
  if (!missing(svcscat)) {
    defaults$svcscat <- svcscat
  }
  if (!missing(tsvcdat)) {
    defaults$tsvcdat <- tsvcdat
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  if (!missing(units)) {
    defaults$units <- units
  }
  if (!missing(npi)) {
    defaults$npi <- npi
  }
  if (!missing(msclmid)) {
    defaults$msclmid <- msclmid
  }
  if (!missing(procmod)) {
    defaults$procmod <- procmod
  }
  assign('outpatient_services', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_red_book <- function(flag, deaclas, deaclds, desidrg, excdgds, excldrg, generid, genind, gennme, gnindds, maintds, maintin, manfnme, mastfrm, metsize, mstfmds, ndcnum, orgbkcd, orgbkds, orgbkfg, pkqtycd, pksize, prdctds, prodcat, prodnme, siglsrc, strngth, roacd, roads, thercls, therdtl, thergrp, thrclds, thrdtds, thrgrds, year, deactdt, reactdt, actind) {
  defaults <- get('red_book', envir = frameworkContext$defaultValues)
  if (!missing(flag)) {
    defaults$flag <- flag
  }
  if (!missing(deaclas)) {
    defaults$deaclas <- deaclas
  }
  if (!missing(deaclds)) {
    defaults$deaclds <- deaclds
  }
  if (!missing(desidrg)) {
    defaults$desidrg <- desidrg
  }
  if (!missing(excdgds)) {
    defaults$excdgds <- excdgds
  }
  if (!missing(excldrg)) {
    defaults$excldrg <- excldrg
  }
  if (!missing(generid)) {
    defaults$generid <- generid
  }
  if (!missing(genind)) {
    defaults$genind <- genind
  }
  if (!missing(gennme)) {
    defaults$gennme <- gennme
  }
  if (!missing(gnindds)) {
    defaults$gnindds <- gnindds
  }
  if (!missing(maintds)) {
    defaults$maintds <- maintds
  }
  if (!missing(maintin)) {
    defaults$maintin <- maintin
  }
  if (!missing(manfnme)) {
    defaults$manfnme <- manfnme
  }
  if (!missing(mastfrm)) {
    defaults$mastfrm <- mastfrm
  }
  if (!missing(metsize)) {
    defaults$metsize <- metsize
  }
  if (!missing(mstfmds)) {
    defaults$mstfmds <- mstfmds
  }
  if (!missing(ndcnum)) {
    defaults$ndcnum <- ndcnum
  }
  if (!missing(orgbkcd)) {
    defaults$orgbkcd <- orgbkcd
  }
  if (!missing(orgbkds)) {
    defaults$orgbkds <- orgbkds
  }
  if (!missing(orgbkfg)) {
    defaults$orgbkfg <- orgbkfg
  }
  if (!missing(pkqtycd)) {
    defaults$pkqtycd <- pkqtycd
  }
  if (!missing(pksize)) {
    defaults$pksize <- pksize
  }
  if (!missing(prdctds)) {
    defaults$prdctds <- prdctds
  }
  if (!missing(prodcat)) {
    defaults$prodcat <- prodcat
  }
  if (!missing(prodnme)) {
    defaults$prodnme <- prodnme
  }
  if (!missing(siglsrc)) {
    defaults$siglsrc <- siglsrc
  }
  if (!missing(strngth)) {
    defaults$strngth <- strngth
  }
  if (!missing(roacd)) {
    defaults$roacd <- roacd
  }
  if (!missing(roads)) {
    defaults$roads <- roads
  }
  if (!missing(thercls)) {
    defaults$thercls <- thercls
  }
  if (!missing(therdtl)) {
    defaults$therdtl <- therdtl
  }
  if (!missing(thergrp)) {
    defaults$thergrp <- thergrp
  }
  if (!missing(thrclds)) {
    defaults$thrclds <- thrclds
  }
  if (!missing(thrdtds)) {
    defaults$thrdtds <- thrdtds
  }
  if (!missing(thrgrds)) {
    defaults$thrgrds <- thrgrds
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  if (!missing(deactdt)) {
    defaults$deactdt <- deactdt
  }
  if (!missing(reactdt)) {
    defaults$reactdt <- reactdt
  }
  if (!missing(actind)) {
    defaults$actind <- actind
  }
  assign('red_book', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_inpatient_admissions <- function(admdate, admtyp, boe, cap, caseid, days, disdate, dobyr, drg, drugcovg, dstatus, dx1, dx10, dx11, dx12, dx13, dx14, dx15, dx2, dx3, dx4, dx5, dx6, dx7, dx8, dx9, dxver, enrolid, hosp_id, hospnet, hosppay, mas, mcasenum, mdc, medicare, mhsacovg, pddate, pdx, phys_id, physnet, physpay, plantyp, poapdx, poadx1, poadx2, poadx3, poadx4, poadx5, poadx6, poadx7, poadx8, poadx9, poadx10, poadx11, poadx12, poadx13, poadx14, poadx15, pproc, proc1, proc10, proc11, proc12, proc13, proc14, proc15, proc2, proc3, proc4, proc5, proc6, proc7, proc8, proc9, seqnum, sex, stdrace, totcob, totcoins, totcopay, totded, totnet, totpay, version, year) {
  defaults <- get('inpatient_admissions', envir = frameworkContext$defaultValues)
  if (!missing(admdate)) {
    defaults$admdate <- admdate
  }
  if (!missing(admtyp)) {
    defaults$admtyp <- admtyp
  }
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(caseid)) {
    defaults$caseid <- caseid
  }
  if (!missing(days)) {
    defaults$days <- days
  }
  if (!missing(disdate)) {
    defaults$disdate <- disdate
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drg)) {
    defaults$drg <- drg
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(dstatus)) {
    defaults$dstatus <- dstatus
  }
  if (!missing(dx1)) {
    defaults$dx1 <- dx1
  }
  if (!missing(dx10)) {
    defaults$dx10 <- dx10
  }
  if (!missing(dx11)) {
    defaults$dx11 <- dx11
  }
  if (!missing(dx12)) {
    defaults$dx12 <- dx12
  }
  if (!missing(dx13)) {
    defaults$dx13 <- dx13
  }
  if (!missing(dx14)) {
    defaults$dx14 <- dx14
  }
  if (!missing(dx15)) {
    defaults$dx15 <- dx15
  }
  if (!missing(dx2)) {
    defaults$dx2 <- dx2
  }
  if (!missing(dx3)) {
    defaults$dx3 <- dx3
  }
  if (!missing(dx4)) {
    defaults$dx4 <- dx4
  }
  if (!missing(dx5)) {
    defaults$dx5 <- dx5
  }
  if (!missing(dx6)) {
    defaults$dx6 <- dx6
  }
  if (!missing(dx7)) {
    defaults$dx7 <- dx7
  }
  if (!missing(dx8)) {
    defaults$dx8 <- dx8
  }
  if (!missing(dx9)) {
    defaults$dx9 <- dx9
  }
  if (!missing(dxver)) {
    defaults$dxver <- dxver
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(hosp_id)) {
    defaults$hosp_id <- hosp_id
  }
  if (!missing(hospnet)) {
    defaults$hospnet <- hospnet
  }
  if (!missing(hosppay)) {
    defaults$hosppay <- hosppay
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(mdc)) {
    defaults$mdc <- mdc
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(pddate)) {
    defaults$pddate <- pddate
  }
  if (!missing(pdx)) {
    defaults$pdx <- pdx
  }
  if (!missing(phys_id)) {
    defaults$phys_id <- phys_id
  }
  if (!missing(physnet)) {
    defaults$physnet <- physnet
  }
  if (!missing(physpay)) {
    defaults$physpay <- physpay
  }
  if (!missing(plantyp)) {
    defaults$plantyp <- plantyp
  }
  if (!missing(poapdx)) {
    defaults$poapdx <- poapdx
  }
  if (!missing(poadx1)) {
    defaults$poadx1 <- poadx1
  }
  if (!missing(poadx2)) {
    defaults$poadx2 <- poadx2
  }
  if (!missing(poadx3)) {
    defaults$poadx3 <- poadx3
  }
  if (!missing(poadx4)) {
    defaults$poadx4 <- poadx4
  }
  if (!missing(poadx5)) {
    defaults$poadx5 <- poadx5
  }
  if (!missing(poadx6)) {
    defaults$poadx6 <- poadx6
  }
  if (!missing(poadx7)) {
    defaults$poadx7 <- poadx7
  }
  if (!missing(poadx8)) {
    defaults$poadx8 <- poadx8
  }
  if (!missing(poadx9)) {
    defaults$poadx9 <- poadx9
  }
  if (!missing(poadx10)) {
    defaults$poadx10 <- poadx10
  }
  if (!missing(poadx11)) {
    defaults$poadx11 <- poadx11
  }
  if (!missing(poadx12)) {
    defaults$poadx12 <- poadx12
  }
  if (!missing(poadx13)) {
    defaults$poadx13 <- poadx13
  }
  if (!missing(poadx14)) {
    defaults$poadx14 <- poadx14
  }
  if (!missing(poadx15)) {
    defaults$poadx15 <- poadx15
  }
  if (!missing(pproc)) {
    defaults$pproc <- pproc
  }
  if (!missing(proc1)) {
    defaults$proc1 <- proc1
  }
  if (!missing(proc10)) {
    defaults$proc10 <- proc10
  }
  if (!missing(proc11)) {
    defaults$proc11 <- proc11
  }
  if (!missing(proc12)) {
    defaults$proc12 <- proc12
  }
  if (!missing(proc13)) {
    defaults$proc13 <- proc13
  }
  if (!missing(proc14)) {
    defaults$proc14 <- proc14
  }
  if (!missing(proc15)) {
    defaults$proc15 <- proc15
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
  if (!missing(proc6)) {
    defaults$proc6 <- proc6
  }
  if (!missing(proc7)) {
    defaults$proc7 <- proc7
  }
  if (!missing(proc8)) {
    defaults$proc8 <- proc8
  }
  if (!missing(proc9)) {
    defaults$proc9 <- proc9
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(totcob)) {
    defaults$totcob <- totcob
  }
  if (!missing(totcoins)) {
    defaults$totcoins <- totcoins
  }
  if (!missing(totcopay)) {
    defaults$totcopay <- totcopay
  }
  if (!missing(totded)) {
    defaults$totded <- totded
  }
  if (!missing(totnet)) {
    defaults$totnet <- totnet
  }
  if (!missing(totpay)) {
    defaults$totpay <- totpay
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  assign('inpatient_admissions', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_inpatient_services <- function(admdate, admtyp, boe, cap, caseid, cob, coins, copay, deduct, disdate, dobyr, drg, drugcovg, dstatus, dx1, dx2, dx3, dx4, dxver, enrolid, fachdid, facprof, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pay, pddate, pdx, plantyp, pproc, proc1, proctyp, prov_id, qty, revcode, seqnum, sex, stdplac, stdprov, stdrace, stdsvc, svcdate, svcscat, tsvcdat, version, year, units, npi, msclmid, procmod) {
  defaults <- get('inpatient_services', envir = frameworkContext$defaultValues)
  if (!missing(admdate)) {
    defaults$admdate <- admdate
  }
  if (!missing(admtyp)) {
    defaults$admtyp <- admtyp
  }
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(caseid)) {
    defaults$caseid <- caseid
  }
  if (!missing(cob)) {
    defaults$cob <- cob
  }
  if (!missing(coins)) {
    defaults$coins <- coins
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(disdate)) {
    defaults$disdate <- disdate
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drg)) {
    defaults$drg <- drg
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(dstatus)) {
    defaults$dstatus <- dstatus
  }
  if (!missing(dx1)) {
    defaults$dx1 <- dx1
  }
  if (!missing(dx2)) {
    defaults$dx2 <- dx2
  }
  if (!missing(dx3)) {
    defaults$dx3 <- dx3
  }
  if (!missing(dx4)) {
    defaults$dx4 <- dx4
  }
  if (!missing(dxver)) {
    defaults$dxver <- dxver
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(fachdid)) {
    defaults$fachdid <- fachdid
  }
  if (!missing(facprof)) {
    defaults$facprof <- facprof
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(mdc)) {
    defaults$mdc <- mdc
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(netpay)) {
    defaults$netpay <- netpay
  }
  if (!missing(pay)) {
    defaults$pay <- pay
  }
  if (!missing(pddate)) {
    defaults$pddate <- pddate
  }
  if (!missing(pdx)) {
    defaults$pdx <- pdx
  }
  if (!missing(plantyp)) {
    defaults$plantyp <- plantyp
  }
  if (!missing(pproc)) {
    defaults$pproc <- pproc
  }
  if (!missing(proc1)) {
    defaults$proc1 <- proc1
  }
  if (!missing(proctyp)) {
    defaults$proctyp <- proctyp
  }
  if (!missing(prov_id)) {
    defaults$prov_id <- prov_id
  }
  if (!missing(qty)) {
    defaults$qty <- qty
  }
  if (!missing(revcode)) {
    defaults$revcode <- revcode
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdplac)) {
    defaults$stdplac <- stdplac
  }
  if (!missing(stdprov)) {
    defaults$stdprov <- stdprov
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(stdsvc)) {
    defaults$stdsvc <- stdsvc
  }
  if (!missing(svcdate)) {
    defaults$svcdate <- svcdate
  }
  if (!missing(svcscat)) {
    defaults$svcscat <- svcscat
  }
  if (!missing(tsvcdat)) {
    defaults$tsvcdat <- tsvcdat
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  if (!missing(units)) {
    defaults$units <- units
  }
  if (!missing(npi)) {
    defaults$npi <- npi
  }
  if (!missing(msclmid)) {
    defaults$msclmid <- msclmid
  }
  if (!missing(procmod)) {
    defaults$procmod <- procmod
  }
  assign('inpatient_services', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_pos_episode_visit <- function(episode_id, enrolid, dt_start, dt_end, visit_type) {
  defaults <- get('pos_episode_visit', envir = frameworkContext$defaultValues)
  if (!missing(episode_id)) {
    defaults$episode_id <- episode_id
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(dt_start)) {
    defaults$dt_start <- dt_start
  }
  if (!missing(dt_end)) {
    defaults$dt_end <- dt_end
  }
  if (!missing(visit_type)) {
    defaults$visit_type <- visit_type
  }
  assign('pos_episode_visit', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_long_term_care <- function(boe, cap, cob, coins, copay, deduct, dobyr, drugcovg, dx1, dx2, dx3, dx4, dxver, enrolid, fachdid, facprof, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pay, pddate, plantyp, proc1, procgrp, proctyp, prov_id, qty, revcode, seqnum, sex, stdplac, stdprov, stdrace, stdsvc, svcdate, svcscat, tsvcdat, version, year, units, npi, msclmid, procmod) {
  defaults <- get('long_term_care', envir = frameworkContext$defaultValues)
  if (!missing(boe)) {
    defaults$boe <- boe
  }
  if (!missing(cap)) {
    defaults$cap <- cap
  }
  if (!missing(cob)) {
    defaults$cob <- cob
  }
  if (!missing(coins)) {
    defaults$coins <- coins
  }
  if (!missing(copay)) {
    defaults$copay <- copay
  }
  if (!missing(deduct)) {
    defaults$deduct <- deduct
  }
  if (!missing(dobyr)) {
    defaults$dobyr <- dobyr
  }
  if (!missing(drugcovg)) {
    defaults$drugcovg <- drugcovg
  }
  if (!missing(dx1)) {
    defaults$dx1 <- dx1
  }
  if (!missing(dx2)) {
    defaults$dx2 <- dx2
  }
  if (!missing(dx3)) {
    defaults$dx3 <- dx3
  }
  if (!missing(dx4)) {
    defaults$dx4 <- dx4
  }
  if (!missing(dxver)) {
    defaults$dxver <- dxver
  }
  if (!missing(enrolid)) {
    defaults$enrolid <- enrolid
  }
  if (!missing(fachdid)) {
    defaults$fachdid <- fachdid
  }
  if (!missing(facprof)) {
    defaults$facprof <- facprof
  }
  if (!missing(mas)) {
    defaults$mas <- mas
  }
  if (!missing(mcasenum)) {
    defaults$mcasenum <- mcasenum
  }
  if (!missing(mdc)) {
    defaults$mdc <- mdc
  }
  if (!missing(medicare)) {
    defaults$medicare <- medicare
  }
  if (!missing(mhsacovg)) {
    defaults$mhsacovg <- mhsacovg
  }
  if (!missing(netpay)) {
    defaults$netpay <- netpay
  }
  if (!missing(pay)) {
    defaults$pay <- pay
  }
  if (!missing(pddate)) {
    defaults$pddate <- pddate
  }
  if (!missing(plantyp)) {
    defaults$plantyp <- plantyp
  }
  if (!missing(proc1)) {
    defaults$proc1 <- proc1
  }
  if (!missing(procgrp)) {
    defaults$procgrp <- procgrp
  }
  if (!missing(proctyp)) {
    defaults$proctyp <- proctyp
  }
  if (!missing(prov_id)) {
    defaults$prov_id <- prov_id
  }
  if (!missing(qty)) {
    defaults$qty <- qty
  }
  if (!missing(revcode)) {
    defaults$revcode <- revcode
  }
  if (!missing(seqnum)) {
    defaults$seqnum <- seqnum
  }
  if (!missing(sex)) {
    defaults$sex <- sex
  }
  if (!missing(stdplac)) {
    defaults$stdplac <- stdplac
  }
  if (!missing(stdprov)) {
    defaults$stdprov <- stdprov
  }
  if (!missing(stdrace)) {
    defaults$stdrace <- stdrace
  }
  if (!missing(stdsvc)) {
    defaults$stdsvc <- stdsvc
  }
  if (!missing(svcdate)) {
    defaults$svcdate <- svcdate
  }
  if (!missing(svcscat)) {
    defaults$svcscat <- svcscat
  }
  if (!missing(tsvcdat)) {
    defaults$tsvcdat <- tsvcdat
  }
  if (!missing(version)) {
    defaults$version <- version
  }
  if (!missing(year)) {
    defaults$year <- year
  }
  if (!missing(units)) {
    defaults$units <- units
  }
  if (!missing(npi)) {
    defaults$npi <- npi
  }
  if (!missing(msclmid)) {
    defaults$msclmid <- msclmid
  }
  if (!missing(procmod)) {
    defaults$procmod <- procmod
  }
  assign('long_term_care', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

get_defaults_icd9 <- function() {
  defaults <- get('icd9', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_enrollment_summary <- function() {
  defaults <- get('enrollment_summary', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_version <- function() {
  defaults <- get('version', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_drug_claims <- function() {
  defaults <- get('drug_claims', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_facility_header <- function() {
  defaults <- get('facility_header', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_enrollment_detail <- function() {
  defaults <- get('enrollment_detail', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_outpatient_services <- function() {
  defaults <- get('outpatient_services', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_red_book <- function() {
  defaults <- get('red_book', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_inpatient_admissions <- function() {
  defaults <- get('inpatient_admissions', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_inpatient_services <- function() {
  defaults <- get('inpatient_services', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_pos_episode_visit <- function() {
  defaults <- get('pos_episode_visit', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_long_term_care <- function() {
  defaults <- get('long_term_care', envir = frameworkContext$defaultValues)
  return(defaults)
}

declareTest <- function(id, description) {
  frameworkContext$testId <- id
  frameworkContext$testDescription <- description
}

add_icd9 <- function(icd_key, icd_code, parent_icd_code, level, children_count, children_count_recursive, description) {
  defaults <- get('icd9', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(icd_key)) {
    icd_key <- defaults$icd_key
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icd9.icd_key')
  }
  fields <- c(fields, "icd_key")
  values <- c(values, if (is.null(icd_key)) "NULL" else if (is(icd_key, "subQuery")) paste0("(", as.character(icd_key), ")") else paste0("'", as.character(icd_key), "'"))

  if (missing(icd_code)) {
    icd_code <- defaults$icd_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icd9.icd_code')
  }
  fields <- c(fields, "icd_code")
  values <- c(values, if (is.null(icd_code)) "NULL" else if (is(icd_code, "subQuery")) paste0("(", as.character(icd_code), ")") else paste0("'", as.character(icd_code), "'"))

  if (missing(parent_icd_code)) {
    parent_icd_code <- defaults$parent_icd_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icd9.parent_icd_code')
  }
  fields <- c(fields, "parent_icd_code")
  values <- c(values, if (is.null(parent_icd_code)) "NULL" else if (is(parent_icd_code, "subQuery")) paste0("(", as.character(parent_icd_code), ")") else paste0("'", as.character(parent_icd_code), "'"))

  if (missing(level)) {
    level <- defaults$level
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icd9.level')
  }
  fields <- c(fields, "level")
  values <- c(values, if (is.null(level)) "NULL" else if (is(level, "subQuery")) paste0("(", as.character(level), ")") else paste0("'", as.character(level), "'"))

  if (missing(children_count)) {
    children_count <- defaults$children_count
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icd9.children_count')
  }
  fields <- c(fields, "children_count")
  values <- c(values, if (is.null(children_count)) "NULL" else if (is(children_count, "subQuery")) paste0("(", as.character(children_count), ")") else paste0("'", as.character(children_count), "'"))

  if (missing(children_count_recursive)) {
    children_count_recursive <- defaults$children_count_recursive
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icd9.children_count_recursive')
  }
  fields <- c(fields, "children_count_recursive")
  values <- c(values, if (is.null(children_count_recursive)) "NULL" else if (is(children_count_recursive, "subQuery")) paste0("(", as.character(children_count_recursive), ")") else paste0("'", as.character(children_count_recursive), "'"))

  if (missing(description)) {
    description <- defaults$description
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'icd9.description')
  }
  fields <- c(fields, "description")
  values <- c(values, if (is.null(description)) "NULL" else if (is(description, "subQuery")) paste0("(", as.character(description), ")") else paste0("'", as.character(description), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "icd9", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_enrollment_summary <- function(boe, cap, dobyr, drugcovg, enrind1, enrind10, enrind11, enrind12, enrind2, enrind3, enrind4, enrind5, enrind6, enrind7, enrind8, enrind9, enrmon, enrolid, mas, mcasenum, medicare, memday1, memday10, memday11, memday12, memday2, memday3, memday4, memday5, memday6, memday7, memday8, memday9, memdays, mhsacovg, plntyp1, plntyp10, plntyp11, plntyp12, plntyp2, plntyp3, plntyp4, plntyp5, plntyp6, plntyp7, plntyp8, plntyp9, seqnum, sex, stdrace, version, year) {
  defaults <- get('enrollment_summary', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(enrind1)) {
    enrind1 <- defaults$enrind1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind1')
  }
  fields <- c(fields, "enrind1")
  values <- c(values, if (is.null(enrind1)) "NULL" else if (is(enrind1, "subQuery")) paste0("(", as.character(enrind1), ")") else paste0("'", as.character(enrind1), "'"))

  if (missing(enrind10)) {
    enrind10 <- defaults$enrind10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind10')
  }
  fields <- c(fields, "enrind10")
  values <- c(values, if (is.null(enrind10)) "NULL" else if (is(enrind10, "subQuery")) paste0("(", as.character(enrind10), ")") else paste0("'", as.character(enrind10), "'"))

  if (missing(enrind11)) {
    enrind11 <- defaults$enrind11
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind11')
  }
  fields <- c(fields, "enrind11")
  values <- c(values, if (is.null(enrind11)) "NULL" else if (is(enrind11, "subQuery")) paste0("(", as.character(enrind11), ")") else paste0("'", as.character(enrind11), "'"))

  if (missing(enrind12)) {
    enrind12 <- defaults$enrind12
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind12')
  }
  fields <- c(fields, "enrind12")
  values <- c(values, if (is.null(enrind12)) "NULL" else if (is(enrind12, "subQuery")) paste0("(", as.character(enrind12), ")") else paste0("'", as.character(enrind12), "'"))

  if (missing(enrind2)) {
    enrind2 <- defaults$enrind2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind2')
  }
  fields <- c(fields, "enrind2")
  values <- c(values, if (is.null(enrind2)) "NULL" else if (is(enrind2, "subQuery")) paste0("(", as.character(enrind2), ")") else paste0("'", as.character(enrind2), "'"))

  if (missing(enrind3)) {
    enrind3 <- defaults$enrind3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind3')
  }
  fields <- c(fields, "enrind3")
  values <- c(values, if (is.null(enrind3)) "NULL" else if (is(enrind3, "subQuery")) paste0("(", as.character(enrind3), ")") else paste0("'", as.character(enrind3), "'"))

  if (missing(enrind4)) {
    enrind4 <- defaults$enrind4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind4')
  }
  fields <- c(fields, "enrind4")
  values <- c(values, if (is.null(enrind4)) "NULL" else if (is(enrind4, "subQuery")) paste0("(", as.character(enrind4), ")") else paste0("'", as.character(enrind4), "'"))

  if (missing(enrind5)) {
    enrind5 <- defaults$enrind5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind5')
  }
  fields <- c(fields, "enrind5")
  values <- c(values, if (is.null(enrind5)) "NULL" else if (is(enrind5, "subQuery")) paste0("(", as.character(enrind5), ")") else paste0("'", as.character(enrind5), "'"))

  if (missing(enrind6)) {
    enrind6 <- defaults$enrind6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind6')
  }
  fields <- c(fields, "enrind6")
  values <- c(values, if (is.null(enrind6)) "NULL" else if (is(enrind6, "subQuery")) paste0("(", as.character(enrind6), ")") else paste0("'", as.character(enrind6), "'"))

  if (missing(enrind7)) {
    enrind7 <- defaults$enrind7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind7')
  }
  fields <- c(fields, "enrind7")
  values <- c(values, if (is.null(enrind7)) "NULL" else if (is(enrind7, "subQuery")) paste0("(", as.character(enrind7), ")") else paste0("'", as.character(enrind7), "'"))

  if (missing(enrind8)) {
    enrind8 <- defaults$enrind8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind8')
  }
  fields <- c(fields, "enrind8")
  values <- c(values, if (is.null(enrind8)) "NULL" else if (is(enrind8, "subQuery")) paste0("(", as.character(enrind8), ")") else paste0("'", as.character(enrind8), "'"))

  if (missing(enrind9)) {
    enrind9 <- defaults$enrind9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrind9')
  }
  fields <- c(fields, "enrind9")
  values <- c(values, if (is.null(enrind9)) "NULL" else if (is(enrind9, "subQuery")) paste0("(", as.character(enrind9), ")") else paste0("'", as.character(enrind9), "'"))

  if (missing(enrmon)) {
    enrmon <- defaults$enrmon
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrmon')
  }
  fields <- c(fields, "enrmon")
  values <- c(values, if (is.null(enrmon)) "NULL" else if (is(enrmon, "subQuery")) paste0("(", as.character(enrmon), ")") else paste0("'", as.character(enrmon), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(memday1)) {
    memday1 <- defaults$memday1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday1')
  }
  fields <- c(fields, "memday1")
  values <- c(values, if (is.null(memday1)) "NULL" else if (is(memday1, "subQuery")) paste0("(", as.character(memday1), ")") else paste0("'", as.character(memday1), "'"))

  if (missing(memday10)) {
    memday10 <- defaults$memday10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday10')
  }
  fields <- c(fields, "memday10")
  values <- c(values, if (is.null(memday10)) "NULL" else if (is(memday10, "subQuery")) paste0("(", as.character(memday10), ")") else paste0("'", as.character(memday10), "'"))

  if (missing(memday11)) {
    memday11 <- defaults$memday11
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday11')
  }
  fields <- c(fields, "memday11")
  values <- c(values, if (is.null(memday11)) "NULL" else if (is(memday11, "subQuery")) paste0("(", as.character(memday11), ")") else paste0("'", as.character(memday11), "'"))

  if (missing(memday12)) {
    memday12 <- defaults$memday12
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday12')
  }
  fields <- c(fields, "memday12")
  values <- c(values, if (is.null(memday12)) "NULL" else if (is(memday12, "subQuery")) paste0("(", as.character(memday12), ")") else paste0("'", as.character(memday12), "'"))

  if (missing(memday2)) {
    memday2 <- defaults$memday2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday2')
  }
  fields <- c(fields, "memday2")
  values <- c(values, if (is.null(memday2)) "NULL" else if (is(memday2, "subQuery")) paste0("(", as.character(memday2), ")") else paste0("'", as.character(memday2), "'"))

  if (missing(memday3)) {
    memday3 <- defaults$memday3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday3')
  }
  fields <- c(fields, "memday3")
  values <- c(values, if (is.null(memday3)) "NULL" else if (is(memday3, "subQuery")) paste0("(", as.character(memday3), ")") else paste0("'", as.character(memday3), "'"))

  if (missing(memday4)) {
    memday4 <- defaults$memday4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday4')
  }
  fields <- c(fields, "memday4")
  values <- c(values, if (is.null(memday4)) "NULL" else if (is(memday4, "subQuery")) paste0("(", as.character(memday4), ")") else paste0("'", as.character(memday4), "'"))

  if (missing(memday5)) {
    memday5 <- defaults$memday5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday5')
  }
  fields <- c(fields, "memday5")
  values <- c(values, if (is.null(memday5)) "NULL" else if (is(memday5, "subQuery")) paste0("(", as.character(memday5), ")") else paste0("'", as.character(memday5), "'"))

  if (missing(memday6)) {
    memday6 <- defaults$memday6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday6')
  }
  fields <- c(fields, "memday6")
  values <- c(values, if (is.null(memday6)) "NULL" else if (is(memday6, "subQuery")) paste0("(", as.character(memday6), ")") else paste0("'", as.character(memday6), "'"))

  if (missing(memday7)) {
    memday7 <- defaults$memday7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday7')
  }
  fields <- c(fields, "memday7")
  values <- c(values, if (is.null(memday7)) "NULL" else if (is(memday7, "subQuery")) paste0("(", as.character(memday7), ")") else paste0("'", as.character(memday7), "'"))

  if (missing(memday8)) {
    memday8 <- defaults$memday8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday8')
  }
  fields <- c(fields, "memday8")
  values <- c(values, if (is.null(memday8)) "NULL" else if (is(memday8, "subQuery")) paste0("(", as.character(memday8), ")") else paste0("'", as.character(memday8), "'"))

  if (missing(memday9)) {
    memday9 <- defaults$memday9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memday9')
  }
  fields <- c(fields, "memday9")
  values <- c(values, if (is.null(memday9)) "NULL" else if (is(memday9, "subQuery")) paste0("(", as.character(memday9), ")") else paste0("'", as.character(memday9), "'"))

  if (missing(memdays)) {
    memdays <- defaults$memdays
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.memdays')
  }
  fields <- c(fields, "memdays")
  values <- c(values, if (is.null(memdays)) "NULL" else if (is(memdays, "subQuery")) paste0("(", as.character(memdays), ")") else paste0("'", as.character(memdays), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(plntyp1)) {
    plntyp1 <- defaults$plntyp1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp1')
  }
  fields <- c(fields, "plntyp1")
  values <- c(values, if (is.null(plntyp1)) "NULL" else if (is(plntyp1, "subQuery")) paste0("(", as.character(plntyp1), ")") else paste0("'", as.character(plntyp1), "'"))

  if (missing(plntyp10)) {
    plntyp10 <- defaults$plntyp10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp10')
  }
  fields <- c(fields, "plntyp10")
  values <- c(values, if (is.null(plntyp10)) "NULL" else if (is(plntyp10, "subQuery")) paste0("(", as.character(plntyp10), ")") else paste0("'", as.character(plntyp10), "'"))

  if (missing(plntyp11)) {
    plntyp11 <- defaults$plntyp11
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp11')
  }
  fields <- c(fields, "plntyp11")
  values <- c(values, if (is.null(plntyp11)) "NULL" else if (is(plntyp11, "subQuery")) paste0("(", as.character(plntyp11), ")") else paste0("'", as.character(plntyp11), "'"))

  if (missing(plntyp12)) {
    plntyp12 <- defaults$plntyp12
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp12')
  }
  fields <- c(fields, "plntyp12")
  values <- c(values, if (is.null(plntyp12)) "NULL" else if (is(plntyp12, "subQuery")) paste0("(", as.character(plntyp12), ")") else paste0("'", as.character(plntyp12), "'"))

  if (missing(plntyp2)) {
    plntyp2 <- defaults$plntyp2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp2')
  }
  fields <- c(fields, "plntyp2")
  values <- c(values, if (is.null(plntyp2)) "NULL" else if (is(plntyp2, "subQuery")) paste0("(", as.character(plntyp2), ")") else paste0("'", as.character(plntyp2), "'"))

  if (missing(plntyp3)) {
    plntyp3 <- defaults$plntyp3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp3')
  }
  fields <- c(fields, "plntyp3")
  values <- c(values, if (is.null(plntyp3)) "NULL" else if (is(plntyp3, "subQuery")) paste0("(", as.character(plntyp3), ")") else paste0("'", as.character(plntyp3), "'"))

  if (missing(plntyp4)) {
    plntyp4 <- defaults$plntyp4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp4')
  }
  fields <- c(fields, "plntyp4")
  values <- c(values, if (is.null(plntyp4)) "NULL" else if (is(plntyp4, "subQuery")) paste0("(", as.character(plntyp4), ")") else paste0("'", as.character(plntyp4), "'"))

  if (missing(plntyp5)) {
    plntyp5 <- defaults$plntyp5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp5')
  }
  fields <- c(fields, "plntyp5")
  values <- c(values, if (is.null(plntyp5)) "NULL" else if (is(plntyp5, "subQuery")) paste0("(", as.character(plntyp5), ")") else paste0("'", as.character(plntyp5), "'"))

  if (missing(plntyp6)) {
    plntyp6 <- defaults$plntyp6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp6')
  }
  fields <- c(fields, "plntyp6")
  values <- c(values, if (is.null(plntyp6)) "NULL" else if (is(plntyp6, "subQuery")) paste0("(", as.character(plntyp6), ")") else paste0("'", as.character(plntyp6), "'"))

  if (missing(plntyp7)) {
    plntyp7 <- defaults$plntyp7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp7')
  }
  fields <- c(fields, "plntyp7")
  values <- c(values, if (is.null(plntyp7)) "NULL" else if (is(plntyp7, "subQuery")) paste0("(", as.character(plntyp7), ")") else paste0("'", as.character(plntyp7), "'"))

  if (missing(plntyp8)) {
    plntyp8 <- defaults$plntyp8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp8')
  }
  fields <- c(fields, "plntyp8")
  values <- c(values, if (is.null(plntyp8)) "NULL" else if (is(plntyp8, "subQuery")) paste0("(", as.character(plntyp8), ")") else paste0("'", as.character(plntyp8), "'"))

  if (missing(plntyp9)) {
    plntyp9 <- defaults$plntyp9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.plntyp9')
  }
  fields <- c(fields, "plntyp9")
  values <- c(values, if (is.null(plntyp9)) "NULL" else if (is(plntyp9, "subQuery")) paste0("(", as.character(plntyp9), ")") else paste0("'", as.character(plntyp9), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_summary.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "enrollment_summary", fields = fields, values = values)
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

add_drug_claims <- function(awp, boe, cap, cob, coins, copay, dawind, daysupp, deaclas, deduct, dispfee, dobyr, drugcovg, enrolid, generid, genind, ingcost, maintin, mas, mcasenum, medicare, metqty, mhsacovg, ndcnum, netpay, pay, pddate, pharmid, plantyp, qty, refill, seqnum, sex, stdrace, svcdate, thercls, thergrp, version, year, gpi) {
  defaults <- get('drug_claims', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(awp)) {
    awp <- defaults$awp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.awp')
  }
  fields <- c(fields, "awp")
  values <- c(values, if (is.null(awp)) "NULL" else if (is(awp, "subQuery")) paste0("(", as.character(awp), ")") else paste0("'", as.character(awp), "'"))

  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(cob)) {
    cob <- defaults$cob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.cob')
  }
  fields <- c(fields, "cob")
  values <- c(values, if (is.null(cob)) "NULL" else if (is(cob, "subQuery")) paste0("(", as.character(cob), ")") else paste0("'", as.character(cob), "'"))

  if (missing(coins)) {
    coins <- defaults$coins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.coins')
  }
  fields <- c(fields, "coins")
  values <- c(values, if (is.null(coins)) "NULL" else if (is(coins, "subQuery")) paste0("(", as.character(coins), ")") else paste0("'", as.character(coins), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(dawind)) {
    dawind <- defaults$dawind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.dawind')
  }
  fields <- c(fields, "dawind")
  values <- c(values, if (is.null(dawind)) "NULL" else if (is(dawind, "subQuery")) paste0("(", as.character(dawind), ")") else paste0("'", as.character(dawind), "'"))

  if (missing(daysupp)) {
    daysupp <- defaults$daysupp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.daysupp')
  }
  fields <- c(fields, "daysupp")
  values <- c(values, if (is.null(daysupp)) "NULL" else if (is(daysupp, "subQuery")) paste0("(", as.character(daysupp), ")") else paste0("'", as.character(daysupp), "'"))

  if (missing(deaclas)) {
    deaclas <- defaults$deaclas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.deaclas')
  }
  fields <- c(fields, "deaclas")
  values <- c(values, if (is.null(deaclas)) "NULL" else if (is(deaclas, "subQuery")) paste0("(", as.character(deaclas), ")") else paste0("'", as.character(deaclas), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(dispfee)) {
    dispfee <- defaults$dispfee
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.dispfee')
  }
  fields <- c(fields, "dispfee")
  values <- c(values, if (is.null(dispfee)) "NULL" else if (is(dispfee, "subQuery")) paste0("(", as.character(dispfee), ")") else paste0("'", as.character(dispfee), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(generid)) {
    generid <- defaults$generid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.generid')
  }
  fields <- c(fields, "generid")
  values <- c(values, if (is.null(generid)) "NULL" else if (is(generid, "subQuery")) paste0("(", as.character(generid), ")") else paste0("'", as.character(generid), "'"))

  if (missing(genind)) {
    genind <- defaults$genind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.genind')
  }
  fields <- c(fields, "genind")
  values <- c(values, if (is.null(genind)) "NULL" else if (is(genind, "subQuery")) paste0("(", as.character(genind), ")") else paste0("'", as.character(genind), "'"))

  if (missing(ingcost)) {
    ingcost <- defaults$ingcost
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.ingcost')
  }
  fields <- c(fields, "ingcost")
  values <- c(values, if (is.null(ingcost)) "NULL" else if (is(ingcost, "subQuery")) paste0("(", as.character(ingcost), ")") else paste0("'", as.character(ingcost), "'"))

  if (missing(maintin)) {
    maintin <- defaults$maintin
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.maintin')
  }
  fields <- c(fields, "maintin")
  values <- c(values, if (is.null(maintin)) "NULL" else if (is(maintin, "subQuery")) paste0("(", as.character(maintin), ")") else paste0("'", as.character(maintin), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(metqty)) {
    metqty <- defaults$metqty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.metqty')
  }
  fields <- c(fields, "metqty")
  values <- c(values, if (is.null(metqty)) "NULL" else if (is(metqty, "subQuery")) paste0("(", as.character(metqty), ")") else paste0("'", as.character(metqty), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(ndcnum)) {
    ndcnum <- defaults$ndcnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.ndcnum')
  }
  fields <- c(fields, "ndcnum")
  values <- c(values, if (is.null(ndcnum)) "NULL" else if (is(ndcnum, "subQuery")) paste0("(", as.character(ndcnum), ")") else paste0("'", as.character(ndcnum), "'"))

  if (missing(netpay)) {
    netpay <- defaults$netpay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.netpay')
  }
  fields <- c(fields, "netpay")
  values <- c(values, if (is.null(netpay)) "NULL" else if (is(netpay, "subQuery")) paste0("(", as.character(netpay), ")") else paste0("'", as.character(netpay), "'"))

  if (missing(pay)) {
    pay <- defaults$pay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.pay')
  }
  fields <- c(fields, "pay")
  values <- c(values, if (is.null(pay)) "NULL" else if (is(pay, "subQuery")) paste0("(", as.character(pay), ")") else paste0("'", as.character(pay), "'"))

  if (missing(pddate)) {
    pddate <- defaults$pddate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.pddate')
  }
  fields <- c(fields, "pddate")
  values <- c(values, if (is.null(pddate)) "NULL" else if (is(pddate, "subQuery")) paste0("(", as.character(pddate), ")") else paste0("'", as.character(pddate), "'"))

  if (missing(pharmid)) {
    pharmid <- defaults$pharmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.pharmid')
  }
  fields <- c(fields, "pharmid")
  values <- c(values, if (is.null(pharmid)) "NULL" else if (is(pharmid, "subQuery")) paste0("(", as.character(pharmid), ")") else paste0("'", as.character(pharmid), "'"))

  if (missing(plantyp)) {
    plantyp <- defaults$plantyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.plantyp')
  }
  fields <- c(fields, "plantyp")
  values <- c(values, if (is.null(plantyp)) "NULL" else if (is(plantyp, "subQuery")) paste0("(", as.character(plantyp), ")") else paste0("'", as.character(plantyp), "'"))

  if (missing(qty)) {
    qty <- defaults$qty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.qty')
  }
  fields <- c(fields, "qty")
  values <- c(values, if (is.null(qty)) "NULL" else if (is(qty, "subQuery")) paste0("(", as.character(qty), ")") else paste0("'", as.character(qty), "'"))

  if (missing(refill)) {
    refill <- defaults$refill
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.refill')
  }
  fields <- c(fields, "refill")
  values <- c(values, if (is.null(refill)) "NULL" else if (is(refill, "subQuery")) paste0("(", as.character(refill), ")") else paste0("'", as.character(refill), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(svcdate)) {
    svcdate <- defaults$svcdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.svcdate')
  }
  fields <- c(fields, "svcdate")
  values <- c(values, if (is.null(svcdate)) "NULL" else if (is(svcdate, "subQuery")) paste0("(", as.character(svcdate), ")") else paste0("'", as.character(svcdate), "'"))

  if (missing(thercls)) {
    thercls <- defaults$thercls
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.thercls')
  }
  fields <- c(fields, "thercls")
  values <- c(values, if (is.null(thercls)) "NULL" else if (is(thercls, "subQuery")) paste0("(", as.character(thercls), ")") else paste0("'", as.character(thercls), "'"))

  if (missing(thergrp)) {
    thergrp <- defaults$thergrp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.thergrp')
  }
  fields <- c(fields, "thergrp")
  values <- c(values, if (is.null(thergrp)) "NULL" else if (is(thergrp, "subQuery")) paste0("(", as.character(thergrp), ")") else paste0("'", as.character(thergrp), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  if (missing(gpi)) {
    gpi <- defaults$gpi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'drug_claims.gpi')
  }
  fields <- c(fields, "_gpi")
  values <- c(values, if (is.null(gpi)) "NULL" else if (is(gpi, "subQuery")) paste0("(", as.character(gpi), ")") else paste0("'", as.character(gpi), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "drug_claims", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_facility_header <- function(billtyp, boe, cap, caseid, cob, coins, copay, deduct, dobyr, drugcovg, dstatus, dx1, dx2, dx3, dx4, dx5, dx6, dx7, dx8, dx9, dxver, enrolid, fachdid, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pddate, plantyp, poadx1, poadx2, poadx3, poadx4, poadx5, poadx6, poadx7, poadx8, poadx9, proc1, proc2, proc3, proc4, proc5, proc6, prov_id, seqnum, sex, stdplac, stdprov, stdrace, svcdate, tsvcdat, version, year, npi, msclmid) {
  defaults <- get('facility_header', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(billtyp)) {
    billtyp <- defaults$billtyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.billtyp')
  }
  fields <- c(fields, "billtyp")
  values <- c(values, if (is.null(billtyp)) "NULL" else if (is(billtyp, "subQuery")) paste0("(", as.character(billtyp), ")") else paste0("'", as.character(billtyp), "'"))

  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(caseid)) {
    caseid <- defaults$caseid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.caseid')
  }
  fields <- c(fields, "caseid")
  values <- c(values, if (is.null(caseid)) "NULL" else if (is(caseid, "subQuery")) paste0("(", as.character(caseid), ")") else paste0("'", as.character(caseid), "'"))

  if (missing(cob)) {
    cob <- defaults$cob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.cob')
  }
  fields <- c(fields, "cob")
  values <- c(values, if (is.null(cob)) "NULL" else if (is(cob, "subQuery")) paste0("(", as.character(cob), ")") else paste0("'", as.character(cob), "'"))

  if (missing(coins)) {
    coins <- defaults$coins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.coins')
  }
  fields <- c(fields, "coins")
  values <- c(values, if (is.null(coins)) "NULL" else if (is(coins, "subQuery")) paste0("(", as.character(coins), ")") else paste0("'", as.character(coins), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(dstatus)) {
    dstatus <- defaults$dstatus
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dstatus')
  }
  fields <- c(fields, "dstatus")
  values <- c(values, if (is.null(dstatus)) "NULL" else if (is(dstatus, "subQuery")) paste0("(", as.character(dstatus), ")") else paste0("'", as.character(dstatus), "'"))

  if (missing(dx1)) {
    dx1 <- defaults$dx1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx1')
  }
  fields <- c(fields, "dx1")
  values <- c(values, if (is.null(dx1)) "NULL" else if (is(dx1, "subQuery")) paste0("(", as.character(dx1), ")") else paste0("'", as.character(dx1), "'"))

  if (missing(dx2)) {
    dx2 <- defaults$dx2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx2')
  }
  fields <- c(fields, "dx2")
  values <- c(values, if (is.null(dx2)) "NULL" else if (is(dx2, "subQuery")) paste0("(", as.character(dx2), ")") else paste0("'", as.character(dx2), "'"))

  if (missing(dx3)) {
    dx3 <- defaults$dx3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx3')
  }
  fields <- c(fields, "dx3")
  values <- c(values, if (is.null(dx3)) "NULL" else if (is(dx3, "subQuery")) paste0("(", as.character(dx3), ")") else paste0("'", as.character(dx3), "'"))

  if (missing(dx4)) {
    dx4 <- defaults$dx4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx4')
  }
  fields <- c(fields, "dx4")
  values <- c(values, if (is.null(dx4)) "NULL" else if (is(dx4, "subQuery")) paste0("(", as.character(dx4), ")") else paste0("'", as.character(dx4), "'"))

  if (missing(dx5)) {
    dx5 <- defaults$dx5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx5')
  }
  fields <- c(fields, "dx5")
  values <- c(values, if (is.null(dx5)) "NULL" else if (is(dx5, "subQuery")) paste0("(", as.character(dx5), ")") else paste0("'", as.character(dx5), "'"))

  if (missing(dx6)) {
    dx6 <- defaults$dx6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx6')
  }
  fields <- c(fields, "dx6")
  values <- c(values, if (is.null(dx6)) "NULL" else if (is(dx6, "subQuery")) paste0("(", as.character(dx6), ")") else paste0("'", as.character(dx6), "'"))

  if (missing(dx7)) {
    dx7 <- defaults$dx7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx7')
  }
  fields <- c(fields, "dx7")
  values <- c(values, if (is.null(dx7)) "NULL" else if (is(dx7, "subQuery")) paste0("(", as.character(dx7), ")") else paste0("'", as.character(dx7), "'"))

  if (missing(dx8)) {
    dx8 <- defaults$dx8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx8')
  }
  fields <- c(fields, "dx8")
  values <- c(values, if (is.null(dx8)) "NULL" else if (is(dx8, "subQuery")) paste0("(", as.character(dx8), ")") else paste0("'", as.character(dx8), "'"))

  if (missing(dx9)) {
    dx9 <- defaults$dx9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dx9')
  }
  fields <- c(fields, "dx9")
  values <- c(values, if (is.null(dx9)) "NULL" else if (is(dx9, "subQuery")) paste0("(", as.character(dx9), ")") else paste0("'", as.character(dx9), "'"))

  if (missing(dxver)) {
    dxver <- defaults$dxver
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.dxver')
  }
  fields <- c(fields, "dxver")
  values <- c(values, if (is.null(dxver)) "NULL" else if (is(dxver, "subQuery")) paste0("(", as.character(dxver), ")") else paste0("'", as.character(dxver), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(fachdid)) {
    fachdid <- defaults$fachdid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.fachdid')
  }
  fields <- c(fields, "fachdid")
  values <- c(values, if (is.null(fachdid)) "NULL" else if (is(fachdid, "subQuery")) paste0("(", as.character(fachdid), ")") else paste0("'", as.character(fachdid), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(mdc)) {
    mdc <- defaults$mdc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.mdc')
  }
  fields <- c(fields, "mdc")
  values <- c(values, if (is.null(mdc)) "NULL" else if (is(mdc, "subQuery")) paste0("(", as.character(mdc), ")") else paste0("'", as.character(mdc), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(netpay)) {
    netpay <- defaults$netpay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.netpay')
  }
  fields <- c(fields, "netpay")
  values <- c(values, if (is.null(netpay)) "NULL" else if (is(netpay, "subQuery")) paste0("(", as.character(netpay), ")") else paste0("'", as.character(netpay), "'"))

  if (missing(pddate)) {
    pddate <- defaults$pddate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.pddate')
  }
  fields <- c(fields, "pddate")
  values <- c(values, if (is.null(pddate)) "NULL" else if (is(pddate, "subQuery")) paste0("(", as.character(pddate), ")") else paste0("'", as.character(pddate), "'"))

  if (missing(plantyp)) {
    plantyp <- defaults$plantyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.plantyp')
  }
  fields <- c(fields, "plantyp")
  values <- c(values, if (is.null(plantyp)) "NULL" else if (is(plantyp, "subQuery")) paste0("(", as.character(plantyp), ")") else paste0("'", as.character(plantyp), "'"))

  if (missing(poadx1)) {
    poadx1 <- defaults$poadx1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx1')
  }
  fields <- c(fields, "poadx1")
  values <- c(values, if (is.null(poadx1)) "NULL" else if (is(poadx1, "subQuery")) paste0("(", as.character(poadx1), ")") else paste0("'", as.character(poadx1), "'"))

  if (missing(poadx2)) {
    poadx2 <- defaults$poadx2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx2')
  }
  fields <- c(fields, "poadx2")
  values <- c(values, if (is.null(poadx2)) "NULL" else if (is(poadx2, "subQuery")) paste0("(", as.character(poadx2), ")") else paste0("'", as.character(poadx2), "'"))

  if (missing(poadx3)) {
    poadx3 <- defaults$poadx3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx3')
  }
  fields <- c(fields, "poadx3")
  values <- c(values, if (is.null(poadx3)) "NULL" else if (is(poadx3, "subQuery")) paste0("(", as.character(poadx3), ")") else paste0("'", as.character(poadx3), "'"))

  if (missing(poadx4)) {
    poadx4 <- defaults$poadx4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx4')
  }
  fields <- c(fields, "poadx4")
  values <- c(values, if (is.null(poadx4)) "NULL" else if (is(poadx4, "subQuery")) paste0("(", as.character(poadx4), ")") else paste0("'", as.character(poadx4), "'"))

  if (missing(poadx5)) {
    poadx5 <- defaults$poadx5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx5')
  }
  fields <- c(fields, "poadx5")
  values <- c(values, if (is.null(poadx5)) "NULL" else if (is(poadx5, "subQuery")) paste0("(", as.character(poadx5), ")") else paste0("'", as.character(poadx5), "'"))

  if (missing(poadx6)) {
    poadx6 <- defaults$poadx6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx6')
  }
  fields <- c(fields, "poadx6")
  values <- c(values, if (is.null(poadx6)) "NULL" else if (is(poadx6, "subQuery")) paste0("(", as.character(poadx6), ")") else paste0("'", as.character(poadx6), "'"))

  if (missing(poadx7)) {
    poadx7 <- defaults$poadx7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx7')
  }
  fields <- c(fields, "poadx7")
  values <- c(values, if (is.null(poadx7)) "NULL" else if (is(poadx7, "subQuery")) paste0("(", as.character(poadx7), ")") else paste0("'", as.character(poadx7), "'"))

  if (missing(poadx8)) {
    poadx8 <- defaults$poadx8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx8')
  }
  fields <- c(fields, "poadx8")
  values <- c(values, if (is.null(poadx8)) "NULL" else if (is(poadx8, "subQuery")) paste0("(", as.character(poadx8), ")") else paste0("'", as.character(poadx8), "'"))

  if (missing(poadx9)) {
    poadx9 <- defaults$poadx9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.poadx9')
  }
  fields <- c(fields, "poadx9")
  values <- c(values, if (is.null(poadx9)) "NULL" else if (is(poadx9, "subQuery")) paste0("(", as.character(poadx9), ")") else paste0("'", as.character(poadx9), "'"))

  if (missing(proc1)) {
    proc1 <- defaults$proc1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.proc1')
  }
  fields <- c(fields, "proc1")
  values <- c(values, if (is.null(proc1)) "NULL" else if (is(proc1, "subQuery")) paste0("(", as.character(proc1), ")") else paste0("'", as.character(proc1), "'"))

  if (missing(proc2)) {
    proc2 <- defaults$proc2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.proc2')
  }
  fields <- c(fields, "proc2")
  values <- c(values, if (is.null(proc2)) "NULL" else if (is(proc2, "subQuery")) paste0("(", as.character(proc2), ")") else paste0("'", as.character(proc2), "'"))

  if (missing(proc3)) {
    proc3 <- defaults$proc3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.proc3')
  }
  fields <- c(fields, "proc3")
  values <- c(values, if (is.null(proc3)) "NULL" else if (is(proc3, "subQuery")) paste0("(", as.character(proc3), ")") else paste0("'", as.character(proc3), "'"))

  if (missing(proc4)) {
    proc4 <- defaults$proc4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.proc4')
  }
  fields <- c(fields, "proc4")
  values <- c(values, if (is.null(proc4)) "NULL" else if (is(proc4, "subQuery")) paste0("(", as.character(proc4), ")") else paste0("'", as.character(proc4), "'"))

  if (missing(proc5)) {
    proc5 <- defaults$proc5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.proc5')
  }
  fields <- c(fields, "proc5")
  values <- c(values, if (is.null(proc5)) "NULL" else if (is(proc5, "subQuery")) paste0("(", as.character(proc5), ")") else paste0("'", as.character(proc5), "'"))

  if (missing(proc6)) {
    proc6 <- defaults$proc6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.proc6')
  }
  fields <- c(fields, "proc6")
  values <- c(values, if (is.null(proc6)) "NULL" else if (is(proc6, "subQuery")) paste0("(", as.character(proc6), ")") else paste0("'", as.character(proc6), "'"))

  if (missing(prov_id)) {
    prov_id <- defaults$prov_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.prov_id')
  }
  fields <- c(fields, "prov_id")
  values <- c(values, if (is.null(prov_id)) "NULL" else if (is(prov_id, "subQuery")) paste0("(", as.character(prov_id), ")") else paste0("'", as.character(prov_id), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdplac)) {
    stdplac <- defaults$stdplac
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.stdplac')
  }
  fields <- c(fields, "stdplac")
  values <- c(values, if (is.null(stdplac)) "NULL" else if (is(stdplac, "subQuery")) paste0("(", as.character(stdplac), ")") else paste0("'", as.character(stdplac), "'"))

  if (missing(stdprov)) {
    stdprov <- defaults$stdprov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.stdprov')
  }
  fields <- c(fields, "stdprov")
  values <- c(values, if (is.null(stdprov)) "NULL" else if (is(stdprov, "subQuery")) paste0("(", as.character(stdprov), ")") else paste0("'", as.character(stdprov), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(svcdate)) {
    svcdate <- defaults$svcdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.svcdate')
  }
  fields <- c(fields, "svcdate")
  values <- c(values, if (is.null(svcdate)) "NULL" else if (is(svcdate, "subQuery")) paste0("(", as.character(svcdate), ")") else paste0("'", as.character(svcdate), "'"))

  if (missing(tsvcdat)) {
    tsvcdat <- defaults$tsvcdat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.tsvcdat')
  }
  fields <- c(fields, "tsvcdat")
  values <- c(values, if (is.null(tsvcdat)) "NULL" else if (is(tsvcdat, "subQuery")) paste0("(", as.character(tsvcdat), ")") else paste0("'", as.character(tsvcdat), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  if (missing(npi)) {
    npi <- defaults$npi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.npi')
  }
  fields <- c(fields, "npi")
  values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))

  if (missing(msclmid)) {
    msclmid <- defaults$msclmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'facility_header.msclmid')
  }
  fields <- c(fields, "msclmid")
  values <- c(values, if (is.null(msclmid)) "NULL" else if (is(msclmid, "subQuery")) paste0("(", as.character(msclmid), ")") else paste0("'", as.character(msclmid), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "facility_header", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_enrollment_detail <- function(boe, cap, dobyr, drugcovg, dtend, dtstart, enrolid, mas, mcasenum, medicare, memdays, mhsacovg, plantyp, seqnum, sex, stdrace, version, year) {
  defaults <- get('enrollment_detail', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(dtend)) {
    dtend <- defaults$dtend
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.dtend')
  }
  fields <- c(fields, "dtend")
  values <- c(values, if (is.null(dtend)) "NULL" else if (is(dtend, "subQuery")) paste0("(", as.character(dtend), ")") else paste0("'", as.character(dtend), "'"))

  if (missing(dtstart)) {
    dtstart <- defaults$dtstart
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.dtstart')
  }
  fields <- c(fields, "dtstart")
  values <- c(values, if (is.null(dtstart)) "NULL" else if (is(dtstart, "subQuery")) paste0("(", as.character(dtstart), ")") else paste0("'", as.character(dtstart), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(memdays)) {
    memdays <- defaults$memdays
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.memdays')
  }
  fields <- c(fields, "memdays")
  values <- c(values, if (is.null(memdays)) "NULL" else if (is(memdays, "subQuery")) paste0("(", as.character(memdays), ")") else paste0("'", as.character(memdays), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(plantyp)) {
    plantyp <- defaults$plantyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.plantyp')
  }
  fields <- c(fields, "plantyp")
  values <- c(values, if (is.null(plantyp)) "NULL" else if (is(plantyp, "subQuery")) paste0("(", as.character(plantyp), ")") else paste0("'", as.character(plantyp), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'enrollment_detail.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "enrollment_detail", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_outpatient_services <- function(boe, cap, cob, coins, copay, deduct, dental, dobyr, drugcovg, dx1, dx2, dx3, dx4, dxver, enrolid, fachdid, facprof, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pay, pddate, plantyp, proc1, procgrp, proctyp, prov_id, qty, revcode, seqnum, sex, stdplac, stdprov, stdrace, stdsvc, svcdate, svcscat, tsvcdat, version, year, units, npi, msclmid, procmod) {
  defaults <- get('outpatient_services', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(cob)) {
    cob <- defaults$cob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.cob')
  }
  fields <- c(fields, "cob")
  values <- c(values, if (is.null(cob)) "NULL" else if (is(cob, "subQuery")) paste0("(", as.character(cob), ")") else paste0("'", as.character(cob), "'"))

  if (missing(coins)) {
    coins <- defaults$coins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.coins')
  }
  fields <- c(fields, "coins")
  values <- c(values, if (is.null(coins)) "NULL" else if (is(coins, "subQuery")) paste0("(", as.character(coins), ")") else paste0("'", as.character(coins), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(dental)) {
    dental <- defaults$dental
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.dental')
  }
  fields <- c(fields, "dental")
  values <- c(values, if (is.null(dental)) "NULL" else if (is(dental, "subQuery")) paste0("(", as.character(dental), ")") else paste0("'", as.character(dental), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(dx1)) {
    dx1 <- defaults$dx1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.dx1')
  }
  fields <- c(fields, "dx1")
  values <- c(values, if (is.null(dx1)) "NULL" else if (is(dx1, "subQuery")) paste0("(", as.character(dx1), ")") else paste0("'", as.character(dx1), "'"))

  if (missing(dx2)) {
    dx2 <- defaults$dx2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.dx2')
  }
  fields <- c(fields, "dx2")
  values <- c(values, if (is.null(dx2)) "NULL" else if (is(dx2, "subQuery")) paste0("(", as.character(dx2), ")") else paste0("'", as.character(dx2), "'"))

  if (missing(dx3)) {
    dx3 <- defaults$dx3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.dx3')
  }
  fields <- c(fields, "dx3")
  values <- c(values, if (is.null(dx3)) "NULL" else if (is(dx3, "subQuery")) paste0("(", as.character(dx3), ")") else paste0("'", as.character(dx3), "'"))

  if (missing(dx4)) {
    dx4 <- defaults$dx4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.dx4')
  }
  fields <- c(fields, "dx4")
  values <- c(values, if (is.null(dx4)) "NULL" else if (is(dx4, "subQuery")) paste0("(", as.character(dx4), ")") else paste0("'", as.character(dx4), "'"))

  if (missing(dxver)) {
    dxver <- defaults$dxver
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.dxver')
  }
  fields <- c(fields, "dxver")
  values <- c(values, if (is.null(dxver)) "NULL" else if (is(dxver, "subQuery")) paste0("(", as.character(dxver), ")") else paste0("'", as.character(dxver), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(fachdid)) {
    fachdid <- defaults$fachdid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.fachdid')
  }
  fields <- c(fields, "fachdid")
  values <- c(values, if (is.null(fachdid)) "NULL" else if (is(fachdid, "subQuery")) paste0("(", as.character(fachdid), ")") else paste0("'", as.character(fachdid), "'"))

  if (missing(facprof)) {
    facprof <- defaults$facprof
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.facprof')
  }
  fields <- c(fields, "facprof")
  values <- c(values, if (is.null(facprof)) "NULL" else if (is(facprof, "subQuery")) paste0("(", as.character(facprof), ")") else paste0("'", as.character(facprof), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(mdc)) {
    mdc <- defaults$mdc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.mdc')
  }
  fields <- c(fields, "mdc")
  values <- c(values, if (is.null(mdc)) "NULL" else if (is(mdc, "subQuery")) paste0("(", as.character(mdc), ")") else paste0("'", as.character(mdc), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(netpay)) {
    netpay <- defaults$netpay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.netpay')
  }
  fields <- c(fields, "netpay")
  values <- c(values, if (is.null(netpay)) "NULL" else if (is(netpay, "subQuery")) paste0("(", as.character(netpay), ")") else paste0("'", as.character(netpay), "'"))

  if (missing(pay)) {
    pay <- defaults$pay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.pay')
  }
  fields <- c(fields, "pay")
  values <- c(values, if (is.null(pay)) "NULL" else if (is(pay, "subQuery")) paste0("(", as.character(pay), ")") else paste0("'", as.character(pay), "'"))

  if (missing(pddate)) {
    pddate <- defaults$pddate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.pddate')
  }
  fields <- c(fields, "pddate")
  values <- c(values, if (is.null(pddate)) "NULL" else if (is(pddate, "subQuery")) paste0("(", as.character(pddate), ")") else paste0("'", as.character(pddate), "'"))

  if (missing(plantyp)) {
    plantyp <- defaults$plantyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.plantyp')
  }
  fields <- c(fields, "plantyp")
  values <- c(values, if (is.null(plantyp)) "NULL" else if (is(plantyp, "subQuery")) paste0("(", as.character(plantyp), ")") else paste0("'", as.character(plantyp), "'"))

  if (missing(proc1)) {
    proc1 <- defaults$proc1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.proc1')
  }
  fields <- c(fields, "proc1")
  values <- c(values, if (is.null(proc1)) "NULL" else if (is(proc1, "subQuery")) paste0("(", as.character(proc1), ")") else paste0("'", as.character(proc1), "'"))

  if (missing(procgrp)) {
    procgrp <- defaults$procgrp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.procgrp')
  }
  fields <- c(fields, "procgrp")
  values <- c(values, if (is.null(procgrp)) "NULL" else if (is(procgrp, "subQuery")) paste0("(", as.character(procgrp), ")") else paste0("'", as.character(procgrp), "'"))

  if (missing(proctyp)) {
    proctyp <- defaults$proctyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.proctyp')
  }
  fields <- c(fields, "proctyp")
  values <- c(values, if (is.null(proctyp)) "NULL" else if (is(proctyp, "subQuery")) paste0("(", as.character(proctyp), ")") else paste0("'", as.character(proctyp), "'"))

  if (missing(prov_id)) {
    prov_id <- defaults$prov_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.prov_id')
  }
  fields <- c(fields, "prov_id")
  values <- c(values, if (is.null(prov_id)) "NULL" else if (is(prov_id, "subQuery")) paste0("(", as.character(prov_id), ")") else paste0("'", as.character(prov_id), "'"))

  if (missing(qty)) {
    qty <- defaults$qty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.qty')
  }
  fields <- c(fields, "qty")
  values <- c(values, if (is.null(qty)) "NULL" else if (is(qty, "subQuery")) paste0("(", as.character(qty), ")") else paste0("'", as.character(qty), "'"))

  if (missing(revcode)) {
    revcode <- defaults$revcode
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.revcode')
  }
  fields <- c(fields, "revcode")
  values <- c(values, if (is.null(revcode)) "NULL" else if (is(revcode, "subQuery")) paste0("(", as.character(revcode), ")") else paste0("'", as.character(revcode), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdplac)) {
    stdplac <- defaults$stdplac
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.stdplac')
  }
  fields <- c(fields, "stdplac")
  values <- c(values, if (is.null(stdplac)) "NULL" else if (is(stdplac, "subQuery")) paste0("(", as.character(stdplac), ")") else paste0("'", as.character(stdplac), "'"))

  if (missing(stdprov)) {
    stdprov <- defaults$stdprov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.stdprov')
  }
  fields <- c(fields, "stdprov")
  values <- c(values, if (is.null(stdprov)) "NULL" else if (is(stdprov, "subQuery")) paste0("(", as.character(stdprov), ")") else paste0("'", as.character(stdprov), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(stdsvc)) {
    stdsvc <- defaults$stdsvc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.stdsvc')
  }
  fields <- c(fields, "stdsvc")
  values <- c(values, if (is.null(stdsvc)) "NULL" else if (is(stdsvc, "subQuery")) paste0("(", as.character(stdsvc), ")") else paste0("'", as.character(stdsvc), "'"))

  if (missing(svcdate)) {
    svcdate <- defaults$svcdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.svcdate')
  }
  fields <- c(fields, "svcdate")
  values <- c(values, if (is.null(svcdate)) "NULL" else if (is(svcdate, "subQuery")) paste0("(", as.character(svcdate), ")") else paste0("'", as.character(svcdate), "'"))

  if (missing(svcscat)) {
    svcscat <- defaults$svcscat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.svcscat')
  }
  fields <- c(fields, "svcscat")
  values <- c(values, if (is.null(svcscat)) "NULL" else if (is(svcscat, "subQuery")) paste0("(", as.character(svcscat), ")") else paste0("'", as.character(svcscat), "'"))

  if (missing(tsvcdat)) {
    tsvcdat <- defaults$tsvcdat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.tsvcdat')
  }
  fields <- c(fields, "tsvcdat")
  values <- c(values, if (is.null(tsvcdat)) "NULL" else if (is(tsvcdat, "subQuery")) paste0("(", as.character(tsvcdat), ")") else paste0("'", as.character(tsvcdat), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  if (missing(units)) {
    units <- defaults$units
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.units')
  }
  fields <- c(fields, "units")
  values <- c(values, if (is.null(units)) "NULL" else if (is(units, "subQuery")) paste0("(", as.character(units), ")") else paste0("'", as.character(units), "'"))

  if (missing(npi)) {
    npi <- defaults$npi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.npi')
  }
  fields <- c(fields, "npi")
  values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))

  if (missing(msclmid)) {
    msclmid <- defaults$msclmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.msclmid')
  }
  fields <- c(fields, "msclmid")
  values <- c(values, if (is.null(msclmid)) "NULL" else if (is(msclmid, "subQuery")) paste0("(", as.character(msclmid), ")") else paste0("'", as.character(msclmid), "'"))

  if (missing(procmod)) {
    procmod <- defaults$procmod
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'outpatient_services.procmod')
  }
  fields <- c(fields, "procmod")
  values <- c(values, if (is.null(procmod)) "NULL" else if (is(procmod, "subQuery")) paste0("(", as.character(procmod), ")") else paste0("'", as.character(procmod), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "outpatient_services", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_red_book <- function(flag, deaclas, deaclds, desidrg, excdgds, excldrg, generid, genind, gennme, gnindds, maintds, maintin, manfnme, mastfrm, metsize, mstfmds, ndcnum, orgbkcd, orgbkds, orgbkfg, pkqtycd, pksize, prdctds, prodcat, prodnme, siglsrc, strngth, roacd, roads, thercls, therdtl, thergrp, thrclds, thrdtds, thrgrds, year, deactdt, reactdt, actind) {
  defaults <- get('red_book', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(flag)) {
    flag <- defaults$flag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.flag')
  }
  fields <- c(fields, "_flag")
  values <- c(values, if (is.null(flag)) "NULL" else if (is(flag, "subQuery")) paste0("(", as.character(flag), ")") else paste0("'", as.character(flag), "'"))

  if (missing(deaclas)) {
    deaclas <- defaults$deaclas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.deaclas')
  }
  fields <- c(fields, "deaclas")
  values <- c(values, if (is.null(deaclas)) "NULL" else if (is(deaclas, "subQuery")) paste0("(", as.character(deaclas), ")") else paste0("'", as.character(deaclas), "'"))

  if (missing(deaclds)) {
    deaclds <- defaults$deaclds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.deaclds')
  }
  fields <- c(fields, "deaclds")
  values <- c(values, if (is.null(deaclds)) "NULL" else if (is(deaclds, "subQuery")) paste0("(", as.character(deaclds), ")") else paste0("'", as.character(deaclds), "'"))

  if (missing(desidrg)) {
    desidrg <- defaults$desidrg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.desidrg')
  }
  fields <- c(fields, "desidrg")
  values <- c(values, if (is.null(desidrg)) "NULL" else if (is(desidrg, "subQuery")) paste0("(", as.character(desidrg), ")") else paste0("'", as.character(desidrg), "'"))

  if (missing(excdgds)) {
    excdgds <- defaults$excdgds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.excdgds')
  }
  fields <- c(fields, "excdgds")
  values <- c(values, if (is.null(excdgds)) "NULL" else if (is(excdgds, "subQuery")) paste0("(", as.character(excdgds), ")") else paste0("'", as.character(excdgds), "'"))

  if (missing(excldrg)) {
    excldrg <- defaults$excldrg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.excldrg')
  }
  fields <- c(fields, "excldrg")
  values <- c(values, if (is.null(excldrg)) "NULL" else if (is(excldrg, "subQuery")) paste0("(", as.character(excldrg), ")") else paste0("'", as.character(excldrg), "'"))

  if (missing(generid)) {
    generid <- defaults$generid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.generid')
  }
  fields <- c(fields, "generid")
  values <- c(values, if (is.null(generid)) "NULL" else if (is(generid, "subQuery")) paste0("(", as.character(generid), ")") else paste0("'", as.character(generid), "'"))

  if (missing(genind)) {
    genind <- defaults$genind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.genind')
  }
  fields <- c(fields, "genind")
  values <- c(values, if (is.null(genind)) "NULL" else if (is(genind, "subQuery")) paste0("(", as.character(genind), ")") else paste0("'", as.character(genind), "'"))

  if (missing(gennme)) {
    gennme <- defaults$gennme
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.gennme')
  }
  fields <- c(fields, "gennme")
  values <- c(values, if (is.null(gennme)) "NULL" else if (is(gennme, "subQuery")) paste0("(", as.character(gennme), ")") else paste0("'", as.character(gennme), "'"))

  if (missing(gnindds)) {
    gnindds <- defaults$gnindds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.gnindds')
  }
  fields <- c(fields, "gnindds")
  values <- c(values, if (is.null(gnindds)) "NULL" else if (is(gnindds, "subQuery")) paste0("(", as.character(gnindds), ")") else paste0("'", as.character(gnindds), "'"))

  if (missing(maintds)) {
    maintds <- defaults$maintds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.maintds')
  }
  fields <- c(fields, "maintds")
  values <- c(values, if (is.null(maintds)) "NULL" else if (is(maintds, "subQuery")) paste0("(", as.character(maintds), ")") else paste0("'", as.character(maintds), "'"))

  if (missing(maintin)) {
    maintin <- defaults$maintin
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.maintin')
  }
  fields <- c(fields, "maintin")
  values <- c(values, if (is.null(maintin)) "NULL" else if (is(maintin, "subQuery")) paste0("(", as.character(maintin), ")") else paste0("'", as.character(maintin), "'"))

  if (missing(manfnme)) {
    manfnme <- defaults$manfnme
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.manfnme')
  }
  fields <- c(fields, "manfnme")
  values <- c(values, if (is.null(manfnme)) "NULL" else if (is(manfnme, "subQuery")) paste0("(", as.character(manfnme), ")") else paste0("'", as.character(manfnme), "'"))

  if (missing(mastfrm)) {
    mastfrm <- defaults$mastfrm
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.mastfrm')
  }
  fields <- c(fields, "mastfrm")
  values <- c(values, if (is.null(mastfrm)) "NULL" else if (is(mastfrm, "subQuery")) paste0("(", as.character(mastfrm), ")") else paste0("'", as.character(mastfrm), "'"))

  if (missing(metsize)) {
    metsize <- defaults$metsize
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.metsize')
  }
  fields <- c(fields, "metsize")
  values <- c(values, if (is.null(metsize)) "NULL" else if (is(metsize, "subQuery")) paste0("(", as.character(metsize), ")") else paste0("'", as.character(metsize), "'"))

  if (missing(mstfmds)) {
    mstfmds <- defaults$mstfmds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.mstfmds')
  }
  fields <- c(fields, "mstfmds")
  values <- c(values, if (is.null(mstfmds)) "NULL" else if (is(mstfmds, "subQuery")) paste0("(", as.character(mstfmds), ")") else paste0("'", as.character(mstfmds), "'"))

  if (missing(ndcnum)) {
    ndcnum <- defaults$ndcnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.ndcnum')
  }
  fields <- c(fields, "ndcnum")
  values <- c(values, if (is.null(ndcnum)) "NULL" else if (is(ndcnum, "subQuery")) paste0("(", as.character(ndcnum), ")") else paste0("'", as.character(ndcnum), "'"))

  if (missing(orgbkcd)) {
    orgbkcd <- defaults$orgbkcd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.orgbkcd')
  }
  fields <- c(fields, "orgbkcd")
  values <- c(values, if (is.null(orgbkcd)) "NULL" else if (is(orgbkcd, "subQuery")) paste0("(", as.character(orgbkcd), ")") else paste0("'", as.character(orgbkcd), "'"))

  if (missing(orgbkds)) {
    orgbkds <- defaults$orgbkds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.orgbkds')
  }
  fields <- c(fields, "orgbkds")
  values <- c(values, if (is.null(orgbkds)) "NULL" else if (is(orgbkds, "subQuery")) paste0("(", as.character(orgbkds), ")") else paste0("'", as.character(orgbkds), "'"))

  if (missing(orgbkfg)) {
    orgbkfg <- defaults$orgbkfg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.orgbkfg')
  }
  fields <- c(fields, "orgbkfg")
  values <- c(values, if (is.null(orgbkfg)) "NULL" else if (is(orgbkfg, "subQuery")) paste0("(", as.character(orgbkfg), ")") else paste0("'", as.character(orgbkfg), "'"))

  if (missing(pkqtycd)) {
    pkqtycd <- defaults$pkqtycd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.pkqtycd')
  }
  fields <- c(fields, "pkqtycd")
  values <- c(values, if (is.null(pkqtycd)) "NULL" else if (is(pkqtycd, "subQuery")) paste0("(", as.character(pkqtycd), ")") else paste0("'", as.character(pkqtycd), "'"))

  if (missing(pksize)) {
    pksize <- defaults$pksize
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.pksize')
  }
  fields <- c(fields, "pksize")
  values <- c(values, if (is.null(pksize)) "NULL" else if (is(pksize, "subQuery")) paste0("(", as.character(pksize), ")") else paste0("'", as.character(pksize), "'"))

  if (missing(prdctds)) {
    prdctds <- defaults$prdctds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.prdctds')
  }
  fields <- c(fields, "prdctds")
  values <- c(values, if (is.null(prdctds)) "NULL" else if (is(prdctds, "subQuery")) paste0("(", as.character(prdctds), ")") else paste0("'", as.character(prdctds), "'"))

  if (missing(prodcat)) {
    prodcat <- defaults$prodcat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.prodcat')
  }
  fields <- c(fields, "prodcat")
  values <- c(values, if (is.null(prodcat)) "NULL" else if (is(prodcat, "subQuery")) paste0("(", as.character(prodcat), ")") else paste0("'", as.character(prodcat), "'"))

  if (missing(prodnme)) {
    prodnme <- defaults$prodnme
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.prodnme')
  }
  fields <- c(fields, "prodnme")
  values <- c(values, if (is.null(prodnme)) "NULL" else if (is(prodnme, "subQuery")) paste0("(", as.character(prodnme), ")") else paste0("'", as.character(prodnme), "'"))

  if (missing(siglsrc)) {
    siglsrc <- defaults$siglsrc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.siglsrc')
  }
  fields <- c(fields, "siglsrc")
  values <- c(values, if (is.null(siglsrc)) "NULL" else if (is(siglsrc, "subQuery")) paste0("(", as.character(siglsrc), ")") else paste0("'", as.character(siglsrc), "'"))

  if (missing(strngth)) {
    strngth <- defaults$strngth
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.strngth')
  }
  fields <- c(fields, "strngth")
  values <- c(values, if (is.null(strngth)) "NULL" else if (is(strngth, "subQuery")) paste0("(", as.character(strngth), ")") else paste0("'", as.character(strngth), "'"))

  if (missing(roacd)) {
    roacd <- defaults$roacd
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.roacd')
  }
  fields <- c(fields, "roacd")
  values <- c(values, if (is.null(roacd)) "NULL" else if (is(roacd, "subQuery")) paste0("(", as.character(roacd), ")") else paste0("'", as.character(roacd), "'"))

  if (missing(roads)) {
    roads <- defaults$roads
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.roads')
  }
  fields <- c(fields, "roads")
  values <- c(values, if (is.null(roads)) "NULL" else if (is(roads, "subQuery")) paste0("(", as.character(roads), ")") else paste0("'", as.character(roads), "'"))

  if (missing(thercls)) {
    thercls <- defaults$thercls
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.thercls')
  }
  fields <- c(fields, "thercls")
  values <- c(values, if (is.null(thercls)) "NULL" else if (is(thercls, "subQuery")) paste0("(", as.character(thercls), ")") else paste0("'", as.character(thercls), "'"))

  if (missing(therdtl)) {
    therdtl <- defaults$therdtl
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.therdtl')
  }
  fields <- c(fields, "therdtl")
  values <- c(values, if (is.null(therdtl)) "NULL" else if (is(therdtl, "subQuery")) paste0("(", as.character(therdtl), ")") else paste0("'", as.character(therdtl), "'"))

  if (missing(thergrp)) {
    thergrp <- defaults$thergrp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.thergrp')
  }
  fields <- c(fields, "thergrp")
  values <- c(values, if (is.null(thergrp)) "NULL" else if (is(thergrp, "subQuery")) paste0("(", as.character(thergrp), ")") else paste0("'", as.character(thergrp), "'"))

  if (missing(thrclds)) {
    thrclds <- defaults$thrclds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.thrclds')
  }
  fields <- c(fields, "thrclds")
  values <- c(values, if (is.null(thrclds)) "NULL" else if (is(thrclds, "subQuery")) paste0("(", as.character(thrclds), ")") else paste0("'", as.character(thrclds), "'"))

  if (missing(thrdtds)) {
    thrdtds <- defaults$thrdtds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.thrdtds')
  }
  fields <- c(fields, "thrdtds")
  values <- c(values, if (is.null(thrdtds)) "NULL" else if (is(thrdtds, "subQuery")) paste0("(", as.character(thrdtds), ")") else paste0("'", as.character(thrdtds), "'"))

  if (missing(thrgrds)) {
    thrgrds <- defaults$thrgrds
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.thrgrds')
  }
  fields <- c(fields, "thrgrds")
  values <- c(values, if (is.null(thrgrds)) "NULL" else if (is(thrgrds, "subQuery")) paste0("(", as.character(thrgrds), ")") else paste0("'", as.character(thrgrds), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  if (missing(deactdt)) {
    deactdt <- defaults$deactdt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.deactdt')
  }
  fields <- c(fields, "deactdt")
  values <- c(values, if (is.null(deactdt)) "NULL" else if (is(deactdt, "subQuery")) paste0("(", as.character(deactdt), ")") else paste0("'", as.character(deactdt), "'"))

  if (missing(reactdt)) {
    reactdt <- defaults$reactdt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.reactdt')
  }
  fields <- c(fields, "reactdt")
  values <- c(values, if (is.null(reactdt)) "NULL" else if (is(reactdt, "subQuery")) paste0("(", as.character(reactdt), ")") else paste0("'", as.character(reactdt), "'"))

  if (missing(actind)) {
    actind <- defaults$actind
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'red_book.actind')
  }
  fields <- c(fields, "actind")
  values <- c(values, if (is.null(actind)) "NULL" else if (is(actind, "subQuery")) paste0("(", as.character(actind), ")") else paste0("'", as.character(actind), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "red_book", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_inpatient_admissions <- function(admdate, admtyp, boe, cap, caseid, days, disdate, dobyr, drg, drugcovg, dstatus, dx1, dx10, dx11, dx12, dx13, dx14, dx15, dx2, dx3, dx4, dx5, dx6, dx7, dx8, dx9, dxver, enrolid, hosp_id, hospnet, hosppay, mas, mcasenum, mdc, medicare, mhsacovg, pddate, pdx, phys_id, physnet, physpay, plantyp, poapdx, poadx1, poadx2, poadx3, poadx4, poadx5, poadx6, poadx7, poadx8, poadx9, poadx10, poadx11, poadx12, poadx13, poadx14, poadx15, pproc, proc1, proc10, proc11, proc12, proc13, proc14, proc15, proc2, proc3, proc4, proc5, proc6, proc7, proc8, proc9, seqnum, sex, stdrace, totcob, totcoins, totcopay, totded, totnet, totpay, version, year) {
  defaults <- get('inpatient_admissions', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(admdate)) {
    admdate <- defaults$admdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.admdate')
  }
  fields <- c(fields, "admdate")
  values <- c(values, if (is.null(admdate)) "NULL" else if (is(admdate, "subQuery")) paste0("(", as.character(admdate), ")") else paste0("'", as.character(admdate), "'"))

  if (missing(admtyp)) {
    admtyp <- defaults$admtyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.admtyp')
  }
  fields <- c(fields, "admtyp")
  values <- c(values, if (is.null(admtyp)) "NULL" else if (is(admtyp, "subQuery")) paste0("(", as.character(admtyp), ")") else paste0("'", as.character(admtyp), "'"))

  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(caseid)) {
    caseid <- defaults$caseid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.caseid')
  }
  fields <- c(fields, "caseid")
  values <- c(values, if (is.null(caseid)) "NULL" else if (is(caseid, "subQuery")) paste0("(", as.character(caseid), ")") else paste0("'", as.character(caseid), "'"))

  if (missing(days)) {
    days <- defaults$days
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.days')
  }
  fields <- c(fields, "days")
  values <- c(values, if (is.null(days)) "NULL" else if (is(days, "subQuery")) paste0("(", as.character(days), ")") else paste0("'", as.character(days), "'"))

  if (missing(disdate)) {
    disdate <- defaults$disdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.disdate')
  }
  fields <- c(fields, "disdate")
  values <- c(values, if (is.null(disdate)) "NULL" else if (is(disdate, "subQuery")) paste0("(", as.character(disdate), ")") else paste0("'", as.character(disdate), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drg)) {
    drg <- defaults$drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.drg')
  }
  fields <- c(fields, "drg")
  values <- c(values, if (is.null(drg)) "NULL" else if (is(drg, "subQuery")) paste0("(", as.character(drg), ")") else paste0("'", as.character(drg), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(dstatus)) {
    dstatus <- defaults$dstatus
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dstatus')
  }
  fields <- c(fields, "dstatus")
  values <- c(values, if (is.null(dstatus)) "NULL" else if (is(dstatus, "subQuery")) paste0("(", as.character(dstatus), ")") else paste0("'", as.character(dstatus), "'"))

  if (missing(dx1)) {
    dx1 <- defaults$dx1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx1')
  }
  fields <- c(fields, "dx1")
  values <- c(values, if (is.null(dx1)) "NULL" else if (is(dx1, "subQuery")) paste0("(", as.character(dx1), ")") else paste0("'", as.character(dx1), "'"))

  if (missing(dx10)) {
    dx10 <- defaults$dx10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx10')
  }
  fields <- c(fields, "dx10")
  values <- c(values, if (is.null(dx10)) "NULL" else if (is(dx10, "subQuery")) paste0("(", as.character(dx10), ")") else paste0("'", as.character(dx10), "'"))

  if (missing(dx11)) {
    dx11 <- defaults$dx11
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx11')
  }
  fields <- c(fields, "dx11")
  values <- c(values, if (is.null(dx11)) "NULL" else if (is(dx11, "subQuery")) paste0("(", as.character(dx11), ")") else paste0("'", as.character(dx11), "'"))

  if (missing(dx12)) {
    dx12 <- defaults$dx12
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx12')
  }
  fields <- c(fields, "dx12")
  values <- c(values, if (is.null(dx12)) "NULL" else if (is(dx12, "subQuery")) paste0("(", as.character(dx12), ")") else paste0("'", as.character(dx12), "'"))

  if (missing(dx13)) {
    dx13 <- defaults$dx13
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx13')
  }
  fields <- c(fields, "dx13")
  values <- c(values, if (is.null(dx13)) "NULL" else if (is(dx13, "subQuery")) paste0("(", as.character(dx13), ")") else paste0("'", as.character(dx13), "'"))

  if (missing(dx14)) {
    dx14 <- defaults$dx14
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx14')
  }
  fields <- c(fields, "dx14")
  values <- c(values, if (is.null(dx14)) "NULL" else if (is(dx14, "subQuery")) paste0("(", as.character(dx14), ")") else paste0("'", as.character(dx14), "'"))

  if (missing(dx15)) {
    dx15 <- defaults$dx15
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx15')
  }
  fields <- c(fields, "dx15")
  values <- c(values, if (is.null(dx15)) "NULL" else if (is(dx15, "subQuery")) paste0("(", as.character(dx15), ")") else paste0("'", as.character(dx15), "'"))

  if (missing(dx2)) {
    dx2 <- defaults$dx2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx2')
  }
  fields <- c(fields, "dx2")
  values <- c(values, if (is.null(dx2)) "NULL" else if (is(dx2, "subQuery")) paste0("(", as.character(dx2), ")") else paste0("'", as.character(dx2), "'"))

  if (missing(dx3)) {
    dx3 <- defaults$dx3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx3')
  }
  fields <- c(fields, "dx3")
  values <- c(values, if (is.null(dx3)) "NULL" else if (is(dx3, "subQuery")) paste0("(", as.character(dx3), ")") else paste0("'", as.character(dx3), "'"))

  if (missing(dx4)) {
    dx4 <- defaults$dx4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx4')
  }
  fields <- c(fields, "dx4")
  values <- c(values, if (is.null(dx4)) "NULL" else if (is(dx4, "subQuery")) paste0("(", as.character(dx4), ")") else paste0("'", as.character(dx4), "'"))

  if (missing(dx5)) {
    dx5 <- defaults$dx5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx5')
  }
  fields <- c(fields, "dx5")
  values <- c(values, if (is.null(dx5)) "NULL" else if (is(dx5, "subQuery")) paste0("(", as.character(dx5), ")") else paste0("'", as.character(dx5), "'"))

  if (missing(dx6)) {
    dx6 <- defaults$dx6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx6')
  }
  fields <- c(fields, "dx6")
  values <- c(values, if (is.null(dx6)) "NULL" else if (is(dx6, "subQuery")) paste0("(", as.character(dx6), ")") else paste0("'", as.character(dx6), "'"))

  if (missing(dx7)) {
    dx7 <- defaults$dx7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx7')
  }
  fields <- c(fields, "dx7")
  values <- c(values, if (is.null(dx7)) "NULL" else if (is(dx7, "subQuery")) paste0("(", as.character(dx7), ")") else paste0("'", as.character(dx7), "'"))

  if (missing(dx8)) {
    dx8 <- defaults$dx8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx8')
  }
  fields <- c(fields, "dx8")
  values <- c(values, if (is.null(dx8)) "NULL" else if (is(dx8, "subQuery")) paste0("(", as.character(dx8), ")") else paste0("'", as.character(dx8), "'"))

  if (missing(dx9)) {
    dx9 <- defaults$dx9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dx9')
  }
  fields <- c(fields, "dx9")
  values <- c(values, if (is.null(dx9)) "NULL" else if (is(dx9, "subQuery")) paste0("(", as.character(dx9), ")") else paste0("'", as.character(dx9), "'"))

  if (missing(dxver)) {
    dxver <- defaults$dxver
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.dxver')
  }
  fields <- c(fields, "dxver")
  values <- c(values, if (is.null(dxver)) "NULL" else if (is(dxver, "subQuery")) paste0("(", as.character(dxver), ")") else paste0("'", as.character(dxver), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(hosp_id)) {
    hosp_id <- defaults$hosp_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.hosp_id')
  }
  fields <- c(fields, "hosp_id")
  values <- c(values, if (is.null(hosp_id)) "NULL" else if (is(hosp_id, "subQuery")) paste0("(", as.character(hosp_id), ")") else paste0("'", as.character(hosp_id), "'"))

  if (missing(hospnet)) {
    hospnet <- defaults$hospnet
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.hospnet')
  }
  fields <- c(fields, "hospnet")
  values <- c(values, if (is.null(hospnet)) "NULL" else if (is(hospnet, "subQuery")) paste0("(", as.character(hospnet), ")") else paste0("'", as.character(hospnet), "'"))

  if (missing(hosppay)) {
    hosppay <- defaults$hosppay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.hosppay')
  }
  fields <- c(fields, "hosppay")
  values <- c(values, if (is.null(hosppay)) "NULL" else if (is(hosppay, "subQuery")) paste0("(", as.character(hosppay), ")") else paste0("'", as.character(hosppay), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(mdc)) {
    mdc <- defaults$mdc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.mdc')
  }
  fields <- c(fields, "mdc")
  values <- c(values, if (is.null(mdc)) "NULL" else if (is(mdc, "subQuery")) paste0("(", as.character(mdc), ")") else paste0("'", as.character(mdc), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(pddate)) {
    pddate <- defaults$pddate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.pddate')
  }
  fields <- c(fields, "pddate")
  values <- c(values, if (is.null(pddate)) "NULL" else if (is(pddate, "subQuery")) paste0("(", as.character(pddate), ")") else paste0("'", as.character(pddate), "'"))

  if (missing(pdx)) {
    pdx <- defaults$pdx
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.pdx')
  }
  fields <- c(fields, "pdx")
  values <- c(values, if (is.null(pdx)) "NULL" else if (is(pdx, "subQuery")) paste0("(", as.character(pdx), ")") else paste0("'", as.character(pdx), "'"))

  if (missing(phys_id)) {
    phys_id <- defaults$phys_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.phys_id')
  }
  fields <- c(fields, "phys_id")
  values <- c(values, if (is.null(phys_id)) "NULL" else if (is(phys_id, "subQuery")) paste0("(", as.character(phys_id), ")") else paste0("'", as.character(phys_id), "'"))

  if (missing(physnet)) {
    physnet <- defaults$physnet
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.physnet')
  }
  fields <- c(fields, "physnet")
  values <- c(values, if (is.null(physnet)) "NULL" else if (is(physnet, "subQuery")) paste0("(", as.character(physnet), ")") else paste0("'", as.character(physnet), "'"))

  if (missing(physpay)) {
    physpay <- defaults$physpay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.physpay')
  }
  fields <- c(fields, "physpay")
  values <- c(values, if (is.null(physpay)) "NULL" else if (is(physpay, "subQuery")) paste0("(", as.character(physpay), ")") else paste0("'", as.character(physpay), "'"))

  if (missing(plantyp)) {
    plantyp <- defaults$plantyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.plantyp')
  }
  fields <- c(fields, "plantyp")
  values <- c(values, if (is.null(plantyp)) "NULL" else if (is(plantyp, "subQuery")) paste0("(", as.character(plantyp), ")") else paste0("'", as.character(plantyp), "'"))

  if (missing(poapdx)) {
    poapdx <- defaults$poapdx
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poapdx')
  }
  fields <- c(fields, "poapdx")
  values <- c(values, if (is.null(poapdx)) "NULL" else if (is(poapdx, "subQuery")) paste0("(", as.character(poapdx), ")") else paste0("'", as.character(poapdx), "'"))

  if (missing(poadx1)) {
    poadx1 <- defaults$poadx1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx1')
  }
  fields <- c(fields, "poadx1")
  values <- c(values, if (is.null(poadx1)) "NULL" else if (is(poadx1, "subQuery")) paste0("(", as.character(poadx1), ")") else paste0("'", as.character(poadx1), "'"))

  if (missing(poadx2)) {
    poadx2 <- defaults$poadx2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx2')
  }
  fields <- c(fields, "poadx2")
  values <- c(values, if (is.null(poadx2)) "NULL" else if (is(poadx2, "subQuery")) paste0("(", as.character(poadx2), ")") else paste0("'", as.character(poadx2), "'"))

  if (missing(poadx3)) {
    poadx3 <- defaults$poadx3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx3')
  }
  fields <- c(fields, "poadx3")
  values <- c(values, if (is.null(poadx3)) "NULL" else if (is(poadx3, "subQuery")) paste0("(", as.character(poadx3), ")") else paste0("'", as.character(poadx3), "'"))

  if (missing(poadx4)) {
    poadx4 <- defaults$poadx4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx4')
  }
  fields <- c(fields, "poadx4")
  values <- c(values, if (is.null(poadx4)) "NULL" else if (is(poadx4, "subQuery")) paste0("(", as.character(poadx4), ")") else paste0("'", as.character(poadx4), "'"))

  if (missing(poadx5)) {
    poadx5 <- defaults$poadx5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx5')
  }
  fields <- c(fields, "poadx5")
  values <- c(values, if (is.null(poadx5)) "NULL" else if (is(poadx5, "subQuery")) paste0("(", as.character(poadx5), ")") else paste0("'", as.character(poadx5), "'"))

  if (missing(poadx6)) {
    poadx6 <- defaults$poadx6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx6')
  }
  fields <- c(fields, "poadx6")
  values <- c(values, if (is.null(poadx6)) "NULL" else if (is(poadx6, "subQuery")) paste0("(", as.character(poadx6), ")") else paste0("'", as.character(poadx6), "'"))

  if (missing(poadx7)) {
    poadx7 <- defaults$poadx7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx7')
  }
  fields <- c(fields, "poadx7")
  values <- c(values, if (is.null(poadx7)) "NULL" else if (is(poadx7, "subQuery")) paste0("(", as.character(poadx7), ")") else paste0("'", as.character(poadx7), "'"))

  if (missing(poadx8)) {
    poadx8 <- defaults$poadx8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx8')
  }
  fields <- c(fields, "poadx8")
  values <- c(values, if (is.null(poadx8)) "NULL" else if (is(poadx8, "subQuery")) paste0("(", as.character(poadx8), ")") else paste0("'", as.character(poadx8), "'"))

  if (missing(poadx9)) {
    poadx9 <- defaults$poadx9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx9')
  }
  fields <- c(fields, "poadx9")
  values <- c(values, if (is.null(poadx9)) "NULL" else if (is(poadx9, "subQuery")) paste0("(", as.character(poadx9), ")") else paste0("'", as.character(poadx9), "'"))

  if (missing(poadx10)) {
    poadx10 <- defaults$poadx10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx10')
  }
  fields <- c(fields, "poadx10")
  values <- c(values, if (is.null(poadx10)) "NULL" else if (is(poadx10, "subQuery")) paste0("(", as.character(poadx10), ")") else paste0("'", as.character(poadx10), "'"))

  if (missing(poadx11)) {
    poadx11 <- defaults$poadx11
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx11')
  }
  fields <- c(fields, "poadx11")
  values <- c(values, if (is.null(poadx11)) "NULL" else if (is(poadx11, "subQuery")) paste0("(", as.character(poadx11), ")") else paste0("'", as.character(poadx11), "'"))

  if (missing(poadx12)) {
    poadx12 <- defaults$poadx12
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx12')
  }
  fields <- c(fields, "poadx12")
  values <- c(values, if (is.null(poadx12)) "NULL" else if (is(poadx12, "subQuery")) paste0("(", as.character(poadx12), ")") else paste0("'", as.character(poadx12), "'"))

  if (missing(poadx13)) {
    poadx13 <- defaults$poadx13
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx13')
  }
  fields <- c(fields, "poadx13")
  values <- c(values, if (is.null(poadx13)) "NULL" else if (is(poadx13, "subQuery")) paste0("(", as.character(poadx13), ")") else paste0("'", as.character(poadx13), "'"))

  if (missing(poadx14)) {
    poadx14 <- defaults$poadx14
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx14')
  }
  fields <- c(fields, "poadx14")
  values <- c(values, if (is.null(poadx14)) "NULL" else if (is(poadx14, "subQuery")) paste0("(", as.character(poadx14), ")") else paste0("'", as.character(poadx14), "'"))

  if (missing(poadx15)) {
    poadx15 <- defaults$poadx15
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.poadx15')
  }
  fields <- c(fields, "poadx15")
  values <- c(values, if (is.null(poadx15)) "NULL" else if (is(poadx15, "subQuery")) paste0("(", as.character(poadx15), ")") else paste0("'", as.character(poadx15), "'"))

  if (missing(pproc)) {
    pproc <- defaults$pproc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.pproc')
  }
  fields <- c(fields, "pproc")
  values <- c(values, if (is.null(pproc)) "NULL" else if (is(pproc, "subQuery")) paste0("(", as.character(pproc), ")") else paste0("'", as.character(pproc), "'"))

  if (missing(proc1)) {
    proc1 <- defaults$proc1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc1')
  }
  fields <- c(fields, "proc1")
  values <- c(values, if (is.null(proc1)) "NULL" else if (is(proc1, "subQuery")) paste0("(", as.character(proc1), ")") else paste0("'", as.character(proc1), "'"))

  if (missing(proc10)) {
    proc10 <- defaults$proc10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc10')
  }
  fields <- c(fields, "proc10")
  values <- c(values, if (is.null(proc10)) "NULL" else if (is(proc10, "subQuery")) paste0("(", as.character(proc10), ")") else paste0("'", as.character(proc10), "'"))

  if (missing(proc11)) {
    proc11 <- defaults$proc11
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc11')
  }
  fields <- c(fields, "proc11")
  values <- c(values, if (is.null(proc11)) "NULL" else if (is(proc11, "subQuery")) paste0("(", as.character(proc11), ")") else paste0("'", as.character(proc11), "'"))

  if (missing(proc12)) {
    proc12 <- defaults$proc12
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc12')
  }
  fields <- c(fields, "proc12")
  values <- c(values, if (is.null(proc12)) "NULL" else if (is(proc12, "subQuery")) paste0("(", as.character(proc12), ")") else paste0("'", as.character(proc12), "'"))

  if (missing(proc13)) {
    proc13 <- defaults$proc13
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc13')
  }
  fields <- c(fields, "proc13")
  values <- c(values, if (is.null(proc13)) "NULL" else if (is(proc13, "subQuery")) paste0("(", as.character(proc13), ")") else paste0("'", as.character(proc13), "'"))

  if (missing(proc14)) {
    proc14 <- defaults$proc14
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc14')
  }
  fields <- c(fields, "proc14")
  values <- c(values, if (is.null(proc14)) "NULL" else if (is(proc14, "subQuery")) paste0("(", as.character(proc14), ")") else paste0("'", as.character(proc14), "'"))

  if (missing(proc15)) {
    proc15 <- defaults$proc15
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc15')
  }
  fields <- c(fields, "proc15")
  values <- c(values, if (is.null(proc15)) "NULL" else if (is(proc15, "subQuery")) paste0("(", as.character(proc15), ")") else paste0("'", as.character(proc15), "'"))

  if (missing(proc2)) {
    proc2 <- defaults$proc2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc2')
  }
  fields <- c(fields, "proc2")
  values <- c(values, if (is.null(proc2)) "NULL" else if (is(proc2, "subQuery")) paste0("(", as.character(proc2), ")") else paste0("'", as.character(proc2), "'"))

  if (missing(proc3)) {
    proc3 <- defaults$proc3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc3')
  }
  fields <- c(fields, "proc3")
  values <- c(values, if (is.null(proc3)) "NULL" else if (is(proc3, "subQuery")) paste0("(", as.character(proc3), ")") else paste0("'", as.character(proc3), "'"))

  if (missing(proc4)) {
    proc4 <- defaults$proc4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc4')
  }
  fields <- c(fields, "proc4")
  values <- c(values, if (is.null(proc4)) "NULL" else if (is(proc4, "subQuery")) paste0("(", as.character(proc4), ")") else paste0("'", as.character(proc4), "'"))

  if (missing(proc5)) {
    proc5 <- defaults$proc5
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc5')
  }
  fields <- c(fields, "proc5")
  values <- c(values, if (is.null(proc5)) "NULL" else if (is(proc5, "subQuery")) paste0("(", as.character(proc5), ")") else paste0("'", as.character(proc5), "'"))

  if (missing(proc6)) {
    proc6 <- defaults$proc6
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc6')
  }
  fields <- c(fields, "proc6")
  values <- c(values, if (is.null(proc6)) "NULL" else if (is(proc6, "subQuery")) paste0("(", as.character(proc6), ")") else paste0("'", as.character(proc6), "'"))

  if (missing(proc7)) {
    proc7 <- defaults$proc7
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc7')
  }
  fields <- c(fields, "proc7")
  values <- c(values, if (is.null(proc7)) "NULL" else if (is(proc7, "subQuery")) paste0("(", as.character(proc7), ")") else paste0("'", as.character(proc7), "'"))

  if (missing(proc8)) {
    proc8 <- defaults$proc8
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc8')
  }
  fields <- c(fields, "proc8")
  values <- c(values, if (is.null(proc8)) "NULL" else if (is(proc8, "subQuery")) paste0("(", as.character(proc8), ")") else paste0("'", as.character(proc8), "'"))

  if (missing(proc9)) {
    proc9 <- defaults$proc9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.proc9')
  }
  fields <- c(fields, "proc9")
  values <- c(values, if (is.null(proc9)) "NULL" else if (is(proc9, "subQuery")) paste0("(", as.character(proc9), ")") else paste0("'", as.character(proc9), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(totcob)) {
    totcob <- defaults$totcob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.totcob')
  }
  fields <- c(fields, "totcob")
  values <- c(values, if (is.null(totcob)) "NULL" else if (is(totcob, "subQuery")) paste0("(", as.character(totcob), ")") else paste0("'", as.character(totcob), "'"))

  if (missing(totcoins)) {
    totcoins <- defaults$totcoins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.totcoins')
  }
  fields <- c(fields, "totcoins")
  values <- c(values, if (is.null(totcoins)) "NULL" else if (is(totcoins, "subQuery")) paste0("(", as.character(totcoins), ")") else paste0("'", as.character(totcoins), "'"))

  if (missing(totcopay)) {
    totcopay <- defaults$totcopay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.totcopay')
  }
  fields <- c(fields, "totcopay")
  values <- c(values, if (is.null(totcopay)) "NULL" else if (is(totcopay, "subQuery")) paste0("(", as.character(totcopay), ")") else paste0("'", as.character(totcopay), "'"))

  if (missing(totded)) {
    totded <- defaults$totded
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.totded')
  }
  fields <- c(fields, "totded")
  values <- c(values, if (is.null(totded)) "NULL" else if (is(totded, "subQuery")) paste0("(", as.character(totded), ")") else paste0("'", as.character(totded), "'"))

  if (missing(totnet)) {
    totnet <- defaults$totnet
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.totnet')
  }
  fields <- c(fields, "totnet")
  values <- c(values, if (is.null(totnet)) "NULL" else if (is(totnet, "subQuery")) paste0("(", as.character(totnet), ")") else paste0("'", as.character(totnet), "'"))

  if (missing(totpay)) {
    totpay <- defaults$totpay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.totpay')
  }
  fields <- c(fields, "totpay")
  values <- c(values, if (is.null(totpay)) "NULL" else if (is(totpay, "subQuery")) paste0("(", as.character(totpay), ")") else paste0("'", as.character(totpay), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_admissions.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "inpatient_admissions", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_inpatient_services <- function(admdate, admtyp, boe, cap, caseid, cob, coins, copay, deduct, disdate, dobyr, drg, drugcovg, dstatus, dx1, dx2, dx3, dx4, dxver, enrolid, fachdid, facprof, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pay, pddate, pdx, plantyp, pproc, proc1, proctyp, prov_id, qty, revcode, seqnum, sex, stdplac, stdprov, stdrace, stdsvc, svcdate, svcscat, tsvcdat, version, year, units, npi, msclmid, procmod) {
  defaults <- get('inpatient_services', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(admdate)) {
    admdate <- defaults$admdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.admdate')
  }
  fields <- c(fields, "admdate")
  values <- c(values, if (is.null(admdate)) "NULL" else if (is(admdate, "subQuery")) paste0("(", as.character(admdate), ")") else paste0("'", as.character(admdate), "'"))

  if (missing(admtyp)) {
    admtyp <- defaults$admtyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.admtyp')
  }
  fields <- c(fields, "admtyp")
  values <- c(values, if (is.null(admtyp)) "NULL" else if (is(admtyp, "subQuery")) paste0("(", as.character(admtyp), ")") else paste0("'", as.character(admtyp), "'"))

  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(caseid)) {
    caseid <- defaults$caseid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.caseid')
  }
  fields <- c(fields, "caseid")
  values <- c(values, if (is.null(caseid)) "NULL" else if (is(caseid, "subQuery")) paste0("(", as.character(caseid), ")") else paste0("'", as.character(caseid), "'"))

  if (missing(cob)) {
    cob <- defaults$cob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.cob')
  }
  fields <- c(fields, "cob")
  values <- c(values, if (is.null(cob)) "NULL" else if (is(cob, "subQuery")) paste0("(", as.character(cob), ")") else paste0("'", as.character(cob), "'"))

  if (missing(coins)) {
    coins <- defaults$coins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.coins')
  }
  fields <- c(fields, "coins")
  values <- c(values, if (is.null(coins)) "NULL" else if (is(coins, "subQuery")) paste0("(", as.character(coins), ")") else paste0("'", as.character(coins), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(disdate)) {
    disdate <- defaults$disdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.disdate')
  }
  fields <- c(fields, "disdate")
  values <- c(values, if (is.null(disdate)) "NULL" else if (is(disdate, "subQuery")) paste0("(", as.character(disdate), ")") else paste0("'", as.character(disdate), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drg)) {
    drg <- defaults$drg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.drg')
  }
  fields <- c(fields, "drg")
  values <- c(values, if (is.null(drg)) "NULL" else if (is(drg, "subQuery")) paste0("(", as.character(drg), ")") else paste0("'", as.character(drg), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(dstatus)) {
    dstatus <- defaults$dstatus
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.dstatus')
  }
  fields <- c(fields, "dstatus")
  values <- c(values, if (is.null(dstatus)) "NULL" else if (is(dstatus, "subQuery")) paste0("(", as.character(dstatus), ")") else paste0("'", as.character(dstatus), "'"))

  if (missing(dx1)) {
    dx1 <- defaults$dx1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.dx1')
  }
  fields <- c(fields, "dx1")
  values <- c(values, if (is.null(dx1)) "NULL" else if (is(dx1, "subQuery")) paste0("(", as.character(dx1), ")") else paste0("'", as.character(dx1), "'"))

  if (missing(dx2)) {
    dx2 <- defaults$dx2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.dx2')
  }
  fields <- c(fields, "dx2")
  values <- c(values, if (is.null(dx2)) "NULL" else if (is(dx2, "subQuery")) paste0("(", as.character(dx2), ")") else paste0("'", as.character(dx2), "'"))

  if (missing(dx3)) {
    dx3 <- defaults$dx3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.dx3')
  }
  fields <- c(fields, "dx3")
  values <- c(values, if (is.null(dx3)) "NULL" else if (is(dx3, "subQuery")) paste0("(", as.character(dx3), ")") else paste0("'", as.character(dx3), "'"))

  if (missing(dx4)) {
    dx4 <- defaults$dx4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.dx4')
  }
  fields <- c(fields, "dx4")
  values <- c(values, if (is.null(dx4)) "NULL" else if (is(dx4, "subQuery")) paste0("(", as.character(dx4), ")") else paste0("'", as.character(dx4), "'"))

  if (missing(dxver)) {
    dxver <- defaults$dxver
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.dxver')
  }
  fields <- c(fields, "dxver")
  values <- c(values, if (is.null(dxver)) "NULL" else if (is(dxver, "subQuery")) paste0("(", as.character(dxver), ")") else paste0("'", as.character(dxver), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(fachdid)) {
    fachdid <- defaults$fachdid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.fachdid')
  }
  fields <- c(fields, "fachdid")
  values <- c(values, if (is.null(fachdid)) "NULL" else if (is(fachdid, "subQuery")) paste0("(", as.character(fachdid), ")") else paste0("'", as.character(fachdid), "'"))

  if (missing(facprof)) {
    facprof <- defaults$facprof
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.facprof')
  }
  fields <- c(fields, "facprof")
  values <- c(values, if (is.null(facprof)) "NULL" else if (is(facprof, "subQuery")) paste0("(", as.character(facprof), ")") else paste0("'", as.character(facprof), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(mdc)) {
    mdc <- defaults$mdc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.mdc')
  }
  fields <- c(fields, "mdc")
  values <- c(values, if (is.null(mdc)) "NULL" else if (is(mdc, "subQuery")) paste0("(", as.character(mdc), ")") else paste0("'", as.character(mdc), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(netpay)) {
    netpay <- defaults$netpay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.netpay')
  }
  fields <- c(fields, "netpay")
  values <- c(values, if (is.null(netpay)) "NULL" else if (is(netpay, "subQuery")) paste0("(", as.character(netpay), ")") else paste0("'", as.character(netpay), "'"))

  if (missing(pay)) {
    pay <- defaults$pay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.pay')
  }
  fields <- c(fields, "pay")
  values <- c(values, if (is.null(pay)) "NULL" else if (is(pay, "subQuery")) paste0("(", as.character(pay), ")") else paste0("'", as.character(pay), "'"))

  if (missing(pddate)) {
    pddate <- defaults$pddate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.pddate')
  }
  fields <- c(fields, "pddate")
  values <- c(values, if (is.null(pddate)) "NULL" else if (is(pddate, "subQuery")) paste0("(", as.character(pddate), ")") else paste0("'", as.character(pddate), "'"))

  if (missing(pdx)) {
    pdx <- defaults$pdx
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.pdx')
  }
  fields <- c(fields, "pdx")
  values <- c(values, if (is.null(pdx)) "NULL" else if (is(pdx, "subQuery")) paste0("(", as.character(pdx), ")") else paste0("'", as.character(pdx), "'"))

  if (missing(plantyp)) {
    plantyp <- defaults$plantyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.plantyp')
  }
  fields <- c(fields, "plantyp")
  values <- c(values, if (is.null(plantyp)) "NULL" else if (is(plantyp, "subQuery")) paste0("(", as.character(plantyp), ")") else paste0("'", as.character(plantyp), "'"))

  if (missing(pproc)) {
    pproc <- defaults$pproc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.pproc')
  }
  fields <- c(fields, "pproc")
  values <- c(values, if (is.null(pproc)) "NULL" else if (is(pproc, "subQuery")) paste0("(", as.character(pproc), ")") else paste0("'", as.character(pproc), "'"))

  if (missing(proc1)) {
    proc1 <- defaults$proc1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.proc1')
  }
  fields <- c(fields, "proc1")
  values <- c(values, if (is.null(proc1)) "NULL" else if (is(proc1, "subQuery")) paste0("(", as.character(proc1), ")") else paste0("'", as.character(proc1), "'"))

  if (missing(proctyp)) {
    proctyp <- defaults$proctyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.proctyp')
  }
  fields <- c(fields, "proctyp")
  values <- c(values, if (is.null(proctyp)) "NULL" else if (is(proctyp, "subQuery")) paste0("(", as.character(proctyp), ")") else paste0("'", as.character(proctyp), "'"))

  if (missing(prov_id)) {
    prov_id <- defaults$prov_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.prov_id')
  }
  fields <- c(fields, "prov_id")
  values <- c(values, if (is.null(prov_id)) "NULL" else if (is(prov_id, "subQuery")) paste0("(", as.character(prov_id), ")") else paste0("'", as.character(prov_id), "'"))

  if (missing(qty)) {
    qty <- defaults$qty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.qty')
  }
  fields <- c(fields, "qty")
  values <- c(values, if (is.null(qty)) "NULL" else if (is(qty, "subQuery")) paste0("(", as.character(qty), ")") else paste0("'", as.character(qty), "'"))

  if (missing(revcode)) {
    revcode <- defaults$revcode
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.revcode')
  }
  fields <- c(fields, "revcode")
  values <- c(values, if (is.null(revcode)) "NULL" else if (is(revcode, "subQuery")) paste0("(", as.character(revcode), ")") else paste0("'", as.character(revcode), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdplac)) {
    stdplac <- defaults$stdplac
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.stdplac')
  }
  fields <- c(fields, "stdplac")
  values <- c(values, if (is.null(stdplac)) "NULL" else if (is(stdplac, "subQuery")) paste0("(", as.character(stdplac), ")") else paste0("'", as.character(stdplac), "'"))

  if (missing(stdprov)) {
    stdprov <- defaults$stdprov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.stdprov')
  }
  fields <- c(fields, "stdprov")
  values <- c(values, if (is.null(stdprov)) "NULL" else if (is(stdprov, "subQuery")) paste0("(", as.character(stdprov), ")") else paste0("'", as.character(stdprov), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(stdsvc)) {
    stdsvc <- defaults$stdsvc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.stdsvc')
  }
  fields <- c(fields, "stdsvc")
  values <- c(values, if (is.null(stdsvc)) "NULL" else if (is(stdsvc, "subQuery")) paste0("(", as.character(stdsvc), ")") else paste0("'", as.character(stdsvc), "'"))

  if (missing(svcdate)) {
    svcdate <- defaults$svcdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.svcdate')
  }
  fields <- c(fields, "svcdate")
  values <- c(values, if (is.null(svcdate)) "NULL" else if (is(svcdate, "subQuery")) paste0("(", as.character(svcdate), ")") else paste0("'", as.character(svcdate), "'"))

  if (missing(svcscat)) {
    svcscat <- defaults$svcscat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.svcscat')
  }
  fields <- c(fields, "svcscat")
  values <- c(values, if (is.null(svcscat)) "NULL" else if (is(svcscat, "subQuery")) paste0("(", as.character(svcscat), ")") else paste0("'", as.character(svcscat), "'"))

  if (missing(tsvcdat)) {
    tsvcdat <- defaults$tsvcdat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.tsvcdat')
  }
  fields <- c(fields, "tsvcdat")
  values <- c(values, if (is.null(tsvcdat)) "NULL" else if (is(tsvcdat, "subQuery")) paste0("(", as.character(tsvcdat), ")") else paste0("'", as.character(tsvcdat), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  if (missing(units)) {
    units <- defaults$units
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.units')
  }
  fields <- c(fields, "units")
  values <- c(values, if (is.null(units)) "NULL" else if (is(units, "subQuery")) paste0("(", as.character(units), ")") else paste0("'", as.character(units), "'"))

  if (missing(npi)) {
    npi <- defaults$npi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.npi')
  }
  fields <- c(fields, "npi")
  values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))

  if (missing(msclmid)) {
    msclmid <- defaults$msclmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.msclmid')
  }
  fields <- c(fields, "msclmid")
  values <- c(values, if (is.null(msclmid)) "NULL" else if (is(msclmid, "subQuery")) paste0("(", as.character(msclmid), ")") else paste0("'", as.character(msclmid), "'"))

  if (missing(procmod)) {
    procmod <- defaults$procmod
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'inpatient_services.procmod')
  }
  fields <- c(fields, "procmod")
  values <- c(values, if (is.null(procmod)) "NULL" else if (is(procmod, "subQuery")) paste0("(", as.character(procmod), ")") else paste0("'", as.character(procmod), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "inpatient_services", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_pos_episode_visit <- function(episode_id, enrolid, dt_start, dt_end, visit_type) {
  defaults <- get('pos_episode_visit', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(episode_id)) {
    episode_id <- defaults$episode_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pos_episode_visit.episode_id')
  }
  fields <- c(fields, "episode_id")
  values <- c(values, if (is.null(episode_id)) "NULL" else if (is(episode_id, "subQuery")) paste0("(", as.character(episode_id), ")") else paste0("'", as.character(episode_id), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pos_episode_visit.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(dt_start)) {
    dt_start <- defaults$dt_start
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pos_episode_visit.dt_start')
  }
  fields <- c(fields, "dt_start")
  values <- c(values, if (is.null(dt_start)) "NULL" else if (is(dt_start, "subQuery")) paste0("(", as.character(dt_start), ")") else paste0("'", as.character(dt_start), "'"))

  if (missing(dt_end)) {
    dt_end <- defaults$dt_end
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pos_episode_visit.dt_end')
  }
  fields <- c(fields, "dt_end")
  values <- c(values, if (is.null(dt_end)) "NULL" else if (is(dt_end, "subQuery")) paste0("(", as.character(dt_end), ")") else paste0("'", as.character(dt_end), "'"))

  if (missing(visit_type)) {
    visit_type <- defaults$visit_type
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'pos_episode_visit.visit_type')
  }
  fields <- c(fields, "visit_type")
  values <- c(values, if (is.null(visit_type)) "NULL" else if (is(visit_type, "subQuery")) paste0("(", as.character(visit_type), ")") else paste0("'", as.character(visit_type), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "_pos_episode_visit", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_long_term_care <- function(boe, cap, cob, coins, copay, deduct, dobyr, drugcovg, dx1, dx2, dx3, dx4, dxver, enrolid, fachdid, facprof, mas, mcasenum, mdc, medicare, mhsacovg, netpay, pay, pddate, plantyp, proc1, procgrp, proctyp, prov_id, qty, revcode, seqnum, sex, stdplac, stdprov, stdrace, stdsvc, svcdate, svcscat, tsvcdat, version, year, units, npi, msclmid, procmod) {
  defaults <- get('long_term_care', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(boe)) {
    boe <- defaults$boe
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.boe')
  }
  fields <- c(fields, "boe")
  values <- c(values, if (is.null(boe)) "NULL" else if (is(boe, "subQuery")) paste0("(", as.character(boe), ")") else paste0("'", as.character(boe), "'"))

  if (missing(cap)) {
    cap <- defaults$cap
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.cap')
  }
  fields <- c(fields, "cap")
  values <- c(values, if (is.null(cap)) "NULL" else if (is(cap, "subQuery")) paste0("(", as.character(cap), ")") else paste0("'", as.character(cap), "'"))

  if (missing(cob)) {
    cob <- defaults$cob
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.cob')
  }
  fields <- c(fields, "cob")
  values <- c(values, if (is.null(cob)) "NULL" else if (is(cob, "subQuery")) paste0("(", as.character(cob), ")") else paste0("'", as.character(cob), "'"))

  if (missing(coins)) {
    coins <- defaults$coins
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.coins')
  }
  fields <- c(fields, "coins")
  values <- c(values, if (is.null(coins)) "NULL" else if (is(coins, "subQuery")) paste0("(", as.character(coins), ")") else paste0("'", as.character(coins), "'"))

  if (missing(copay)) {
    copay <- defaults$copay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.copay')
  }
  fields <- c(fields, "copay")
  values <- c(values, if (is.null(copay)) "NULL" else if (is(copay, "subQuery")) paste0("(", as.character(copay), ")") else paste0("'", as.character(copay), "'"))

  if (missing(deduct)) {
    deduct <- defaults$deduct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.deduct')
  }
  fields <- c(fields, "deduct")
  values <- c(values, if (is.null(deduct)) "NULL" else if (is(deduct, "subQuery")) paste0("(", as.character(deduct), ")") else paste0("'", as.character(deduct), "'"))

  if (missing(dobyr)) {
    dobyr <- defaults$dobyr
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.dobyr')
  }
  fields <- c(fields, "dobyr")
  values <- c(values, if (is.null(dobyr)) "NULL" else if (is(dobyr, "subQuery")) paste0("(", as.character(dobyr), ")") else paste0("'", as.character(dobyr), "'"))

  if (missing(drugcovg)) {
    drugcovg <- defaults$drugcovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.drugcovg')
  }
  fields <- c(fields, "drugcovg")
  values <- c(values, if (is.null(drugcovg)) "NULL" else if (is(drugcovg, "subQuery")) paste0("(", as.character(drugcovg), ")") else paste0("'", as.character(drugcovg), "'"))

  if (missing(dx1)) {
    dx1 <- defaults$dx1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.dx1')
  }
  fields <- c(fields, "dx1")
  values <- c(values, if (is.null(dx1)) "NULL" else if (is(dx1, "subQuery")) paste0("(", as.character(dx1), ")") else paste0("'", as.character(dx1), "'"))

  if (missing(dx2)) {
    dx2 <- defaults$dx2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.dx2')
  }
  fields <- c(fields, "dx2")
  values <- c(values, if (is.null(dx2)) "NULL" else if (is(dx2, "subQuery")) paste0("(", as.character(dx2), ")") else paste0("'", as.character(dx2), "'"))

  if (missing(dx3)) {
    dx3 <- defaults$dx3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.dx3')
  }
  fields <- c(fields, "dx3")
  values <- c(values, if (is.null(dx3)) "NULL" else if (is(dx3, "subQuery")) paste0("(", as.character(dx3), ")") else paste0("'", as.character(dx3), "'"))

  if (missing(dx4)) {
    dx4 <- defaults$dx4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.dx4')
  }
  fields <- c(fields, "dx4")
  values <- c(values, if (is.null(dx4)) "NULL" else if (is(dx4, "subQuery")) paste0("(", as.character(dx4), ")") else paste0("'", as.character(dx4), "'"))

  if (missing(dxver)) {
    dxver <- defaults$dxver
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.dxver')
  }
  fields <- c(fields, "dxver")
  values <- c(values, if (is.null(dxver)) "NULL" else if (is(dxver, "subQuery")) paste0("(", as.character(dxver), ")") else paste0("'", as.character(dxver), "'"))

  if (missing(enrolid)) {
    enrolid <- defaults$enrolid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.enrolid')
  }
  fields <- c(fields, "enrolid")
  values <- c(values, if (is.null(enrolid)) "NULL" else if (is(enrolid, "subQuery")) paste0("(", as.character(enrolid), ")") else paste0("'", as.character(enrolid), "'"))

  if (missing(fachdid)) {
    fachdid <- defaults$fachdid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.fachdid')
  }
  fields <- c(fields, "fachdid")
  values <- c(values, if (is.null(fachdid)) "NULL" else if (is(fachdid, "subQuery")) paste0("(", as.character(fachdid), ")") else paste0("'", as.character(fachdid), "'"))

  if (missing(facprof)) {
    facprof <- defaults$facprof
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.facprof')
  }
  fields <- c(fields, "facprof")
  values <- c(values, if (is.null(facprof)) "NULL" else if (is(facprof, "subQuery")) paste0("(", as.character(facprof), ")") else paste0("'", as.character(facprof), "'"))

  if (missing(mas)) {
    mas <- defaults$mas
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.mas')
  }
  fields <- c(fields, "mas")
  values <- c(values, if (is.null(mas)) "NULL" else if (is(mas, "subQuery")) paste0("(", as.character(mas), ")") else paste0("'", as.character(mas), "'"))

  if (missing(mcasenum)) {
    mcasenum <- defaults$mcasenum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.mcasenum')
  }
  fields <- c(fields, "mcasenum")
  values <- c(values, if (is.null(mcasenum)) "NULL" else if (is(mcasenum, "subQuery")) paste0("(", as.character(mcasenum), ")") else paste0("'", as.character(mcasenum), "'"))

  if (missing(mdc)) {
    mdc <- defaults$mdc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.mdc')
  }
  fields <- c(fields, "mdc")
  values <- c(values, if (is.null(mdc)) "NULL" else if (is(mdc, "subQuery")) paste0("(", as.character(mdc), ")") else paste0("'", as.character(mdc), "'"))

  if (missing(medicare)) {
    medicare <- defaults$medicare
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.medicare')
  }
  fields <- c(fields, "medicare")
  values <- c(values, if (is.null(medicare)) "NULL" else if (is(medicare, "subQuery")) paste0("(", as.character(medicare), ")") else paste0("'", as.character(medicare), "'"))

  if (missing(mhsacovg)) {
    mhsacovg <- defaults$mhsacovg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.mhsacovg')
  }
  fields <- c(fields, "mhsacovg")
  values <- c(values, if (is.null(mhsacovg)) "NULL" else if (is(mhsacovg, "subQuery")) paste0("(", as.character(mhsacovg), ")") else paste0("'", as.character(mhsacovg), "'"))

  if (missing(netpay)) {
    netpay <- defaults$netpay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.netpay')
  }
  fields <- c(fields, "netpay")
  values <- c(values, if (is.null(netpay)) "NULL" else if (is(netpay, "subQuery")) paste0("(", as.character(netpay), ")") else paste0("'", as.character(netpay), "'"))

  if (missing(pay)) {
    pay <- defaults$pay
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.pay')
  }
  fields <- c(fields, "pay")
  values <- c(values, if (is.null(pay)) "NULL" else if (is(pay, "subQuery")) paste0("(", as.character(pay), ")") else paste0("'", as.character(pay), "'"))

  if (missing(pddate)) {
    pddate <- defaults$pddate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.pddate')
  }
  fields <- c(fields, "pddate")
  values <- c(values, if (is.null(pddate)) "NULL" else if (is(pddate, "subQuery")) paste0("(", as.character(pddate), ")") else paste0("'", as.character(pddate), "'"))

  if (missing(plantyp)) {
    plantyp <- defaults$plantyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.plantyp')
  }
  fields <- c(fields, "plantyp")
  values <- c(values, if (is.null(plantyp)) "NULL" else if (is(plantyp, "subQuery")) paste0("(", as.character(plantyp), ")") else paste0("'", as.character(plantyp), "'"))

  if (missing(proc1)) {
    proc1 <- defaults$proc1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.proc1')
  }
  fields <- c(fields, "proc1")
  values <- c(values, if (is.null(proc1)) "NULL" else if (is(proc1, "subQuery")) paste0("(", as.character(proc1), ")") else paste0("'", as.character(proc1), "'"))

  if (missing(procgrp)) {
    procgrp <- defaults$procgrp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.procgrp')
  }
  fields <- c(fields, "procgrp")
  values <- c(values, if (is.null(procgrp)) "NULL" else if (is(procgrp, "subQuery")) paste0("(", as.character(procgrp), ")") else paste0("'", as.character(procgrp), "'"))

  if (missing(proctyp)) {
    proctyp <- defaults$proctyp
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.proctyp')
  }
  fields <- c(fields, "proctyp")
  values <- c(values, if (is.null(proctyp)) "NULL" else if (is(proctyp, "subQuery")) paste0("(", as.character(proctyp), ")") else paste0("'", as.character(proctyp), "'"))

  if (missing(prov_id)) {
    prov_id <- defaults$prov_id
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.prov_id')
  }
  fields <- c(fields, "prov_id")
  values <- c(values, if (is.null(prov_id)) "NULL" else if (is(prov_id, "subQuery")) paste0("(", as.character(prov_id), ")") else paste0("'", as.character(prov_id), "'"))

  if (missing(qty)) {
    qty <- defaults$qty
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.qty')
  }
  fields <- c(fields, "qty")
  values <- c(values, if (is.null(qty)) "NULL" else if (is(qty, "subQuery")) paste0("(", as.character(qty), ")") else paste0("'", as.character(qty), "'"))

  if (missing(revcode)) {
    revcode <- defaults$revcode
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.revcode')
  }
  fields <- c(fields, "revcode")
  values <- c(values, if (is.null(revcode)) "NULL" else if (is(revcode, "subQuery")) paste0("(", as.character(revcode), ")") else paste0("'", as.character(revcode), "'"))

  if (missing(seqnum)) {
    seqnum <- defaults$seqnum
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.seqnum')
  }
  fields <- c(fields, "seqnum")
  values <- c(values, if (is.null(seqnum)) "NULL" else if (is(seqnum, "subQuery")) paste0("(", as.character(seqnum), ")") else paste0("'", as.character(seqnum), "'"))

  if (missing(sex)) {
    sex <- defaults$sex
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.sex')
  }
  fields <- c(fields, "sex")
  values <- c(values, if (is.null(sex)) "NULL" else if (is(sex, "subQuery")) paste0("(", as.character(sex), ")") else paste0("'", as.character(sex), "'"))

  if (missing(stdplac)) {
    stdplac <- defaults$stdplac
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.stdplac')
  }
  fields <- c(fields, "stdplac")
  values <- c(values, if (is.null(stdplac)) "NULL" else if (is(stdplac, "subQuery")) paste0("(", as.character(stdplac), ")") else paste0("'", as.character(stdplac), "'"))

  if (missing(stdprov)) {
    stdprov <- defaults$stdprov
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.stdprov')
  }
  fields <- c(fields, "stdprov")
  values <- c(values, if (is.null(stdprov)) "NULL" else if (is(stdprov, "subQuery")) paste0("(", as.character(stdprov), ")") else paste0("'", as.character(stdprov), "'"))

  if (missing(stdrace)) {
    stdrace <- defaults$stdrace
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.stdrace')
  }
  fields <- c(fields, "stdrace")
  values <- c(values, if (is.null(stdrace)) "NULL" else if (is(stdrace, "subQuery")) paste0("(", as.character(stdrace), ")") else paste0("'", as.character(stdrace), "'"))

  if (missing(stdsvc)) {
    stdsvc <- defaults$stdsvc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.stdsvc')
  }
  fields <- c(fields, "stdsvc")
  values <- c(values, if (is.null(stdsvc)) "NULL" else if (is(stdsvc, "subQuery")) paste0("(", as.character(stdsvc), ")") else paste0("'", as.character(stdsvc), "'"))

  if (missing(svcdate)) {
    svcdate <- defaults$svcdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.svcdate')
  }
  fields <- c(fields, "svcdate")
  values <- c(values, if (is.null(svcdate)) "NULL" else if (is(svcdate, "subQuery")) paste0("(", as.character(svcdate), ")") else paste0("'", as.character(svcdate), "'"))

  if (missing(svcscat)) {
    svcscat <- defaults$svcscat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.svcscat')
  }
  fields <- c(fields, "svcscat")
  values <- c(values, if (is.null(svcscat)) "NULL" else if (is(svcscat, "subQuery")) paste0("(", as.character(svcscat), ")") else paste0("'", as.character(svcscat), "'"))

  if (missing(tsvcdat)) {
    tsvcdat <- defaults$tsvcdat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.tsvcdat')
  }
  fields <- c(fields, "tsvcdat")
  values <- c(values, if (is.null(tsvcdat)) "NULL" else if (is(tsvcdat, "subQuery")) paste0("(", as.character(tsvcdat), ")") else paste0("'", as.character(tsvcdat), "'"))

  if (missing(version)) {
    version <- defaults$version
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.version')
  }
  fields <- c(fields, "version")
  values <- c(values, if (is.null(version)) "NULL" else if (is(version, "subQuery")) paste0("(", as.character(version), ")") else paste0("'", as.character(version), "'"))

  if (missing(year)) {
    year <- defaults$year
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.year')
  }
  fields <- c(fields, "year")
  values <- c(values, if (is.null(year)) "NULL" else if (is(year, "subQuery")) paste0("(", as.character(year), ")") else paste0("'", as.character(year), "'"))

  if (missing(units)) {
    units <- defaults$units
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.units')
  }
  fields <- c(fields, "units")
  values <- c(values, if (is.null(units)) "NULL" else if (is(units, "subQuery")) paste0("(", as.character(units), ")") else paste0("'", as.character(units), "'"))

  if (missing(npi)) {
    npi <- defaults$npi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.npi')
  }
  fields <- c(fields, "npi")
  values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))

  if (missing(msclmid)) {
    msclmid <- defaults$msclmid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.msclmid')
  }
  fields <- c(fields, "msclmid")
  values <- c(values, if (is.null(msclmid)) "NULL" else if (is(msclmid, "subQuery")) paste0("(", as.character(msclmid), ")") else paste0("'", as.character(msclmid), "'"))

  if (missing(procmod)) {
    procmod <- defaults$procmod
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'long_term_care.procmod')
  }
  fields <- c(fields, "procmod")
  values <- c(values, if (is.null(procmod)) "NULL" else if (is(procmod, "subQuery")) paste0("(", as.character(procmod), ")") else paste0("'", as.character(procmod), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "long_term_care", fields = fields, values = values)
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
    fields <- c(fields, "offset")
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
    fields <- c(fields, "offset")
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
    fields <- c(fields, "offset")
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
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.icd9;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.enrollment_summary;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema._version;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.drug_claims;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.facility_header;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.enrollment_detail;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.outpatient_services;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.red_book;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.inpatient_admissions;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.inpatient_services;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema._pos_episode_visit;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.long_term_care;")
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

