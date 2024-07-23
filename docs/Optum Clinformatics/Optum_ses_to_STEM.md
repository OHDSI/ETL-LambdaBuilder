---
layout: default
title: SES
nav_order: 8
parent: Optum Clinformatics to STEM
grand_parent: Optum Clinformatics
description: "Optum SES table mapping to CDM STEM table"

---


## **Mapping from SES**

The SES table in the Optum Extended SES data contains additional socio-economic variables that are not available in the DOD (date of death) version. It does not have a date associated to the information and when it was asked of the patient so we will use the last day of the most recent observation period.Use the following to set the `value_as_string` and `value_as_concept_id` for each variable. 

Optum updates the socio-economic status variables within the Optum CDM SES view quarterly with the most up-to-date information about each member. Please note only the most recent value received is populated and historic values are not retained. 

### d_education_level_code - Highest level of education

|**d_education_level_code**|**value_as_string**|**value_as_concept_id**|
| :----: | :----: | :----:|
| A | 'Less than 12th Grade' | 37079293 (Less than high school degree) |
| B | 'High School Diploma' |  37079292 (High school diploma or GED) |
| C | 'Less than Bachelor Degree' | 1621239 (Attended some years of university) | 
| D | 'Bachelor Degree Plus' | 1990213 (More than 4-year college degree) |
| U | 'Unknown' | 0 |


### d_home_ownership_code - Home ownership

|**d_home_ownership_code**|**value_as_string**|**value_as_concept_id**|
| :----: | :----: | :----:|
| 1 | 'Probable Homeowner' | 4201839 (Owns own home) |
| 2 | 'Probable Renter' | 4072617 (Lives in rented accommodation)  |
| 0 | 'Unknown' | 0 |


|**d_household_income_range_code**|**value_as_string**|**value_as_concept_id**|
| :----: | :----: | :----:|
| 1 | '<$40K' | 45883177 (Less than 35,000) *this one is not exact but it is the closest* |
| 2 | '$40K-$49K' | 46237798 (40,000 to 49,000) |
| 3 | '$50K-$59K' | 46237437 (50,000 to 59,000) | 
| 4 | '$60K-$74K' | 46237851 (60,000 to 74,000) |
| 5 | '$75K-$99K' | 46237403 (75,000 to 99,999) | 
| 6 | '$100K+' | 35819437 (Greater than 100,000) |
| 0 | 'Unknown' | 0 |



The table below details how the other variables in the SES table should be mapped to the CDM.

|**Destination Field**|**Source Field**|**Applied Rule**|**Comment**|
| :----: | :----: | :--------: | :------: |
| id |  |Autogenerate||
| domain_id || Observation||
| person_id | PATID| Use patid to lookup Person_id ||
| visit_detail_id |NULL|||
| visit_occurrence_id |NULL|||
| provider_id | |||
| start_datetime |observation_period_end_date | Use the **latest** observation_period_end_date per patient since we do not have dates associated with this data. ||
| concept_id | d_household_income_range_code<br> d_education_level_code<br>d_home_ownership_code|d_household_income_range_code: Set to concept 4076114 (Household Income) <br><br>d_education_level_code: Set to 42528763 (Highest level of education - reported)<br><br>d_home_ownership_code: Set to 4076206 (House ownership and tenure)|
| source_value |d_household_income_range_code<br> d_education_level_code<br>d_home_ownership_code<br> |Set to the name of the variable||
| source_concept_id |0| ||
| type_concept_id |Use concept 32813|||  
| operator_concept_id | |||
| unit_concept_id | |||
| unit_source_value | |||
| start_date | extract_ym | The first four digits of this value are the **year**, the second two digits are the **month**, set day to the last **day** in the month|| 
| end_date |  |||
| range_high |||| 
| range_low |  ||| 
| value_as_number |  |||
| value_as_string | See the tables above for how to set this variable |||
| value_as_concept_id | See the tables above for how to set this variable | ||
| value_source_value | Put the value as given in the source data |||
| end_datetime | |||
| verbatim_end_date |  |||
| days_supply | |||
| dose_unit_source_value ||||
| lot_number | |||
| modifier_concept_id|| | |
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