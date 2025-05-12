-- DROP SCHEMA ccae_tests_native;

CREATE SCHEMA ccae_tests_native;
-- ccae_tests_native."_pos_episode_visit" definition

-- Drop table

-- DROP TABLE ccae_tests_native."_pos_episode_visit";

--DROP TABLE ccae_tests_native._pos_episode_visit;
CREATE TABLE IF NOT EXISTS ccae_tests_native._pos_episode_visit
(
	episode_id BIGINT   ENCODE az64
	,enrolid BIGINT   ENCODE az64
	,dt_start DATE   ENCODE az64
	,dt_end DATE   ENCODE az64
	,visit_type VARCHAR(3)   ENCODE lzo
)
DISTSTYLE AUTO
;
ALTER TABLE ccae_tests_native._pos_episode_visit owner to rhealth_etl;


-- ccae_tests_native."_version" definition

-- Drop table

-- DROP TABLE ccae_tests_native."_version";

--DROP TABLE ccae_tests_native._version;
CREATE TABLE IF NOT EXISTS ccae_tests_native._version
(
	version_id INTEGER   ENCODE az64
	,version_date DATE   ENCODE az64
)
DISTSTYLE AUTO
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
DISTSTYLE AUTO
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
	,agegrp CHAR(1)   ENCODE lzo
	,awp DOUBLE PRECISION   ENCODE RAW
	,cap_svc CHAR(1)   ENCODE lzo
	,cob DOUBLE PRECISION   ENCODE RAW
	,coins DOUBLE PRECISION   ENCODE RAW
	,copay DOUBLE PRECISION   ENCODE RAW
	,datatyp SMALLINT   ENCODE az64
	,dawind CHAR(2)   ENCODE lzo
	,daysupp SMALLINT   ENCODE az64
	,deaclas CHAR(1)   ENCODE lzo
	,deduct DOUBLE PRECISION   ENCODE RAW
	,dispfee DOUBLE PRECISION   ENCODE RAW
	,dobyr SMALLINT   ENCODE az64
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE lzo
	,eidflag CHAR(1)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrflag CHAR(1)   ENCODE lzo
	,enrolid BIGINT   ENCODE az64
	,generid INTEGER   ENCODE az64
	,genind CHAR(1)   ENCODE lzo
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
	,ingcost DOUBLE PRECISION   ENCODE RAW
	,maintin CHAR(1)   ENCODE lzo
	,metqty DOUBLE PRECISION   ENCODE RAW
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,ndcnum VARCHAR(11)   ENCODE lzo
	,netpay DOUBLE PRECISION   ENCODE RAW
	,ntwkprov CHAR(1)   ENCODE lzo
	,paidntwk CHAR(1)   ENCODE lzo
	,pay DOUBLE PRECISION   ENCODE RAW
	,pddate DATE   ENCODE az64
	,pharmid INTEGER   ENCODE az64
	,phyflag CHAR(1)   ENCODE lzo
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,qty INTEGER   ENCODE az64
	,refill SMALLINT   ENCODE az64
	,"region" CHAR(1)   ENCODE lzo
	,rxmr CHAR(1)   ENCODE lzo
	,saletax DOUBLE PRECISION   ENCODE RAW
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,svcdate DATE   ENCODE az64
	,thercls SMALLINT   ENCODE az64
	,thergrp CHAR(2)   ENCODE lzo
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,medadv INTEGER   ENCODE az64
)
DISTSTYLE AUTO
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
	,agegrp CHAR(1)   ENCODE lzo
	,datatyp SMALLINT   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,dtend DATE   ENCODE az64
	,dtstart DATE   ENCODE az64
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrolid BIGINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
	,memdays SMALLINT   ENCODE az64
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,phyflag CHAR(1)   ENCODE lzo
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,"region" CHAR(1)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,medadv INTEGER   ENCODE az64
)
DISTSTYLE AUTO
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
	,agegrp CHAR(1)   ENCODE lzo
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
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
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
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
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
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,phyflag CHAR(1)   ENCODE lzo
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
	,"region" CHAR(1)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,mswgtkey VARCHAR(5)   ENCODE lzo
	,medadv1 INTEGER   ENCODE az64
	,medadv2 INTEGER   ENCODE az64
	,medadv3 INTEGER   ENCODE az64
	,medadv4 INTEGER   ENCODE az64
	,medadv5 INTEGER   ENCODE az64
	,medadv6 INTEGER   ENCODE az64
	,medadv7 INTEGER   ENCODE az64
	,medadv8 INTEGER   ENCODE az64
	,medadv9 INTEGER   ENCODE az64
	,medadv10 INTEGER   ENCODE az64
	,medadv11 INTEGER   ENCODE az64
	,medadv12 INTEGER   ENCODE az64
)
DISTSTYLE AUTO
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
	,agegrp CHAR(1)   ENCODE lzo
	,billtyp CHAR(3)   ENCODE lzo
	,cap_svc CHAR(1)   ENCODE lzo
	,caseid INTEGER   ENCODE az64
	,cob DOUBLE PRECISION   ENCODE RAW
	,coins DOUBLE PRECISION   ENCODE RAW
	,copay DOUBLE PRECISION   ENCODE RAW
	,datatyp SMALLINT   ENCODE az64
	,deduct DOUBLE PRECISION   ENCODE RAW
	,dobyr SMALLINT   ENCODE az64
	,dstatus CHAR(2)   ENCODE lzo
	,dx1 CHAR(8)   ENCODE lzo
	,dx2 CHAR(7)   ENCODE lzo
	,dx3 CHAR(7)   ENCODE lzo
	,dx4 CHAR(7)   ENCODE lzo
	,dx5 CHAR(7)   ENCODE lzo
	,dx6 CHAR(7)   ENCODE lzo
	,dx7 CHAR(7)   ENCODE lzo
	,dx8 CHAR(7)   ENCODE lzo
	,dx9 CHAR(7)   ENCODE lzo
	,dxver CHAR(1)   ENCODE lzo
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE lzo
	,eidflag CHAR(1)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrflag CHAR(1)   ENCODE lzo
	,enrolid BIGINT   ENCODE az64
	,fachdid BIGINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
	,mdc CHAR(2)   ENCODE lzo
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,netpay DOUBLE PRECISION   ENCODE RAW
	,ntwkprov CHAR(1)   ENCODE lzo
	,paidntwk CHAR(1)   ENCODE lzo
	,pddate DATE   ENCODE az64
	,phyflag CHAR(1)   ENCODE lzo
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,poadx1 CHAR(8)   ENCODE lzo
	,poadx2 CHAR(1)   ENCODE lzo
	,poadx3 CHAR(1)   ENCODE lzo
	,poadx4 CHAR(1)   ENCODE lzo
	,poadx5 CHAR(1)   ENCODE lzo
	,poadx6 CHAR(1)   ENCODE lzo
	,poadx7 CHAR(1)   ENCODE lzo
	,poadx8 CHAR(1)   ENCODE lzo
	,poadx9 CHAR(1)   ENCODE lzo
	,proc1 CHAR(7)   ENCODE lzo
	,proc2 CHAR(7)   ENCODE lzo
	,proc3 CHAR(7)   ENCODE lzo
	,proc4 CHAR(7)   ENCODE lzo
	,proc5 CHAR(7)   ENCODE lzo
	,proc6 CHAR(7)   ENCODE lzo
	,provid INTEGER   ENCODE az64
	,"region" CHAR(1)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,stdplac SMALLINT   ENCODE az64
	,stdprov SMALLINT   ENCODE az64
	,svcdate DATE   ENCODE az64
	,tsvcdat DATE   ENCODE az64
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,msclmid INTEGER   ENCODE az64
	,npi VARCHAR(10)   ENCODE lzo
	,medadv INTEGER   ENCODE az64
)
DISTSTYLE AUTO
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
DISTSTYLE AUTO
;
ALTER TABLE ccae_tests_native.geoloc owner to rhealth_etl;


