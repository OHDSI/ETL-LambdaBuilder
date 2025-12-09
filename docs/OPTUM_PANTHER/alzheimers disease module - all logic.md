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

The ALZ Cognitive Assessment table includes results from tests of interest that evaluate cognitive impairment, when present in the physician’s notes for a patient. Tests of interest include only: MMSE, MOCA, Mini-cog, SLUMS, 6CIT and AD8.

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
|measurement_date| note_date|||
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

The ALZ Biomarker table includes biomarkers associated with Alzheimer's disease (AD), when present in the physician’s notes, for a specific patient. Biomarkers of interest include only amyloid beta, phosphorylated tau protein, and apolipoprotein. This table supplements the structured Lab table and can provide additional information regarding patient biomarker testing not found in the structured tables.

#### Mapping measurement_concept_id

biomarker|biomarker_source|measurement_concept_id|Notes
---|---|---|---
amyloid beta 40 peptide |	plasma| 42868556 (Amyloid beta 40 peptide [Mass/volume] in Plasma)
amyloid beta 40 peptide |	cerebrospinal fluid| 42868555 (Amyloid beta 40 peptide [Mass/volume] in CSF)
amyloid beta 40 peptide	||42868556 (Amyloid beta 40 peptide [Mass/volume] in Plasma)
amyloid beta 42 peptide/amyloid beta 40 peptide	|blood| |Mapping available in August 2025 release of vocabulary loinc code =`106941-8`
amyloid beta 42 peptide/amyloid beta 40 peptide	|cerebrospinal fluid| 1617024 (Amyloid beta 42 peptide/Amyloid beta 40 peptide, Spinal fluid)
amyloid beta 42 peptide/amyloid beta 40 peptide	|plasma| |Mapping available in August 2025 release of vocabulary loinc code =`106941-8`
amyloid beta 42 peptide/amyloid beta 40 peptide	|| |Mapping available in August 2025 release of vocabulary loinc code =`106941-8`
amyloid beta-peptides|	blood| 1091801 (Beta-Amyloid 1-42 and 1-40 panel, Spinal fluid)| Mapping to CSF in lieu of other concepts
amyloid beta-peptides|	cerebrospinal fluid| 1091801 (Beta-Amyloid 1-42 and 1-40 panel, Spinal fluid)| Mapping to CSF in lieu of other concepts
amyloid beta-peptides|	plasma| 1091801 (Beta-Amyloid 1-42 and 1-40 panel, Spinal fluid)| Mapping to CSF in lieu of other concepts
amyloid beta-peptides|	|1091801 (Beta-Amyloid 1-42 and 1-40 panel, Spinal fluid)| Mapping to CSF in lieu of other concepts
amyloid beta-protein (1-42)	|blood| 3043102	(Amyloid beta 42 peptide [Mass/volume] in Plasma)
amyloid beta-protein (1-42)	|cerebrospinal fluid| 3042810 (Amyloid beta 42 peptide [Mass/volume] in Cerebral spinal fluid)
amyloid beta-protein (1-42)	|plasma| 3043102	(Amyloid beta 42 peptide [Mass/volume] in Plasma)
amyloid beta-protein (1-42)	|| 3043102	(Amyloid beta 42 peptide [Mass/volume] in Plasma)
amyloid tau index|	cerebrospinal fluid| 3042151 (Tau protein/Amyloid beta 42 peptide [Ratio] in Cerebral spinal fluid)
amyloid tau index|	| 3042151 (Tau protein/Amyloid beta 42 peptide [Ratio] in Cerebral spinal fluid)
apolipoprotein e|	blood| 3044063 (Apolipoprotein E [Presence] in Serum or Plasma)
apolipoprotein e|	cerebrospinal fluid|1617460 (Apolipoprotein E [Mass/volume] in Cerebral spinal fluid)
apolipoprotein e|	plasma| 3044063 (Apolipoprotein E [Presence] in Serum or Plasma)
apolipoprotein e|	| 3044063 (Apolipoprotein E [Presence] in Serum or Plasma)
phosphorylated tau protein|	blood|   3011901	(Tau protein [Mass/volume] in Serum)| Mapping to general tau protein concept in lieu of phosphorylated concept
phosphorylated tau protein|	cerebrospinal fluid| 3000242 (Tau protein [Mass/volume] in Cerebral spinal fluid)| Mapping to general tau protein concept in lieu of phosphorylated concept
phosphorylated tau protein|	plasma| 3011901	(Tau protein [Mass/volume] in Serum)| Mapping to general tau protein concept in lieu of phosphorylated concept
phosphorylated tau protein|	| 3011901	(Tau protein [Mass/volume] in Serum)| Mapping to general tau protein concept in lieu of phosphorylated concept
tau protein, phosphorylated 181|	cerebrospinal fluid| 43055225 (Phosphorylated tau 181 [Mass/volume] in Cerebral spinal fluid by Immunoassay)
tau protein, phosphorylated 181|	| 1259491(Phosphorylated tau 181 [Mass/volume] in Plasma by Immunoassay)
tau protein, phosphorylated 217	|| 1092155 (Tau protein.phosphorylated 217 [Mass/volume] in Serum or Plasma by Immunoassay)
tau protein/amyloid beta 42 peptide|	cerebrospinal fluid| 3042151 (Tau protein/Amyloid beta 42 peptide [Ratio] in Cerebral spinal fluid)
tau proteins|	blood| 3011901	(Tau protein [Mass/volume] in Serum)
tau proteins|	cerebrospinal fluid| 3000242 (Tau protein [Mass/volume] in Cerebral spinal fluid)
tau proteins|	|3011901	(Tau protein [Mass/volume] in Serum)
total tau protein|	blood|3011901	(Tau protein [Mass/volume] in Serum)
total tau protein|	cerebrospinal fluid|  3000242 (Tau protein [Mass/volume] in Cerebral spinal fluid)
total tau protein|	plasma| 3011901	(Tau protein [Mass/volume] in Serum)
total tau protein|	|3011901	(Tau protein [Mass/volume] in Serum)

