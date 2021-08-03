---
title: "Premier"
has_children: yes
layout: default
permalink: /docs/PREMIER
description: Premier
---

# Premier Hospitalization Database (PHD) ETL Documentation
This ETL documentation is in the process of being updated. Here is the [link](https://github.com/OHDSI/ETL-CDMBuilder/blob/master/man/PREMIER/Premier_ETL_CDM_V5_3.doc) to the current document. 

This document reflects the requirements, assumptions, business rules, and transformations for the implementation of the Common Data Model Version 5.0 (CDM) as implemented by Alan A. Andryc and Stephen Fortin, Observational Health Data Analytics, Janssen Epidemiology, Research and Development.

The purpose of this document is to describe the ETL mapping of the licensed data from Premier Hospitalization Database (PHD) into the Observational Medical Outcomes Partnership (OMOP) Common Data Model (CDM). 

Premier Healthcare Database (PHD) is a nationally representative all-payer US hospital database that houses data on the inpatient and outpatient visits from non-profit, non-governmental and community and teaching hospitals and health systems. The data represent 1 in 5 inpatient hospital stays in the US.  It is a visit-centric, billing database where each visit is linked with a unique billing record. The database contains information on medications, laboratory and diagnostic procedures, and diagnoses with day of service for medications and procedures.

# Source Data Mapping

![](/PREMIER/images/source_data_mapping.png)

The VISIT_OCCURRENCE table must be generated first because procedure occurrence, device exposure, condition occurrence, and drug exposure dates are subsequently generated using visit start date. The start and end date of each visit are derived from the maximum number of service days recorded during a visit and leveraging the days from prior to ensure temporality. The service days for each visit are in the PATBILL table where, for each visit, the maximum value in this field is obtained. The days from piror data is in the READMIT table where for each visit we can calculate how many days it came after a prior visit.  The visit logic anchors on the last day of the month for which the most recent visit occurred.  The logic transformation for these dates are explained in the sections for each respective table.

# Janssen Note:  
In 2020 a separate data set was delivered that was COVID-19 specific.  This data set followed the same structure as the PHD data set previously licensed but included both the GEN_LAB and LAB_RESULTS tables.  Upon expiration of the COVID-19 specific license the GEN_LAB and LAB_RESULTS tables were licensed in addition to the previously licensed full PHD data set.
