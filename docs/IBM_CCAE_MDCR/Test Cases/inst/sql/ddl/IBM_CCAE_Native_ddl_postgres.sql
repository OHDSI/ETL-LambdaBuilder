-- DROP SCHEMA ccae_tests_native;

CREATE SCHEMA ccae_tests_native;
-- ccae_tests_native."_pos_episode_visit" definition

-- Drop table

-- DROP TABLE ccae_tests_native."_pos_episode_visit";

--DROP TABLE ccae_tests_native._pos_episode_visit;
CREATE TABLE IF NOT EXISTS ccae_tests_native._pos_episode_visit
(
	episode_id BIGINT   
	,enrolid BIGINT   
	,dt_start DATE   
	,dt_end DATE   
	,visit_type VARCHAR(3)   
)

;



-- ccae_tests_native."_version" definition

-- Drop table

-- DROP TABLE ccae_tests_native."_version";

--DROP TABLE ccae_tests_native._version;
CREATE TABLE IF NOT EXISTS ccae_tests_native._version
(
	version_id INTEGER   
	,version_date DATE   
)

;


-- ccae_tests_native.cpt4 definition

-- Drop table

-- DROP TABLE ccae_tests_native.cpt4;

--DROP TABLE ccae_tests_native.cpt4;
CREATE TABLE IF NOT EXISTS ccae_tests_native.cpt4
(
	cpt_code CHAR(5)   
	,cpt_desc VARCHAR(50)   
)

;


-- ccae_tests_native.drug_claims definition

-- Drop table

-- DROP TABLE ccae_tests_native.drug_claims;

--DROP TABLE ccae_tests_native.drug_claims;
CREATE TABLE IF NOT EXISTS ccae_tests_native.drug_claims
(
	_flag SMALLINT   
	,age SMALLINT   
	,agegrp CHAR(1)   
	,awp DOUBLE PRECISION   
	,cap_svc CHAR(1)   
	,cob DOUBLE PRECISION   
	,coins DOUBLE PRECISION   
	,copay DOUBLE PRECISION   
	,datatyp SMALLINT   
	,dawind CHAR(2)   
	,daysupp SMALLINT   
	,deaclas CHAR(1)   
	,deduct DOUBLE PRECISION   
	,dispfee DOUBLE PRECISION   
	,dobyr SMALLINT   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,efamid INTEGER   
	,egeoloc CHAR(2)   
	,eidflag CHAR(1)   
	,emprel CHAR(1)   
	,enrflag CHAR(1)   
	,enrolid BIGINT   
	,generid INTEGER   
	,genind CHAR(1)   
	,hlthplan CHAR(1)   
	,indstry CHAR(1)   
	,ingcost DOUBLE PRECISION   
	,maintin CHAR(1)   
	,metqty DOUBLE PRECISION   
	,mhsacovg CHAR(1)   
	,msa INTEGER   
	,ndcnum VARCHAR(11)   
	,netpay DOUBLE PRECISION   
	,ntwkprov CHAR(1)   
	,paidntwk CHAR(1)   
	,pay DOUBLE PRECISION   
	,pddate DATE   
	,pharmid INTEGER   
	,phyflag CHAR(1)   
	,plankey SMALLINT   
	,plantyp SMALLINT   
	,qty INTEGER   
	,refill SMALLINT   
	,"region" CHAR(1)   
	,rxmr CHAR(1)   
	,saletax DOUBLE PRECISION   
	,seqnum BIGINT   
	,sex CHAR(1)   
	,svcdate DATE   
	,thercls SMALLINT   
	,thergrp CHAR(2)   
	,version CHAR(2)   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,medadv INTEGER   
)

;


-- ccae_tests_native.enrollment_detail definition

-- Drop table

-- DROP TABLE ccae_tests_native.enrollment_detail;

