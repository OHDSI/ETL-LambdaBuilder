---
layout: default
title: Source Code to SNOMED and Episode Domain Mapping
nav_order: 17
description: "Universal mapping logic for native vocabulary codes to both SNOMED conditions and Disease Dynamic Episodes"

---

# Source Code to SNOMED and Episode Domain Mapping

## Overview

Traditionally, native diagnosis codes (ICD9CM, ICD10CM, Read codes, etc.) have been mapped to standard concepts across various OMOP CDM domains (Conditions, Observations, Measurements, Procedures, etc.) via concept_relationship tables. However, cancer data requires an additional layer of abstraction to capture disease progression and clinical status over time. This guide describes the **universal mapping logic** for any source codes that may now have parallel mappings to:

1. **Standard Domain Concepts** (traditional mapping via concept_relationship to any OMOP domain)
2. **Episode Domain Concepts** - specifically Disease Dynamic Episodes (new parallel mapping for cancer data)

This dual mapping approach enriches cancer real-world evidence by capturing not just *what* the diagnosis is, but *when* and *how* the disease status is evolving throughout the patient's cancer journey. The logic applies universally across all databases and native vocabularies (CPRD with Read codes, Optum with ICD9/ICD10, IBM with native coding, JMDC with Japanese codes, etc.).

---

## Background: Disease Dynamic Episodes

Disease Dynamic Episodes represent **time frames during which a patient's cancer status remains consistent**. They abstract clinical events (conditions, measurements, procedures) into higher-level disease states that define the course of the cancer.

### The Five Disease Dynamic Episode States

| Episode Type | Definition | Triggered By |
|--------------|-----------|---|
| **Remission** | Cancer status unclear; may be complete or partial | Completion of treatment without clear outcome data |
| **Complete Remission** | No evidence of disease after curative surgery or treatment | Resolved metastases, node involvement absent, biomarker levels normal |
| **Partial Remission** | Measurable reduction but incomplete response | Metastases/nodes reduced in dimension, biomarker levels decreased |
| **Stable Disease** | No improvement or worsening; disease unchanged | Metastases, nodes, and biomarkers show no change |
| **Progression** | Disease worsening or new disease manifestations | New/growing metastases, new nodes, rising biomarkers, new treatments |

---

## Mapping Architecture

### Step 1: Source Code to Standard Domain Mapping (Traditional)

All native diagnosis codes (ICD9CM, ICD10CM, Read codes, etc.) continue to be mapped to standard concepts across various OMOP CDM domains using the existing vocabulary relationship infrastructure:

```
Source Code (ICD9/ICD10/Read/Native) → Maps to → Standard Concept (various OMOP domains)
```

**Examples:**
- Source code representing a cancer diagnosis → standard concept in Condition domain
- Source code representing a different clinical finding → standard concept in appropriate domain
- Source code representing a treatment or biomarker → standard concept in Measurement or Procedure domain

This mapping:
- Is populated into the appropriate domain table (e.g., `CONDITION_OCCURRENCE.condition_concept_id`, `MEASUREMENT.measurement_concept_id`, `OBSERVATION.observation_concept_id`, etc.)
- Uses concept_relationship `Maps to` to identify the target standard concept
- May target any standard domain depending on the source code semantics

### Step 2: Source Code to Disease Dynamic Episode Mapping (Parallel)

In parallel, selected source codes (from any native vocabulary) are now mapped to Episode domain concepts to capture disease status transitions:

```
Source Code (ICD9/ICD10/Read/Native) → Interpreted as → Disease Dynamic Episode Concept (EPISODE table)
```

**Important:** A source code may map to BOTH a standard domain concept (Step 1) AND an Episode concept (Step 2) simultaneously. This creates dual records in the CDM representing both the clinical event and the disease trajectory.

**Example Scenario:**

| Source Code | Maps to Standard Concept (Condition) | Also Creates Episode |
|-----------|-----------------|----------------------|
| ICD10CM `C93.32` (Juvenile myelomonocytic leukemia, in relapse) | Condition: Juvenile myelomonocytic leukemia (concept_id 40482847) | Episode: Progression (concept_id 32949) |

This example shows a real mapping where the ICD10CM code maps to both a Condition domain concept (the base diagnosis) and an Episode concept (the disease status indicating progression).

---

## ETL Implementation Guidelines

### Universal Mapping Rules

The following rules apply universally across all cancer databases and native vocabularies (CPRD Aurum with Read codes, Optum with ICD9/ICD10, IBM CCAE/MDCD with ICD9/ICD10, JMDC with native codes, PREMIER, etc.):

#### 1. **Dual Record Creation**

For each source code (native vocabulary) that has Episode mappings:

1. **Always create the standard domain record(s):**
   - Populate the appropriate OMOP CDM table based on the standard concept domain (CONDITION_OCCURRENCE, MEASUREMENT, OBSERVATION, PROCEDURE_OCCURRENCE, etc.)
   - Example for Condition domain: `condition_concept_id` = mapped standard concept
   - Example for Measurement domain: `measurement_concept_id` = mapped standard concept
   - Fill in all required date/time fields from source
   - Use appropriate type_concept_id (EHR, Registry, etc.)

