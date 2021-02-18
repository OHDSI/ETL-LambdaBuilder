---
layout: default
title: Location
nav_order: 5
parent: IBM MDCD
description: "**LOCATION** mapping from IBM MarketScan® Medicaid Database (MDCD) **ENROLLMENT_DETAIL**." 
---

## Table name: **LOCATION**

### Key conventions
* MarketScan provides a lookup for GEOLOC that defines EGEOLOC (Geographic Location of Employee) that is used to map state.
* Remove duplicate records before assigning LOCATION_ID.     

### Reading from **ENROLLMENT_DETAIL**



| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| LOCATION_ID | - | 0 | - |
| ADDRESS_1 | - | NULL | - |
| ADDRESS_2 | - | NULL | - |
| CITY | - | NULL | - |
| STATE | - | NULL |  |
| ZIP | - | NULL | - |
| COUNTY | - | NULL | - |
| COUNTRY | - | NULL | - |
| LOCATION_SOURCE_VALUE | - | NULL | - |
| LATITUDE | - | NULL | - |
| LONGITUDE | - | NULL | - |