--DROP TABLE ccae_tests_native.enrollment_detail;
CREATE TABLE IF NOT EXISTS ccae_tests_native.enrollment_detail
(
	_flag SMALLINT   
	,age SMALLINT   
	,agegrp CHAR(1)   
	,datatyp SMALLINT   
	,dobyr SMALLINT   
	,dtend DATE   
	,dtstart DATE   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,efamid INTEGER   
	,egeoloc CHAR(2)   
	,emprel CHAR(1)   
	,enrolid BIGINT   
	,hlthplan CHAR(1)   
	,indstry CHAR(1)   
	,memdays SMALLINT   
	,mhsacovg CHAR(1)   
	,msa INTEGER   
	,phyflag CHAR(1)   
	,plankey SMALLINT   
	,plantyp SMALLINT   
	,"region" CHAR(1)   
	,rx CHAR(1)   
	,seqnum BIGINT   
	,sex CHAR(1)   
	,version CHAR(2)   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,medadv INTEGER   
)

;


-- ccae_tests_native.enrollment_summary definition

-- Drop table

-- DROP TABLE ccae_tests_native.enrollment_summary;

--DROP TABLE ccae_tests_native.enrollment_summary;
CREATE TABLE IF NOT EXISTS ccae_tests_native.enrollment_summary
(
	_flag SMALLINT   
	,age SMALLINT   
	,agegrp CHAR(1)   
	,dattyp1 SMALLINT   
	,dattyp10 SMALLINT   
	,dattyp11 SMALLINT   
	,dattyp12 SMALLINT   
	,dattyp2 SMALLINT   
	,dattyp3 SMALLINT   
	,dattyp4 SMALLINT   
	,dattyp5 SMALLINT   
	,dattyp6 SMALLINT   
	,dattyp7 SMALLINT   
	,dattyp8 SMALLINT   
	,dattyp9 SMALLINT   
	,dobyr SMALLINT   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,efamid INTEGER   
	,egeoloc CHAR(2)   
	,emprel CHAR(1)   
	,enrind1 SMALLINT   
	,enrind10 SMALLINT   
	,enrind11 SMALLINT   
	,enrind12 SMALLINT   
	,enrind2 SMALLINT   
	,enrind3 SMALLINT   
	,enrind4 SMALLINT   
	,enrind5 SMALLINT   
	,enrind6 SMALLINT   
	,enrind7 SMALLINT   
	,enrind8 SMALLINT   
	,enrind9 SMALLINT   
	,enrmon SMALLINT   
	,enrolid BIGINT   
	,hlthplan CHAR(1)   
	,indstry CHAR(1)   
	,memday1 SMALLINT   
	,memday10 SMALLINT   
	,memday11 SMALLINT   
	,memday12 SMALLINT   
	,memday2 SMALLINT   
	,memday3 SMALLINT   
	,memday4 SMALLINT   
	,memday5 SMALLINT   
	,memday6 SMALLINT   
	,memday7 SMALLINT   
	,memday8 SMALLINT   
	,memday9 SMALLINT   
	,memdays SMALLINT   
	,mhsacovg CHAR(1)   
	,msa INTEGER   
	,phyflag CHAR(1)   
	,plnkey1 SMALLINT   
	,plnkey10 SMALLINT   
	,plnkey11 SMALLINT   
	,plnkey12 SMALLINT   
	,plnkey2 SMALLINT   
	,plnkey3 SMALLINT   
	,plnkey4 SMALLINT   
	,plnkey5 SMALLINT   
	,plnkey6 SMALLINT   
	,plnkey7 SMALLINT   
	,plnkey8 SMALLINT   
	,plnkey9 SMALLINT   
	,plntyp1 SMALLINT   
	,plntyp10 SMALLINT   
	,plntyp11 SMALLINT   
	,plntyp12 SMALLINT   
	,plntyp2 SMALLINT   
	,plntyp3 SMALLINT   
	,plntyp4 SMALLINT   
	,plntyp5 SMALLINT   
	,plntyp6 SMALLINT   
	,plntyp7 SMALLINT   
	,plntyp8 SMALLINT   
	,plntyp9 SMALLINT   
	,"region" CHAR(1)   
	,rx CHAR(1)   
	,seqnum BIGINT   
	,sex CHAR(1)   
	,version CHAR(2)   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,mswgtkey VARCHAR(5)   
	,medadv1 INTEGER   
	,medadv2 INTEGER   
	,medadv3 INTEGER   
	,medadv4 INTEGER   
	,medadv5 INTEGER   
	,medadv6 INTEGER   
	,medadv7 INTEGER   
	,medadv8 INTEGER   
	,medadv9 INTEGER   
	,medadv10 INTEGER   
	,medadv11 INTEGER   
	,medadv12 INTEGER   
)

