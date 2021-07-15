---
layout: default
title: HRA
nav_order: 7
parent: Optum Clinformatics to STEM
grand_parent: Optum Clinformatics
description: "Optum HRA table mapping to CDM STEM table"

---

### **Notes**
- VISIT_DETAIL must be built before STEM (refer to [VISIT_DETAIL file](VISIT_DETAIL.md))
- The **MED_PROCEDURE** table can be joined to **MEDICAL_CLAIMS** which is joined to **VISIT_DETAIL**. 
- Referential integrity is maintained with VISIT_DETAIL. 
- For every record in **STEM** there should be 1 row record in VISIT_DETAIL (n:1 join). 
- For every record in **VISIT_DETAIL** there may be 0 to n rows in **STEM**.

## **Mapping from HRA**
The HRA table is the health risk assessment table that contains question and answer pairs filled out by the health insurance members. Use the following table to map HRA questions to standard concept ids. 

**HRA field**|**Domain**|**Concept Id**|**Type Concept Id**|**Value as Number**|**Value as String / Value Source Value**|**Unit Concept Id**|**Unit Source Value**|**Source Value**
:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
H_BMI|Measurement|3038553|44786633| H_BMI | H_BMI |9531 | NULL|HEOR defined BMI 
H_BSA|Measurement|3005424|44786633|H_BSA | H_BSA | 8617  |m2|HEOR defined Body Surface Area (in m2) - Mosteller formula (most commonly used)
H_CHRONIC_PAIN|Observation|3005359|44786634| NULL| 1 = Yes<br/>0 = No<br/>U = Unknown | 0|NULL|HEOR defined Chronic Pain
H_HEIGHT|Measurement|44786634|44786633| H_HEIGHT |H_HEIGHT| 9330| inches|HEOR defined Height (in inches)
H_SMOKING_STATUS|Observation|42742404|44786634| NULL |1 = Current user<br/>2 = Previous user<br/>3 = Never used<br/>U = Unknown|0|NULL|HEOR defined Smoking status
H_WEIGHT|Measurement|3023166|44786633|H_WEIGHT|H_WEIGHT|8739|lbs|HEOR defined Weight (in pounds)
ISA10008|Observation|46235605|44786634|NULL|ISA10008|0| NULL|(10008) During the past 4 weeks, how much did your health problems affect your ability to do your regular daily activities, (other than work at a job)
ISA1006|Measurement|46235605|44786633|ISA1006|NULL|NULL|NULL|(1006) Weekly alcoholic drinks - Actual
ISA13021|Observation|0|44786634|NULL|ISA13021|0| NULL|(13021) Chronic Pain - Back
ISA13022|Observation |4269428|44786634|NULL|ISA13022|0|NULL |(13022) Chronic Pain - Neck, Shoulder or Arm
ISA13023|Observation|0|44786634|NULL|ISA13021|0| NULL|(13023) Chronic Pain - Other
ISA13040|Observation |40767204 |44786634 |NULL |ISA13040 |0|NULL|(13040) High Blood Pressure (Hypertension)
ISA16010|Observation|0|44786634|NULL|ISA13021|0| NULL|(16010) During the past year, how much effect has stress had on your health
ISA16016|Observation|0|44786634|NULL|ISA13021|0| NULL|(16016) In general, how often is stress a problem for you
ISA16040|Measurement|40768653|44786633|NULL|ISA16040|0|NULL|(16040) How many hours of sleep on average do you get each night
ISA17001|Measurement|45877288|44786633|NULL|ISA17001|0|NULL|(17001) Current use of cigarettes
ISA17015|Observation |4218917|44786634|NULL|ISA17015|0|NULL|(17015) Current use of cigars or pipes
ISA17021|Observation|0|44786634|NULL|ISA17021|0| NULL|(17021) Cigars/Pipes Former Users - Years since quitting -Actual
ISA17023|Observation|37017610|44786634|NULL|ISA17023|0|NULL|(17023) Current use of smokeless tobacco
ISA18015|Observation|4268831|44786634|NULL|ISA18015|0|NULL|(18015) Have you made changes recently to manage your weight
ISA19004|Observation|4200660|44786634|NULL|ISA19004|0|NULL|(19004) Rate your satisfaction with current job
ISA19005|Observation|4121656|44786634|NULL|ISA19005|0|NULL|(19005) Rate current satisfaction with life
ISA20061|Observation|4053609|44786634|NULL|ISA20061|0|NULL|(20061) Current Marital Status
ISA20064|Observation|4143273|44786634|NULL|ISA20064|0|NULL|(20064) Past year number of days missed an entire work day due to physical or mental health problems -Range
ISA20069|Observation|0|44786634|NULL|ISA20069|0|NULL|(20069) HPQ-Treatment of Chronic Neck /Back Pain
ISA20072|Observation|3005359|44786634|NULL|ISA20072|0|NULL|(20072) HPQ-Treatment of Any other Chronic Pain
ISA21001|Observation|40764568|44786634|NULL|ISA21001|0|NULL|(21001) In past 2 wks, how often did physical / emotional problems make it difficult to work the required hours
ISA21003|Observation|0|44786634|NULL|ISA21003|0|NULL|(21003) In past 2 wks, how often did physical /emotional problems keep you from starting work when you arrive
ISA21009|Observation|0|44786634|NULL|ISA21009|0|NULL|(21009) Past 2 wks, how often able to repeat same motions working w/o difficulty caused by physical health
ISA21015|Observation|0|44786634|NULL|ISA21015|0|NULL|(21015) Past 2 wks, how often did physical /emotional problems make it difficult to concentrate on work
ISA21020|Observation|0|44786634|NULL|ISA21020|0|NULL|(21020) Past 2 wks, how often did physical/emotional problems make it difficult to help people get work done
ISA21021|Observation|0|44786634|NULL|ISA21021|0|NULL|(21021) Past 2 wks, how often did physical/emotional problems make it difficult to handle workload
ISA21025|Observation|0|44786634|NULL|ISA21025|0|NULL|(21025) Past 2 wks, how often did physical/ emotional problems make it difficult to feel cap
ISA3010|Observation|4072486|44786634|NULL|ISA3010|0|NULL|(3010) Have a strong network of friends and family
ISA5001|Observation|4224901|44786634|NULL|ISA5001|0|NULL|(5001) Perceived Health Status
ISA5004|Observation|1585811|44786634|NULL|ISA5004|0|NULL|(5004) Currently pregnant
ISA5010|Observation|44808949|44786634|NULL|ISA5010|0|NULL|(5010) Perform monthly self exams to detect health problems
ISA5018|Measurement|40767407|44786633|NULL|ISA5018|0|NULL|(5018) Have your menstrual periods stopped
ISA7018|Observation|0|44786634|NULL|ISA5010|0|NULL|(7018) Currently Taking Chronic Pain Medication
ISA8016|Observation|0|44786634|NULL|ISA8016|0|NULL|(8016) High Fat -Range of Servings Per Day
ISA9009|Observation|4036426|44786634|NULL|ISA5010|0|NULL|(9009) During a typical week, how many days do you do physical activity outside your job
ISA9063|Observation|46235936|44786634|NULL|ISA5010|0|NULL|(9063) Have you made an effort recently to change physical activity

