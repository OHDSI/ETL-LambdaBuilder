---
title: "Measurement"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 10
layout: default
---

# Table Name: Measurement

The MEASUREMENT table will house records from PATBILL, PATCPT, VITALS, GENLAB, LAB_RESULT and PATICD_DIAG that have been mapped to the measurement domain. Additionally, procedures that occur on the same day as billing records for operation time will have operation time calculated and recorded in the measurement table. 

Measurements are recorded in the PATBILL table as standard charges.  Premier captures the day the measurement is made in the SERV_DAY field thus, the MEASUREMENT_DATE is determined from the VISIT_START_DATE from VISIT_OCCURRENCE and PATBILL.SERV_DAY unless the start date is greater than the end of the month, then it’s truncated to the end of month. For measurements recorded in the PATCPT table, the day the measurement was made is unknown so MEASUREMENT_DATE is recorded as VISIT_END_DATE. 

In Premier, many procedures are recorded in the PATICD_PROC table, which includes the day the procedure was performed as PATICD_PROC.PROC_DAY. Certain billing records in PATBILL include information on surgical operation time. The sample code below the field mapping table returns surgical operation time values in minutes for procedures where operation time billing record(s) happen on the same day. It is assumed that if a procedure and an operating time bill happen on the same day, then the operating time is associated with the procedure. These operation time values move to the MEASUREMENT table and the MEASUREMENT_DATE equals the corresponding PROCEDURE_DATE (which is VISIT_OCCURRENCE + PROC_DAY). To associate a surgical operation time with a procedure: MEASUREMENT.VISIT_OCCURRENCE_ID=PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID AND MEASUREMENT.MEASUREMENT_DATE=PROCEDURE_OCCURRENCE.PROCEDURE_DATE.
There are three providers that exist in Premier, the admitting, attending, and procedure. This ETL makes the decision to use admitting physician for all measurements except operation time because it is unknown whether the admitting provider, attending provider or another person obtained the measurement. 

##TODO: 
- For operation time measurements, the provider is set as the procedure physician.
Only records that fall within an OBSERVATION_PERIOD are available for each person. The VISIT_OCCURRENCE table must be created before the MEASUREMENT table is created.

## Reading from PATBILL, PATCPT, PATICD_DIAG

The field mapping is performed as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| MEASUREMENT_ID | - | System generated |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| MEASUREMENT_CONCEPT_ID | PATCPT.CPT_CODE<br>PATBILL.STD_CHG_CODE<br>PATICD_DIAG.ICD_CODE<br>PATBILL.STD_CHG_DESC | QUERY: SOURCE TO STANDARDSELECT TARGET_CONCEPT_IDFROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS', 'ICD10CM', 'ICD9CM', 'JNJ_PMR_PROC_CHRG_CD')AND TARGET_DOMAIN_ID = 'Measurement'When operation time measurement values then 3016562  | Only capture those records that have a domain map to Measurement. |
| MEASUREMENT_DATE | VISIT_OCCURRENCE.VISIT_START_DATEPATBILL.SERV_DAY <br>Or<br>VISIT_OCCURRENCE.VISIT_END_DATE <br>Or<br> VISIT_OCCURRENCE.VISIT_START_DATEPATICD_PROC.PROC_DAY |  | If measurement is from PATBILL use a combination of service day and visit start date unless the service day is greater than the end of the monthIf measurement comes from PATCPT then use visit end dateFor operation time measurement, a combination of procedure day and visit start date unless the procedure day is greater than the end of the month |
| MEASUREMENT_DATETIME | - | NULL |  |
| MEASUREMENT_TYPE_CONCEPT_ID | - | All records within the measurement table should have a measurement_type_concept_id = 32875 (Provider financial system) |  |
| OPERATOR_CONCEPT_ID | - | NULL |  |
| VALUE_AS_NUMBER | - | See query below |  |
| VALUE_AS_CONCEPT_ID | - | NULL |  |
| UNIT_CONCEPT_ID | - | For operation time records 8550Else NULL |Set UNIT_CONCEPT_ID = NULL when the source unit value is NULL;<br>Set UNIT_CONCEPT_ID = 0 when source unit value is not NULL but doesn't have a mapping  |
| RANGE_LOW | - | NULL |  |
| RANGE_HIGH | - | NULL |  |
| PROVIDER_ID | PATICD_PROC.PROC_PHYPAT.ADMPHY | When operation time PATICD_PROC.PROC_PHYElsePAT.ADMPHY |  |
| VISIT_OCCURRENCE_ID | PAT.PAT_KEY |  |  |
| MEASUREMENT_SOURCE_VALUE |  | SELECT SOURCE_VALUE FROM (SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL AJOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODEJOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id ) AUNION(SELECT CPT_CODE AS SOURCE_VALUE FROM PATCPT)For operation time records, NULL for now |  |
| MEASUREMENT_SOURCE_CONCEPT_ID | - | QUERY: SOURCE TO SOURCESELECT SOURCE_CONCEPT_IDFROM CTE_VOCAB_MAPWHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS')AND TARGET_VOCABULARY_ID IN ('CPT4', 'HCPCS') AND DOMAIN_ID='Measurement' | Only populated for standard coding CPT4, and HCPCS codes |
| UNIT_SOURCE_VALUE | - | NULL |  |
| VALUE_SOURCE_VALUE | - | NULL |  |