;


-- ccae_tests_native.facility_header definition

-- Drop table

-- DROP TABLE ccae_tests_native.facility_header;

--DROP TABLE ccae_tests_native.facility_header;
CREATE TABLE IF NOT EXISTS ccae_tests_native.facility_header
(
	_flag SMALLINT   
	,age SMALLINT   
	,agegrp CHAR(1)   
	,billtyp CHAR(3)   
	,cap_svc CHAR(1)   
	,caseid INTEGER   
	,cob DOUBLE PRECISION   
	,coins DOUBLE PRECISION   
	,copay DOUBLE PRECISION   
	,datatyp SMALLINT   
	,deduct DOUBLE PRECISION   
	,dobyr SMALLINT   
	,dstatus CHAR(2)   
	,dx1 CHAR(8)   
	,dx2 CHAR(7)   
	,dx3 CHAR(7)   
	,dx4 CHAR(7)   
	,dx5 CHAR(7)   
	,dx6 CHAR(7)   
	,dx7 CHAR(7)   
	,dx8 CHAR(7)   
	,dx9 CHAR(7)   
	,dxver CHAR(1)   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,efamid INTEGER   
	,egeoloc CHAR(2)   
	,eidflag CHAR(1)   
	,emprel CHAR(1)   
	,enrflag CHAR(1)   
	,enrolid BIGINT   
	,fachdid BIGINT   
	,hlthplan CHAR(1)   
	,indstry CHAR(1)   
	,mdc CHAR(2)   
	,mhsacovg CHAR(1)   
	,msa INTEGER   
	,netpay DOUBLE PRECISION   
	,ntwkprov CHAR(1)   
	,paidntwk CHAR(1)   
	,pddate DATE   
	,phyflag CHAR(1)   
	,plankey SMALLINT   
	,plantyp SMALLINT   
	,poadx1 CHAR(8)   
	,poadx2 CHAR(1)   
	,poadx3 CHAR(1)   
	,poadx4 CHAR(1)   
	,poadx5 CHAR(1)   
	,poadx6 CHAR(1)   
	,poadx7 CHAR(1)   
	,poadx8 CHAR(1)   
	,poadx9 CHAR(1)   
	,proc1 CHAR(7)   
	,proc2 CHAR(7)   
	,proc3 CHAR(7)   
	,proc4 CHAR(7)   
	,proc5 CHAR(7)   
	,proc6 CHAR(7)   
	,provid INTEGER   
	,"region" CHAR(1)   
	,rx CHAR(1)   
	,seqnum BIGINT   
	,sex CHAR(1)   
	,stdplac SMALLINT   
	,stdprov SMALLINT   
	,svcdate DATE   
	,tsvcdat DATE   
	,version CHAR(2)   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,msclmid INTEGER   
	,npi VARCHAR(10)   
	,medadv INTEGER   
)

;


-- ccae_tests_native.geoloc definition

-- Drop table

-- DROP TABLE ccae_tests_native.geoloc;

--DROP TABLE ccae_tests_native.geoloc;
CREATE TABLE IF NOT EXISTS ccae_tests_native.geoloc
(
	egeoloc CHAR(2)   
	,egeoloc_description VARCHAR(42)   
	,state CHAR(2)   
)

;


-- ccae_tests_native.health_risk_assessment definition

-- Drop table

-- DROP TABLE ccae_tests_native.health_risk_assessment;

