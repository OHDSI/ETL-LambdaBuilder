---
layout: default
title: Location
nav_order: 5
parent: Optum Clinformatics
description: "Location mapping from Optum Clinformatics member_enrollment and provider tables"

---
# CDM Table: LOCATION

This table is built off the Optum **MEMBER_ENROLLMENT** table and **PROVIDER** table.

## **Edits during ETL**

-   Only assign LOCATION_ID for unique locations.


## **Mapping logic**

|**Source code**|**Concept name**|**Concept id**|
|---------------------|----------------|----------------|
|AK|Alaska|42046190
|AL|Alabama|42046189
|AR|Arkansas|42046193
|AZ|Arizona|42046192
|CA|California|42046196
|CO|Colorado|42046197
|CT|Connecticut|42046198
|DC|District of Columbia|42046200
|DE|Delaware|42046199
|FL|Florida|42046218
|GA|Georgia|42046219
|HI|Hawaii|42046226
|IA|Iowa|42046232
|ID|Idaho|42046227
|IL|Illinois|42046228
|IN|Indiana|42046229
|KS|Kansas|42046237
|KY|Kentucky|42046238
|LA|Louisiana|42046239
|MA|Massachusetts|42046242
|MD|Maryland|42046241
|ME|Maine|42046240
|MI|Michigan|42046252
|MN|Minnesota|42046253
|MO|Missouri|42046255
|MS|Mississippi|42046254
|MT|Montana|42046264
|NC|North Carolina|42046271
|ND|North Dakota|42046280
|NE|Nebraska|42046265
|NH|New Hampshire|42046267
|NJ|New Jersey|42046268
|NM|New Mexico|42046269
|NV|Nevada|42046266
|NY|New York|42046270
|OH|Ohio|42046284
|OK|Oklahoma|42046285
|OR|Oregon|42046286
|PA|Pennsylvania|42046289
|PR|Puerto Rico|42046290
|RI|Rhode Island|42046292
|SC|South Carolina|42046293
|SD|South Dakota|42046294
|TN|Tennessee|42046298
|TX|Texas|42046299
|UN|Unknown|0
|UT|Utah|42046303
|VA|Virginia|42046309
|VT|Vermont|42046304
|WA|Washington|42046310
|WI|Wisconsin|42046312
|WV|West Virginia|42046311
|WY|Wyoming|42046313


|**Destination Field**|**Source Field**|**Applied Rule**|**Comment**|
|---------------|-------------|-----------|---------|
|LOCATION_ID|Autogenerate | ||
|ADDRESS_1| | | |
|ADDRESS_2| | | |
|CITY| | | |
|STATE|**MEMBER_ENROLLMENT** STATE<br><br>**PROVIDER** PROV_STATE| ||
|ZIP| | | |
|COUNTY| | | |
|COUNTRY| | | |
|LOCATION_SOURCE_VALUE| | ||
|REGION_CONCEPT_ID||||
|LATITUDE| | | |
|LONGITUDE| | | |
---
*Common Data Model ETL Mapping Specification for Optum Extended SES & Extended DOD*
<br>*CDM Version = 6.0.0, Clinformatics Version = v8.0*