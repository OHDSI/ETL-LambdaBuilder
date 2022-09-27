---
title: "Dose Era"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 7
layout: default
---

# Table Name: Dose Era

 A Dose Era is defined as a span of time when the Person is assumed to be exposed to a constant dose of a specific active ingredient. 
 
| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| DOSE_ERA_ID  |  | System-generated  |  |
| PERSON_ID  | PERSON_ID  |  |  |
| DRUG_CONCEPT_ID  | DRUG_CONCEPT_ID  | Do not build dose_era where the drug_concept_id=0  |  |
| UNIT_CONCEPT_ID  |  |  |  |
| DOSE_VALUE  |  |  | Numeric value of dose  |
| DOSE_ERA_START_DATE  | DRUG_EXPOSURE_START_DATE  |  | The start date for the dose era constructed from the individual instances of drug exposures. It is the start date of the very first chronologically recorded instance of utilization of a drug.  |
| DOSE_ERA_END_DATE  |  |  |  |