--DROP TABLE ccae_tests_native.health_risk_assessment;
CREATE TABLE IF NOT EXISTS ccae_tests_native.health_risk_assessment
(
	_flag SMALLINT   
	,alc_amt CHAR(1)   
	,alcdyamt CHAR(1)   
	,alcweek CHAR(1)   
	,bmi DOUBLE PRECISION   
	,cc_allergy CHAR(1)   
	,cc_arthritis CHAR(1)   
	,cc_asthma CHAR(1)   
	,cc_backpain CHAR(1)   
	,cc_chf CHAR(1)   
	,cc_depress CHAR(1)   
	,cc_diab CHAR(1)   
	,cc_heartdis CHAR(1)   
	,cc_highbp CHAR(1)   
	,cc_highcol CHAR(1)   
	,cc_hrtburn CHAR(1)   
	,cc_lungdis CHAR(1)   
	,cc_migraine CHAR(1)   
	,cc_nonskincan CHAR(1)   
	,cc_osteopo CHAR(1)   
	,cc_skincan CHAR(1)   
	,cgramt CHAR(1)   
	,cgrcurr CHAR(1)   
	,cgrdur CHAR(1)   
	,cgrprev CHAR(1)   
	,cgrqtyr SMALLINT   
	,cgrquit CHAR(1)   
	,cgtamt CHAR(1)   
	,cgtcurr CHAR(1)   
	,cgtdur CHAR(1)   
	,cgtpkamt CHAR(1)   
	,cgtprev CHAR(1)   
	,cgtqtcat CHAR(1)   
	,cgtqtyr SMALLINT   
	,cgtquit CHAR(1)   
	,chewamt CHAR(1)   
	,chewcurr CHAR(1)   
	,chewdur CHAR(1)   
	,chewprev CHAR(1)   
	,chewqtyr SMALLINT   
	,chewquit CHAR(1)   
	,cholestr DOUBLE PRECISION   
	,copestrs CHAR(1)   
	,diast_bp SMALLINT   
	,dietfrt CHAR(1)   
	,dietfrvg CHAR(1)   
	,dietveg CHAR(1)   
	,dobyr SMALLINT   
	,drnkdrv CHAR(1)   
	,educ_lvl CHAR(1)   
	,efamid INTEGER   
	,enrolid BIGINT   
	,exermo CHAR(1)   
	,exerweek SMALLINT   
	,famabscat12 CHAR(1)   
	,fireext CHAR(1)   
	,flu_shot CHAR(1)   
	,glucose DOUBLE PRECISION   
	,gluc_fast CHAR(1)   
	,hdl DOUBLE PRECISION   
	,height SMALLINT   
	,hlthplan CHAR(1)   
	,hltimpct CHAR(1)   
	,job_sat CHAR(1)   
	,ldl DOUBLE PRECISION   
	,life_sat CHAR(1)   
	,liftwgt CHAR(1)   
	,mh_freq CHAR(1)   
	,mh_prob CHAR(1)   
	,pipeamt CHAR(1)   
	,pipecurr CHAR(1)   
	,pipedur CHAR(1)   
	,pipeprev CHAR(1)   
	,pipeqtyr SMALLINT   
	,pipequit CHAR(1)   
	,planalc CHAR(1)   
	,plandiet CHAR(1)   
	,plandrad CHAR(1)   
	,planexer CHAR(1)   
	,planslp CHAR(1)   
	,planstrs CHAR(1)   
	,plantob CHAR(1)   
	,planwgt CHAR(1)   
	,prev_mammo CHAR(1)   
	,prev_paptest CHAR(1)   
	,prev_prostex CHAR(1)   
	,prev_sigmoid CHAR(1)   
	,prodabscat CHAR(1)   
	,risk_alc CHAR(1)   
	,risk_bp CHAR(1)   
	,risk_chol CHAR(1)   
	,risk_depr CHAR(1)   
	,risk_exer CHAR(1)   
	,risk_gluc CHAR(1)   
	,risk_mh CHAR(1)   
	,risk_nutr CHAR(1)   
	,risk_safe CHAR(1)   
	,risk_sleep CHAR(1)   
	,risk_smok CHAR(1)   
	,risk_stress CHAR(1)   
	,risk_wgt CHAR(1)   
	,seatbelt CHAR(1)   
	,selfhlth CHAR(1)   
	,seqnum INTEGER   
	,sex CHAR(1)   
	,sleep_hr CHAR(1)   
	,slpapnea CHAR(1)   
	,slpprob CHAR(1)   
	,smkdetect CHAR(1)   
	,stretch CHAR(1)   
	,survdate DATE   
	,systo_bp SMALLINT   
	,tobcurr CHAR(1)   
	,tobprev CHAR(1)   
	,triglycd DOUBLE PRECISION   
	,version CHAR(3)   
	,weight DOUBLE PRECISION   
	,workabs SMALLINT   
	,wrkabscat CHAR(1)   
	,wrkabscat12 CHAR(1)   
	,"year" SMALLINT   
	,ecigvape CHAR(1)   
)

