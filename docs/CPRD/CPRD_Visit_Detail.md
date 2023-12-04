---
layout: default
title: Visit_Detail
nav_order: 6
parent: CPRD GOLD
description: "Visit_Detil mapping from CPRD GOLD event tables"

---


# CDM Table name: VISIT_DETAIL

## Reading from CPRD.Clinical, Immunisation, Referral, Test, and Therapy.

Take all records from CPRD tables Clinical, Immunisation, Referral, Test, and Therapy. Using only the fields patid, consid, and eventdate, stack records sequentially by patid and consid. Each unique combination of the three fields will create a visit. Set VISIT_START_DATE as eventdate. If eventdate is blank, remove record. 

The 'accept' flag in the patient table should remove records where eventdate occurs prior to the date of birth. In the case this was not universally applied at the source if any eventdates are prior to patient date of birth set eventdate to patient.frd. 

For datetime fields, set time to midnight 00:00:00.

![](images/image8.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_detail_id |  |  | Autogenerate |
| person_id | patid |  |  |
| visit_detail_concept_id |  |  | 9202 - OP |
| visit_detail_start_date | eventdate | If eventdate is blank, remove record. The 'accept' flag in the patient table should remove records where eventdate < date of birth. In the case this was not universally applied at the source, if any eventdates are prior to patient date of birth, set eventdate to patient.frd. |  |
| visit_detail_start_datetime | eventdate | Use the same logic used to set visit_detail_start_date. Set time to 00:00:00 |  |
| visit_detail_end_date |  | Set as visit_detail_start_date  | |
| visit_detail_end_datetime |  | Set as visit_detail_start_datetime |  |
| visit_detail_type_concept_id |  | Use **32817** - EHR |  |
| provider_id | staffid |  |  |
| care_site_id | patid | Use the last three digits of the patid (removing leading zeros) to look up the care_site_id in the care_site table. |  |
| visit_detail_source_value | constype | Use the consid to link back to the consultation table. Use the constype from the consultation table as the visit_detail_source_value. If there are two based on how the visit detail was defined, choose one. |  |
| visit_detail_source_concept_id |  |  | 0 |
| admitting_source_concept_id |  |  |  |
| admitting_source_value |  |  | NULL |
| discharge_to_concept_id |  |  |  |
| discharge_to_source_value |  |  | NULL |
| preceding_visit_detail_id |  | Put the visit_detail_id of the most recent prior visit here. |  |
| visit_detail_parent_id |  |  |  |
| visit_occurrence_id |  | Put the VISIT_OCCURRENCE_ID of the VISIT_OCCURRENCE record that the VISIT_DETAIL record belongs to |  |
