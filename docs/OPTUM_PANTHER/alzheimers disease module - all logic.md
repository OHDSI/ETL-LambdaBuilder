---
layout: default
title: Alzheimer's Disease Enrichment ETL
nav_order: 11
parent: Optum EHR
description: "Alzheimer's Disease Enrichment ETL documentation"

---

# OPTUM EHR Alzheimer's Disease Enrichment ETL documentation


# Background

Optum Alzheimer’s enriched clinical data is a quarterly data offering that includes patients with an AD or
MCI diagnosis, or AD or MCI mention within provider notes, or are 55 years or older and have a symptom of
interest mentioned within provider notes. The provider notes fed into the models are dated from January 1,
2007 to the most recent data available. The model output is then processed into a tabular format that can be
easily joined to the structured data using structured query language (SQL) or other languages.

Optum Alzheimer’s enriched clinical data product is created by using NLP techniques catered specifically
to the Alzheimer’s clinical domain to extract relevant concepts from unstructured provider notes.
The data undergoes transformations allowing it to be usable for research, including value standardization,
de-duplication, normalization, manual abstraction and some clinical validation. The overall goal of this
data set is to provide data that is true to the notes and provides maximum information with high quality
to meet users’ needs for research.

# How to run this conversion

This conversion is run after the main corpus of the data is converted, then the results are inserted in CDM tables.

# Table name: measurement

## Reading from alz_assessment

#### Mapping measurement_concept_id

system_name|measurement_concept_id
---|---
6CIT| 35609721 (6CIT - Six Item Cognitive Impairment Test)
AD8| 36684956 (Eight-item Informant Interview to Differentiate Aging and Dementia screening score)
MMSE| 4169175 (Mini-mental state examination)
MOCA| 44808666 (Montreal cognitive assessment)
MOCA 2.1| 44808666 (Montreal cognitive assessment)
MOCA 7.1| 606673 (Montreal Cognitive Assessment version 7.1)
MOCA 7.2| 606672 (Montreal Cognitive Assessment version 7.2)
MOCA 7.3| 606670 (Montreal Cognitive Assessment version 7.3)
MOCA 8.1| 606671 (Montreal Cognitive Assessment version 8.1)
MOCA 8.1 Blind| 606671 (Montreal Cognitive Assessment version 8.1)
MOCA 8.2| 44808666 (Montreal cognitive assessment)
MOCA 8.3| 44808666 (Montreal cognitive assessment)
MOCA Blind| 44808666 (Montreal cognitive assessment)
Minicog| 37017073 (Mini-Cog)
SLUMS| 605634 (Saint Louis University Mental Status)

| Destination Field| SourceField| Logic| Comment|
|-|-|-|-|
| measurement_id||Autogenerate||
| visit_occurrence_id|encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
|person_id|ptid|||
|measurement_type_concept_id||32858 (NLP)|
|measurement_date| encounterdate|||
|measurement_concept_id|system_name|See mapping logic above||
|measurement_source_concept_id||Set to 0 |
|measurement_source_value|system_name|||
|provider_id| encid    |   Use the encid to lookup PROVIDER_ID in the VISIT_DETAIL table.    |  If encid is blank then leave PROVIDER_ID blank.    |
|observation_datetime||||
|value_as_number|numeric_result|||
|value_source_value| numeric_result|||
|value_as_concept_id|||
|unit_concept_id||||
|visit_detail_id||||
|unit_source_value||||

## Reading from alz_biomarker

#### Mapping measurement_concept_id

biomarker|biomarker_source|measurement_concept_id
---|---|---
amyloid beta 40 peptide |	plasma|
amyloid beta 40 peptide	||
amyloid beta 42 peptide/amyloid beta 40 peptide	|blood|
amyloid beta 42 peptide/amyloid beta 40 peptide	|cerebrospinal fluid|
amyloid beta 42 peptide/amyloid beta 40 peptide	|plasma|
amyloid beta 42 peptide/amyloid beta 40 peptide	||
amyloid beta-peptides|	blood|
amyloid beta-peptides|	cerebrospinal fluid|
amyloid beta-peptides|	plasma|
amyloid beta-peptides|	|
amyloid beta-protein (1-42)	|blood|
amyloid beta-protein (1-42)	|cerebrospinal fluid|
amyloid beta-protein (1-42)	|plasma|
amyloid beta-protein (1-42)	||
amyloid tau index|	cerebrospinal fluid|
amyloid tau index|	|
apolipoprotein e|	blood|
apolipoprotein e|	cerebrospinal fluid|
apolipoprotein e|	plasma|
apolipoprotein e|	|
phosphorylated tau protein|	blood|
phosphorylated tau protein|	cerebrospinal fluid|
phosphorylated tau protein|	plasma|
phosphorylated tau protein|	|
tau protein, phosphorylated 181|	cerebrospinal fluid|
tau protein, phosphorylated 181|	|
tau protein, phosphorylated 217	||
tau protein/amyloid beta 42 peptide|	cerebrospinal fluid|
tau proteins|	blood|
tau proteins|	cerebrospinal fluid|
tau proteins|	|
total tau protein|	blood|
total tau protein|	cerebrospinal fluid|
total tau protein|	plasma|
total tau protein|	|

