---
layout: default
title: IBM MDCD
nav_order: 5
description: "IBM MarketScan® Medicaid Database (MDCD) ETL to OMOP CDM"
has_children: true
permalink: /docs/IBM_MDCD
---

## IBM MULTI-STATE MEDICAID DATABASE OVERVIEW

The MarketScan Multi-State Medicaid Database reflects the healthcare service use of individuals covered by Medicaid programs in numerous geographically dispersed states. The database contains the pooled healthcare experience of Medicaid enrollees, covered under fee-for-service and managed care plans. It includes records of inpatient services, inpatient admissions, outpatient services, and prescription drug claims, as well as information on long-term care. Data on eligibility and service and provider type are also included. In addition to standard demographic variables such as age and gender, the database includes variables of particular value to researchers investigating Medicaid populations, such as federal aid category (income based, disability, Temporary Assistance for Needy Families) and race.

<br>

 | Database | Content | Covered Lives |
 | --- | --- | --- | 
| Multi-State Medicaid Database (MDCD) |  Health care coverage eligibility and service use of individuals enrolled in state Medicaid programs for several states and/or Medicaid managed care programs | Medicaid recipients for several states| 


<br>

### The IBM® MarketScan® Multi-State Medicaid Database Tables include:

* Medical/Surgical
    * Inpatient Admissions (I)
    * Facility Header (F)
    * Inpatient Services (S) 
    * Outpatient Services (O)
    * Long-Term Care (L)
* Prescription Drug (D)
* Enrollment (A,T)

### The IBM® MarketScan® Multi-State Medicaid Database
IBM MarketScan® Multi-State Medicaid Database (MDCD) adjudicated US health insurance claims for Medicaid enrollees from multiple states and includes hospital discharge diagnoses, outpatient diagnoses and procedures, and outpatient pharmacy claims as well as ethnicity and Medicare eligibility.  Members maintain their same identifier even if they leave the system for a brief period however the dataset lacks lab result data.  

The major data elements contained within this database are outpatient pharmacy dispensing claims (coded with National Drug Codes (NDC), inpatient and outpatient medical claims which provide procedure codes (coded in CPT-4, HCPCs, ICD-9-CM or ICD-10-PCS) and diagnosis codes (coded in ICD-9-CM or ICD-10-CM).  The data does not contain laboratory results.  
<br>



