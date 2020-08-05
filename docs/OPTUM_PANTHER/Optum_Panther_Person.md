---
layout: default
title: Person
nav_order: 1
parent: OPTUM_PANTHER
description: "Person mapping from Optum EHR patient table"

---

# CDM Table name: PERSON

## Reading from OPTUM_EHR.Patient

![](images/personmap.png)

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
|     person_id    |     ptid    |          |     Remove ‘PT’   prefix: cast(replace(ptid, 'PT','') as bigint)    |
|     gender_concept_id    |     gender    |     If gender = ‘Unknown’ then remove     Else if   gender = 'Male' then 8507     else if   gender = 'Female' then 8532    |          |
|     year_of_birth    |     birth_yr    |     if birth_yr == 'Unknown' or *NULL* then remove   <br>  else if   birth_yr <> 'Unknown' then      if birth_yr   = '1927 and earlier' then 1927     else   birth_yr    |          |
|     month_of_birth    |          |          |          |
|     day_of_birth    |          |          |          |
|     birth_datetime    |          |          |          |
|     race_concept_id    |     race    |     if   'Caucasian' then 8527     else if   'African American' then 8516     else if   'Asian' then 8515     else 0    |          |
|     ethnicity_concept_id    |     ethnicity    |     if   'Hispanic' then 38003563  <br> if 'Not Hispanic' then 38003564 <br>   else 0    |          |
|     location_id    |     region     division    |     Look up from   Location table    |          |
|     provider_id    |     provid_pcp    |     Look up   from Provider table. In the case when the value is “” in the source, set the   provider_id to NULL.    |          |
|     care_site_id    |          |          |          |
|     person_source_value    |     ptid    |          |          |
|     gender_source_value    |     gender    |          |          |
|     gender_source_concept_id    |          |          |          |
|     race_source_value    |     race    |          |          |
|     race_source_concept_id    |          |          |          |
|     ethnicity_source_value    |     ethnicity    |          |          |
|     ethnicity_source_concept_id    |          |          |          |

## Change Log

- Added logic *if birth_yr is NULL*
- Added logic to map *Not Hispanic ethnicity*