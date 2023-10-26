---
title: "Visit Occurrence"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 19
layout: default
---

# Table Name: VISIT_OCCURRENCE

Premier data are visit oriented; thus, each visit has its own unique visit identifier. The PAT table includes admission date and discharge date for each visit. Each visit is stored as a date but the day of the stay is always coded as the first of the month. The LOS field on the PAT table is populated for inpatient stays and is recorded as the number of 24 hour increments that a patient spends in the hospital. The LOS field is usually off by one calendar day for inpatient visits. Outpatient visits have a LOS of 0 and are typically only one day in length which is represented in the billing tables. For about 6% of outpatient visits, a single visit is comprised of multiple procedures that occur on different days for procedures such as chemotherapy or dialysis. The Premier billing system does not separate these into individual visits and for purposes of the ETL these will be considered one continuous visit. The PATBILL table houses billing records that occur each calendar day during the visit. Some visits may include a service day record of zero, which are considered pre-visit tests or procedures. For the purposes of the ETL, the information is considered as the first day of the visit, which can occur for inpatient and outpatient stays.  

Logic for ER stays is varied due to data changes from Premier in identifying ER visits. ER Visits in Premier are identified through point of origin or admission source. If a patient visits the ER and then leaves, the visit is considered ER. If an inpatient stay results from an ER visit, that is identified as an ER-to-Inpatient stay. Inpatient stays and outpatient stays with no associated ER visit are simply consider inpatient and outpatient stays, respectively. Additional logic has been added to constrain dates and fields which reflect changes in Premier’s classification of emergency room visits. In Premier, the value of admission source that designates emergency room was discontinued 7/1/2010 because it no longer was a required variable for CMS. Point of origin represents the last physical location of a patient before entering the hospital. This field is populated in Premier after 7/1/2010 with emergency room visits. Thus, a combination of point of origin, admission source, and admission type is used to determine if a patient had a valid ER stay for Premier. LOS, the length of stay field, is not used because each billing record corresponds to a service day in the PATBILL table.

Admitting and discharge information is captured in Premier as the place of service from which the patient arrived and the place to service to which the patient is discharged.

|Destination Field|Source Field|Applied Rule|Comment|
|---|---|---|---|
|VISIT_OCCURRENCE_ID|PAT.PAT_KEY|
|PERSON_ID|PAT.MEDREC_KEY|
|VISIT_CONCEPT_ID||When PAT.ADM_DATE <= ‘6/1/2010’ and ADM_SOURCE=7 and I_O_IND =’O’ then concept_id=9203<br>When PAT.ADM_DATE <= ‘6/1/2010’ and ADM_SOURCE=7 and I_O_IND =’I’ then concept_id=262<br>When PAT.ADM_DATE >= ‘7/1/2010’ and (POINT_OF_ORIGIN=7 or ADM_SOURCE =1) and I_O_IND =’O’ then concept_id=9203<br>When PAT.ADM_DATE >= ‘7/1/2010’ and (POINT_OF_ORIGIN=7 or ADM_SOURCE =1) and I_O_IND =’I’ then concept_id=262<br>When  I_O_IND =’I’ then concept_id=9201<br>When I_O_IND =’O’ then concept_id=9202||
|VISIT_START_DATE|PAT.ADM_DATE <br>PATBILL.SERV_DATE|||
|VISIT_START_DATETIME||||
|VISIT_END_DATE|PAT.DISC_DATE<br>PATBILL.SERV_DATE|||
|VISIT_END_DATETIME||||
|VISIT_TYPE_CONCEPT_ID| - | All records within the visit_occurence table should have a visit_type_concept_id = 32875 (Provider financial system) | |
|PROVIDER_ID|PAT.ADM_PHY|||
|CARE_SITE_ID|PAT.PROV_ID|||
|VISIT_SOURCE_VALUE|PAT.I_O_IND|||
|VISIT_SOURCE_CONCEPT_ID|-|||
|ADMITTING_SOURCE_CONCEPT_ID|PAT.POINT_OF_ORIGIN|if POINT_OF_ORIGIN then ADMITTING_SOURCE_CONCEPT_ID<br>0 then 8976<br>1 then 8844<br>2 then 8716<br>3 then 8844<br>4 then 8717<br>45 then 581384<br>46 then 8650<br>5 then 8863<br>6 then 8844<br>7 then 8870<br>8 then 8844<br>9 then 8844<br>A then 8761<br>B then 8536<br>C then 8536<br>D then 8717<br>E then 8883<br>F then 8546<br>||
|ADMITTING_SOURCE_VALUE|PAT. POINT_OF_ORIGIN|PAT. POINT_OF_ORIGIN||
|DISCHARGE_TO_CONCEPT_ID|PAT.DISC_STATUS|If DISC_STATUS then DISCHARGE_TO_CONCEPT_ID<br>1 then 8536, 2 then 8844<br>3 then 8863, 4 then 8863<br>5 then 8844, 6 then 8536<br>7 then 8844, 8 then 8536<br>9 then 8717, 20 then NULL<br>21 then 8844, 30 then 8844<br>40 then 8546, 41 then 8546<br>42 then 8546, 43 then 8966<br>50 then 8546, 51 then 8546<br>61 then 8863, 62 then 8920<br>63 then 8970, 64 then 8676<br>65 then 8971, 66 then 581379<br>69 then 8844, 70 then 8844<br>71 then 8844, 72 then 8717<br>81 then 8536, 82 then 581379<br>83 then 8863, 84 then 8827<br>85 then 8844, 86 then 8536<br>87 then 8844, 88 then 8966<br>89 then 8863, 90 then 581379<br>91 then 581379, 92 then 8676<br>93 then 8971, 94 then 581379<br>95 then 8844, 99 then 8844<br>||
|DISCHARGE_TO_SOURCE_VALUE|PAT.DISC_STATUS|PAT.DISC_STATUS||
|PRECEDING_VISIT_OCCURRENCE_ID|VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID|For a given person, find the visit prior to this one and reference it here|A foreign key to the VISIT_OCCURRENCE table of the visit immediately preceding this visit|

## Change Log:
* 2023.10.23:  Updated visit logic, the exact date of visits is now available.
* 2021.08.11:  Updated VISIT_TYPE_CONCEPT_ID to leverage standard concept id.
