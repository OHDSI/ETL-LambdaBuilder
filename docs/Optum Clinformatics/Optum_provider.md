---
layout: default
title: Provider
nav_order: 6
parent: Optum_Clinformatics
description: "Provider mapping from Optum Clinformatics provider table"

---
# CDM Table: PROVIDER

Is derived from one table **PROVIDER** limited to Prov_Type in (empty, '1', 'unknown')

Note: OPTUM DOD/SES has two provider tables **PROVIDER** and **PROVIDER_BRIDGE**. **PROVIDER** table takes advantage of known information about providers/facilities to consolidate multiple provider IDs for the same provider/facility into a better single identifier (Master Provider index). PROV field from medical table and the identifiers NPI/DEA from pharmacy tables link to PROVIDER_BRIDGE table. The purpose of the PROVIDER_BRIDGE  table is to link PROVIDER table to medical/pharmacy claims tables to get information such as credentials or specialty information.

## **PROVIDER Table Logic**

- When source table has PROV as an identifier for provider/care_site, it should be crosswalked to PROV_UNIQUE using **PROVIDER_BRIDGE**. PROVIDER_SOURCE_VALUE will be populated by PROV_UNIQUE.
- DEA and NPI are encrypted and not used in ETL
- To determine SPECIALTY_CONCEPT_ID use the following hierarchy:
    1. Taxonomy1
    2. If Taxonomy1 is NULL then Taxonomy2
    3. If Taxonomy2 is NULL then PROVCAT

## Provider specialty mapping 
If Taxonomy1 or Taxonomy2 are not NULL then do the following:
- To map the SPECIALTY_CONCEPT_ID use the SOURCE_TO_STANDARD query with the filter: `Where source_vocabulary in 'NUCC' and invalid_reason is NULL and standard_concept = 'S'`
- To map the SPECIALTY_SOURCE_CONCEPT_ID use the SOURCE_TO_SOURCE query with the filter: `Where source_vocabulary in 'NUCC'`

If Taxonomy1 and Taxonomy2 are both NULL then use PROVCAT to map SPECIALITY_CONCEPT_ID using the SOURCE_TO_STANDARD query with the filter: `Where source_vocabulary in 'JNJ_OPTUM_P_SPCLTY' ` and set SPECIALTY_SOURCE_CONCEPT_ID to 0.

**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
PROVIDER_ID|**PROVIDER** Prov_Unique||
PROVIDER_NAME| |NULL|
NPI|NULL|**PROVIDER_BRIDGE** NPI is encrypted NPI; it does not pass validity check using NPI check algorithms like [here](https://www.eclaims.com/articles/how-to-calculate-the-npi-check-digit/)
DEA|NULL|**PROVIDER_BRIDGE** DEA is encrypted DEA; it does not pass validity check using DEA check algorithms like [here](https://en.wikipedia.org/wiki/DEA_number)
SPECIALTY_CONCEPT_ID|**PROVIDER** Taxonomy1, Taxonomy2, PROVCAT||[See provider specialty logic](#Provider-specialty-mapping)
CARE_SITE_ID|0||
YEAR_OF_BIRTH|NULL| |
GENDER_CONCEPT_ID|0||
PROVIDER_SOURCE_VALUE|**PROVIDER** Prov_Unique|
SPECIALTY_SOURCE_VALUE|**PROVIDER** Taxonomy1,  Taxonomy2, PROVCAT||[See provider specialty logic](#Provider-specialty-mapping)
SPECIALTY_SOURCE_CONCEPT_ID|**PROVIDER** Taxonomy1, Taxonomy2||[See provider specialty logic](#Provider-specialty-mapping)
GENDER_SOURCE_VALUE|NULL| |
GENDER_SOURCE_CONCEPT_ID|0||
---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*