## Reading from VITALS

The field mapping is performed as follows:


<table>
   <th>Destination Field
   </th>
   <th>Source Field
   </th>
   <th>Logic
   </th>
   <th>Comment
   </th>
  </tr>
  <tr>
   <td>measurement_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>person_id
   </td>
   <td>PAT.MEDREC_KEY
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_concept_id
   </td>
   <td>lab_test_loinc_code
   </td>
   <td>when lab_test_loinc_code !=’’, map to LOINC using lab_test_loinc_code = concept.concept_code and vocabulary_id =’LOINC’:
<p>
Use the Source-to-Standard Query.
<p>
WHERE SOURCE_VOCABULARY_ID IN ('LOINC')
<p>
AND TARGET_STANDARD_CONCEPT = 'S'
<p>
AND TARGET_INVALID_REASON IS NULL
<p>
 
<p>
when lab_test_loinc_code = ‘’, then map to SNOMED using <strong><code>regexp_replace(lab_test, '\\(.*\\)', '') = c.concept_name and c. standard_concept ='S' and c.vocabulary_id ='SNOMED'</code></strong>
 
<p>
if there’s still no standard concept, set to 0
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_date
   </td>
   <td><code>observation_day_number</code>
   </td>
   <td>DATEADD(DAY, [COLLECTION_DAY_NUMBER]-1, VISIT_START_DATE)
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_source_value
   </td>
   <td><code>lab_test, lab_test_loinc_code</code>
   </td>
   <td>When <code>lab_test_loinc_code!=''</code>
<p>
<code>Then lab_test_loinc_code</code>
<p>
<code>When lab_test_loinc_code =''</code>
<p>
<code>Then lab_test</code>
<p>
 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>value_as_number
   </td>
   <td><code>test_result_numeric_value</code>
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>unit_concept_id
   </td>
   <td>lab_test_result_unit
   </td>
   <td>map using STCM with the source_vocabulary_id =’JNJ UNITS’
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>value_as_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>meas_event_field_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_event_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_source_concept_id
   </td>
   <td><code>lab_test, lab_test_loinc_code</code>
   </td>
   <td>when lab_test_loinc_code !=’’, map to LOINC using lab_test_loinc_code = concept.concept_code and vocabulary_id =’LOINC’:
<p>
<strong><code>select concept_id from VITALS</code></strong>
<code> <strong>join</strong> concept c <strong>on</strong> lab_test_loinc_code = c.concept_code <strong>and</strong> c.vocabulary_id ='LOINC'</code>
<code> <strong>where</strong> lab_test_loinc_code !=''</code>
 
<p>
when lab_test_loinc_code = ‘’, then map to SNOMED using <strong><code>regexp_replace(lab_test, '\\(.*\\)', '') = c.concept_name and c.vocabulary_id ='SNOMED'</code></strong>
 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_datetime
   </td>
   <td><code>observation_day_number,</code>
<p>
observation_time_of_day
   </td>
   <td>DATEADD(DAY, [COLLECTION_DAY_NUMBER]-1, VISIT_START_DATE)
