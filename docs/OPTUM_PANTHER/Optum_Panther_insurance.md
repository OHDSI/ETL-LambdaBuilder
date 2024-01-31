---
layout: default
title: Insurance
nav_order: 20
parent: Optum EHR
description: "OPTUM EHR Insurance table to Observation"
---

# CDM Table name: Observation

## Reading from OPTUM_EHR.Insurance

Note, the observation_concept_id belong to Payer domain, but goes to Observation table as en exclusion. These concepts normally go to the PAYER_PLAN_PERIOD table, but the Insurance table has a type of insurance at the encounter, not an insurance period which is needed for PAYER_PLAN_PERIOD.
 <table>
  <tr>
   <th>
    Destination Field
   </th>
   <th>
    Source Field
   </th>
   <th>
    Logic
   </th>
   <th>
    Comment
   </th>
  </tr>
  <tr>
   <td>
    observation_id
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    person_id
   </td>
   <td>
    ptid
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    observation_concept_id
   </td>
   <td>
    ins_type
   </td>
   <td>
    Use mapping:<br><br>
    Ins_type-concept_id<br>
    Commercial - 418<br>
    Medicare - 280<br>
    Medicaid - 289<br>
    Otherwise - 0
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
    observation_date
   </td>
   <td>
    insurance_date
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    observation_time
   </td>
   <td>
    insurance_time
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    observation_type_concept_id
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    value_as_number
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    value_as_string
   </td>
   <td>
    ins_type
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    value_as_concept_id
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    qualifier_concept_id
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    unit_concept_id
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    provider_id
   </td>
   <td>
    encid
   </td>
   <td>
     
   </td>
   <td>
    To avoid duplication, apply the same logic described when transforming the encounter table to visit_occurrence above.
   </td>
  </tr>
  <tr>
   <td>
    visit_occurrence_id
   </td>
   <td>
    encid
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    visit_detail_id
   </td>
   <td>
    encid
   </td>
   <td>
    If encid is found in the VISIT_DETAIL table, include the visit_detail_id in this field otherwise leave as NULL
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    observation_source_value
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    observation_source_concept_id
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    unit_source_value
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
  <tr>
   <td>
    qualifier_source_value
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
   <td>
     
   </td>
  </tr>
</table>

## Change log

### 13-Nov-2023
Set proper header.