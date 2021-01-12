---
layout: default
title: Death
nav_order: 10
parent: IBM CCAE & MDCR
description: "**DEATH** mapping from IBM MarketScan® Commercial Database (CCAE) & IBM MarketScan® Medicare Supplemental Database (MDCR) **FACILITY_HEADER**, **INPATIENT_SERVICES**, and **INPATIENT_ADMISSIONS**"
---

### Key conventions

* The Death table is designed to capture the time when a Person is deceased and cause of death. Death in Truven can be captured by discharge status in (20,40,41,42) (DSTATUS in **FACILITY_HEADER**, **INPATIENT_SERVICES**, and **INPATIENT_ADMISSIONS**). 


## Table name: **DEATH**

### Reading from **FACILITY_HEADER**

![](_files/image92.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| PERSON_ID | ENROLID | - | - |
| DEATH_DATE | VISIT_END_DATE | - | - |
| DEATH_DATETIME | - | - | - |
| DEATH_TYPE_CONCEPT_ID | DSTATUS | When dstatus is in (20,40,41,42) then death_type_concept_id = `38003566` for death captured by discharge status | - |
| CAUSE_CONCEPT_ID | - | - | - |
| CAUSE_SOURCE_VALUE | - | - | - |
| CAUSE_SOURCE_CONCEPT_ID | - | - | - |

<br><br>

### Reading from **INPATIENT_SERVICES**

![](_files/image93.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| PERSON_ID | ENROLID | - | - |
| DEATH_DATE | VISIT_END_DATE | - | - |
| DEATH_DATETIME | - | - | - |
| DEATH_TYPE_CONCEPT_ID | DSTATUS | When dstatus is in (20,40,41,42) then death_type_concept_id = `38003566` for death captured by discharge status | - |
| CAUSE_CONCEPT_ID | - | - | - |
| CAUSE_SOURCE_VALUE | - | - | - |
| CAUSE_SOURCE_CONCEPT_ID | - | - | - |

<br><br>

### Reading from **INPATIENT_ADMISSIONS**

![](_files/image94.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| PERSON_ID | ENROLID | - | - |
| DEATH_DATE | VISIT_END_DATE | - | - |
| DEATH_DATETIME | - | - | - |
| DEATH_TYPE_CONCEPT_ID | DSTATUS | When dstatus is in (20,40,41,42) then death_type_concept_id = `38003566` for death captured by discharge status | - |
| CAUSE_CONCEPT_ID | - | - | - |
| CAUSE_SOURCE_VALUE | - | - | - |
| CAUSE_SOURCE_CONCEPT_ID | - | - | - |