;


-- ccae_tests_native.hra_question_ref definition

-- Drop table

-- DROP TABLE ccae_tests_native.hra_question_ref;

--DROP TABLE ccae_tests_native.hra_question_ref;
CREATE TABLE IF NOT EXISTS ccae_tests_native.hra_question_ref
(
	question_type_id INTEGER   
	,category_value VARCHAR(255)   
	,category_name VARCHAR(255)   
)

;


-- ccae_tests_native.hra_variable_ref definition

-- Drop table

-- DROP TABLE ccae_tests_native.hra_variable_ref;

--DROP TABLE ccae_tests_native.hra_variable_ref;
CREATE TABLE IF NOT EXISTS ccae_tests_native.hra_variable_ref
(
	variable_name VARCHAR(255)   
	,variable_longname VARCHAR(255)   
	,variable_description VARCHAR(255)   
	,notes VARCHAR(255)   
	,question_type_id DOUBLE PRECISION   
)

;


-- ccae_tests_native.icd9 definition

-- Drop table

-- DROP TABLE ccae_tests_native.icd9;

--DROP TABLE ccae_tests_native.icd9;
CREATE TABLE IF NOT EXISTS ccae_tests_native.icd9
(
	icd_key VARCHAR(9)   
	,icd_code VARCHAR(9)   
	,parent_icd_code VARCHAR(9)   
	,"level" SMALLINT   
	,children_count SMALLINT   
	,children_count_recursive SMALLINT   
	,description VARCHAR(250)   
)

;


-- ccae_tests_native.inpatient_admissions definition

-- Drop table

-- DROP TABLE ccae_tests_native.inpatient_admissions;

--DROP TABLE ccae_tests_native.inpatient_admissions;
CREATE TABLE IF NOT EXISTS ccae_tests_native.inpatient_admissions
(
	_flag SMALLINT   
	,admdate DATE   
	,admtyp CHAR(1)   
	,age SMALLINT   
	,agegrp CHAR(1)   
	,caseid INTEGER   
	,datatyp SMALLINT   
	,days SMALLINT   
	,disdate DATE   
	,dobyr SMALLINT   
	,drg SMALLINT   
	,dstatus CHAR(2)   
	,dx1 CHAR(8)   
	,dx10 CHAR(7)   
	,dx11 CHAR(7)   
	,dx12 CHAR(7)   
	,dx13 CHAR(7)   
	,dx14 CHAR(7)   
	,dx15 CHAR(7)   
	,dx2 CHAR(7)   
	,dx3 CHAR(7)   
	,dx4 CHAR(7)   
	,dx5 CHAR(7)   
	,dx6 CHAR(7)   
	,dx7 CHAR(7)   
	,dx8 CHAR(7)   
	,dx9 CHAR(7)   
	,dxver CHAR(1)   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,efamid INTEGER   
	,egeoloc CHAR(2)   
	,eidflag CHAR(1)   
	,emprel CHAR(1)   
	,enrflag CHAR(1)   
	,enrolid BIGINT   
	,hlthplan CHAR(1)   
	,hospnet DOUBLE PRECISION   
	,hosppay DOUBLE PRECISION   
	,indstry CHAR(1)   
	,mdc CHAR(2)   
	,mhsacovg CHAR(1)   
	,msa INTEGER   
	,pdx CHAR(8)   
	,phyflag CHAR(1)   
	,physid INTEGER   
	,physnet DOUBLE PRECISION   
	,physpay DOUBLE PRECISION   
	,plankey SMALLINT   
	,plantyp SMALLINT   
	,poapdx CHAR(8)   
	,poadx1 CHAR(8)   
	,poadx2 CHAR(1)   
	,poadx3 CHAR(1)   
	,poadx4 CHAR(1)   
	,poadx5 CHAR(1)   
	,poadx6 CHAR(1)   
	,poadx7 CHAR(1)   
	,poadx8 CHAR(1)   
	,poadx9 CHAR(1)   
	,poadx10 CHAR(1)   
	,poadx11 CHAR(1)   
	,poadx12 CHAR(1)   
	,poadx13 CHAR(1)   
	,poadx14 CHAR(1)   
	,poadx15 CHAR(1)   
	,pproc CHAR(7)   
	,proc1 CHAR(7)   
	,proc10 CHAR(7)   
	,proc11 CHAR(7)   
	,proc12 CHAR(7)   
	,proc13 CHAR(7)   
	,proc14 CHAR(7)   
	,proc15 CHAR(7)   
	,proc2 CHAR(7)   
	,proc3 CHAR(7)   
	,proc4 CHAR(7)   
	,proc5 CHAR(7)   
	,proc6 CHAR(7)   
	,proc7 CHAR(7)   
	,proc8 CHAR(7)   
	,proc9 CHAR(7)   
	,"region" CHAR(1)   
	,rx CHAR(1)   
	,seqnum BIGINT   
	,sex CHAR(1)   
	,state CHAR(2)   
	,totcob DOUBLE PRECISION   
	,totcoins DOUBLE PRECISION   
	,totcopay DOUBLE PRECISION   
	,totded DOUBLE PRECISION   
	,totnet DOUBLE PRECISION   
	,totpay DOUBLE PRECISION   
	,version CHAR(2)   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,medadv INTEGER   
)

