createDeathTests <- function()
{
    if (tolower(frameworkType) == "dod")
    {
		patient <- createPatient()
		claim <- createClaim()
		declareTest("DEATH - Patient has valid death record", id = patient$person_id)
		add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
						  gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
        add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')						  
		add_death(patid = patient$patid, ymdod = '201307', extract_ym = '201606', version = '6.0')
	    expect_death(person_id = patient$person_id, death_date = '2013-07-31')
		
		
		patient <- createPatient()
		claim <- createClaim()
		declareTest("DEATH - Patient has invalid death record after DOB", id = patient$person_id)
		add_member_continuous_enrollment(eligeff = '2015-04-01', eligend = '2015-05-01',
						  gdr_cd = 'F', patid = patient$patid, yrdob = 2015)
        add_member_enrollment(patid = patient$patid, eligeff = '2015-04-01', eligend = '2015-05-01')						  						  
		add_death(patid = patient$patid, ymdod = '201307', extract_ym = '201606', version = '6.0')
	    expect_no_death(person_id = patient$person_id)
		

		patient <- createPatient()
		claim <- createClaim()
		declareTest("DEATH - Patient has IP visit with visit start date before 30 days of death, create the death record.", id = patient$person_id)
		add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
						  gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
        add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')						  						  						  
		add_death(patid = patient$patid, ymdod = '201307', extract_ym = '201606', version = '6.0')
		add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-31',
						   pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-31', prov = '111111', provcat = '5678', pos = '21')
		add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", clmid = claim$clmid, diag_position = 1)
	    expect_death(person_id = patient$person_id)
		

		patient <- createPatient()
		claim <- createClaim()
		declareTest("DEATH - Patient has IP visit with visit start date after 30 days of death, delete the death record.", id = patient$person_id)
		add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
						  gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
        add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')						  						  						  						  
		add_death(patid = patient$patid, ymdod = '201307', extract_ym = '201606', version = '6.0')
		add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-10-02',
						   pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-10-02', prov = '111111', provcat = '5678', pos = '21')
		add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", clmid = claim$clmid, diag_position = 1)
	    expect_no_death(person_id = patient$person_id)
		
		patient <- createPatient()
		claim <- createClaim()
		declareTest("DEATH - Patient has ER visit with visit start date before 30 days of death, create the death record.", id = patient$person_id)
		add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
						  gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
        add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')						  						  						  
		add_death(patid = patient$patid, ymdod = '201307', extract_ym = '201606', version = '6.0')
		add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-07-31',
						   pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-07-31', prov = '111111', provcat = '5678', pos = '23')
		add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", clmid = claim$clmid, diag_position = 1)
	    expect_death(person_id = patient$person_id)
		

		patient <- createPatient()
		claim <- createClaim()
		declareTest("DEATH - Patient has ER visit with visit start date after 30 days of death, delete the death record.", id = patient$person_id)
		add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
						  gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
        add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')						  						  						  						  
		add_death(patid = patient$patid, ymdod = '201307', extract_ym = '201606', version = '6.0')
		add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2013-10-02',
						   pat_planid = patient$patid, patid = patient$patid, fst_dt = '2013-10-02', prov = '111111', provcat = '5678', pos = '23')
		add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7061", clmid = claim$clmid, diag_position = 1)
	    expect_no_death(person_id = patient$person_id)
		
		
		patient <- createPatient()
		claim <- createClaim()
		declareTest("DEATH - Patient ICD9 for death and a record in the death table", id = patient$person_id)
		add_member_continuous_enrollment(eligeff = '2010-05-01', eligend = '2013-10-31',
						  gdr_cd = 'F', patid = patient$patid, yrdob = 1969)
        add_member_enrollment(patid = patient$patid, eligeff = '2010-05-01', eligend = '2013-10-31')						  
		add_death(patid = patient$patid, ymdod = '201307', extract_ym = '201606', version = '6.0')
		add_medical_claims(clmid = claim$clmid, clmseq = '001', lst_dt = '2011-08-02', proc_cd = '64475',
						   pat_planid = patient$patid, patid = patient$patid, fst_dt = '2011-08-02', prov = '111111', provcat = '5678')
		add_med_diagnosis(patid = patient$patid, pat_planid = patient$patid, icd_flag = "9", diag = "7616", clmid = claim$clmid, diag_position = 1)
	    expect_death(person_id = patient$person_id, death_date = '2013-07-31')
   }
}