2. **Always create EPISODE records when a Maps to relationship exists:**
   - If the source code has a `Maps to` relationship to an Episode domain concept, create the EPISODE record
   - Use the target concept from the `Maps to` relationship as `episode_concept_id`
   - Link to the corresponding standard domain record via EPISODE_EVENT table (using the appropriate event_id and episode_event_field_concept_id)

#### 2. **Episode-Event Linking**

Connect the standard domain record to EPISODE through the EPISODE_EVENT table. The `event_id` field should reference the primary key of the triggering event, and `episode_event_field_concept_id` should indicate the table type:

```sql
-- Example: Linking from CONDITION_OCCURRENCE
INSERT INTO EPISODE_EVENT (episode_id, event_id, episode_event_field_concept_id)
VALUES (
  <episode_id>,                           -- From EPISODE table
  <condition_occurrence_id>,              -- From CONDITION_OCCURRENCE
  4203600                                 -- concept_id for 'Condition Occurrence ID'
);

-- Example: Linking from MEASUREMENT (e.g., biomarker trigger)
INSERT INTO EPISODE_EVENT (episode_id, event_id, episode_event_field_concept_id)
VALUES (
  <episode_id>,                           -- From EPISODE table
  <measurement_id>,                       -- From MEASUREMENT
  4203601                                 -- concept_id for 'Measurement ID'
);
```

#### 3. **Temporal Ordering**

- `episode_start_date` = the start date of the event (e.g., `condition_start_date`, `measurement_date`)
- `episode_end_date` = the end date of the event (e.g., `condition_end_date`, `measurement_date`)
  - If the source event has no end date, set `episode_end_date` = `episode_start_date`

**Note on Episode Duration:** The current mapping creates Episode records directly from source events using their dates. Future iterations will implement logic to determine appropriate episode lengths and boundaries based on clinical progression indicators and disease state transitions. This may result in episodes that differ from individual event dates and have gaps between them.



## Specific Mapping Examples

### Example 1: Source Code Mapping to Condition and Remission Episode

**Source Data:**
- Native vocabulary code indicating a cancer diagnosis with remission status
- Date: [diagnosis/assessment date]
- Clinical context: "Patient in remission, no evidence of disease"

**OMOP Output:**

1. **Standard Domain Record (via concept_relationship Maps to):**
   - Populate appropriate table with standard concept mapped via `Maps to` relationship
   - Use source date as start date

2. **EPISODE:**
   - `episode_concept_id`: "Complete Remission" or "Remission" (from Episode vocabulary)
   - `episode_start_date`: [date of remission indication]
   - `episode_end_date`: [same as episode_start_date if no end date available]

3. **EPISODE_EVENT:**
   - `episode_id`: [from EPISODE table]
   - `event_id`: [primary key of the standard domain record created in step 1]
   - `episode_event_field_concept_id`: [concept_id indicating the source table type, e.g., 4203600 for Condition Occurrence ID]

---

### Example 2: Source Code Mapping with Stable Disease Episode

**Source Data:**
- Native vocabulary code indicating ongoing cancer management without change
- Date: [date of assessment]
- Clinical context: "Disease stable on surveillance" or follow-up without progression

**OMOP Output:**

1. **Standard Domain Record (via concept_relationship Maps to):**
   - Standard concept for cancer diagnosis linked via `Maps to` relationship

2. **EPISODE:**
   - `episode_concept_id`: "Stable Disease" (from Episode vocabulary)
   - `episode_start_date`: [date of assessment]
   - `episode_end_date`: [same as episode_start_date if no end date available]

3. **EPISODE_EVENT:**
   - `episode_id`: [from EPISODE table]
   - `event_id`: [primary key of the standard domain record created in step 1]
   - `episode_event_field_concept_id`: [concept_id indicating the source table type, e.g., 4203600 for Condition Occurrence ID]

---

## Important Note on Episode Overlap

The current mapping logic creates EPISODE records directly from source events using their dates. This may result in multiple Disease Dynamic Episodes for the same person and time period, which violates the OMOP CDM expectation that episodes are mutually exclusive and non-overlapping. 

**This overlap behavior is expected in this initial implementation.** Future versions will implement sophisticated logic to:
- Determine appropriate episode boundaries
- Consolidate overlapping episodes
- Apply persistence windows and clinical rules to create coherent disease state transitions

For now, episodes should be created for all source codes with `Maps to` relationships to Episode concepts, and any overlap resolution is deferred to future development.

---

## References

- [OHDSI Oncology Working Group - OnRamp (Disease Dynamic Episodes)](https://github.com/ohdsi/OncologyWG/wiki/onramp#disease-dynamic-episodes)
- [OMOP CDM Episode Table Specification](https://ohdsi.github.io/CommonDataModel/cdm60.html#episode)
- [OHDSI Cancer Vocabulary - Episode Domain](https://athena.ohdsi.org/search-terms/terms?domain=Episode&standardConcept=Standard)
- [ICD10CM to SNOMED Mapping Best Practices](https://ohdsi.github.io/CommonDataModel/sqlScripts.html)

---

**Last Updated:** August 2026  
**Related Documentation:** [Drug Era Logic](Drug_Era_Logic.md), [STEM to CDM Mapping](STEM_to_CDM_Mapping.md)
