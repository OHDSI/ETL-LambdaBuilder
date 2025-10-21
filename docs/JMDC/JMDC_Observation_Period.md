---
layout: default
title: Observation Period
nav_order: 2
parent: JMDC
description: "Observation_Period mapping from JMDC enrollment table"

---

# CDM Table name: OBSERVATION_PERIOD

In the case that the OBSERVATION_PERIOD ends greater than 60 days after the patient's death date, set the OBSERVATION_PERIOD_END_DATE to be the death date + 60 days. 

## Reading from JMDC.Enrollment

![](images/image3.png)

| Destination   Field   | Source   Field    | Logic   | Comment   Field  |
|-------------------------------|-------------------|-------------------------------------------------------------------------|-----------------------------------------------|
| observation_period_id         |   | |  |
| person_id    | member_id       | Remove 'M' prefix  |    |
| observation_period_start_date | observation_start | Set to first of month (E.g.   '200802' becomes 1st of February 2008)    |     |
| observation_period_end_date   | observation_end   | Set to last day of month (E.g.   '200801' becomes 31st of January 2008) |   See note above for how to set this date when the the observation_period_end_date is greater than 60 days after death.  |
| period_type_concept_id     |  |   | `32813` Claim enrolment record  |