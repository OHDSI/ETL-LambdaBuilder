-- DROP SCHEMA ccae_tests_native;

CREATE SCHEMA ccae_tests_native;
-- ccae_tests_native."_version" definition

-- Drop table

-- DROP TABLE ccae_tests_native."_version";

--DROP TABLE ccae_tests_native._version;
CREATE TABLE IF NOT EXISTS ccae_tests_native._version
(
	version_id INTEGER NOT NULL  ENCODE az64
	,version_date DATE NOT NULL  ENCODE az64
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native._version owner to rhealth_etl;


-- ccae_tests_native.cpt4 definition

-- Drop table

-- DROP TABLE ccae_tests_native.cpt4;

--DROP TABLE ccae_tests_native.cpt4;
CREATE TABLE IF NOT EXISTS ccae_tests_native.cpt4
(
	cpt_code CHAR(5)   ENCODE lzo
	,cpt_desc VARCHAR(50)   ENCODE lzo
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.cpt4 owner to rhealth_etl;


-- ccae_tests_native.drug_claims definition

-- Drop table

-- DROP TABLE ccae_tests_native.drug_claims;

--DROP TABLE ccae_tests_native.drug_claims;
CREATE TABLE IF NOT EXISTS ccae_tests_native.drug_claims
(
	_flag SMALLINT   ENCODE az64
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE zstd
	,awp DOUBLE PRECISION   ENCODE RAW
	,cap_svc CHAR(1)   ENCODE zstd
	,cob DOUBLE PRECISION   ENCODE zstd
	,coins DOUBLE PRECISION   ENCODE zstd
	,copay DOUBLE PRECISION   ENCODE zstd
	,datatyp SMALLINT   ENCODE az64
	,dawind CHAR(2)   ENCODE zstd
	,daysupp SMALLINT   ENCODE az64
	,deaclas CHAR(1)   ENCODE zstd
	,deduct DOUBLE PRECISION   ENCODE zstd
	,dispfee DOUBLE PRECISION   ENCODE zstd
	,dobyr SMALLINT   ENCODE az64
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE zstd
	,eidflag CHAR(1)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrflag CHAR(1)   ENCODE zstd
	,enrolid BIGINT   ENCODE az64
	,generid INTEGER   ENCODE az64
	,genind CHAR(1)   ENCODE zstd
	,hlthplan CHAR(1)   ENCODE zstd
	,indstry CHAR(1)   ENCODE zstd
	,ingcost DOUBLE PRECISION   ENCODE RAW
	,maintin CHAR(1)   ENCODE zstd
	,metqty DOUBLE PRECISION   ENCODE zstd
	,mhsacovg CHAR(1)   ENCODE zstd
	,msa INTEGER   ENCODE az64
	,ndcnum VARCHAR(11)   ENCODE zstd
	,netpay DOUBLE PRECISION   ENCODE zstd
	,ntwkprov CHAR(1)   ENCODE zstd
	,paidntwk CHAR(1)   ENCODE zstd
	,pay DOUBLE PRECISION   ENCODE RAW
	,pddate DATE   ENCODE az64
	,pharmid INTEGER   ENCODE az64
	,phyflag CHAR(1)   ENCODE zstd
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,qty INTEGER   ENCODE az64
	,refill SMALLINT   ENCODE az64
	,"region" CHAR(1)   ENCODE zstd
	,rxmr CHAR(1)   ENCODE zstd
	,saletax DOUBLE PRECISION   ENCODE zstd
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,svcdate DATE   ENCODE az64
	,thercls SMALLINT   ENCODE az64
	,thergrp CHAR(2)   ENCODE zstd
	,version CHAR(2)   ENCODE zstd
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	svcdate
	, _flag
	)
;
ALTER TABLE ccae_tests_native.drug_claims owner to rhealth_etl;


-- ccae_tests_native.enrollment_detail definition

-- Drop table

-- DROP TABLE ccae_tests_native.enrollment_detail;

--DROP TABLE ccae_tests_native.enrollment_detail;
CREATE TABLE IF NOT EXISTS ccae_tests_native.enrollment_detail
(
	_flag SMALLINT   ENCODE az64
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE zstd
	,datatyp SMALLINT   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,dtend DATE   ENCODE az64
	,dtstart DATE   ENCODE az64
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrolid BIGINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE zstd
	,indstry CHAR(1)   ENCODE zstd
	,memdays SMALLINT   ENCODE az64
	,mhsacovg CHAR(1)   ENCODE zstd
	,msa INTEGER   ENCODE az64
	,phyflag CHAR(1)   ENCODE zstd
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,"region" CHAR(1)   ENCODE zstd
	,rx CHAR(1)   ENCODE zstd
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,version CHAR(2)   ENCODE zstd
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,medadv VARCHAR(50) ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	dtstart
	, _flag
	)
;
ALTER TABLE ccae_tests_native.enrollment_detail owner to rhealth_etl;


-- ccae_tests_native.enrollment_summary definition

-- Drop table

-- DROP TABLE ccae_tests_native.enrollment_summary;

--DROP TABLE ccae_tests_native.enrollment_summary;
CREATE TABLE IF NOT EXISTS ccae_tests_native.enrollment_summary
(
	_flag SMALLINT   ENCODE az64
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE zstd
	,dattyp1 SMALLINT   ENCODE az64
	,dattyp10 SMALLINT   ENCODE az64
	,dattyp11 SMALLINT   ENCODE az64
	,dattyp12 SMALLINT   ENCODE az64
	,dattyp2 SMALLINT   ENCODE az64
	,dattyp3 SMALLINT   ENCODE az64
	,dattyp4 SMALLINT   ENCODE az64
	,dattyp5 SMALLINT   ENCODE az64
	,dattyp6 SMALLINT   ENCODE az64
	,dattyp7 SMALLINT   ENCODE az64
	,dattyp8 SMALLINT   ENCODE az64
	,dattyp9 SMALLINT   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrind1 SMALLINT   ENCODE az64
	,enrind10 SMALLINT   ENCODE az64
	,enrind11 SMALLINT   ENCODE az64
	,enrind12 SMALLINT   ENCODE az64
	,enrind2 SMALLINT   ENCODE az64
	,enrind3 SMALLINT   ENCODE az64
	,enrind4 SMALLINT   ENCODE az64
	,enrind5 SMALLINT   ENCODE az64
	,enrind6 SMALLINT   ENCODE az64
	,enrind7 SMALLINT   ENCODE az64
	,enrind8 SMALLINT   ENCODE az64
	,enrind9 SMALLINT   ENCODE az64
	,enrmon SMALLINT   ENCODE az64
	,enrolid BIGINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE zstd
	,indstry CHAR(1)   ENCODE zstd
	,memday1 SMALLINT   ENCODE az64
	,memday10 SMALLINT   ENCODE az64
	,memday11 SMALLINT   ENCODE az64
	,memday12 SMALLINT   ENCODE az64
	,memday2 SMALLINT   ENCODE az64
	,memday3 SMALLINT   ENCODE az64
	,memday4 SMALLINT   ENCODE az64
	,memday5 SMALLINT   ENCODE az64
	,memday6 SMALLINT   ENCODE az64
	,memday7 SMALLINT   ENCODE az64
	,memday8 SMALLINT   ENCODE az64
	,memday9 SMALLINT   ENCODE az64
	,memdays SMALLINT   ENCODE az64
	,mhsacovg CHAR(1)   ENCODE zstd
	,msa INTEGER   ENCODE az64
	,phyflag CHAR(1)   ENCODE zstd
	,plnkey1 SMALLINT   ENCODE az64
	,plnkey10 SMALLINT   ENCODE az64
	,plnkey11 SMALLINT   ENCODE az64
	,plnkey12 SMALLINT   ENCODE az64
	,plnkey2 SMALLINT   ENCODE az64
	,plnkey3 SMALLINT   ENCODE az64
	,plnkey4 SMALLINT   ENCODE az64
	,plnkey5 SMALLINT   ENCODE az64
	,plnkey6 SMALLINT   ENCODE az64
	,plnkey7 SMALLINT   ENCODE az64
	,plnkey8 SMALLINT   ENCODE az64
	,plnkey9 SMALLINT   ENCODE az64
	,plntyp1 SMALLINT   ENCODE az64
	,plntyp10 SMALLINT   ENCODE az64
	,plntyp11 SMALLINT   ENCODE az64
	,plntyp12 SMALLINT   ENCODE az64
	,plntyp2 SMALLINT   ENCODE az64
	,plntyp3 SMALLINT   ENCODE az64
	,plntyp4 SMALLINT   ENCODE az64
	,plntyp5 SMALLINT   ENCODE az64
	,plntyp6 SMALLINT   ENCODE az64
	,plntyp7 SMALLINT   ENCODE az64
	,plntyp8 SMALLINT   ENCODE az64
	,plntyp9 SMALLINT   ENCODE az64
	,"region" CHAR(1)   ENCODE zstd
	,rx CHAR(1)   ENCODE zstd
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,version CHAR(2)   ENCODE zstd
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,mswgtkey VARCHAR(5)   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	_flag
	)
;
ALTER TABLE ccae_tests_native.enrollment_summary owner to rhealth_etl;


-- ccae_tests_native.facility_header definition

-- Drop table

-- DROP TABLE ccae_tests_native.facility_header;

--DROP TABLE ccae_tests_native.facility_header;
CREATE TABLE IF NOT EXISTS ccae_tests_native.facility_header
(
	_flag SMALLINT   ENCODE az64
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE zstd
	,billtyp CHAR(3)   ENCODE zstd
	,cap_svc CHAR(1)   ENCODE zstd
	,caseid INTEGER   ENCODE az64
	,cob DOUBLE PRECISION   ENCODE zstd
	,coins DOUBLE PRECISION   ENCODE zstd
	,copay DOUBLE PRECISION   ENCODE zstd
	,datatyp SMALLINT   ENCODE az64
	,deduct DOUBLE PRECISION   ENCODE zstd
	,dobyr SMALLINT   ENCODE az64
	,dstatus CHAR(2)   ENCODE zstd
	,dx1 CHAR(7)   ENCODE zstd
	,dx2 CHAR(7)   ENCODE zstd
	,dx3 CHAR(7)   ENCODE zstd
	,dx4 CHAR(7)   ENCODE zstd
	,dx5 CHAR(7)   ENCODE zstd
	,dx6 CHAR(7)   ENCODE zstd
	,dx7 CHAR(7)   ENCODE zstd
	,dx8 CHAR(7)   ENCODE zstd
	,dx9 CHAR(7)   ENCODE zstd
	,dxver CHAR(1)   ENCODE lzo
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE zstd
	,eidflag CHAR(1)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrflag CHAR(1)   ENCODE zstd
	,enrolid BIGINT   ENCODE az64
	,fachdid BIGINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE zstd
	,indstry CHAR(1)   ENCODE zstd
	,mdc CHAR(2)   ENCODE zstd
	,mhsacovg CHAR(1)   ENCODE zstd
	,msa INTEGER   ENCODE az64
	,netpay DOUBLE PRECISION   ENCODE zstd
	,ntwkprov CHAR(1)   ENCODE zstd
	,paidntwk CHAR(1)   ENCODE zstd
	,pddate DATE   ENCODE az64
	,phyflag CHAR(1)   ENCODE zstd
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,proc1 CHAR(7)   ENCODE zstd
	,proc2 CHAR(7)   ENCODE zstd
	,proc3 CHAR(7)   ENCODE zstd
	,proc4 CHAR(7)   ENCODE lzo
	,proc5 CHAR(7)   ENCODE lzo
	,proc6 CHAR(7)   ENCODE lzo
	,provid INTEGER   ENCODE az64
	,"region" CHAR(1)   ENCODE zstd
	,rx CHAR(1)   ENCODE zstd
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,stdplac SMALLINT   ENCODE az64
	,stdprov SMALLINT   ENCODE az64
	,svcdate DATE   ENCODE az64
	,tsvcdat DATE   ENCODE az64
	,version CHAR(2)   ENCODE zstd
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,msclmid INTEGER   ENCODE az64
	,npi VARCHAR(10)   ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	svcdate
	, _flag
	)
;
ALTER TABLE ccae_tests_native.facility_header owner to rhealth_etl;


-- ccae_tests_native.geoloc definition

-- Drop table

-- DROP TABLE ccae_tests_native.geoloc;

--DROP TABLE ccae_tests_native.geoloc;
CREATE TABLE IF NOT EXISTS ccae_tests_native.geoloc
(
	egeoloc CHAR(2)   ENCODE lzo
	,egeoloc_description VARCHAR(42)   ENCODE lzo
	,state CHAR(2)   ENCODE lzo
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.geoloc owner to rhealth_etl;


-- ccae_tests_native.health_risk_assessment definition

-- Drop table

-- DROP TABLE ccae_tests_native.health_risk_assessment;

--DROP TABLE ccae_tests_native.health_risk_assessment;
CREATE TABLE IF NOT EXISTS ccae_tests_native.health_risk_assessment
(
	_flag SMALLINT   ENCODE az64
	,alc_amt CHAR(1)   ENCODE zstd
	,alcdyamt CHAR(1)   ENCODE zstd
	,alcweek CHAR(1)   ENCODE zstd
	,bmi DOUBLE PRECISION   ENCODE zstd
	,cc_allergy CHAR(1)   ENCODE zstd
	,cc_arthritis CHAR(1)   ENCODE zstd
	,cc_asthma CHAR(1)   ENCODE zstd
	,cc_backpain CHAR(1)   ENCODE zstd
	,cc_chf CHAR(1)   ENCODE zstd
	,cc_depress CHAR(1)   ENCODE zstd
	,cc_diab CHAR(1)   ENCODE zstd
	,cc_heartdis CHAR(1)   ENCODE zstd
	,cc_highbp CHAR(1)   ENCODE zstd
	,cc_highcol CHAR(1)   ENCODE zstd
	,cc_hrtburn CHAR(1)   ENCODE zstd
	,cc_lungdis CHAR(1)   ENCODE zstd
	,cc_migraine CHAR(1)   ENCODE zstd
	,cc_nonskincan CHAR(1)   ENCODE zstd
	,cc_osteopo CHAR(1)   ENCODE zstd
	,cc_skincan CHAR(1)   ENCODE zstd
	,cgramt CHAR(1)   ENCODE lzo
	,cgrcurr CHAR(1)   ENCODE zstd
	,cgrdur CHAR(1)   ENCODE lzo
	,cgrprev CHAR(1)   ENCODE zstd
	,cgrqtyr SMALLINT   ENCODE az64
	,cgrquit CHAR(1)   ENCODE lzo
	,cgtamt CHAR(1)   ENCODE zstd
	,cgtcurr CHAR(1)   ENCODE zstd
	,cgtdur CHAR(1)   ENCODE zstd
	,cgtpkamt CHAR(1)   ENCODE zstd
	,cgtprev CHAR(1)   ENCODE zstd
	,cgtqtcat CHAR(1)   ENCODE zstd
	,cgtqtyr SMALLINT   ENCODE az64
	,cgtquit CHAR(1)   ENCODE zstd
	,chewamt CHAR(1)   ENCODE lzo
	,chewcurr CHAR(1)   ENCODE zstd
	,chewdur CHAR(1)   ENCODE lzo
	,chewprev CHAR(1)   ENCODE zstd
	,chewqtyr SMALLINT   ENCODE az64
	,chewquit CHAR(1)   ENCODE lzo
	,cholestr DOUBLE PRECISION   ENCODE zstd
	,copestrs CHAR(1)   ENCODE zstd
	,diast_bp SMALLINT   ENCODE az64
	,dietfrt CHAR(1)   ENCODE zstd
	,dietfrvg CHAR(1)   ENCODE zstd
	,dietveg CHAR(1)   ENCODE zstd
	,dobyr SMALLINT   ENCODE az64
	,drnkdrv CHAR(1)   ENCODE zstd
	,educ_lvl CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,enrolid BIGINT   ENCODE az64
	,exermo CHAR(1)   ENCODE zstd
	,exerweek SMALLINT   ENCODE az64
	,famabscat12 CHAR(1)   ENCODE zstd
	,fireext CHAR(1)   ENCODE zstd
	,flu_shot CHAR(1)   ENCODE zstd
	,glucose DOUBLE PRECISION   ENCODE zstd
	,hdl DOUBLE PRECISION   ENCODE zstd
	,height SMALLINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE lzo
	,hltimpct CHAR(1)   ENCODE zstd
	,job_sat CHAR(1)   ENCODE zstd
	,ldl DOUBLE PRECISION   ENCODE zstd
	,life_sat CHAR(1)   ENCODE zstd
	,liftwgt CHAR(1)   ENCODE zstd
	,mh_freq CHAR(1)   ENCODE zstd
	,mh_prob CHAR(1)   ENCODE zstd
	,pipeamt CHAR(1)   ENCODE lzo
	,pipecurr CHAR(1)   ENCODE zstd
	,pipedur CHAR(1)   ENCODE lzo
	,pipeprev CHAR(1)   ENCODE zstd
	,pipeqtyr SMALLINT   ENCODE az64
	,pipequit CHAR(1)   ENCODE lzo
	,planalc CHAR(1)   ENCODE zstd
	,plandiet CHAR(1)   ENCODE zstd
	,plandrad CHAR(1)   ENCODE zstd
	,planexer CHAR(1)   ENCODE zstd
	,planslp CHAR(1)   ENCODE lzo
	,planstrs CHAR(1)   ENCODE zstd
	,plantob CHAR(1)   ENCODE zstd
	,planwgt CHAR(1)   ENCODE zstd
	,prev_mammo CHAR(1)   ENCODE zstd
	,prev_paptest CHAR(1)   ENCODE zstd
	,prev_prostex CHAR(1)   ENCODE zstd
	,prev_sigmoid CHAR(1)   ENCODE zstd
	,prodabscat CHAR(1)   ENCODE zstd
	,risk_alc CHAR(1)   ENCODE zstd
	,risk_bp CHAR(1)   ENCODE zstd
	,risk_chol CHAR(1)   ENCODE zstd
	,risk_exer CHAR(1)   ENCODE zstd
	,risk_gluc CHAR(1)   ENCODE zstd
	,risk_mh CHAR(1)   ENCODE zstd
	,risk_nutr CHAR(1)   ENCODE zstd
	,risk_safe CHAR(1)   ENCODE zstd
	,risk_sleep CHAR(1)   ENCODE zstd
	,risk_smok CHAR(1)   ENCODE zstd
	,risk_wgt CHAR(1)   ENCODE zstd
	,seatbelt CHAR(1)   ENCODE zstd
	,selfhlth CHAR(1)   ENCODE zstd
	,seqnum INTEGER   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,sleep_hr CHAR(1)   ENCODE lzo
	,slpapnea CHAR(1)   ENCODE zstd
	,slpprob CHAR(1)   ENCODE zstd
	,smkdetect CHAR(1)   ENCODE zstd
	,stretch CHAR(1)   ENCODE zstd
	,survdate DATE   ENCODE az64
	,systo_bp SMALLINT   ENCODE az64
	,tobcurr CHAR(1)   ENCODE zstd
	,tobprev CHAR(1)   ENCODE zstd
	,triglycd DOUBLE PRECISION   ENCODE zstd
	,version CHAR(3)   ENCODE zstd
	,weight DOUBLE PRECISION   ENCODE zstd
	,workabs SMALLINT   ENCODE az64
	,wrkabscat CHAR(1)   ENCODE zstd
	,wrkabscat12 CHAR(1)   ENCODE zstd
	,"year" SMALLINT   ENCODE az64
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	survdate
	, _flag
	)
;
ALTER TABLE ccae_tests_native.health_risk_assessment owner to rhealth_etl;


-- ccae_tests_native.hra_question_ref definition

-- Drop table

-- DROP TABLE ccae_tests_native.hra_question_ref;

--DROP TABLE ccae_tests_native.hra_question_ref;
CREATE TABLE IF NOT EXISTS ccae_tests_native.hra_question_ref
(
	question_type_id INTEGER   ENCODE az64
	,category_value VARCHAR(255)   ENCODE lzo
	,category_name VARCHAR(255)   ENCODE lzo
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.hra_question_ref owner to rhealth_etl;


-- ccae_tests_native.hra_variable_ref definition

-- Drop table

-- DROP TABLE ccae_tests_native.hra_variable_ref;

--DROP TABLE ccae_tests_native.hra_variable_ref;
CREATE TABLE IF NOT EXISTS ccae_tests_native.hra_variable_ref
(
	variable_name VARCHAR(255)   ENCODE lzo
	,variable_longname VARCHAR(255)   ENCODE lzo
	,variable_description VARCHAR(255)   ENCODE lzo
	,notes VARCHAR(255)   ENCODE lzo
	,question_type_id DOUBLE PRECISION   ENCODE RAW
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.hra_variable_ref owner to rhealth_etl;


-- ccae_tests_native.icd9 definition

-- Drop table

-- DROP TABLE ccae_tests_native.icd9;

--DROP TABLE ccae_tests_native.icd9;
CREATE TABLE IF NOT EXISTS ccae_tests_native.icd9
(
	icd_key VARCHAR(9)   ENCODE lzo
	,icd_code VARCHAR(9)   ENCODE lzo
	,parent_icd_code VARCHAR(9)   ENCODE lzo
	,"level" SMALLINT   ENCODE az64
	,children_count SMALLINT   ENCODE az64
	,children_count_recursive SMALLINT   ENCODE az64
	,description VARCHAR(250)   ENCODE lzo
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.icd9 owner to rhealth_etl;


-- ccae_tests_native.inpatient_admissions definition

-- Drop table

-- DROP TABLE ccae_tests_native.inpatient_admissions;

--DROP TABLE ccae_tests_native.inpatient_admissions;
CREATE TABLE IF NOT EXISTS ccae_tests_native.inpatient_admissions
(
	_flag SMALLINT   ENCODE az64
	,admdate DATE   ENCODE az64
	,admtyp CHAR(1)   ENCODE zstd
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE zstd
	,caseid INTEGER   ENCODE az64
	,datatyp SMALLINT   ENCODE az64
	,days SMALLINT   ENCODE az64
	,disdate DATE   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,drg SMALLINT   ENCODE az64
	,dstatus CHAR(2)   ENCODE zstd
	,dx1 CHAR(7)   ENCODE zstd
	,dx10 CHAR(7)   ENCODE zstd
	,dx11 CHAR(7)   ENCODE zstd
	,dx12 CHAR(7)   ENCODE zstd
	,dx13 CHAR(7)   ENCODE zstd
	,dx14 CHAR(7)   ENCODE lzo
	,dx15 CHAR(7)   ENCODE lzo
	,dx2 CHAR(7)   ENCODE zstd
	,dx3 CHAR(7)   ENCODE zstd
	,dx4 CHAR(7)   ENCODE zstd
	,dx5 CHAR(7)   ENCODE zstd
	,dx6 CHAR(7)   ENCODE zstd
	,dx7 CHAR(7)   ENCODE zstd
	,dx8 CHAR(7)   ENCODE zstd
	,dx9 CHAR(7)   ENCODE zstd
	,dxver CHAR(1)   ENCODE lzo
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE zstd
	,eidflag CHAR(1)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrflag CHAR(1)   ENCODE zstd
	,enrolid BIGINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE zstd
	,hospnet DOUBLE PRECISION   ENCODE RAW
	,hosppay DOUBLE PRECISION   ENCODE RAW
	,indstry CHAR(1)   ENCODE zstd
	,mdc CHAR(2)   ENCODE zstd
	,mhsacovg CHAR(1)   ENCODE zstd
	,msa INTEGER   ENCODE az64
	,pdx CHAR(7)   ENCODE zstd
	,phyflag CHAR(1)   ENCODE zstd
	,physid INTEGER   ENCODE az64
	,physnet DOUBLE PRECISION   ENCODE zstd
	,physpay DOUBLE PRECISION   ENCODE zstd
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,pproc CHAR(7)   ENCODE zstd
	,proc1 CHAR(7)   ENCODE zstd
	,proc10 CHAR(7)   ENCODE zstd
	,proc11 CHAR(7)   ENCODE zstd
	,proc12 CHAR(7)   ENCODE zstd
	,proc13 CHAR(7)   ENCODE zstd
	,proc14 CHAR(7)   ENCODE zstd
	,proc15 CHAR(7)   ENCODE zstd
	,proc2 CHAR(7)   ENCODE zstd
	,proc3 CHAR(7)   ENCODE zstd
	,proc4 CHAR(7)   ENCODE zstd
	,proc5 CHAR(7)   ENCODE zstd
	,proc6 CHAR(7)   ENCODE zstd
	,proc7 CHAR(7)   ENCODE zstd
	,proc8 CHAR(7)   ENCODE zstd
	,proc9 CHAR(7)   ENCODE zstd
	,"region" CHAR(1)   ENCODE zstd
	,rx CHAR(1)   ENCODE zstd
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,state CHAR(2)   ENCODE zstd
	,totcob DOUBLE PRECISION   ENCODE zstd
	,totcoins DOUBLE PRECISION   ENCODE zstd
	,totcopay DOUBLE PRECISION   ENCODE zstd
	,totded DOUBLE PRECISION   ENCODE zstd
	,totnet DOUBLE PRECISION   ENCODE RAW
	,totpay DOUBLE PRECISION   ENCODE RAW
	,version CHAR(2)   ENCODE zstd
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	admdate
	, _flag
	)
;
ALTER TABLE ccae_tests_native.inpatient_admissions owner to rhealth_etl;


-- ccae_tests_native.inpatient_services definition

-- Drop table

-- DROP TABLE ccae_tests_native.inpatient_services;

--DROP TABLE ccae_tests_native.inpatient_services;
CREATE TABLE IF NOT EXISTS ccae_tests_native.inpatient_services
(
	_flag SMALLINT   ENCODE az64
	,admdate DATE   ENCODE az64
	,admtyp CHAR(1)   ENCODE zstd
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE zstd
	,cap_svc CHAR(1)   ENCODE zstd
	,caseid INTEGER   ENCODE az64
	,cob DOUBLE PRECISION   ENCODE zstd
	,coins DOUBLE PRECISION   ENCODE zstd
	,copay DOUBLE PRECISION   ENCODE zstd
	,datatyp SMALLINT   ENCODE az64
	,deduct DOUBLE PRECISION   ENCODE zstd
	,disdate DATE   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,drg SMALLINT   ENCODE az64
	,dstatus CHAR(2)   ENCODE zstd
	,dx1 CHAR(7)   ENCODE zstd
	,dx2 CHAR(7)   ENCODE zstd
	,dx3 CHAR(7)   ENCODE zstd
	,dx4 CHAR(7)   ENCODE zstd
	,dx5 CHAR(7)   ENCODE zstd
	,dxver CHAR(1)   ENCODE zstd
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE zstd
	,eidflag CHAR(1)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrflag CHAR(1)   ENCODE zstd
	,enrolid BIGINT   ENCODE az64
	,fachdid BIGINT   ENCODE az64
	,facprof CHAR(1)   ENCODE zstd
	,hlthplan CHAR(1)   ENCODE zstd
	,indstry CHAR(1)   ENCODE zstd
	,mdc CHAR(2)   ENCODE zstd
	,mhsacovg CHAR(1)   ENCODE zstd
	,msa INTEGER   ENCODE az64
	,netpay DOUBLE PRECISION   ENCODE zstd
	,ntwkprov CHAR(1)   ENCODE zstd
	,paidntwk CHAR(1)   ENCODE zstd
	,pay DOUBLE PRECISION   ENCODE zstd
	,pddate DATE   ENCODE az64
	,pdx CHAR(7)   ENCODE zstd
	,phyflag CHAR(1)   ENCODE zstd
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,pproc CHAR(7)   ENCODE zstd
	,proc1 CHAR(7)   ENCODE zstd
	,procmod CHAR(2)   ENCODE zstd
	,proctyp CHAR(1)   ENCODE zstd
	,provid INTEGER   ENCODE az64
	,qty INTEGER   ENCODE az64
	,"region" CHAR(1)   ENCODE zstd
	,revcode CHAR(4)   ENCODE zstd
	,rx CHAR(1)   ENCODE zstd
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,stdplac SMALLINT   ENCODE az64
	,stdprov SMALLINT   ENCODE az64
	,svcdate DATE   ENCODE az64
	,svcscat CHAR(5)   ENCODE zstd
	,tsvcdat DATE   ENCODE az64
	,version CHAR(2)   ENCODE zstd
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,units DOUBLE PRECISION   ENCODE zstd
	,npi VARCHAR(10)   ENCODE zstd
	,msclmid INTEGER   ENCODE az64
	,medadv VARCHAR(50) ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	admdate
	, _flag
	)
;
ALTER TABLE ccae_tests_native.inpatient_services owner to rhealth_etl;


-- ccae_tests_native.lab definition

-- Drop table

-- DROP TABLE ccae_tests_native.lab;

--DROP TABLE ccae_tests_native.lab;
CREATE TABLE IF NOT EXISTS ccae_tests_native.lab
(
	enrolid BIGINT   ENCODE az64
	,seqnum BIGINT   ENCODE az64
	,abnormal CHAR(1)   ENCODE zstd
	,agegrp CHAR(1)   ENCODE zstd
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,eidflag CHAR(1)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrflag CHAR(1)   ENCODE zstd
	,hlthplan CHAR(1)   ENCODE zstd
	,indstry CHAR(1)   ENCODE lzo
	,mhsacovg CHAR(1)   ENCODE zstd
	,phyflag CHAR(1)   ENCODE zstd
	,proctyp CHAR(1)   ENCODE zstd
	,"region" CHAR(1)   ENCODE zstd
	,rx CHAR(1)   ENCODE zstd
	,sex CHAR(1)   ENCODE zstd
	,egeoloc CHAR(2)   ENCODE zstd
	,mdc CHAR(2)   ENCODE zstd
	,version CHAR(2)   ENCODE zstd
	,resltcat CHAR(3)   ENCODE lzo
	,dx1 CHAR(7)   ENCODE zstd
	,proc1 CHAR(7)   ENCODE zstd
	,pddate DATE   ENCODE az64
	,svcdate DATE   ENCODE az64
	,msa INTEGER   ENCODE az64
	,orderid INTEGER   ENCODE az64
	,provid INTEGER   ENCODE az64
	,refhigh DOUBLE PRECISION   ENCODE zstd
	,reflow DOUBLE PRECISION   ENCODE zstd
	,"result" DOUBLE PRECISION   ENCODE zstd
	,testcnt INTEGER   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,plankey SMALLINT   ENCODE az64
	,stdprov SMALLINT   ENCODE az64
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,age SMALLINT   ENCODE az64
	,datatyp SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,stdplac SMALLINT   ENCODE az64
	,loinccd VARCHAR(7)   ENCODE zstd
	,resunit VARCHAR(30)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,dxver CHAR(1)   ENCODE lzo
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	svcdate
	)
;
ALTER TABLE ccae_tests_native.lab owner to rhealth_etl;


-- ccae_tests_native.loinc definition

-- Drop table

-- DROP TABLE ccae_tests_native.loinc;

--DROP TABLE ccae_tests_native.loinc;
CREATE TABLE IF NOT EXISTS ccae_tests_native.loinc
(
	loinc_num CHAR(7) NOT NULL  ENCODE lzo
	,component VARCHAR(500) NOT NULL  ENCODE lzo
	,property VARCHAR(50)   ENCODE lzo
	,time_aspct VARCHAR(15)   ENCODE lzo
	,"system" VARCHAR(100)   ENCODE lzo
	,scale_typ VARCHAR(5)   ENCODE lzo
	,method_typ VARCHAR(100)   ENCODE lzo
	,relat_nms VARCHAR(500)   ENCODE lzo
	,"class" VARCHAR(50)   ENCODE lzo
	,source VARCHAR(20)   ENCODE lzo
	,dt_last_ch VARCHAR(8)   ENCODE lzo
	,chng_type CHAR(3) NOT NULL  ENCODE lzo
	,comments VARCHAR(4500)   ENCODE lzo
	,answerlist VARCHAR(200)   ENCODE lzo
	,status VARCHAR(20) NOT NULL  ENCODE lzo
	,map_to VARCHAR(7)   ENCODE lzo
	,scope VARCHAR(20)   ENCODE lzo
	,consumer_name VARCHAR(100)   ENCODE lzo
	,ipcc_units VARCHAR(20)   ENCODE lzo
	,reference VARCHAR(500)   ENCODE lzo
	,exact_cmp_sy VARCHAR(50)   ENCODE lzo
	,molar_mass VARCHAR(20)   ENCODE lzo
	,classtype INTEGER NOT NULL  ENCODE az64
	,formula VARCHAR(500)   ENCODE lzo
	,species VARCHAR(20)   ENCODE lzo
	,exmpl_answers VARCHAR(4000)   ENCODE lzo
	,acssym VARCHAR(2600)   ENCODE lzo
	,base_name VARCHAR(50)   ENCODE lzo
	,final CHAR(1) NOT NULL  ENCODE lzo
	,naaccr_id VARCHAR(20)   ENCODE lzo
	,code_table VARCHAR(20)   ENCODE lzo
	,setroot BOOLEAN NOT NULL  ENCODE RAW
	,panelelements VARCHAR(500)   ENCODE lzo
	,survey_quest_text VARCHAR(500)   ENCODE lzo
	,survey_quest_src VARCHAR(50)   ENCODE lzo
	,unitsrequired CHAR(1)   ENCODE lzo
	,submitted_units VARCHAR(50)   ENCODE lzo
	,relatednames2 VARCHAR(1000)   ENCODE zstd
	,shortname VARCHAR(40)   ENCODE lzo
	,order_obs VARCHAR(15)   ENCODE lzo
	,cdisc_common_tests CHAR(1)   ENCODE lzo
	,hl7_field_subfield_id VARCHAR(50)   ENCODE lzo
	,external_copyright_notice VARCHAR(500)   ENCODE lzo
	,example_units VARCHAR(100)   ENCODE lzo
	,inpc_percentage REAL NOT NULL  ENCODE RAW
	,long_common_name VARCHAR(500)   ENCODE lzo
	,hl7_v2_datatype VARCHAR(10)   ENCODE lzo
	,hl7_v3_datatype VARCHAR(10)   ENCODE lzo
	,curated_range_and_units VARCHAR(50)   ENCODE lzo
	,document_section VARCHAR(50)   ENCODE lzo
	,definition_description_help VARCHAR(1000)   ENCODE lzo
	,example_ucum_units VARCHAR(50)   ENCODE lzo
	,example_si_ucum_units VARCHAR(50)   ENCODE lzo
	,status_reason VARCHAR(9)   ENCODE lzo
	,status_text VARCHAR(500)   ENCODE lzo
	,change_reason_public VARCHAR(500)   ENCODE lzo
	,common_test_rank INTEGER   ENCODE az64
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.loinc owner to rhealth_etl;


-- ccae_tests_native.outpatient_services definition

-- Drop table

-- DROP TABLE ccae_tests_native.outpatient_services;

--DROP TABLE ccae_tests_native.outpatient_services;
CREATE TABLE IF NOT EXISTS ccae_tests_native.outpatient_services
(
	_flag SMALLINT   ENCODE az64
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE zstd
	,cap_svc CHAR(1)   ENCODE zstd
	,cob DOUBLE PRECISION   ENCODE zstd
	,coins DOUBLE PRECISION   ENCODE zstd
	,copay DOUBLE PRECISION   ENCODE zstd
	,datatyp SMALLINT   ENCODE az64
	,deduct DOUBLE PRECISION   ENCODE zstd
	,dobyr SMALLINT   ENCODE az64
	,dx1 CHAR(7)   ENCODE zstd
	,dx2 CHAR(7)   ENCODE zstd
	,dx3 CHAR(7)   ENCODE zstd
	,dx4 CHAR(7)   ENCODE zstd
	,dx5 CHAR(7)   ENCODE zstd
	,dxver CHAR(1)   ENCODE zstd
	,eeclass CHAR(1)   ENCODE zstd
	,eestatu CHAR(1)   ENCODE zstd
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE zstd
	,eidflag CHAR(1)   ENCODE zstd
	,emprel CHAR(1)   ENCODE zstd
	,enrflag CHAR(1)   ENCODE zstd
	,enrolid BIGINT   ENCODE az64
	,fachdid BIGINT   ENCODE az64
	,facprof CHAR(1)   ENCODE zstd
	,hlthplan CHAR(1)   ENCODE zstd
	,indstry CHAR(1)   ENCODE zstd
	,mdc CHAR(2)   ENCODE zstd
	,mhsacovg CHAR(1)   ENCODE zstd
	,msa INTEGER   ENCODE az64
	,netpay DOUBLE PRECISION   ENCODE zstd
	,ntwkprov CHAR(1)   ENCODE zstd
	,paidntwk CHAR(1)   ENCODE zstd
	,pay DOUBLE PRECISION   ENCODE zstd
	,pddate DATE   ENCODE az64
	,phyflag CHAR(1)   ENCODE zstd
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,proc1 CHAR(7)   ENCODE zstd
	,procgrp SMALLINT   ENCODE az64
	,procmod CHAR(2)   ENCODE zstd
	,proctyp CHAR(1)   ENCODE zstd
	,provid INTEGER   ENCODE az64
	,qty INTEGER   ENCODE az64
	,"region" CHAR(1)   ENCODE zstd
	,revcode CHAR(4)   ENCODE zstd
	,rx CHAR(1)   ENCODE zstd
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE zstd
	,stdplac SMALLINT   ENCODE az64
	,stdprov SMALLINT   ENCODE az64
	,svcdate DATE   ENCODE az64
	,svcscat CHAR(5)   ENCODE zstd
	,tsvcdat DATE   ENCODE az64
	,version CHAR(2)   ENCODE zstd
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,units DOUBLE PRECISION   ENCODE zstd
	,npi VARCHAR(10)   ENCODE zstd
	,msclmid INTEGER   ENCODE az64
	,medadv VARCHAR(50) ENCODE zstd
)
DISTSTYLE KEY
 DISTKEY (enrolid)
 SORTKEY (
	svcdate
	, _flag
	)
;
ALTER TABLE ccae_tests_native.outpatient_services owner to rhealth_etl;


-- ccae_tests_native.populations definition

-- Drop table

-- DROP TABLE ccae_tests_native.populations;

--DROP TABLE ccae_tests_native.populations;
CREATE TABLE IF NOT EXISTS ccae_tests_native.populations
(
	_flag SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE lzo
	,datatyp SMALLINT   ENCODE az64
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,egeoloc CHAR(2)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrflag CHAR(1)   ENCODE lzo
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,phyflag CHAR(1)   ENCODE lzo
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,popcnt DOUBLE PRECISION   ENCODE zstd
	,popdate DATE   ENCODE az64
	,"region" CHAR(1)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,sex CHAR(1)   ENCODE lzo
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.populations owner to rhealth_etl;


-- ccae_tests_native.red_book definition

-- Drop table

-- DROP TABLE ccae_tests_native.red_book;

--DROP TABLE ccae_tests_native.red_book;
CREATE TABLE IF NOT EXISTS ccae_tests_native.red_book
(
	_flag SMALLINT   ENCODE az64
	,deaclas CHAR(1)   ENCODE lzo
	,deaclds VARCHAR(50)   ENCODE zstd
	,desidrg CHAR(1)   ENCODE lzo
	,excdgds VARCHAR(30)   ENCODE lzo
	,excldrg CHAR(2)   ENCODE lzo
	,generid INTEGER   ENCODE az64
	,genind CHAR(1)   ENCODE lzo
	,gennme VARCHAR(50)   ENCODE zstd
	,gnindds VARCHAR(30)   ENCODE zstd
	,maintds VARCHAR(30)   ENCODE zstd
	,maintin CHAR(1)   ENCODE lzo
	,manfnme VARCHAR(50)   ENCODE zstd
	,mastfrm CHAR(3)   ENCODE lzo
	,metsize VARCHAR(30)   ENCODE zstd
	,mstfmds VARCHAR(30)   ENCODE zstd
	,ndcnum VARCHAR(11)   ENCODE zstd
	,orgbkcd CHAR(3)   ENCODE lzo
	,orgbkds VARCHAR(30)   ENCODE zstd
	,orgbkfg CHAR(1)   ENCODE lzo
	,pkqtycd CHAR(3)   ENCODE lzo
	,pksize INTEGER   ENCODE az64
	,prdctds VARCHAR(30)   ENCODE zstd
	,prodcat CHAR(2)   ENCODE lzo
	,prodnme VARCHAR(50)   ENCODE zstd
	,siglsrc CHAR(1)   ENCODE lzo
	,strngth VARCHAR(30)   ENCODE zstd
	,roacd VARCHAR(2)   ENCODE lzo
	,roads VARCHAR(30)   ENCODE lzo
	,thercls VARCHAR(3)   ENCODE zstd
	,therdtl VARCHAR(10)   ENCODE zstd
	,thergrp VARCHAR(2)   ENCODE zstd
	,thrclds VARCHAR(30)   ENCODE zstd
	,thrdtds VARCHAR(30)   ENCODE zstd
	,thrgrds VARCHAR(30)   ENCODE zstd
	,"year" SMALLINT   ENCODE az64
)
DISTSTYLE ALL
;
ALTER TABLE ccae_tests_native.red_book owner to rhealth_etl;


