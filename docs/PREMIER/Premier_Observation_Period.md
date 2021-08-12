---
title: "Observation Period"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 12
layout: default
---

# Table: Observation_Period

Because of the lack of enrollment data in Premier, the observation period for each patient will be defined by unique visits from the VISIT_OCCURRENCE table for each unique patient. Derived admission and discharge dates are created using the number of service days, length of stay, days from prior and the sequence of visits. (See VISIT_OCCURRENCE specification).

 All overlapping visits will be collapsed into one observation period.  An overlapping visit is defined by a visit that has an admit date that is within 31 days of the previous discharge date. For example, a patient has an admission date of ‘2011-02-01’ and a discharge date of ‘2011-02-05’ and the next visit occurs in ‘2011-02-19’ and a discharge date of ‘2011-03-01’. These records would be collapsed into a single observation period.

The field mapping is as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| OBSERVATION_PERIOD_ID | - | System generated |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| OBSERVATION_PERIOD_START_DATE | VISIT_OCCURRENCE.VISIT_START_DATE |  |  |
| OBSERVATION_PERIOD_END_DATE | VISIT_OCCURRENCE.VISIT_END_DATE |  |  |
| PERIOD_TYPE_CONCEPT_ID | - | All records within the observation_period table should have a period_type_concept_id = 32875 (Provider financial system) |  |
