---
layout: default
title: Location
nav_order: 4
parent: CPRD Aurum
description: "Location mapping from CPRD Aurum Practice table"

---

# CDM Table name: LOCATION

## Reading from CPRD_Aurum.Practice

![](images/location.png)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| location_id | region |  |  |
| address_1 |  |  |  |
| address_2 |  |  |  |
| city |  |  |  |
| state |  |  |  |
| zip |  |  |  |
| county |  |  |  |
| location_source_value | lkpRegion.Description | Join to lkpRegion on `practice.region = lkpRegion.regionid` and set the location_source_value as lkpRegion.description. |  |