-- ccae_tests_native.health_risk_assessment definition

-- Drop table

-- DROP TABLE ccae_tests_native.health_risk_assessment;

--DROP TABLE ccae_tests_native.health_risk_assessment;
CREATE TABLE IF NOT EXISTS ccae_tests_native.health_risk_assessment
(
	_flag SMALLINT   ENCODE az64
	,alc_amt CHAR(1)   ENCODE lzo
	,alcdyamt CHAR(1)   ENCODE lzo
	,alcweek CHAR(1)   ENCODE lzo
	,bmi DOUBLE PRECISION   ENCODE RAW
	,cc_allergy CHAR(1)   ENCODE lzo
	,cc_arthritis CHAR(1)   ENCODE lzo
	,cc_asthma CHAR(1)   ENCODE lzo
	,cc_backpain CHAR(1)   ENCODE lzo
	,cc_chf CHAR(1)   ENCODE lzo
	,cc_depress CHAR(1)   ENCODE lzo
	,cc_diab CHAR(1)   ENCODE lzo
	,cc_heartdis CHAR(1)   ENCODE lzo
	,cc_highbp CHAR(1)   ENCODE lzo
	,cc_highcol CHAR(1)   ENCODE lzo
	,cc_hrtburn CHAR(1)   ENCODE lzo
	,cc_lungdis CHAR(1)   ENCODE lzo
	,cc_migraine CHAR(1)   ENCODE lzo
	,cc_nonskincan CHAR(1)   ENCODE lzo
	,cc_osteopo CHAR(1)   ENCODE lzo
	,cc_skincan CHAR(1)   ENCODE lzo
	,cgramt CHAR(1)   ENCODE lzo
	,cgrcurr CHAR(1)   ENCODE lzo
	,cgrdur CHAR(1)   ENCODE lzo
	,cgrprev CHAR(1)   ENCODE lzo
	,cgrqtyr SMALLINT   ENCODE az64
	,cgrquit CHAR(1)   ENCODE lzo
	,cgtamt CHAR(1)   ENCODE lzo
	,cgtcurr CHAR(1)   ENCODE lzo
	,cgtdur CHAR(1)   ENCODE lzo
	,cgtpkamt CHAR(1)   ENCODE lzo
	,cgtprev CHAR(1)   ENCODE lzo
	,cgtqtcat CHAR(1)   ENCODE lzo
	,cgtqtyr SMALLINT   ENCODE az64
	,cgtquit CHAR(1)   ENCODE lzo
	,chewamt CHAR(1)   ENCODE lzo
	,chewcurr CHAR(1)   ENCODE lzo
	,chewdur CHAR(1)   ENCODE lzo
	,chewprev CHAR(1)   ENCODE lzo
	,chewqtyr SMALLINT   ENCODE az64
	,chewquit CHAR(1)   ENCODE lzo
	,cholestr DOUBLE PRECISION   ENCODE RAW
	,copestrs CHAR(1)   ENCODE lzo
	,diast_bp SMALLINT   ENCODE az64
	,dietfrt CHAR(1)   ENCODE lzo
	,dietfrvg CHAR(1)   ENCODE lzo
	,dietveg CHAR(1)   ENCODE lzo
	,dobyr SMALLINT   ENCODE az64
	,drnkdrv CHAR(1)   ENCODE lzo
	,educ_lvl CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,enrolid BIGINT   ENCODE az64
	,exermo CHAR(1)   ENCODE lzo
	,exerweek SMALLINT   ENCODE az64
	,famabscat12 CHAR(1)   ENCODE lzo
	,fireext CHAR(1)   ENCODE lzo
	,flu_shot CHAR(1)   ENCODE lzo
	,glucose DOUBLE PRECISION   ENCODE RAW
	,gluc_fast CHAR(1)   ENCODE lzo
	,hdl DOUBLE PRECISION   ENCODE RAW
	,height SMALLINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE lzo
	,hltimpct CHAR(1)   ENCODE lzo
	,job_sat CHAR(1)   ENCODE lzo
	,ldl DOUBLE PRECISION   ENCODE RAW
	,life_sat CHAR(1)   ENCODE lzo
	,liftwgt CHAR(1)   ENCODE lzo
	,mh_freq CHAR(1)   ENCODE lzo
	,mh_prob CHAR(1)   ENCODE lzo
	,pipeamt CHAR(1)   ENCODE lzo
	,pipecurr CHAR(1)   ENCODE lzo
	,pipedur CHAR(1)   ENCODE lzo
	,pipeprev CHAR(1)   ENCODE lzo
	,pipeqtyr SMALLINT   ENCODE az64
	,pipequit CHAR(1)   ENCODE lzo
	,planalc CHAR(1)   ENCODE lzo
	,plandiet CHAR(1)   ENCODE lzo
	,plandrad CHAR(1)   ENCODE lzo
	,planexer CHAR(1)   ENCODE lzo
	,planslp CHAR(1)   ENCODE lzo
	,planstrs CHAR(1)   ENCODE lzo
	,plantob CHAR(1)   ENCODE lzo
	,planwgt CHAR(1)   ENCODE lzo
	,prev_mammo CHAR(1)   ENCODE lzo
	,prev_paptest CHAR(1)   ENCODE lzo
	,prev_prostex CHAR(1)   ENCODE lzo
	,prev_sigmoid CHAR(1)   ENCODE lzo
	,prodabscat CHAR(1)   ENCODE lzo
	,risk_alc CHAR(1)   ENCODE lzo
	,risk_bp CHAR(1)   ENCODE lzo
	,risk_chol CHAR(1)   ENCODE lzo
	,risk_depr CHAR(1)   ENCODE lzo
	,risk_exer CHAR(1)   ENCODE lzo
	,risk_gluc CHAR(1)   ENCODE lzo
	,risk_mh CHAR(1)   ENCODE lzo
	,risk_nutr CHAR(1)   ENCODE lzo
	,risk_safe CHAR(1)   ENCODE lzo
	,risk_sleep CHAR(1)   ENCODE lzo
	,risk_smok CHAR(1)   ENCODE lzo
	,risk_stress CHAR(1)   ENCODE lzo
	,risk_wgt CHAR(1)   ENCODE lzo
	,seatbelt CHAR(1)   ENCODE lzo
	,selfhlth CHAR(1)   ENCODE lzo
	,seqnum INTEGER   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,sleep_hr CHAR(1)   ENCODE lzo
	,slpapnea CHAR(1)   ENCODE lzo
	,slpprob CHAR(1)   ENCODE lzo
	,smkdetect CHAR(1)   ENCODE lzo
	,stretch CHAR(1)   ENCODE lzo
	,survdate DATE   ENCODE az64
	,systo_bp SMALLINT   ENCODE az64
	,tobcurr CHAR(1)   ENCODE lzo
	,tobprev CHAR(1)   ENCODE lzo
	,triglycd DOUBLE PRECISION   ENCODE RAW
	,version CHAR(3)   ENCODE lzo
	,weight DOUBLE PRECISION   ENCODE RAW
	,workabs SMALLINT   ENCODE az64
	,wrkabscat CHAR(1)   ENCODE lzo
	,wrkabscat12 CHAR(1)   ENCODE lzo
	,"year" SMALLINT   ENCODE az64
	,ecigvape CHAR(1)   ENCODE lzo
)
DISTSTYLE AUTO
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
DISTSTYLE AUTO
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
DISTSTYLE AUTO
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
DISTSTYLE AUTO
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
	,admtyp CHAR(1)   ENCODE lzo
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE lzo
	,caseid INTEGER   ENCODE az64
	,datatyp SMALLINT   ENCODE az64
	,days SMALLINT   ENCODE az64
	,disdate DATE   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,drg SMALLINT   ENCODE az64
	,dstatus CHAR(2)   ENCODE lzo
	,dx1 CHAR(8)   ENCODE lzo
	,dx10 CHAR(7)   ENCODE lzo
	,dx11 CHAR(7)   ENCODE lzo
	,dx12 CHAR(7)   ENCODE lzo
	,dx13 CHAR(7)   ENCODE lzo
	,dx14 CHAR(7)   ENCODE lzo
	,dx15 CHAR(7)   ENCODE lzo
	,dx2 CHAR(7)   ENCODE lzo
	,dx3 CHAR(7)   ENCODE lzo
	,dx4 CHAR(7)   ENCODE lzo
	,dx5 CHAR(7)   ENCODE lzo
	,dx6 CHAR(7)   ENCODE lzo
	,dx7 CHAR(7)   ENCODE lzo
	,dx8 CHAR(7)   ENCODE lzo
	,dx9 CHAR(7)   ENCODE lzo
	,dxver CHAR(1)   ENCODE lzo
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE lzo
	,eidflag CHAR(1)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrflag CHAR(1)   ENCODE lzo
	,enrolid BIGINT   ENCODE az64
	,hlthplan CHAR(1)   ENCODE lzo
	,hospnet DOUBLE PRECISION   ENCODE RAW
	,hosppay DOUBLE PRECISION   ENCODE RAW
	,indstry CHAR(1)   ENCODE lzo
	,mdc CHAR(2)   ENCODE lzo
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,pdx CHAR(8)   ENCODE lzo
	,phyflag CHAR(1)   ENCODE lzo
	,physid INTEGER   ENCODE az64
	,physnet DOUBLE PRECISION   ENCODE RAW
	,physpay DOUBLE PRECISION   ENCODE RAW
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,poapdx CHAR(8)   ENCODE lzo
	,poadx1 CHAR(8)   ENCODE lzo
	,poadx2 CHAR(1)   ENCODE lzo
	,poadx3 CHAR(1)   ENCODE lzo
	,poadx4 CHAR(1)   ENCODE lzo
	,poadx5 CHAR(1)   ENCODE lzo
	,poadx6 CHAR(1)   ENCODE lzo
	,poadx7 CHAR(1)   ENCODE lzo
	,poadx8 CHAR(1)   ENCODE lzo
	,poadx9 CHAR(1)   ENCODE lzo
	,poadx10 CHAR(1)   ENCODE lzo
	,poadx11 CHAR(1)   ENCODE lzo
	,poadx12 CHAR(1)   ENCODE lzo
	,poadx13 CHAR(1)   ENCODE lzo
	,poadx14 CHAR(1)   ENCODE lzo
	,poadx15 CHAR(1)   ENCODE lzo
	,pproc CHAR(7)   ENCODE lzo
	,proc1 CHAR(7)   ENCODE lzo
	,proc10 CHAR(7)   ENCODE lzo
	,proc11 CHAR(7)   ENCODE lzo
	,proc12 CHAR(7)   ENCODE lzo
	,proc13 CHAR(7)   ENCODE lzo
	,proc14 CHAR(7)   ENCODE lzo
	,proc15 CHAR(7)   ENCODE lzo
	,proc2 CHAR(7)   ENCODE lzo
	,proc3 CHAR(7)   ENCODE lzo
	,proc4 CHAR(7)   ENCODE lzo
	,proc5 CHAR(7)   ENCODE lzo
	,proc6 CHAR(7)   ENCODE lzo
	,proc7 CHAR(7)   ENCODE lzo
	,proc8 CHAR(7)   ENCODE lzo
	,proc9 CHAR(7)   ENCODE lzo
	,"region" CHAR(1)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,state CHAR(2)   ENCODE lzo
	,totcob DOUBLE PRECISION   ENCODE RAW
	,totcoins DOUBLE PRECISION   ENCODE RAW
	,totcopay DOUBLE PRECISION   ENCODE RAW
	,totded DOUBLE PRECISION   ENCODE RAW
	,totnet DOUBLE PRECISION   ENCODE RAW
	,totpay DOUBLE PRECISION   ENCODE RAW
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,medadv INTEGER   ENCODE az64
)
DISTSTYLE AUTO
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
	,admtyp CHAR(1)   ENCODE lzo
	,age SMALLINT   ENCODE az64
	,agegrp CHAR(1)   ENCODE lzo
	,cap_svc CHAR(1)   ENCODE lzo
	,caseid INTEGER   ENCODE az64
	,cob DOUBLE PRECISION   ENCODE RAW
	,coins DOUBLE PRECISION   ENCODE RAW
	,copay DOUBLE PRECISION   ENCODE RAW
	,datatyp SMALLINT   ENCODE az64
	,deduct DOUBLE PRECISION   ENCODE RAW
	,disdate DATE   ENCODE az64
	,dobyr SMALLINT   ENCODE az64
	,drg SMALLINT   ENCODE az64
	,dstatus CHAR(2)   ENCODE lzo
	,dx1 CHAR(8)   ENCODE lzo
	,dx2 CHAR(7)   ENCODE lzo
	,dx3 CHAR(7)   ENCODE lzo
	,dx4 CHAR(7)   ENCODE lzo
	,dx5 CHAR(7)   ENCODE lzo
	,dxver CHAR(1)   ENCODE lzo
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE lzo
	,eidflag CHAR(1)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrflag CHAR(1)   ENCODE lzo
	,enrolid BIGINT   ENCODE az64
	,fachdid BIGINT   ENCODE az64
	,facprof CHAR(1)   ENCODE lzo
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
	,mdc CHAR(2)   ENCODE lzo
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,netpay DOUBLE PRECISION   ENCODE RAW
	,ntwkprov CHAR(1)   ENCODE lzo
	,paidntwk CHAR(1)   ENCODE lzo
	,pay DOUBLE PRECISION   ENCODE RAW
	,pddate DATE   ENCODE az64
	,pdx CHAR(8)   ENCODE lzo
	,phyflag CHAR(1)   ENCODE lzo
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,pproc CHAR(7)   ENCODE lzo
	,proc1 CHAR(7)   ENCODE lzo
	,procmod CHAR(2)   ENCODE lzo
	,proctyp CHAR(10)   ENCODE lzo
	,provid INTEGER   ENCODE az64
	,qty INTEGER   ENCODE az64
	,"region" CHAR(1)   ENCODE lzo
	,revcode CHAR(4)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,stdplac SMALLINT   ENCODE az64
	,stdprov SMALLINT   ENCODE az64
	,svcdate DATE   ENCODE az64
	,svcscat CHAR(5)   ENCODE lzo
	,tsvcdat DATE   ENCODE az64
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,units DOUBLE PRECISION   ENCODE RAW
	,npi VARCHAR(10)   ENCODE lzo
	,msclmid INTEGER   ENCODE az64
	,medadv INTEGER   ENCODE az64
	,_svcdate DATE   ENCODE az64
	,_tsvcdat DATE   ENCODE az64
	,_visittype VARCHAR(3)   ENCODE lzo
)
DISTSTYLE AUTO
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
	,abnormal CHAR(1)   ENCODE lzo
	,agegrp CHAR(1)   ENCODE lzo
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,eidflag CHAR(1)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrflag CHAR(1)   ENCODE lzo
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
	,mhsacovg CHAR(1)   ENCODE lzo
	,phyflag CHAR(1)   ENCODE lzo
	,proctyp CHAR(1)   ENCODE lzo
	,"region" CHAR(1)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,sex CHAR(1)   ENCODE lzo
	,egeoloc CHAR(2)   ENCODE lzo
	,mdc CHAR(2)   ENCODE lzo
	,version CHAR(2)   ENCODE lzo
	,resltcat CHAR(3)   ENCODE lzo
	,dx1 CHAR(7)   ENCODE lzo
	,proc1 CHAR(7)   ENCODE lzo
	,pddate DATE   ENCODE az64
	,svcdate DATE   ENCODE az64
	,msa INTEGER   ENCODE az64
	,orderid INTEGER   ENCODE az64
	,provid INTEGER   ENCODE az64
	,refhigh DOUBLE PRECISION   ENCODE RAW
	,reflow DOUBLE PRECISION   ENCODE RAW
	,"result" DOUBLE PRECISION   ENCODE RAW
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
	,loinccd VARCHAR(7)   ENCODE lzo
	,resunit VARCHAR(30)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,dxver CHAR(1)   ENCODE lzo
	,medadv INTEGER   ENCODE az64
	,_flag SMALLINT   ENCODE az64
)
DISTSTYLE AUTO
;
ALTER TABLE ccae_tests_native.lab owner to rhealth_etl;