| Destination Field| SourceField| Logic| Comment|
|-|-|-|-|
| measurement_id||Autogenerate||
| visit_occurrence_id|encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
|person_id|ptid|||
|measurement_type_concept_id||32858 (NLP)|
|measurement_date| encounterdate|||
|measurement_concept_id|biomarker <br> biomarker_source |See mapping logic above||
|measurement_source_concept_id||Set to 0 |
|measurement_source_value|concat(biomarker,'\|',biomarker_source)|||
|provider_id| encid    |   Use the encid to lookup PROVIDER_ID in the VISIT_DETAIL table.    |  If encid is blank then leave PROVIDER_ID blank.    |
|observation_datetime||||
|value_as_number|numeric_result |||
|value_source_value|variant|||
|value_as_concept_id|||
|unit_concept_id|||
|visit_detail_id||||
|unit_source_value|||

# Table name: procedure_occurrence

## Reading from alz_imaging

biomarker|biomarker_source|procedure_concept_id
---|---|---
computed tomography	|with|
computed tomography|	with and without|
computed tomography	|without|
computed tomography|	|
magnetic resonance imaging|	with|
magnetic resonance imaging|	with and without|
magnetic resonance imaging|	without|
magnetic resonance imaging|	|
magnetic resonance spectroscopy|	with|
magnetic resonance spectroscopy|	with and without|
magnetic resonance spectroscopy|	without|
magnetic resonance spectroscopy|	|
positron emission tomography|	with|
positron emission tomography|	without|
positron emission tomography|	|
single-photon emission computed tomography|	with|
single-photon emission computed tomography||	

#### Mapping procedure_concept_id

|Destination Field |SourceField |Logic |Comment |
|-|-|-|-|
|procedure_occurrence_id | | Autogenerate | |
| visit_occurrence_id|encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
|person_id|ptid|||
|procedure_type_concept_id ||32858 (NLP)|
|procedure_concept_id |procedure <br> contrast | See Mapping Logic Above
|procedure_source_concept_id || Set to 0
|procedure_source_value |procedure <br> contrast | concat(procedure,'\|',contrast)
|provider_id | encid    |   Use the encid to lookup PROVIDER_ID in the VISIT_DETAIL table.    |  If encid is blank then leave PROVIDER_ID blank.    |
|procedure_datetime | | | |
|modifier_concept_id | | | |
|quantity | | | |
|visit_detail_id | | | |
|modifier_source_value | | | |

# Table name: note, note_nlp

## Reading from alz_problem

### NOTE

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
note_id	 |    autogenerate      |          |          |
|     person_id    |     ptid    |          |          |
|     nlp_date    |     text_date <br> encounterdate    | coalesce(text_date,encounter_date)         |          |
|     Nlp_datetime    | text_date <br> encounterdate    | coalesce(text_date,encounter_date) Set time to midnight        |         |
note_type_concept_id	||||
note_class_concept_id|||
note_title	|section|||
note_text	|problem|||
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |     encid    |     Use the encid to lookup the PROVIDER_ID from the associated VISIT_DETAIL record   |  If encid is blank then leave PROVIDER_ID blank    |
| visit_occurrence_id|encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
note_source_value|problem <br> section | concat(problem,'\|',section')||

### NOTE_NLP

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     Note_nlp_id    |    autogenerate      |          |          |
|     Note_id    |    autogenerate      |          |          |
|     person_id    |     ptid    |          |          |
|     nlp_date    |     text_date <br> encounterdate    | coalesce(text_date,encounter_date)         |          |
|     Nlp_datetime    | text_date <br> encounterdate    | coalesce(text_date,encounter_date) Set time to midnight        |         |
|     section_concept_id    |    section    |     See mapping logic above    |          |
|     lexical_variant    |  problem|||
term_exists|qualifier|||
term_temporal|temporality||
term_modifiers|qualifier|||