---
title: "Condition Era"
author: "Andryc, A; Fortin, S"
parent: Premier
layout: default
---

# Table Name: Condition Era

CONDITION_ERAs are chronological periods of condition occurrence.  There will only be one type of persistence window (duration that can elapse between condition occurrences) applied to this CDM, which is 30 days. CONDITION_END_DATE will be the CONDITION_START_DATE. 

Exclude records with a CONDITION_CONCEPT_ID=0.  

All Condition Eras are recorded in the CONDITION_ERA table based on the following field mapping: 

| Destination Field  | Source Field  | Applied Rule  | Comment  |
| --- | --- | --- | --- |
| CONDITION_ERA_ID  |  | System-generated  |  |
| PERSON_ID  | PERSON_ID  |  |  |
| CONDITION_CONCEPT_ID  | CONDITION_CONCEPT_ID  | Do not build condition_era where the condition_occurence_condition_concept_id=0  |  |
| CONDITION_ERA_START_DATE  | CONDITION_START_DATE  |  | The start date for the condition era constructed from the individual instances of condition occurrences. It is the start date of the very first chronologically recorded instance of the condition.  |
| CONDITION_ERA_END_DATE  | CONDITION_START_DATE  |  | The end date for the condition era constructed from the individual instances of condition occurrences. It is the end date of the final continuously recorded instance of the condition.  |
| CONDITION_TYPE_CONCEPT_ID  |  | Apply a 30-day persistence window and label as CONCEPT_ID 38000247 (Condition era - 30 days persistence window).    | Falls under CONCEPT_VOCABULARY_ID = 37 - OMOP Condition Occurrence Type.  |
| CONDITION_OCCURRENCE_COUNT  |  | Sum up the number of CONDITION_OCCURRENCEs for this PERSON_ID and this CONCEPT_ID during the exposure window being built.  |  |
