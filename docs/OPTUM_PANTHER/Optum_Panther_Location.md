---
layout: default
title: Location
nav_order: 3
parent: OPTUM_PANTHER
description: "Mapping the Location table from the Optum Panther patient table"

---

# CDM Table name: LOCATION

## Reading from OPTUM_EHR.Patient

![](images/locationmap.png)

|     Destination Field    |     Source Field    |     Logic    |     Comment    |
|-|-|-|-|
|     location_id    |          |          |     Autogen    |
|     address_1    |          |          |          |
|     address_2    |          |          |          |
|     city    |          |          |          |
|     state    |          |          |          |
|     zip    |          |          |          |
|     county    |          |          |          |
|     location_source_value    |     division     region    |     {region}_{division}    |     Concatenate   region_division region to create unique location_id    |