<p>
And add “observation_time_of_day” as datatime
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_time
   </td>
   <td>observation_time_of_day
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_type_concept_id
   </td>
   <td>32836
   </td>
   <td> 
   </td>
   <td>EHR physical examination
   </td>
  </tr>
  <tr>
   <td>operator_concept_id
   </td>
   <td>numeric_value_operator
   </td>
   <td>The following mappings should be leveraged:
<p>
> map to 4172704
<p>
&lt; map to 4171756
<p>
+ map to 0
<p>
=> map to 4171755
<p>
&lt;= map to 4171754
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>range_low
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>range_high
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>provider_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>visit_occurrence_id
   </td>
   <td>pat_key
   </td>
   <td>Referncing visit that exists in VISIT_OCCURRENCE, a combindation of medrec_key and pat_key create a unique visit for a specific patient.
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>visit_detail_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>unit_source_value
   </td>
   <td>lab_test_result_unit
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>unit_source_concept_id
   </td>
   <td>0
   </td>
   <td>0
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>value_source_value
   </td>
   <td><code>lab_test_result</code>
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
</table>



## Reading from GENLAB:

<table>
  <tr>
   <th>Destination Field
   </th>
   <th>Source Field
   </th>
   <th>Logic
   </th>
   <th>Comment
   </th>
  </tr>
  <tr>
   <td>measurement_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>System Generated - Consisten with current schema design.
   </td>
  </tr>
  <tr>
   <td>value_source_value
   </td>
   <td>lab_test_result
   </td>
   <td> 
   </td>
   <td>Values to be mapped directly.
   </td>
  </tr>
  <tr>
   <td>person_id
   </td>
   <td>pat_key
   </td>
   <td> 
   </td>
   <td>Lookup of PAT.MEDREC_KEY leveraging the PAT_KEY.
<p>
 
<p>
SELECT PAT.MEDREC_KEY
<p>
FROM PAT, GEN_LAB
<p>
WHERE PAT.PAT_KEY = GEN_LAB.PAT_KEY
   </td>
  </tr>
  <tr>
   <td>measurement_concept_id
   </td>
   <td>lab_test_loinc_code
   </td>
   <td> 
   </td>
   <td>Leveraged the Source-to-Standard query with the following filters:
<p>
SOURCE_VOCABULARY:  LOINC
<p>
STANDARD_CODE:  S
<p>
Invalid Reason:  NULL
   </td>
  </tr>
  <tr>
   <td>measurement_date
   </td>
   <td>collection_day_number
   </td>
   <td> 
   </td>
   <td>Calculated based of the COLLECTION_DAY_NUMBER and the corresponding value identified in the VISIT_OCCURRENCE table.
<p>
 
<p>
SELECT DATEADD(DAY, [GEN_LAB.COLLECTION_DAY_NUMBER]-1, VISIT_START_DATE) AS MEASUREMENT_DATE
<p>
FROM CDM_PREMIER_V1196.DBO.VISIT_OCCURRENCE
<p>
WHERE VISIT_OCCURRENCE_ID = [GEN_LAB.PAT_KEY];
   </td>
  </tr>
  <tr>
   <td>measurement_datetime
   </td>
   <td>collection_time_of_day
<p>
collection_day_number
   </td>
   <td> 
   </td>
   <td>GENLAB Transformation:
<p>
Calculated based of the COLLECTION_DAY_NUMBER, the COLLECTION_TIME_OF_DAY and the corresponding value identified in the VISIT_OCCURRENCE table.  One was added to the calculation to account for records that occurred on the day of admission.
<p>
 
<p>
SELECT CAST(CAST(DATEADD(DAY, [GEN_LAB.COLLECTION_DAY_NUMBER]-1, VISIT_START_DATE) AS VARCHAR) + ' ' + '10:15:20' AS DATETIME) AS MEASUREMENT_DATETIME
<p>
FROM CDM_PREMIER_V1196.DBO.VISIT_OCCURRENCE
<p>
WHERE VISIT_OCCURRENCE_ID = [GEN_LAB.PAT_KEY];
   </td>
  </tr>
  <tr>
   <td>measurement_time
   </td>
   <td>collection_time_of_day
   </td>
   <td> 
   </td>
   <td>Mapped directly.
   </td>
  </tr>
  <tr>
   <td>unit_source_value
   </td>
   <td>result_unit
   </td>
   <td> 
   </td>
   <td>LAB_RESULT Transformation:
