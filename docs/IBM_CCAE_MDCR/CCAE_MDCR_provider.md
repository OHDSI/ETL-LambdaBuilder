---
layout: default
title: Provider
nav_order: 5
parent: CCAE MDCR
description: "**PROVIDER** mapping from IBM MarketScan® Commercial Database (CCAE) & IBM MarketScan® Medicare Supplemental Database (MDCR) **FACILITY_HEADER**, **OUTPATIENT_SERVICES**, **INPATIENT_SERVICES**, and **LAB**."

---

## Table name: **PROVIDER**

The PROVIDER table contains a list of uniquely identified health care providers (physicians).  IBM does have some provider information; however some of the providers listed by IBM may also be considered care sites or organizations.  Since there is no clear way to decipher between all items identified as providers by IBM, regardless of whether they are truly organizations or care sites, they will be added to this table.

### Key conventions
* To build this table it is essentially a distinct listing of the entire provider IDs with all their associated specialties. 
<br>`SELECT DISTINCT PROVID, STDPROV`
<br>`FROM FACILITY_HEADER`
<br>`UNION`
<br>`SELECT DISTINCT PROVID, STDPROV`
<br>`FROM OUTPATIENT_SERVICES`
<br>`UNION`
<br>`SELECT DISTINCT PROVID, STDPROV`
<br>`FROM INPATIENT_SERVICES`
<br>`UNION`
<br>`SELECT DISTINCT PROVID, STDPROV`
<br>`FROM LAB`
* Provider Specialty (STDPROV) is available in MarketScan. We add mapping of MarketScan provider specialty to OMOP concept - VOCABULARY_ID = JNJ_TRU_P_SPCLTY. 
* Set SPECIALTY_CONCEPT_ID as 38004514 (Unknown Physician Specialty) if STDPROV is missing or can't be mapped.

### Reading from **FACILITY_HEADER**, **OUTPATIENT_SERVICES**, **INPATIENT_SERVICES**, & **LAB**

![](_files/image13.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| PROVIDER_ID |  | System generated. |  |
| PROVIDER_NAME |  | NULL |  |
| NPI |  | NULL |  |
| DEA |  | NULL |  |
| SPECIALTY_CONCEPT_ID | STDPROV | Use the code in [SOURCE_TO_STANDARD.sql](https://github.com/OHDSI/ETL-LambdaBuilder/blob/master/docs/Standard%20Queries/SOURCE_TO_STANDARD.sql). <br><br>Filters: <br>`WHERE SOURCE_VOCABULARY_ID IN ('JNJ_TRU_P_SPCLTY')` <br>`AND TARGET_STANDARD_CONCEPT IS NOT NULL` <br>`AND TARGET_INVALID_REASON IS NULL` | Set SPECIALTY_CONCEPT_ID as 38004514 (Unknown Physician Specialty) if STDPROV is missing or cannot be mapped.<br> |
| CARE_SITE_ID | - | 0 | - |
| YEAR_OF_BIRTH | - | NULL | - |
| GENDER_CONCEPT_ID | - | 0 | - |
| PROVIDER_SOURCE_VALUE | PROVID | - | - |
| SPECIALTY_SOURCE_VALUE | STDPROV | - | - |
| SPECIALTY_SOURCE_CONCEPT_ID | - | 0 | - |
| GENDER_SOURCE_VALUE | - | NULL | - |
| GENDER_SOURCE_CONCEPT_ID | - | 0 | - |