| Destination Field| SourceField| Logic| Comment|
|-|-|-|-|
| measurement_id||Autogenerate||
| visit_occurrence_id|encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
|person_id|ptid|||
|measurement_type_concept_id||32858 (NLP)|
|measurement_date| note_date|||
|measurement_concept_id|biomarker <br> biomarker_source |See mapping logic above||
|measurement_source_concept_id||Set to 0 |
|measurement_source_value|concat(biomarker,'\|',biomarker_source)|||
|provider_id| encid    |   Use the encid to lookup PROVIDER_ID in the VISIT_DETAIL table.    |  If encid is blank then leave PROVIDER_ID blank.    |
|observation_datetime||||
|value_as_number|numeric_result |||
|value_source_value|numeric_result<br>narrative_result<br>variant|concat(coalesce(numeric_result,narrative_result),'\|', variant)||
|value_as_concept_id|narrative_result| Map value_as_concept_id using the CONCEPT table where lower(narrative_result)=lower(concept_code) and vocabulary_id='SNOMED' and concept_class_id='Qualifier Value' and standard_concept='S'|||
|unit_concept_id|unit| Map the following: <br> %= 8554 (Percent) <br> pg/ml= 8845 (picogram per milliliter) |||
|visit_detail_id||||
|unit_source_value|unit||

### Querying the Biomarker Data

Because of the lack of specificity in the native data and granularity in the mapping of the vocabulary, it is recommended to search the `measurement_source_value` when looking to differentiate between `tau`, `total tau`, `ptau`, `ptau 181` and `ptau217`. 

Example query shown below:

```sql
    select measurement_concept_id,measurement_source_value,c.concept_name,c.concept_code,c.vocabulary_id,count(*)
    from measurement m 
    left join concept c on m.measurement_concept_id =c.concept_id 
    where measurement_type_concept_id =32858
    and measurement_source_value ~ 'tau'
    group by 1,2,3,4,5
    order by 2 asc;
```

