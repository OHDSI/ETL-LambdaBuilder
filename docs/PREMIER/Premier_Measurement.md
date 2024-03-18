---
title: "Measurement"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 10
layout: default
---

# Table Name: Measurement

The MEASUREMENT table will house records from PATBILL, PATCPT, VITALS, GENLAB, LAB_RESULT and PATICD_DIAG that have been mapped to the measurement domain.  

Measurements are recorded in the PATBILL table as standard charges.  Premier captures the date the measurement is made in the SERV_DATE field thus, the MEASUREMENT_DATE is determined from the VISIT_START_DATE from VISIT_OCCURRENCE and PATBILL.SERV_DATE unless the start date is greater than the end of the month, then it’s truncated to the end of month. For measurements recorded in the PATCPT table, the date the measurement was made is unknown so MEASUREMENT_DATE is recorded as VISIT_END_DATE. 

## Reading from PATBILL, PATCPT, PATICD_DIAG

The field mapping is performed as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| MEASUREMENT_ID | - | System generated |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| MEASUREMENT_CONCEPT_ID | PATCPT.CPT_CODE<br>PATBILL.STD_CHG_CODE<br>PATICD_DIAG.ICD_CODE<br>PATBILL.STD_CHG_DESC | QUERY: SOURCE TO STANDARD <br> <code>SELECT TARGET_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS', 'ICD10CM', 'ICD9CM', 'JNJ_PMR_PROC_CHRG_CD') AND TARGET_DOMAIN_ID = 'Measurement'</code>  | Only capture those records that have a domain map to Measurement. |
| MEASUREMENT_DATE | VISIT_OCCURRENCE.VISIT_START_DATEPATBILL.SERV_DATE <br>Or<br>VISIT_OCCURRENCE.VISIT_END_DATE <br>Or<br> VISIT_OCCURRENCE.VISIT_START_DATEPATICD_PROC.PROC_DAY |  | If measurement is from PATBILL use service date and visit start date unless the service date is greater than the end of the month <br> If measurement comes from PATCPT then use visit end date |
| MEASUREMENT_DATETIME | - | NULL |  |
| MEASUREMENT_TYPE_CONCEPT_ID | - | All records within the measurement table should have a measurement_type_concept_id = 32875 (Provider financial system) |  |
| OPERATOR_CONCEPT_ID | - | NULL |  |
| VALUE_AS_NUMBER | - | See query below |  |
| VALUE_AS_CONCEPT_ID | - | NULL |  |
| UNIT_CONCEPT_ID | - | |Set UNIT_CONCEPT_ID = NULL when the source unit value is NULL;<br>Set UNIT_CONCEPT_ID = 0 when source unit value is not NULL but doesn't have a mapping  |
| RANGE_LOW | - | NULL |  |
| RANGE_HIGH | - | NULL |  |
| PROVIDER_ID | PATICD_PROC.PROC_PHY<br>PAT.ADMPHY |  |  |
| VISIT_OCCURRENCE_ID | PAT.PAT_KEY |  |  |
| MEASUREMENT_SOURCE_VALUE |  | <code>SELECT SOURCE_VALUE FROM (SELECT CONCAT(STD_CHG_DESC, ' / ', HOSP_CHG_DESC) AS SOURCE_VALUE FROM PATBILL A JOIN CHGMSTR B ON A.STD_CHG_CODE=B.STD_CHG_CODE JOIN hospchg C ON A.hosp_chg_id=C.hosp_chg_id ) A UNION(SELECT CPT_CODE AS SOURCE_VALUE FROM PATCPT)</code> |  |
| MEASUREMENT_SOURCE_CONCEPT_ID | - | QUERY: SOURCE TO SOURCE <br> <code>SELECT SOURCE_CONCEPT_ID FROM CTE_VOCAB_MAP WHERE SOURCE_VOCABULARY_ID IN ('CPT4', 'HCPCS') AND TARGET_VOCABULARY_ID IN ('CPT4', 'HCPCS') AND DOMAIN_ID='Measurement'</code> | Only populated for standard coding CPT4, and HCPCS codes |
| UNIT_SOURCE_VALUE | - | NULL |  |
| VALUE_SOURCE_VALUE | - | NULL |  |



## Reading from VITALS

The field mapping is performed as follows:


<table>
   <tbody><tr><th>Destination Field
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
   <td><code>when lab_test_loinc_code !=’’, map to LOINC using lab_test_loinc_code = concept.concept_code and vocabulary_id =’LOINC’</code> :
<p>
Use the Source-to-Standard Query.
</p><p>
<code>
WHERE SOURCE_VOCABULARY_ID IN ('LOINC')
AND TARGET_STANDARD_CONCEPT = 'S'
AND TARGET_INVALID_REASON IS NULL
</code>
</p><p>
when lab_test_loinc_code = ‘’, then map to SNOMED using <strong><code>regexp_replace(lab_test, '\\(.*\\)', '') = c.concept_name and c. standard_concept ='S' and c.vocabulary_id ='SNOMED'</code></strong>
</p><p>
if there’s still no standard concept, set to 0
   </p></td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_date
   </td>
   <td>observation_datetime
   </td>
   <td>
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_source_value
   </td>
   <td>lab_test, lab_test_loinc_code
   </td>
   <td>When <code>lab_test_loinc_code!=''</code>