;


-- ccae_tests_native.inpatient_services definition

-- Drop table

-- DROP TABLE ccae_tests_native.inpatient_services;

--DROP TABLE ccae_tests_native.inpatient_services;
CREATE TABLE IF NOT EXISTS ccae_tests_native.inpatient_services
(
	_flag SMALLINT   
	,admdate DATE   
	,admtyp CHAR(1)   
	,age SMALLINT   
	,agegrp CHAR(1)   
	,cap_svc CHAR(1)   
	,caseid INTEGER   
	,cob DOUBLE PRECISION   
	,coins DOUBLE PRECISION   
	,copay DOUBLE PRECISION   
	,datatyp SMALLINT   
	,deduct DOUBLE PRECISION   
	,disdate DATE   
	,dobyr SMALLINT   
	,drg SMALLINT   
	,dstatus CHAR(2)   
	,dx1 CHAR(8)   
	,dx2 CHAR(7)   
	,dx3 CHAR(7)   
	,dx4 CHAR(7)   
	,dx5 CHAR(7)   
	,dxver CHAR(1)   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,efamid INTEGER   
	,egeoloc CHAR(2)   
	,eidflag CHAR(1)   
	,emprel CHAR(1)   
	,enrflag CHAR(1)   
	,enrolid BIGINT   
	,fachdid BIGINT   
	,facprof CHAR(1)   
	,hlthplan CHAR(1)   
	,indstry CHAR(1)   
	,mdc CHAR(2)   
	,mhsacovg CHAR(1)   
	,msa INTEGER   
	,netpay DOUBLE PRECISION   
	,ntwkprov CHAR(1)   
	,paidntwk CHAR(1)   
	,pay DOUBLE PRECISION   
	,pddate DATE   
	,pdx CHAR(8)   
	,phyflag CHAR(1)   
	,plankey SMALLINT   
	,plantyp SMALLINT   
	,pproc CHAR(7)   
	,proc1 CHAR(7)   
	,procmod CHAR(2)   
	,proctyp CHAR(10)   
	,provid INTEGER   
	,qty INTEGER   
	,"region" CHAR(1)   
	,revcode CHAR(4)   
	,rx CHAR(1)   
	,seqnum BIGINT   
	,sex CHAR(1)   
	,stdplac SMALLINT   
	,stdprov SMALLINT   
	,svcdate DATE   
	,svcscat CHAR(5)   
	,tsvcdat DATE   
	,version CHAR(2)   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,units DOUBLE PRECISION   
	,npi VARCHAR(10)   
	,msclmid INTEGER   
	,medadv INTEGER   
	,_svcdate DATE   
	,_tsvcdat DATE   
	,_visittype VARCHAR(3)   
)

;


-- ccae_tests_native.lab definition

-- Drop table

-- DROP TABLE ccae_tests_native.lab;

