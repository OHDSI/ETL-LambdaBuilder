---
layout: default
title: CPRD
nav_order: 2
description: "Clinical Practice Research Datalink (CPRD) ETL Documentation"
has_children: true
permalink: /docs/CPRD
---

# Clinical Practice Research Datalink (CPRD) ETL Documentation

These materials are meant to serve as documentation and reference for how the [CPRD GOLD](https://cprd.com/home) database was converted to the [OMOP Common Data Model (CDM)](https://ohdsi.github.io/CommonDataModel/). This was a collaborative effort between the Observational Health Data Analytics team at Janssen Research & Development and the University of Oxford Nuffield Department of Orthopaedics, Rheumatology, and Musculoskeletal Sciences (NDORMS).

The Clinical Practice Research Datalink (CPRD) is a database of anonymised medical records from participating general practitioner (GP) practices throughout England, Scotland, Wales, and Northern Ireland (UK). In the UK, 98% of the population is registered with a GP who is the gatekeeper of care in the National Health Service (NHS). The GP is primarily responsible for non-emergency care and referral to secondary care as needed. Participating GPs provide their electronic health record data to CPRD on a monthly basis, which includes all patients registered with the practice unless the patient has specifically requested to opt out of data sharing<sup id="cprd1">[1](#f1)</sup>.

**Specifically, CPRD includes GP data relating to:**

* Demographics
* Diagnoses
* Symptoms
* Signs
* Prescriptions
* Referrals
* Immunisations
* Behavioural factors
* Diagnostic Tests

Entries to a patient record are considered consultations, though not all involve a face-to-face encounter with a provider. For example, reminder phone calls will be recorded as a consultation in the Consultation table. Within a consultation multiple events can be recorded in the corresponding event tables (Figure 1).

![](images/CPRDnative.png)
**Figure 1**

Entries to a patient record are considered consultations, though not all involve a face-to-face encounter with a provider. For example, reminder phone calls will be recorded as a consultation in the Consultation table. Within a consultation multiple events can be recorded in the corresponding event tables.

The image below (Figure 2) show a high-level diagram of how the native tables in the CPRD database were mapped to the OMOP CDM. The main CPRD event tables (Clinical, Immunisation, Referral, Test, Therapy, and Consultation) are mapped to what is known as the STEM table. The STEM table is a staging area where source codes like Read codes will first be mapped to concept_ids. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to.  

![](images/image1.png) 
**Figure 2**

<b id="f1">1</b> Herrett, E., Gallagher, A. M., Bhaskaran, K., Forbes, H., Mathur, R., van Staa, T., & Smeeth, L. (2015). Data Resource Profile: Clinical Practice Research Datalink (CPRD). International journal of epidemiology, 44(3), 827–836. doi:10.1093/ije/dyv098 [↩](#cprd1)
