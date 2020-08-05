---
layout: default
title: Optum EHR to Note_NLP
nav_order: 8
parent: Optum EHR
has_children: false
description: "Note NLP table description"
---

# CDM Table name: Note_NLP

This section describes how the multiple NLP tables in Optum EHR should be mapped to the NOTE_NLP table in the CDM.

## Reading from OPTUM_EHR.NLP_BIOMARKERS

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     Note_id    |    autogenerate      |          |          |
|     person_id    |     ptid    |          |          |
|     note_date    |     note_date    |          |          |
|     Note_datetime    |   note_date       |  Set time to midnight        |          |
|     Note_type_concept_id    |     44814642    |     Pathology report    |          |
|     Note_class_concept_id    |     44817649    |     Plan of care and summary note    |          |
|     Note_title    |     ‘NLP_BIOMARKERS’    |      Store the name of the table of origin    |          |
|     Note_text    |     biomarker_status     variation_detail     biomarker    |     Format as a single string by   concatenating as a set of name value pairs. The resulting text should look   like:     Concatenate biomarker:<biomarker>; variation_detail :<variation_detail>;   biomarker_status:<biomarker_status>     This may require truncation of   the string on MPP platforms since the resulting string could be quite long.    |          |
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |     encid    |   Use the encid to lookup PROVIDER_ID in the VISIT_DETAIL table.    |  If encid is blank then leave PROVIDER_ID blank.    |
|     Note_source_value    |     NULL     |          |          |
|     Visit_occurrence_id    |     encid    |   If encid is blank then leave VISIT_OCCURRENCE_ID blank|          |

## Reading from OPTUM_EHR.NLP_CUSTOM

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     Note_id    |          |      Auto-increment    |          |
|     person_id    |     ptid    |          |          |
|     note_date    |     note_date    |          |          |
|     Note_datetime    |    note_date      |   Set time to midnight   |          |
|     Note_type_concept_id    |     44814642    |     Note – note type concept    |          |
|     Note_class_concept_id    |     44817649    |     Plan of care and summary note    |          |
|     Note_title    |     ‘NLP_CUSTOM’    |      Store the name of the table of origin    |          |
|     Note_text    |     Nlp_term     Nlp_term_attribute_1     Nlp_term_attribute_2     Nlp_term_qualifier    |     Format as a single string by   concatenating as a set of name value pairs. The resulting text should look   like:     Concatenate term:<nlp_term>; term_attribute_1:<nlp_term_attribute_1>;term_attribute_2:<nlp_term_attribute_2>;nlp_term_qualifier:<nlp_term_qualifier>     This may require truncation of   the string on MPP platforms since the resulting string could be quite long.    |          |
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |     encid    |     Look up the PROVIDER_ID by linking the encid to a VISIT_DETAIL_ID and taking the PROVIDER_ID from the VISIT_DETAIL record.    |     If encid is blank then leave PROVIDER_ID blank    |
|     Note_source_value    |     Note_section    |          |          |
|     Visit_occurrence_id    |     encid    |    Use the encid to lookup the VISIT_OCCURRENCE_ID   |    If encid is blank then leave VISIT_OCCURRENCE_ID blank.     |

## Reading from OPTUM_EHR.NLP_DRUG_RATIONALE

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     Note_id    |          |          |          |
|     person_id    |     ptid    |          |          |
|     note_date    |     note_date    |          |          |
|     Note_datetime    |    note_date      |   Set time as midnight   |          |
|     Note_type_concept_id    |     44814645    |     Note – note type concept    |          |
|     Note_class_concept_id    |     44817649    |     Plan of care and summary note    |          |
|     Note_title    |     ‘NLP_DRUG_RATIONALE’    |      Store the name of the table of origin    |          |
|     Note_text    |     Drug_name     drug_action     drug_action_preposition     reason_general     sentiment     sentiment_who    |     Format as a single string by   concatenating as a set of name value pairs. The resulting text should look   like:           drug_name:<drug_name>;drug_Action:   <drug_action>; drug_action_preposition:<drug_action_preposition>;   reason_general:< reason_general>;sentiment:<sentiment>; sentiment_who:<sentiment_who>              This may require truncation of   the string on MPP platforms since the resulting string could be quite long.    |          |
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |     encid    |     Use the encid to lookup the PROVIDER_ID from the associated VISIT_DETAIL record   |  If encid is blank then leave PROVIDER_ID blank    |
|     Note_source_value    |     Note_section     |          |          |
|     Visit_occurrence_id    |     encid    |       Use encid to lookup the VISIT_OCCURRENCE_ID   |   If encid is blank then leave VISIT_OCCURRENCE_ID blank      |

