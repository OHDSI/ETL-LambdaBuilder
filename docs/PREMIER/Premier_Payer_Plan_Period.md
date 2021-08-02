---
title: "Payer Plan Period"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 4
layout: default
---

Payer information presented in Premier exists in the PAT table, in the field PAT.STD_PAYOR, which represents standard payer categories. Since information about how long the patient remains with a payer or is enrolled is unavailable, the PAYER_PLAN_PERIOD_START_DATE and PAYER_PLAN_PERIOD_END_DATE is the same as the calculated OBSERVATION_PERIOD for each patient. If a patient changes payer within an observation period, then the payer plan period will be segmented to reflect the change in payers. If multiple payers are attributed to one observation period, use visit start and visit end to determine the payer.

The field mapping is as follows:

| Destination Field | Source Field | Applied Rule | Comment |
| --- | --- | --- | --- |
| PAYER_PLAN_PERIOD_ID | - | System- generated value |  |
| PERSON_ID | PAT.MEDREC_KEY |  |  |
| PAYER_PLAN_PERIOD_START_DATE | OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE |  |  |
| PAYER_PLAN_PERIOD_END_DATE | OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE |  |  |
| PAYER_SOURCE_VALUE | PAYOR.STD_PAYER_DESC |  |  |
| PLAN_SOURCE_VALUE | - | NULL |  |
| FAMILY_SOURCE_VALUE | - | NULL |  |