--DROP TABLE ccae_tests_native.lab;
CREATE TABLE IF NOT EXISTS ccae_tests_native.lab
(
	enrolid BIGINT   
	,seqnum BIGINT   
	,abnormal CHAR(1)   
	,agegrp CHAR(1)   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,eidflag CHAR(1)   
	,emprel CHAR(1)   
	,enrflag CHAR(1)   
	,hlthplan CHAR(1)   
	,indstry CHAR(1)   
	,mhsacovg CHAR(1)   
	,phyflag CHAR(1)   
	,proctyp CHAR(1)   
	,"region" CHAR(1)   
	,rx CHAR(1)   
	,sex CHAR(1)   
	,egeoloc CHAR(2)   
	,mdc CHAR(2)   
	,version CHAR(2)   
	,resltcat CHAR(3)   
	,dx1 CHAR(7)   
	,proc1 CHAR(7)   
	,pddate DATE   
	,svcdate DATE   
	,msa INTEGER   
	,orderid INTEGER   
	,provid INTEGER   
	,refhigh DOUBLE PRECISION   
	,reflow DOUBLE PRECISION   
	,"result" DOUBLE PRECISION   
	,testcnt INTEGER   
	,dobyr SMALLINT   
	,plankey SMALLINT   
	,stdprov SMALLINT   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,age SMALLINT   
	,datatyp SMALLINT   
	,plantyp SMALLINT   
	,stdplac SMALLINT   
	,loinccd VARCHAR(7)   
	,resunit VARCHAR(30)   
	,efamid INTEGER   
	,dxver CHAR(1)   
	,medadv INTEGER   
	,_flag SMALLINT   
)

;


-- ccae_tests_native.loinc definition

-- Drop table

-- DROP TABLE ccae_tests_native.loinc;

--DROP TABLE ccae_tests_native.loinc;
CREATE TABLE IF NOT EXISTS ccae_tests_native.loinc
(
	loinc_num CHAR(7)   
	,component VARCHAR(500)   
	,property VARCHAR(50)   
	,time_aspct VARCHAR(15)   
	,"system" VARCHAR(100)   
	,scale_typ VARCHAR(5)   
	,method_typ VARCHAR(100)   
	,relat_nms VARCHAR(500)   
	,"class" VARCHAR(50)   
	,source VARCHAR(20)   
	,dt_last_ch VARCHAR(8)   
	,chng_type CHAR(3)   
	,comments VARCHAR(4500)   
	,answerlist VARCHAR(200)   
	,status VARCHAR(20)   
	,map_to VARCHAR(7)   
	,scope VARCHAR(20)   
	,consumer_name VARCHAR(100)   
	,ipcc_units VARCHAR(20)   
	,reference VARCHAR(500)   
	,exact_cmp_sy VARCHAR(50)   
	,molar_mass VARCHAR(20)   
	,classtype INTEGER   
	,formula VARCHAR(500)   
	,species VARCHAR(20)   
	,exmpl_answers VARCHAR(4000)   
	,acssym VARCHAR(2600)   
	,base_name VARCHAR(50)   
	,final CHAR(1)   
	,naaccr_id VARCHAR(20)   
	,code_table VARCHAR(20)   
	,setroot BOOLEAN   
	,panelelements VARCHAR(500)   
	,survey_quest_text VARCHAR(500)   
	,survey_quest_src VARCHAR(50)   
	,unitsrequired CHAR(1)   
	,submitted_units VARCHAR(50)   
	,relatednames2 VARCHAR(1000)   
	,shortname VARCHAR(40)   
	,order_obs VARCHAR(15)   
	,cdisc_common_tests CHAR(1)   
	,hl7_field_subfield_id VARCHAR(50)   
	,external_copyright_notice VARCHAR(500)   
	,example_units VARCHAR(100)   
	,inpc_percentage REAL   
	,long_common_name VARCHAR(500)   
	,hl7_v2_datatype VARCHAR(10)   
	,hl7_v3_datatype VARCHAR(10)   
	,curated_range_and_units VARCHAR(50)   
	,document_section VARCHAR(50)   
	,definition_description_help VARCHAR(1000)   
	,example_ucum_units VARCHAR(50)   
	,example_si_ucum_units VARCHAR(50)   
	,status_reason VARCHAR(9)   
	,status_text VARCHAR(500)   
	,change_reason_public VARCHAR(500)   
	,common_test_rank INTEGER   
)

;


-- ccae_tests_native.outpatient_services definition

-- Drop table

-- DROP TABLE ccae_tests_native.outpatient_services;

