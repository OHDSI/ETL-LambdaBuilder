---
layout: default
title: Provider
nav_order: 5
parent: CPRD GOLD
description: "Provider mapping from CPRD GOLD staff table"

---

# CDM Table name: PROVIDER

## Reading from CPRD.Staff

Use the staff table to populate the provider table. In CPRD, the staffid field represents the unique identifier given to the practice staff member entering the data, it does not necessarily represent the provider.  

![](images/image7.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | :---: | --- |
| provider_id | staffid |  |  |
| provider_name |  |  |  |
| npi |  |  |  |
| dea |  |  |  |
| specialty_concept_id | role | Join onto SOURCE_TO_CONCEPT_MAP, lookup the role in the source_code field using the [SOURCE_TO_STANDARD](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql) query with the following filter:    WHERE SOURCE_VOCABULARY_ID = 'JNJ_CPRD_PROV_SPEC' | Use the file [CPRD_Native_Specialties.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Vocab%20Updates/CPRD_Native_Specialties.sql) to find all provider specialities and counts if mapping updates to the SOURCE_TO_CONCEPT_MAP need to be made. <br><br> Set SPECIALTY_CONCEPT_ID as 38004514 (Unknown Physician Specialty) if role is missing or cannot be mapped. |
| care_site_id | staffid | right(staffid,3) | Last 3 digits of the staffid are the practice identifier with the leading zeros removed. |
| year_of_birth |  |  |  |
| gender_concept_id | gender | Map the CPRD gender code to gender_concept_id using the following logic: <br>1 = 8507<br>2 = 8532<br>(0,3,4) = 0 |  |
| provider_source_value | staffid |  |  |
| specialty_source_value | role | Join the staff table to the ROL lookup table on role = code where lookup_type_id = 76. Put the text from the lookup table as the SPECIALTY_SOURCE_VALUE. | See the file [CPRD_Native_Specialties.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/CPRD/Vocab%20Updates/CPRD_Native_Specialties.sql) for more information on how to join the tables. |
| specialty_source_concept_id |  |  | 0 |
| gender_source_value | gender | logic: <br>1 = M<br>2 = F |  |
| gender_source_concept_id |  |  | 0 |

## Change Log

### March 12, 2024
- specialty_concept_id added Unknown Physician Specialty for missing role