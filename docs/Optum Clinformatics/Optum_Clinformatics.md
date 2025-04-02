---
layout: default
title: Optum Clinformatics
nav_order: 7
description: "Optum Clinformatics ETL Documentation"
has_children: true
permalink: /docs/Optum_Clinformatics
---

# Optum Clinformatics (Optum) ETL Documentation

These materials are meant to serve as documentation and reference for how the Optum Clinformatics database was converted to the [OMOP Common Data Model (CDM)](https://ohdsi.github.io/CommonDataModel/).

## Change Log

### February 14, 2025
- As of the 2025Q1 release, we are no longer imputing DEATH logic for Optum SES as it is likely unrepresentative and incomplete. For prior releases, refer to the imputation logic that was used [here](https://github.com/OHDSI/ETL-LambdaBuilder/blob/v.1.1.0/docs/Optum%20Clinformatics/Optum_death.md).