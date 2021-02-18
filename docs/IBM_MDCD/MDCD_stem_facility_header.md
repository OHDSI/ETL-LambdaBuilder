---
layout: default
title: Facility Header
nav_order: 6
grand_parent: IBM MDCD
parent: IBM MDCD to STEM
description: "FACILITY_HEADER to STEM table description"
---

## Table name: **STEM_TABLE**


#### Key conventions

* We take any **FACILITY_HEADER** record that matches up to a **INPATIENT_SERVICES** or **OUTPATIENT_SERVICES** record on ENROLID, FACHDID, and YEAR.  However we only take the first row for each ENROLID, FACHDID, and YEAR giving the visit with highest priority preference if it can be linked to multiple visits: IP visit > ER visit > OP visit.
* The **FACILITY_HEADER** table contains visit information and will be used to populate **CONDITION_OCCURRENCE**, **PROCEDURE_OCCURRENCE** and **DEATH** tables.

### Reading from **FACILITY_HEADER**

![](images/image1.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| DOMAIN_ID | - | NULL | - |
| PERSON_ID | ENROLID | - | - |
| VISIT_OCCURRNCE_ID | - | Refer to logic in building **VISIT_OCCURRENCE** table for linking with VISIT_OCCURRENCE_ID. | - |
| VISIT_DETAIL_ID | - | Refer to logic in building **VISIT_DETAIL** table for linking with VISIT_DETAIL_ID. | - |
| PROVIDER_ID | - | Refer to logic in building **VISIT_OCCURRENCE** table for assigning VISIT_PROVID and VISIT_PROVSTD, and map them to PROVIDER_SOURCE_VALUE and SPECIALTY_SOURCE_VALUE in **PROVIDER** table to extract associated Provider ID. Else write a `NULL`. | - |
| ID | - | System generated. | - |
| CONCEPT_ID | DX1-9<BR><BR>PROC1-6 | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a><BR /><br>When a code comes from a proc field:<br>`WHERE SOURCE_VOCABULARY_ID IN (‘ICD9Proc’,’HCPCS’,’CPT4’,’ICD10PCS’)  AND TARGET_STANDARD_CONCEPT IS NOT NULL AND TARGET_INVALID_REASON IS NULL AND TARGET_CONCEPT_CLASS_ID NOT IN (‘HCPCS Modifier’,’CPT4 Modifier’,’CPT4 Hierarchy’, ‘ICD10PCS Hierarchy’)`<br><br>From a code comes from a dx field: <br>If DXVER=9 use the filter:<br>`WHERE SOURCE_VOCABULARY_ID IN (‘ICD9CM’) AND TARGET_STANDARD_CONCEPT IS NOT NULL AND TARGET_INVALID_REASON IS NULL`<br><br>If DXVER=0 use the filter:<br>`WHERE SOURCE_VOCABULARY_ID IN (’ICD10CM’) AND TARGET_STANDARD_CONCEPT IS NOT NULL AND TARGET_INVALID_REASON IS NULL`<br>See STEM Key Conventions DXVER does not exist. |
| SOURCE_VALUE | DX1-9<br>PROC1-6 | - | - |
| TYPE_CONCEPT_ID | - | On the STEM Lookup page refer to "Condition Type Concept ID Lookup" for DX columns and the "Procedure Type Concept ID Lookup" for the PROC columns. | - |
| START_DATE | - | For conditions:  If a date is not defined, use VISIT_START_DATE.<br><br> For procedures:  If a date is not defined, use VISIT_END_DATE of the associated visit. | - |
| START_DATETIME | - | START_DATE + Midnight | - |
| END_DATE | - | NULL | - |
| END_DATETIME | - | NULL | - |
| VERBATIM_END_DATE | - | NULL | - |
| DAYS_SUPPLY | - | NULL | - |
| DOSE_UNIT_SOURCE_VALUE | - | NULL | - |
| LOT_NUMBER | - | NULL | - |
| MODIFIER_CONCEPT_ID | PROCMOD | Use the <a href="https://ohdsi.github.io/CommonDataModel/sqlScripts.html">Source-to-Standard Query</a><BR /><br>When a code comes from a proc field:<br>`WHERE SOURCE_VOCABULARY_ID IN (‘ICD9Proc’,’HCPCS’,’CPT4’,’ICD10PCS’)  AND TARGET_STANDARD_CONCEPT IS NOT NULL AND TARGET_INVALID_REASON IS NULL AND TARGET_CONCEPT_CLASS_IN ('HCPCS Modifier','CPT4 Modifier')`<BR><BR> If PROCMOD is blank then set to 0. | - |
| MODIFIER_SOURCE_VALUE | - | NULL | - |
| OPERATOR_CONCEPT_ID | - | 0 | - |
| QUANTITY | - | NULL | - |
| RANGE_HIGH | - | NULL | - |
| RANGE_LOW | - | NULL | - |
| REFILLS | - | NULL | - |
| ROUTE_CONCEPT_ID | - | 0 | - |
| ROUTE_SOURCE_VALUE | - | NULL | - |
| SIG | - | NULL | "Sig" is short for the Latin, signetur, or "let it be labeled." |
| STOP_REASON | - | NULL | - |
| UNIQUE_DEVICE_ID | - | NULL | - |
| UNIT_CONCEPT_ID | - | 0 | - |
| UNIT_SOURCE_VALUE | - | NULL | - |
| VALUE_AS_CONCEPT_ID | - | 0 | - |
| VALUE_AS_NUMBER | - | NULL | - |
| VALUE_AS_STRING | - | NULL | - |
| VALUE_SOURCE_VALUE | - | NULL | - |
| ANATOMIC_SITE_CONCEPT_ID | - | 0 | - |
| DISEASE_STATUS_CONCEPT_ID | - | 0 | - |
| SPECIMEN_SOURCE_ID | - | NULL | - |
| ANATOMIC_SITE_SOURCE_VALUE | - | NULL | - |
| DISEASE_STATUS_SOURCE_VALUE | - | NULL | - |
| CONDITION_STATUS_CONCEPT_ID | - | 0 | - |
| CONDITION_STATUS_SOURCE_VALUE | - | NULL | - |
| EVENT_ID | - | NULL | - |
| EVENT_FIELD_CONCEPT_ID | - | 0 | - |
| VALUE_AS_DATETIME | - | NULL | - |
| QUALIFIER_CONCEPT_ID | - | 0 | - |
| QUALIFIER_SOURCE_VALUE | - | NULL | - |