-- ccae_tests_native.loinc definition

-- Drop table

-- DROP TABLE ccae_tests_native.loinc;

--DROP TABLE ccae_tests_native.loinc;
CREATE TABLE IF NOT EXISTS ccae_tests_native.loinc
(
	loinc_num CHAR(7)   ENCODE lzo
	,component VARCHAR(500)   ENCODE lzo
	,property VARCHAR(50)   ENCODE lzo
	,time_aspct VARCHAR(15)   ENCODE lzo
	,"system" VARCHAR(100)   ENCODE lzo
	,scale_typ VARCHAR(5)   ENCODE lzo
	,method_typ VARCHAR(100)   ENCODE lzo
	,relat_nms VARCHAR(500)   ENCODE lzo
	,"class" VARCHAR(50)   ENCODE lzo
	,source VARCHAR(20)   ENCODE lzo
	,dt_last_ch VARCHAR(8)   ENCODE lzo
	,chng_type CHAR(3)   ENCODE lzo
	,comments VARCHAR(4500)   ENCODE lzo
	,answerlist VARCHAR(200)   ENCODE lzo
	,status VARCHAR(20)   ENCODE lzo
	,map_to VARCHAR(7)   ENCODE lzo
	,scope VARCHAR(20)   ENCODE lzo
	,consumer_name VARCHAR(100)   ENCODE lzo
	,ipcc_units VARCHAR(20)   ENCODE lzo
	,reference VARCHAR(500)   ENCODE lzo
	,exact_cmp_sy VARCHAR(50)   ENCODE lzo
	,molar_mass VARCHAR(20)   ENCODE lzo
	,classtype INTEGER   ENCODE az64
	,formula VARCHAR(500)   ENCODE lzo
	,species VARCHAR(20)   ENCODE lzo
	,exmpl_answers VARCHAR(4000)   ENCODE lzo
	,acssym VARCHAR(2600)   ENCODE lzo
	,base_name VARCHAR(50)   ENCODE lzo
	,final CHAR(1)   ENCODE lzo
	,naaccr_id VARCHAR(20)   ENCODE lzo
	,code_table VARCHAR(20)   ENCODE lzo
	,setroot BOOLEAN   ENCODE RAW
	,panelelements VARCHAR(500)   ENCODE lzo
	,survey_quest_text VARCHAR(500)   ENCODE lzo
	,survey_quest_src VARCHAR(50)   ENCODE lzo
	,unitsrequired CHAR(1)   ENCODE lzo
	,submitted_units VARCHAR(50)   ENCODE lzo
	,relatednames2 VARCHAR(1000)   ENCODE lzo
	,shortname VARCHAR(40)   ENCODE lzo
	,order_obs VARCHAR(15)   ENCODE lzo
	,cdisc_common_tests CHAR(1)   ENCODE lzo
	,hl7_field_subfield_id VARCHAR(50)   ENCODE lzo
	,external_copyright_notice VARCHAR(500)   ENCODE lzo
	,example_units VARCHAR(100)   ENCODE lzo
	,inpc_percentage REAL   ENCODE RAW
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
DISTSTYLE AUTO
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
	,agegrp CHAR(1)   ENCODE lzo
	,cap_svc CHAR(1)   ENCODE lzo
	,cob DOUBLE PRECISION   ENCODE RAW
	,coins DOUBLE PRECISION   ENCODE RAW
	,copay DOUBLE PRECISION   ENCODE RAW
	,datatyp SMALLINT   ENCODE az64
	,deduct DOUBLE PRECISION   ENCODE RAW
	,dobyr SMALLINT   ENCODE az64
	,dx1 CHAR(8)   ENCODE lzo
	,dx2 CHAR(7)   ENCODE lzo
	,dx3 CHAR(7)   ENCODE lzo
	,dx4 CHAR(7)   ENCODE lzo
	,dx5 CHAR(7)   ENCODE lzo
	,dxver CHAR(1)   ENCODE lzo
	,eeclass CHAR(1)   ENCODE lzo
	,eestatu CHAR(1)   ENCODE lzo
	,efamid INTEGER   ENCODE az64
	,egeoloc CHAR(2)   ENCODE lzo
	,eidflag CHAR(1)   ENCODE lzo
	,emprel CHAR(1)   ENCODE lzo
	,enrflag CHAR(1)   ENCODE lzo
	,enrolid BIGINT   ENCODE az64
	,fachdid BIGINT   ENCODE az64
	,facprof CHAR(1)   ENCODE lzo
	,hlthplan CHAR(1)   ENCODE lzo
	,indstry CHAR(1)   ENCODE lzo
	,mdc CHAR(2)   ENCODE lzo
	,mhsacovg CHAR(1)   ENCODE lzo
	,msa INTEGER   ENCODE az64
	,netpay DOUBLE PRECISION   ENCODE RAW
	,ntwkprov CHAR(1)   ENCODE lzo
	,paidntwk CHAR(1)   ENCODE lzo
	,pay DOUBLE PRECISION   ENCODE RAW
	,pddate DATE   ENCODE az64
	,phyflag CHAR(1)   ENCODE lzo
	,plankey SMALLINT   ENCODE az64
	,plantyp SMALLINT   ENCODE az64
	,proc1 CHAR(7)   ENCODE lzo
	,procgrp SMALLINT   ENCODE az64
	,procmod CHAR(2)   ENCODE lzo
	,proctyp CHAR(10)   ENCODE lzo
	,provid INTEGER   ENCODE az64
	,qty INTEGER   ENCODE az64
	,"region" CHAR(1)   ENCODE lzo
	,revcode CHAR(4)   ENCODE lzo
	,rx CHAR(1)   ENCODE lzo
	,seqnum BIGINT   ENCODE az64
	,sex CHAR(1)   ENCODE lzo
	,stdplac SMALLINT   ENCODE az64
	,stdprov SMALLINT   ENCODE az64
	,svcdate DATE   ENCODE az64
	,svcscat CHAR(5)   ENCODE lzo
	,tsvcdat DATE   ENCODE az64
	,version CHAR(2)   ENCODE lzo
	,wgtkey SMALLINT   ENCODE az64
	,"year" SMALLINT   ENCODE az64
	,units DOUBLE PRECISION   ENCODE RAW
	,npi VARCHAR(10)   ENCODE lzo
	,msclmid INTEGER   ENCODE az64
	,medadv INTEGER   ENCODE az64
	,_svcdate DATE   ENCODE az64
	,_tsvcdat DATE   ENCODE az64
	,_visittype VARCHAR(3)   ENCODE lzo
)
DISTSTYLE AUTO
;
ALTER TABLE ccae_tests_native.outpatient_services owner to rhealth_etl;