## Reading from OPTUM_EHR.NLP_MEASUREMENT

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     Note_id    |          |          |          |
|     person_id    |     ptid    |          |          |
|     note_date    |     note_date    |          |          |
|     Note_datetime    |    note_date   |   Set time as midnight    |          |
|     Note_type_concept_id    |     44814645    |     Note – note type concept    |          |
|     Note_class_concept_id    |     44817649    |     Plan of care and summary note    |          |
|     Note_title    |     ‘NLP_MEASUREMENT’    |      Store the name of the table of origin    |          |
|     Note_text    |     measurement_type,     measurement_value,     measurement_detail,     measurement_year,     measurement_monthyear,     measurement_date    |     Format as a single string by   concatenating as a set of name value pairs. The resulting text should look   like:           type:<measurement_type>;value:   <measurement_value>; detail:<measurement_detail>; year:<measurement_year>;monthyear:<monthyear>;   date:<measurement_date>            This may require truncation of   the string on MPP platforms since the resulting string could be quite long.    |          |
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |     encid    |     Use the encid to lookup the PROVIDER_ID from the associated VISIT_DETAIL record   |  If encid is blank then leave PROVIDER_ID blank      |
|     Note_source_value    |     Note_section     |          |          |
|     Visit_occurrence_id    |     encid    |       Use encid to lookup the VISIT_OCCURRENCE_ID   |   If encid is blank then leave VISIT_OCCURRENCE_ID blank    |          |

## Reading from OPTUM_EHR.NLP_SDS

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     Note_id    |          |          |          |
|     person_id    |     ptid    |          |          |
|     note_date    |     note_date    |          |          |
|     Note_datetime    |     note_date     |   Set time to midnight   |          |
|     Note_type_concept_id    |     44814645    |     Note – note type concept    |          |
|     Note_class_concept_id    |     44817649    |     Plan of care and summary note    |          |
|     Note_title    |     ‘NLP_SDS’    |      Store the name of the table of origin    |          |
|     Note_text    |     sds_term sds_location     sds_attribute     sds_sentiment    |     Format as a single string by   concatenating as a set of name value pairs. The resulting text should look   like:           term:<sds_term>;location:   <sds_location>; attribute:<sds_attribute>;   sentiment:<sds_sentiment>            This may require truncation of   the string on MPP platforms since the resulting string could be quite long.    |          |
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |    encid    |     Use the encid to lookup the PROVIDER_ID from the associated VISIT_DETAIL record   |  If encid is blank then leave PROVIDER_ID blank      |
|     Note_source_value    |     Note_section     |          |          |
|     Visit_occurrence_id    |    encid    |       Use encid to lookup the VISIT_OCCURRENCE_ID   |   If encid is blank then leave VISIT_OCCURRENCE_ID blank   |          |

## Reading from OPTUM_EHR.NLP_SDS_FAMILY

|     Destination   Field    |     Source   Field    |     Logic    |     Comment    |
|-|-|-|-|
|     Note_id    |          |          |          |
|     person_id    |     ptid    |          |          |
|     note_date    |     note_date    |          |          |
|     Note_datetime    |   note_date       |   Set time to midnight  |          |
|     Note_type_concept_id    |     44814645    |     Note – note type concept    |          |
|     Note_class_concept_id    |     44817649    |     Plan of care and summary note    |          |
|     Note_title    |     ‘NLP_SDS_FAMILY’    |      Store the name of the table of origin    |          |
|     Note_text    |     sds_term     sds_location sds_family_member     sds_sentiment    |     Format as a single string by   concatenating as a set of name value pairs. The resulting text should look   like:           term:<sds_term>;location:   <sds_location>; family_member:<sds_family_member>;   sentiment:<sds_sentiment>            This may require truncation of   the string on MPP platforms since the resulting string could be quite long.    |          |
|     Encoding_concept_id    |     0    |          |          |
|     Language_concept_id    |     40639387    |     US English    |          |
|     Provider_id    |     encid    |     Use the encid to lookup the PROVIDER_ID from the associated VISIT_DETAIL record   |  If encid is blank then leave PROVIDER_ID blank     |
|     Note_source_value    |     Note_section     |          |          |
|     Visit_occurrence_id    |     encid    |       Use encid to lookup the VISIT_OCCURRENCE_ID   |   If encid is blank then leave VISIT_OCCURRENCE_ID blank   |          |