---
layout: default
title: Care Site
nav_order: 4
parent: IBM CCAE & MDCR
description: "**CARE_SITE** mapping for the IBM MarketScan® Commercial Database (CCAE) & IBM MarketScan® Medicare Supplemental Database (MDCR)"

---

## Table name: **CARE_SITE**

The **CARE_SITE** table contains a list of uniquely identified points of care, or an individual clinical location within an organization. Each CARE_SITE belongs to one ORGANIZATION.

MarketScan does not have clear care site information so this table will only contain one value representing the fact that no care site information will be captured.

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| CARE_SITE_ID | - | System generated | - |
| LOCATION_ID | - | NULL | - |
| ORGANIZATION_ID | - | NULL | - |
| PLACE_OF_SERVICE_CONCEPT_ID | - | 0 | - |
| CARE_SITE_SOURCE_VALUE | - | NULL | - |
| PLACE_OF_SERVICE_SOURCE_VALUE | - | NULL | - |