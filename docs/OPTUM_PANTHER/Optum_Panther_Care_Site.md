---
layout: default
title: Care Site
nav_order: 4
parent: Optum EHR
description: "Care_Site mapping from Optum EHR sources"

---
# CDM Table: CARE_SITE

Optum EHR is made up of eletronic health records from a variety of hospital-based and ambulatory-only facilities across the US. There are more than 50 sources contributing to the Optum EHR data, including over 30 large integrated delivery networks (IDNs). An IDN is a network of healthcare facilities and providers that work together to deliver coordinated care to patients. Each source represented in Optum EHR will be considered a CARE_SITE and assigned a unique CARE_SITE_ID to faciliate understanding of how the sources come together to represent a full patient journey.

## **CARE_SITE Table Logic**

First, unique sources need to be identified from the native tables and identifed as IDNs, if applicable. 

This is done in a two-step process:
1. Identify the unique sources from the native **PATIENT** table and their IDN status. Patients can exist in multiple sources, so the sourceids in this table are concatenated, and they can look something like this: *S0072\*S0123*. This will be handled in step 2 so that we are left with only the individual sourceids, like *S0072* and their IDN indicators.
```sql

/* Get the sources and IDN indicators from the patient table */

SELECT p.sourceid, max(p.idn_indicator) as idn
INTO #patient_sources
FROM native.patient p
GROUP BY p.sourceid;
```

2. Identify the indiviual sources from the native **ENCOUNTER** table and join to the temp table we made in step 1 to get the IDN status. 
```sql

/* Get the individual sources from the encounter table */

SELECT DISTINCT(e.sourceid) as sourceid
INTO #encounter_sources
FROM native.encounter e;

/* Join the encounter sources to the patient sources to get the IDN status */
SELECT e.sourceid, p.idn
FROM #encounter_sources e
LEFT JOIN #patient_sources p
    ON e.sourceid = p.sourceid;

```
You should now be left with a table that has the individual sourceids and their IDN status.

## **Mapping the CARE_SITE table**


**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
CARE_SITE_ID|*system generated*| |
CARE_SITE_NAME| NULL | |
PLACE_OF_SERVICE_CONCEPT_ID|0| |
LOCATION_ID|||
CARE_SITE_SOURCE_VALUE|sourceid| |
PLACE_OF_SERVICE_SOURCE_VALUE|IDN status|From above query, if IDN = 1 then 'IDN' else NULL|

---

### 19-Jun-2025
- Initial sourceid and IDN status logic added to the CARE_SITE table.