# Table name: procedure_occurrence

## Reading from alz_imaging

The ALZ Radiology Report Findings table features provider-documented imaging procedure findings of Alzheimer’s disease (AD) or cognitive impairment progression and treatment efficacy, as noted in radiology reports. These findings are based on brain PET scans, MRI, MRS, CT and SPECT images. The table includes neuroimaging biomarker findings that help confirm AD diagnoses and monitor disease progression and treatment effectiveness.

#### Mapping procedure_concept_id

procedure|contrast|procedure_concept_id
---|---|---
computed tomography	|with|1073730 (CT with contrast)
computed tomography|	with and without| 4300757 (Computed Tomography)
computed tomography	|without| 4163903 (CT without contrast)
computed tomography|	|4300757 (Computed Tomography)
magnetic resonance imaging|	with| 4198856 (MRI with contrast)
magnetic resonance imaging|	with and without| 4013636 (magnetic resonance imaging)
magnetic resonance imaging|	without| 4231864 (MRI without contrast)
magnetic resonance imaging|	|4013636 (magnetic resonance imaging)
magnetic resonance spectroscopy|	with| 4082847 (magnetic resonance spectroscopy)
magnetic resonance spectroscopy|	with and without| 4082847 (magnetic resonance spectroscopy)
magnetic resonance spectroscopy|	without| 4082847 (magnetic resonance spectroscopy)
magnetic resonance spectroscopy|	| 4082847 (magnetic resonance spectroscopy)
positron emission tomography|	with| 4305790 (positron emission tomography)
positron emission tomography|	without| 4305790 (positron emission tomography)
positron emission tomography|	| 4305790 (positron emission tomography)
single-photon emission computed tomography|	with| 4019823 (single photon emission computed tomography)
single-photon emission computed tomography|| 4019823 (single photon emission computed tomography)

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
|procedure_date | procedure_date <br> encounter_date | coalesce(procedure_date,note_date) | |
|procedure_datetime | procedure_date <br> encounter_date | coalesce(procedure_date,note_date) | |
|modifier_concept_id | | | |
|quantity | | | |
|visit_detail_id | | | |
|modifier_source_value | | | |

# Table name: note, note_nlp

## Reading from alz_problem

The ALZ Symptoms and Problems table records patient cognitive impairment, health incidents, complaints, ailments and progression when present in the physician’s notes. Examples may include cognitive, behavioral, emotional, psychiatric and physical symptoms and problems. Additionally, this table includes records of provider documented Alzheimer’s or MCI diagnoses recorded in the provider note. This information offers an overview of a patient’s health over time

### NOTE

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
note_id	 |    autogenerate      |          |          |
|     person_id    |     ptid    |          |          |
|     nlp_date    |     text_date <br> note_date    | coalesce(text_date,encounter_date)         |          |
|     Nlp_datetime    | text_date <br> note_date    | coalesce(text_date,encounter_date) Set time to midnight        |         |
note_type_concept_id	|32858 (NLP)|||
note_class_concept_id|||
note_title	|section|||
note_text	|problem| concat("problem:",problem)||
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
|     nlp_date    |     text_date <br> note_date    | coalesce(text_date,encounter_date)         |          |
|     Nlp_datetime    | text_date <br> note_date    | coalesce(text_date,encounter_date) Set time to midnight        |         |
|     section_concept_id    |  0   |    |          |
|     lexical_variant    |  problem|||
term_exists|qualifier|||
term_temporal|temporality||
term_modifiers|severity <br> chronicity <br> stage <br> change| Concatenate a string with the applicable modifiers <br> "Severity=`severity`\| Chronicity=`chronicity`\| Stage=`stage`\| Change=`change`" ||


## Reading from alz_imaging