--DROP TABLE ccae_tests_native.outpatient_services;
CREATE TABLE IF NOT EXISTS ccae_tests_native.outpatient_services
(
	_flag SMALLINT   
	,age SMALLINT   
	,agegrp CHAR(1)   
	,cap_svc CHAR(1)   
	,cob DOUBLE PRECISION   
	,coins DOUBLE PRECISION   
	,copay DOUBLE PRECISION   
	,datatyp SMALLINT   
	,deduct DOUBLE PRECISION   
	,dobyr SMALLINT   
	,dx1 CHAR(8)   
	,dx2 CHAR(7)   
	,dx3 CHAR(7)   
	,dx4 CHAR(7)   
	,dx5 CHAR(7)   
	,dxver CHAR(1)   
	,eeclass CHAR(1)   
	,eestatu CHAR(1)   
	,efamid INTEGER   
	,egeoloc CHAR(2)   
	,eidflag CHAR(1)   
	,emprel CHAR(1)   
	,enrflag CHAR(1)   
	,enrolid BIGINT   
	,fachdid BIGINT   
	,facprof CHAR(1)   
	,hlthplan CHAR(1)   
	,indstry CHAR(1)   
	,mdc CHAR(2)   
	,mhsacovg CHAR(1)   
	,msa INTEGER   
	,netpay DOUBLE PRECISION   
	,ntwkprov CHAR(1)   
	,paidntwk CHAR(1)   
	,pay DOUBLE PRECISION   
	,pddate DATE   
	,phyflag CHAR(1)   
	,plankey SMALLINT   
	,plantyp SMALLINT   
	,proc1 CHAR(7)   
	,procgrp SMALLINT   
	,procmod CHAR(2)   
	,proctyp CHAR(10)   
	,provid INTEGER   
	,qty INTEGER   
	,"region" CHAR(1)   
	,revcode CHAR(4)   
	,rx CHAR(1)   
	,seqnum BIGINT   
	,sex CHAR(1)   
	,stdplac SMALLINT   
	,stdprov SMALLINT   
	,svcdate DATE   
	,svcscat CHAR(5)   
	,tsvcdat DATE   
	,version CHAR(2)   
	,wgtkey SMALLINT   
	,"year" SMALLINT   
	,units DOUBLE PRECISION   
	,npi VARCHAR(10)   
	,msclmid INTEGER   
	,medadv INTEGER   
	,_svcdate DATE   
	,_tsvcdat DATE   
	,_visittype VARCHAR(3)   
)

;


-- ccae_tests_native.red_book definition

-- Drop table

-- DROP TABLE ccae_tests_native.red_book;

--DROP TABLE ccae_tests_native.red_book;
CREATE TABLE IF NOT EXISTS ccae_tests_native.red_book
(
	_flag SMALLINT   
	,deaclas CHAR(1)   
	,deaclds VARCHAR(50)   
	,desidrg CHAR(1)   
	,excdgds VARCHAR(30)   
	,excldrg CHAR(2)   
	,generid INTEGER   
	,genind CHAR(1)   
	,gennme VARCHAR(50)   
	,gnindds VARCHAR(30)   
	,maintds VARCHAR(30)   
	,maintin CHAR(1)   
	,manfnme VARCHAR(50)   
	,mastfrm CHAR(3)   
	,metsize VARCHAR(30)   
	,mstfmds VARCHAR(30)   
	,ndcnum VARCHAR(11)   
	,orgbkcd CHAR(3)   
	,orgbkds VARCHAR(30)   
	,orgbkfg CHAR(1)   
	,pkqtycd CHAR(3)   
	,pksize INTEGER   
	,prdctds VARCHAR(30)   
	,prodcat CHAR(2)   
	,prodnme VARCHAR(50)   
	,siglsrc CHAR(1)   
	,strngth VARCHAR(30)   
	,roacd VARCHAR(2)   
	,roads VARCHAR(30)   
	,thercls VARCHAR(3)   
	,therdtl VARCHAR(10)   
	,thergrp VARCHAR(2)   
	,thrclds VARCHAR(30)   
	,thrdtds VARCHAR(30)   
	,thrgrds VARCHAR(30)   
	,"year" SMALLINT   
	,deactdt DATE   
	,reactdt DATE   
	,actind VARCHAR(1)   
)

;


