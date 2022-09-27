---
title: "Patient Loss"
author: "Andryc, A; Fortin, S"
parent: Appendix
grand_parent: Premier
layout: default
nav_order: 98
---

# Appendix:  Breakdown of Patient Loss

In converting to the OMOP Common Data Model (CDM), certain persons / patients are removed from the database for various reasons.  Below is a breakdown of those reasons.

## Table Build:  Person
 - Some patients (MEDREC_KEY) have some visits (PAT_KEY) where AGE is recorded as 999. This is problematic where AGE=999 at a patient's first visit since year of birth is calculated as year of fist visit (date_part(year, min(VISIT_START_DATE))) minus AGE.  The ETL calculates year of birth as year of first visit minus age where age does not equal 999. If all patient age records are 999, then we drop that patient and they do not move to the CDM.
 - Delete any patients that have invalid birth years < 1900 or > the current year. 
 - After birth year has been determined delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH.
 - If a person has YEAR_OF_BIRTH that varies over two years then that person is dropped.
 - If a person has multiple genders recorded or unknown gender then those records are dropped.
 - After birth year has been determined delete any individual that has an OBSERVATION_PERIOD that is >= 2 years prior to the YEAR_OF_BIRTH.