<p>
This hold the source codes inferred by Usagi for the LAB_RESULT.TEST attribute which Premier identifies as LOINC for source data with a DATA_SOURCE_IND of '4'.
   </td>
  </tr>
  <tr>
   <td>measurement_type_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>operator_concept_id
   </td>
   <td>numeric_value_operator
   </td>
   <td> 
   </td>
   <td>The following mappings should be leveraged:
<p>
> map to 4172704
<p>
&lt; map to 4171756
<p>
+ map to 0
<p>
=> map to 4171755
<p>
&lt;= map to 4171754
   </td>
  </tr>
  <tr>
   <td>value_as_number
   </td>
   <td>numeric_value
   </td>
   <td> 
   </td>
   <td>Mapped directly.
   </td>
  </tr>
  <tr>
   <td>value_as_concept_id
   </td>
   <td>lab_test_result
   </td>
   <td> 
   </td>
   <td>The 3 items should be mapped:
<p>
45878583 - Negative
<p>
46237248 - Positive
<p>
45880296 - Not Detected
<p>
Everything else should map to 0.
   </td>
  </tr>
  <tr>
   <td>unit_concept_id
   </td>
   <td>result_unit
   </td>
   <td> 
   </td>
   <td>Map to UCUM source vocabulary:
<p>
 
<p>
Where SOURCE_VOCABULARY_ID = ‘UCUM’
<p>
AND TARGET_STANDARD_CONCEPT = ‘S’
<p>
AND TARGET_INVALID_REASON IS NULL
   </td>
  </tr>
  <tr>
   <td>range_low
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>NULL
   </td>
  </tr>
  <tr>
   <td>range_high
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>NIULL
   </td>
  </tr>
  <tr>
   <td>provider_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>GENLAB; LAB_RESULT Transformation:
<p>
Lookup PAT.ADM_PHY leveraging PAT_KEY.
<p>
 
<p>
SELECT PAT.ADM_PHY
<p>
FROM PAT
<p>
WHERE PAT.PAT_KEY = GEN_LAB.PAT_KEY
   </td>
  </tr>
  <tr>
   <td>visit_occurrence_id
   </td>
   <td>pat_key
   </td>
   <td> 
   </td>
   <td>Referncing visit that exists in VISIT_OCCURRENCE, a combindation of medrec_key and pat_key create a unique visit for a specific patient.
   </td>
  </tr>
  <tr>
   <td>visit_detail_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>NULL
   </td>
  </tr>
  <tr>
   <td>measurement_source_value
   </td>
   <td>lab_test_loinc_code
   </td>
   <td> 
   </td>
   <td>Direct mapping.
   </td>
  </tr>
  <tr>
   <td>measurement_source_concept_id
   </td>
   <td>lab_test_loinc_code
   </td>
   <td> 
   </td>
   <td>Leverage Source-to-Source Query
<p>
Vocabulary:  LOINC
<p>
Leveraged standard Source-to-Concept lookup.
   </td>
  </tr>
</table>


 

 


## Reading from LAB_RESULTS


<table>
  <tr>
  <th>Destination Field
   </th>
   <th>Source Field
   </th>
   <th>Logic
   </th>
   <th>Comment
   </th>
  </tr>
  <tr>
   <td>measurement_id
   </td>
   <td>pat_key
<p>
specimen_id
<p>
observation
   </td>
   <td> 
   </td>
   <td>System generated.  Consistent with the measurement_id attribute creation.
<p>
 
<p>
 
<p>
System Generated - Consisten with current schema design.
   </td>
  </tr>
  <tr>
   <td>value_source_value
   </td>
   <td>observation
   </td>
   <td> 
   </td>
   <td>Directly Mapped.
   </td>
  </tr>
  <tr>
   <td>person_id
   </td>
   <td>pat_key
   </td>
   <td> 
   </td>
   <td>Lookup of PAT.MEDREC_KEY leveraging the PAT_KEY.
<p>
 
