#Use this to set pertinent default values for the test cases
#' @export
setDefaults <- function (){
  set_defaults_drug_claims(metqty = '0', daysupp = '30')
  set_defaults_inpatient_admissions(admdate = '2012-01-01', disdate = '2012-12-31', year = '2012', proc2 = NULL)
  
  
  if (tolower(frameworkType) == "mdcd")
  {
    set_defaults_enrollment_detail(drugcovg = '1')
  }
  
  if (tolower(frameworkType) == "ccae")
  {
    set_defaults_enrollment_detail(indstry = '1')
    set_defaults_enrollment_detail(efamid = '0')
    
    set_defaults_enrollment_detail(wgtkey = '0')
    set_defaults_enrollment_detail(seqnum = '0')
    set_defaults_enrollment_detail(plankey = '0')
    set_defaults_facility_header(stdprov = '0')
    
    set_defaults_inpatient_services(
      flag = 0, 
      admdate = '2024-11-28', 
      admtyp = 'A', 
      age = 35, 
      agegrp = 'B', 
      cap_svc = 'N', 
      caseid = 123456, 
      cob = 100.50, 
      coins = 50.25, 
      copay = 20.75, 
      datatyp = 1, 
      deduct = 0.0, 
      disdate = '2024-12-01', 
      dobyr = 1989, 
      drg = 123, 
      dstatus = '01', 
      dx1 = 'A12345', 
      dx2 = 'B67890', 
      dx3 = 'C12345', 
      dx4 = 'D67890', 
      dx5 = 'E12345', 
      dxver = '9', 
      eeclass = 'N', 
      eestatu = 'E', 
      efamid = 789012, 
      egeoloc = 'NY', 
      eidflag = 'Y', 
      emprel = 'S', 
      enrflag = 'N', 
      enrolid = 1234567890, 
      fachdid = 9876543210, 
      facprof = 'P', 
      hlthplan = 'H', 
      indstry = 'M', 
      mdc = '01', 
      mhsacovg = 'Y', 
      msa = 100, 
      netpay = 1500.75, 
      ntwkprov = 'N', 
      paidntwk = 'N', 
      pay = 2000.00, 
      pddate = '2024-12-15', 
      pdx = 'F12345', 
      phyflag = 'Y', 
      plankey = 99, 
      plantyp = 2, 
      pproc = 'G12345', 
      proc1 = 'H67890', 
      procmod = '01', 
      proctyp = 'I', 
      provid = 555555, 
      qty = 10, 
      region = 'R', 
      revcode = '0123', 
      rx = 'Y', 
      seqnum = 9876543210, 
      sex = 'M', 
      stdplac = 12, 
      stdprov = 456, 
      svcdate = '2024-11-15', 
      svcscat = 'X9999', 
      tsvcdat = '2024-11-28', 
      version = '01', 
      wgtkey = 100, 
      year = 2024, 
      units = 2.5, 
      npi = '1234567890', 
      msclmid = 678901, 
      medadv = 'abc'
    )
    
    set_defaults_outpatient_services(
      flag = 0, 
      age = 30, 
      agegrp = 'A', 
      cap_svc = 'N', 
      cob = 100.00, 
      coins = 50.00, 
      copay = 25.00, 
      datatyp = 2, 
      deduct = 0.0, 
      dobyr = 1993, 
      dx1 = 'A11111', 
      dx2 = 'B22222', 
      dx3 = 'C33333', 
      dx4 = 'D44444', 
      dx5 = 'E55555', 
      dxver = '9', 
      eeclass = 'C', 
      eestatu = 'E', 
      efamid = 12345, 
      egeoloc = 'CA', 
      eidflag = 'Y', 
      emprel = 'S', 
      enrflag = 'N', 
      enrolid = 9876543210, 
      fachdid = 1234567890, 
      facprof = 'P', 
      hlthplan = 'H', 
      indstry = 'M', 
      mdc = '02', 
      mhsacovg = 'Y', 
      msa = 101, 
      netpay = 200.00, 
      ntwkprov = 'N', 
      paidntwk = 'N', 
      pay = 300.00, 
      pddate = '2024-11-28', 
      phyflag = 'Y', 
      plankey = 55, 
      plantyp = 3, 
      proc1 = 'P12345', 
      procgrp = 12, 
      procmod = '01', 
      proctyp = 'R', 
      provid = 789456, 
      qty = 1, 
      region = 'N', 
      revcode = '9999', 
      rx = 'N', 
      seqnum = 1122334455, 
      sex = 'F', 
      stdplac = 7, 
      stdprov = 66, 
      svcdate = '2024-11-27', 
      svcscat = 'S1234', 
      tsvcdat = '2024-11-28', 
      version = '01', 
      wgtkey = 100, 
      year = 2024, 
      units = 2.0, 
      npi = '1234567890', 
      msclmid = 987654, 
      medadv = 'abc'
    )
    
  }
}