|**Destination Field**|**Source Field**|**Applied Rule**|**Comment**|
| :----: | :----: | :--------: | :------: |
| id |  |Autogenerate||
| domain_id ||This should be the domain_id of the standard concept in the CONCEPT_ID field. If a code is mapped to CONCEPT_ID 0, put the domain_id as Observation.||
| person_id | PATID| Use patid to lookup Person_id ||
| visit_detail_id |NULL|||
| visit_occurrence_id |NULL|||
| provider_id | |||
| start_datetime |HRA_COMPLTD_DT |||
| concept_id | See the above table to assign HRA questions to standard concept ids||
| source_value | See the above table to assign source values|||
| source_concept_id |0| ||
| type_concept_id |Use concept 44786634|||  
| operator_concept_id | |||
| unit_concept_id | See the above table for assigning this value for each question|||
| unit_source_value | See the above table for assigning this value for each question|||
| start_date | HRA_COMPLTD_DT||| 
| end_date |  |||
| range_high |||| 
| range_low |  ||| 
| value_as_number | See the above table. If VALUE_AS_NUMBER is the name of the column, then the the column will have a numeric value that should be put here. |||
| value_as_string | |||
| value_as_concept_id | Map the values in VALUE_SOURCE_VALUE | Use the SOURCE_TO_STANDARD query with the filter<br/><br/>**LOINC_CD**<br> WHERE SOURCE_VOCABULARY_ID IN ('LOINC') AND TARGET_STANDARD_CONCEPT ='S' AND TARGET_INVALID_REASON IS NULL||
| value_source_value | See the above table. If VALUE_AS_STRING is listed as the name of the column then put the value found in that column here. Otherwise, write out the definitions of the values as given.  |||
| end_datetime | |||
| verbatim_end_date |  |||
| days_supply | |||
| dose_unit_source_value ||||
| lot_number | |||
|MODIFIER_CONCEPT_ID|| | |
| modifier_source_value | |||
| quantity | |||
| refills | |||
| route_concept_id | |||
| route_source_value | |||
| sig |  |||
| stop_reason | |||
| unique_device_id | |||
| anatomic_site_concept_id | |||
| disease_status_concept_id |  |||
| specimen_source_id ||||
| anatomic_site_source_value | |||
| disease_status_source_value | |||
| condition_status_concept_id | |||
| condition_status_source_value | |||
