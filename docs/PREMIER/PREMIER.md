---
layout: default
title: Premier
nav_order: 9
description: "Premier"
has_children: yes
permalink: /docs/PREMIER
---

# Premier Hospitalization Database (PHD) ETL Documentation
This ETL documentation is in the process of being updated. Here is the [link](https://github.com/OHDSI/ETL-CDMBuilder/blob/master/man/PREMIER/Premier_ETL_CDM_V5_3.doc) to the current document. 

This document reflects the requirements, assumptions, business rules, and transformations for the implementation of the Common Data Model Version 5.4 (CDM) as implemented by Alan A. Andryc and Stephen Fortin, Observational Health Data Analytics, Janssen Epidemiology, Research and Development.

The purpose of this document is to describe the ETL mapping of the licensed data from Premier Hospitalization Database (PHD) into the Observational Medical Outcomes Partnership (OMOP) Common Data Model (CDM). 

Premier Healthcare Database (PHD) is a nationally representative all-payer US hospital database that houses data on the inpatient and outpatient visits from non-profit, non-governmental and community and teaching hospitals and health systems. The data represent 1 in 5 inpatient hospital stays in the US.  It is a visit-centric, billing database where each visit is linked with a unique billing record. The database contains information on medications, laboratory and diagnostic procedures, and diagnoses with day of service for medications and procedures.

# Janssen Note:  
In 2020 a separate data set was delivered that was COVID-19 specific.  This data set followed the same structure as the PHD data set previously licensed but included both the GEN_LAB and LAB_RESULTS tables.  Upon expiration of the COVID-19 specific license the GEN_LAB and LAB_RESULTS tables were licensed in addition to the previously licensed full PHD data set.

## Change Log

### February 14, 2025
- As of the 2025Q1 release, we are no longer imputing DEATH logic for this data source as it is likely unrepresentative and incomplete. For prior releases, refer to the imputation logic that was used [here](https://github.com/OHDSI/ETL-LambdaBuilder/blob/v.1.1.0/docs/PREMIER/Premier_Death.md).