<p>
SELECT PAT.MEDREC_KEY
<p>
FROM PAT, LAB_RES
<p>
WHERE PAT.PAT_KEY = LAB_RES.PAT_KEY
   </td>
  </tr>
  <tr>
   <td>measurement_concept_id
   </td>
   <td>test
   </td>
   <td> 
   </td>
   <td>The LAB_RES table provides a LOINC formatted description but does not provide the actual LOINC code utilized in this table.  Usagi was leveraged to infer standard concept codes based on the LOINC formatted descriptions.
<p>
 
<p>
Leverage source to concept mappings (+80% mapped).
   </td>
  </tr>
  <tr>
   <td>measurement_date
   </td>
   <td>spec_day_number
   </td>
   <td> 
   </td>
   <td>The LAB_RESULT.SPEC_DAY_NUMBER in addition to the VISIT_OCCURRENCE table are leveraged for the transformation of MEASUREMENT_DATE.
<p>
 
<p>
SELECT DATEADD(DAY, [LAB_RES.SPEC_DAY_NUMBER]-1, VISIT_START_DATE) AS MEASUREMENT_DATE
<p>
FROM CDM_PREMIER_V1196.DBO.VISIT_OCCURRENCE
<p>
WHERE VISIT_OCCURRENCE_ID = [LAB_RES.PAT_KEY];
   </td>
  </tr>
  <tr>
   <td>measurement_datetime
   </td>
   <td>spec_day_number
<p>
spec_time_of_day
   </td>
   <td> 
   </td>
   <td>LAB_RESULT Transformation:
<p>
LAB_RESULT.SPEC_DAY_NUMBER, LAB_RESULT.SPEC_TIME_OF_DAY in combination with the CDM VISIT_OCCURRENCE table leveraged to create MEASUREMENT_DATETIME.  One was added to the calculation to account for records that occurred on the day of admission.
<p>
 
<p>
SELECT CAST(CAST(DATEADD(DAY, [LAB_RES.COLLECTION_DAY_NUMBER]-1, VISIT_START_DATE) AS VARCHAR) + ' ' + [LAB_RES.SPEC_TIME_OF_DAY] AS DATETIME) AS MEASUREMENT_DATETIME
<p>
FROM CDM_PREMIER_V1196.DBO.VISIT_OCCURRENCE
<p>
WHERE VISIT_OCCURRENCE_ID = [LAB_RES.PAT_KEY];
   </td>
  </tr>
  <tr>
   <td>measurement_time
   </td>
   <td>spec_time_of_day
   </td>
   <td> 
   </td>
   <td>Direct mapping
   </td>
  </tr>
  <tr>
   <td>unit_source_value
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>LAB_RESULT Transformation:
<p>
This hold the source codes inferred by Usagi for the LAB_RESULT.TEST attribute which Premier identifies as LOINC for source data with a DATA_SOURCE_IND of '4'.
   </td>
  </tr>
  <tr>
   <td>measurement_type_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>GENLAB; LAB_RESULT Transformation:
<p>
Values mapped to Concept ID 5001, 'Test ordered through EHR'
   </td>
  </tr>
  <tr>
   <td>operator_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>value_as_number
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>value_as_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>unit_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>range_low
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>NULL
   </td>
  </tr>
  <tr>
   <td>range_high
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>NULL
   </td>
  </tr>
  <tr>
   <td>provider_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>GENLAB; LAB_RESULT Transformation:
<p>
Lookup PAT.ADM_PHY leveraging PAT_KEY.
<p>
 
<p>
SELECT PAT.ADM_PHY
<p>
FROM PAT
<p>
WHERE PAT.PAT_KEY = GEN_LAB.PAT_KEY
   </td>
  </tr>
  <tr>
   <td>visit_occurrence_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>visit_detail_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>NULL
   </td>
  </tr>
  <tr>
   <td>measurement_source_value
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_source_concept_id
   </td>
   <td> 
   </td>
   <td> 
   </td>
   <td>Leveraged standard Source-to-Concept lookup.
   </td>
  </tr>
</table>



## Change Log:
### 2021.08.11: 
 Updated MEASUREMENT_TYPE_CONCEPT_ID to leverage standard concept id.
### 29-Aug-2023
Added readings from VITALS, GENLAB, LAB_RESULT
