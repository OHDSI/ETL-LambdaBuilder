---
layout: default
title: Visit Detail
nav_order: 8
parent: CDM to CDM
description: "VISIT_DETAIL mapping from an existing CDM instance"
---

## Table name: **VISIT_DETAIL**

### Reading from **VISIT_DETAIL**

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| visit_detail_id | visit_detail_id|||
| person_id | person_id |||
| visit_detail_concept_id | visit_detail_concept_id |||
| visit_detail_start_date | visit_detail_start_date|||
| visit_detail_start_datetime | visit_detail_start_datetime|||
| visit_detail_end_date | visit_detail_end_date|||
| visit_detail_end_datetime | visit_detail_end_datetime |||
| visit_detail_type_concept_id |  visit_detail_type_concept_id |||
| provider_id | provider_id |||
| care_site_id | care_site_id|||
| visit_detail_source_value | visit_detail_source_value|||
| visit_detail_source_concept_id | visit_detail_source_concept_id |||
| admitted_from_concept_id |admitted_from_concept_id(v5.4) <br> admitting_source_concept_id(v5.3.) |||
| admitted_from_source_value |admitted_from_source_value(v5.4) <br>  admitting_source_value(v5.3.)|||
| discharged_to_source_value | discharged_to_source_value(v5.4) <br> discharge_to_source_value(v5.3.)|||
| discharged_to_concept_id | discharged_to_concept_id(v5.4) <br> discharge_to_concept_id(v5.3.)|||
| preceding_visit_detail_id | preceding_visit_detail_id  |||
| parent_visit_detail_id | parent_visit_detail_id (v5.4) visit_detail_parent_id(v5.3.) |||
| visit_occurrence_id | visit_occurrence_id |||

## Change Log