-- ccae_tests_native.red_book definition

-- Drop table

-- DROP TABLE ccae_tests_native.red_book;

--DROP TABLE ccae_tests_native.red_book;
CREATE TABLE IF NOT EXISTS ccae_tests_native.red_book
(
	_flag SMALLINT   ENCODE az64
	,deaclas CHAR(1)   ENCODE lzo
	,deaclds VARCHAR(50)   ENCODE lzo
	,desidrg CHAR(1)   ENCODE lzo
	,excdgds VARCHAR(30)   ENCODE lzo
	,excldrg CHAR(2)   ENCODE lzo
	,generid INTEGER   ENCODE az64
	,genind CHAR(1)   ENCODE lzo
	,gennme VARCHAR(50)   ENCODE lzo
	,gnindds VARCHAR(30)   ENCODE lzo
	,maintds VARCHAR(30)   ENCODE lzo
	,maintin CHAR(1)   ENCODE lzo
	,manfnme VARCHAR(50)   ENCODE lzo
	,mastfrm CHAR(3)   ENCODE lzo
	,metsize VARCHAR(30)   ENCODE lzo
	,mstfmds VARCHAR(30)   ENCODE lzo
	,ndcnum VARCHAR(11)   ENCODE lzo
	,orgbkcd CHAR(3)   ENCODE lzo
	,orgbkds VARCHAR(30)   ENCODE lzo
	,orgbkfg CHAR(1)   ENCODE lzo
	,pkqtycd CHAR(3)   ENCODE lzo
	,pksize INTEGER   ENCODE az64
	,prdctds VARCHAR(30)   ENCODE lzo
	,prodcat CHAR(2)   ENCODE lzo
	,prodnme VARCHAR(50)   ENCODE lzo
	,siglsrc CHAR(1)   ENCODE lzo
	,strngth VARCHAR(30)   ENCODE lzo
	,roacd VARCHAR(2)   ENCODE lzo
	,roads VARCHAR(30)   ENCODE lzo
	,thercls VARCHAR(3)   ENCODE lzo
	,therdtl VARCHAR(10)   ENCODE lzo
	,thergrp VARCHAR(2)   ENCODE lzo
	,thrclds VARCHAR(30)   ENCODE lzo
	,thrdtds VARCHAR(30)   ENCODE lzo
	,thrgrds VARCHAR(30)   ENCODE lzo
	,"year" SMALLINT   ENCODE az64
	,deactdt DATE   ENCODE az64
	,reactdt DATE   ENCODE az64
	,actind VARCHAR(1)   ENCODE lzo
)
DISTSTYLE AUTO
;
ALTER TABLE ccae_tests_native.red_book owner to rhealth_etl;