<p>
<code>Then lab_test_loinc_code</code>
</p><p>
<code>When lab_test_loinc_code =''</code>
<code>Then lab_test</code>
</p><p>
   </p></td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>value_as_number
   </td>
   <td>test_result_numeric_value
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
   <td>lab_test, lab_test_loinc_code
   </td>
   <td>when lab_test_loinc_code !=’’, map to LOINC using lab_test_loinc_code = concept.concept_code and vocabulary_id =’LOINC’:
<p>
<strong><code>select concept_id from VITALS</code></strong>
<code> <strong>join</strong> concept c <strong>on</strong> lab_test_loinc_code = c.concept_code <strong>and</strong> c.vocabulary_id ='LOINC'</code>
<code> <strong>where</strong> lab_test_loinc_code !=''</code>
</p><p>
when lab_test_loinc_code = ‘’, then map to SNOMED using <strong><code>regexp_replace(lab_test, '\\(.*\\)', '') = c.concept_name and c.vocabulary_id ='SNOMED'</code></strong>
   </p></td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_datetime
   </td>
   <td>observation_datetime
   </td>
   <td>
<p>
   </p></td>
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
&gt; map to 4172704
</p><p>
&lt; map to 4171756
</p><p>
+ map to 0
</p><p>
=&gt; map to 4171755
</p><p>
&lt;= map to 4171754
   </p></td>
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
   <td>lab_test_result
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
</tbody></table>



## Reading from GENLAB:

<table>
   <tbody><tr><th>Destination Field
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
</p><p>
WHERE SOURCE_VOCABULARY_ID IN ('LOINC')
</p><p>
AND TARGET_STANDARD_CONCEPT = 'S'
</p><p>
AND TARGET_INVALID_REASON IS NULL
</p><p>
</p><p>
when lab_test_loinc_code = ‘’, then map to SNOMED using <strong><code>regexp_replace(lab_test, '\\(.*\\)', '') = c.concept_name and c. standard_concept ='S' and c.vocabulary_id ='SNOMED'</code></strong>
</p><p>
if there’s still no standard concept, set to 0
   </p></td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_date
   </td>
   <td>collection_datetime
   </td>
   <td>
   </td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_source_value
   </td>
   <td>lab_test, lab_test_loinc_code
   </td>
   <td>When <code>lab_test_loinc_code!=''</code>
<p>
<code>Then lab_test_loinc_code</code>
</p><p>
<code>When lab_test_loinc_code =''</code>
</p><p>
<code>Then lab_test</code>
</p><p>
   </p></td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>value_as_number
   </td>
   <td>test_result_numeric_value
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
   <td>lab_test, lab_test_loinc_code
   </td>
   <td>when lab_test_loinc_code !=’’, map to LOINC using lab_test_loinc_code = concept.concept_code and vocabulary_id =’LOINC’:
<p>
<strong><code>select concept_id from VITALS</code></strong>
<code> <strong>join</strong> concept c <strong>on</strong> lab_test_loinc_code = c.concept_code <strong>and</strong> c.vocabulary_id ='LOINC'</code>
<code> <strong>where</strong> lab_test_loinc_code !=''</code>
</p><p>
when lab_test_loinc_code = ‘’, then map to SNOMED using <strong><code>regexp_replace(lab_test, '\\(.*\\)', '') = c.concept_name and c.vocabulary_id ='SNOMED'</code></strong>
   </p></td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_datetime
   </td>
   <td>collection_datetime</td>
   <td>
<p>
</p></td>
   <td> 
   </td>
  </tr>
  <tr>
   <td>measurement_time
   </td>
   <td>collection_datetime
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
&gt; map to 4172704
</p><p>
&lt; map to 4171756
</p><p>
+ map to 0
</p><p>
=&gt; map to 4171755
</p><p>
&lt;= map to 4171754
   </p></td>
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
   <td>lab_test_result
   </td>
   <td> 
   </td>
   <td> 
   </td>
  </tr>
</tbody></table>


 

 


## Reading from LAB_RESULTS


<table>
  <tbody><tr>
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
</p><p>
observation
   </p></td>
   <td> 
   </td>
   <td>System generated.  Consistent with the measurement_id attribute creation.
<p>
</p><p>
</p><p>
System Generated - Consisten with current schema design.
   </p></td>
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
</p><p>
SELECT PAT.MEDREC_KEY
</p><p>
FROM PAT, LAB_RES
</p><p>
WHERE PAT.PAT_KEY = LAB_RES.PAT_KEY
   </p></td>
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
</p><p>
Leverage source to concept mappings (+80% mapped).
   </p></td>
  </tr>
  <tr>
   <td>measurement_date
   </td>
   <td>collection_datetime
   </td>
   <td> 
   </td>
   <td>Direct mapping</td>
  </tr>
  <tr>
   <td>measurement_datetime
   </td>
   <td>collection_datetime
</td>
   <td> 
   </td>
   <td>Direct mapping</td>
  </tr>
  <tr>
   <td>measurement_time
   </td>
   <td>collection_datetime
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
   </p></td>
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
   </p></td>
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
</p><p>
</p><p>
SELECT PAT.ADM_PHY
</p><p>
FROM PAT
</p><p>
WHERE PAT.PAT_KEY = GEN_LAB.PAT_KEY
   </p></td>
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
</tbody></table>


## Change Log:
### 2024.03.12: 
 Moved Surgery (concept_id=3016562) to the Observation table
### 2021.08.11: 
 Updated MEASUREMENT_TYPE_CONCEPT_ID to leverage standard concept id.
### 29-Aug-2023
 Added readings from VITALS, GENLAB, LAB_RESULT