### NOTE

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
note_id	 |    autogenerate      |          |          |
|     person_id    |     ptid    |          |          |
|     nlp_date    |     procedure_date <br> note_date    | coalesce(text_date,encounter_date)         |          |
|     Nlp_datetime    | procedure_date <br> note_date    | coalesce(text_date,encounter_date) Set time to midnight        |         |
note_type_concept_id	|32858 (NLP)|||
note_class_concept_id|||
note_title	||||
note_text	|findings|concat("imaging:",findings)||
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |     encid    |     Use the encid to lookup the PROVIDER_ID from the associated VISIT_DETAIL record   |  If encid is blank then leave PROVIDER_ID blank    |
| visit_occurrence_id|encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
note_source_value|findings <br> reasons | concat(findings,'\|',reasons')||
note_event_id||Link to associated procedure_occurrence id from record that was created

# Table name: drug_exposure

## Reading from alz_medication

The ALZ Medications table records Alzheimer’s disease (AD) and cognitive impairment drugs that have been documented in the unstructured physician notes. Medications of interest include donepezil (brand and generic), mematine (brand and generic), Rexulti®, Exelon® and others. This table supplements the structured medication data, such as written prescriptions, administered medications and procedures and can provide additional information regarding the actions and responses associated with medications not found in the structured tables.

drug| drug_concept_id| Notes
---|---|---
aducanumab| 1537087 (aducanumab)
aduhelm| 1537087 (aducanumab)| Aduhelm is the brand name of aducanumab
aricept| 715997 (donepezil)|Aricept is the brand name of donepezil
brexpiprazole| 46275300 (brexpiprazole)
donanemab| 1734796 (donanemab)
donepezil| 715997 (donepezil)
donepezil / memantine|715997 (donepezil)
donepezil / memantine|701322 (memantine)
exelon|733523 (risvastigmine)| Exelon is the brand name of risvastigmine
galantamine| 757627 (galantamine)
gantenerumab| 36851650 (gantenerumab)
kisunla| 1734796 (donanemab)| Kisunla is the brand name of donanemab
lecanemab| 1301377 (lecanemab)
leqembi| 1301377 (lecanemab)| Leqembia is the brand name of lecanemab
memantine|701322 (memantine)
namenda|701322 (memantine)| Namenda is the brand name of memantine
namzaric|715997 (donepezil)| Namzaric is the brand name of donepezil / memantine
namzaric|701322 (memantine)| Namzaric is the brand name of donepezil / memantine
razadyne|757627 (galantamine)| Razadyne is the brand of galantamine
rexulti|46275300 (brexpiprazole)| Rexulti is the brand of brexpiprazole
risvastigmine| 733523 (risvastigmine)

| Destination Field | Source field | Logic | Comment field |
| --- | --- | --- | --- |
| drug_exposure_id | id |  |  |
| person_id | ptid |  |  |
| drug_concept_id | drug | See mapping above  |  |
| drug_exposure_start_date | encounter_date |  |  |
| drug_exposure_start_datetime | encounter_date |  |  |
| drug_exposure_end_date | encounter_date | |  |
| drug_exposure_end_datetime | encounter_date |||
| verbatim_end_date | | | |
| drug_type_concept_id |32858 (NLP)|||
| refills | |  |  |
| quantity | |  |  |  |
| days_supply |  |  |  |
| sig |  |  |  |
| route_concept_id |  |  |  |
|     Provider_id    |     encid    |     Use the encid to lookup the PROVIDER_ID from the associated VISIT_DETAIL record   |  If encid is blank then leave PROVIDER_ID blank    |
| visit_occurrence_id|encid | Lookup the VISIT_OCCURRENCE_ID based on the encid |If encid is blank then use diag_date to determine which VISIT_OCCURRENCE_ID the diagnosis should be associated to|
| visit_detail_id |  |  |  |
| drug_source_value | drug |  |  |
| drug_source_concept_id | 0 |  |  |
| route_source_value | |  |  |