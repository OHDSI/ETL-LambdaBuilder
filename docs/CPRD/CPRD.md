---
layout: default
title: CPRD
nav_order: 2
description: "Clinical Practice Research Datalink (CPRD) ETL Documentation"
has_children: true
permalink: /docs/CPRD
---

# CPRD ETL

The image below show a high-level diagram of how the native tables in the CPRD database were mapped to the OMOP CDM. The main CPRD event tables (Clinical, Immunisation, Referral, Test, Therapy, and Consultation) are mapped to what is known as the STEM table. The STEM table is a staging area where source codes like Read codes will first be mapped to concept_ids. After a record is mapped and staged, the domain of the concept_id dictates which OMOP table (Condition_occurrence, Drug_exposure, Procedure_occurrence, Measurement, Observation, Device_exposure) the record will move to.  

![](images/image1.png) 