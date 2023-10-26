---
title: "Drug Era"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 8
layout: default
---

# Table Name: Drug Era

A Drug Era is defined as a span of time when the Person is assumed to be exposed to a drug. Successive periods of Drug Exposures are combined under certain rules to produce continuous Drug Eras.  The DRUG_ERA table is populated by pulling from the DRUG_EXPOSURE table within the CDM.  Drug eras are consolidated to their respective ingredient off the DRUG_EXPOSURE table.  A drug era is therefore understood as exposure to a certain compound over a certain period.  There will only be one type of persistence window (duration that can elapse between drug exposures) applied to this CDM, which is 30 days.  

Drugs that are mapped to a DRUG_CONCEPT_ID=0 should not be mapped. The logic below is used to map DRUG_CONCEPT_ID’s to ingredients.  

```r
Select distinct A.concept_id as concept_id,
				C.concept_id as ingredient_concept_id
FROM CONCEPT C
JOIN CONCEPT_ANCESTOR CA
	ON CA.ancestor_concept_id = C.concept_id
	and lower(c.standard_concept) = 's'
	and lower(c.concept_class_id) = 'ingredient'
	and (invalid_reason is null or invalid_reason = '')
JOIN CONCEPT A
	ON CA.descendant_CONCEPT_ID = A.CONCEPT_ID
```

Do not include records that cannot be mapped to the ingredient level. The DRUG_EXPOSURE_END_DATE is the DRUG_EXPOSURE_START_DATE.  

The field mapping is as follows:

|||||
|--- |--- |--- |--- |
|Destination Field|Source Field|Applied Rule|Comment|
|DRUG_ERA_ID||System generated||
|PERSON_ID|PERSON_ID|||
|DRUG_CONCEPT_ID|DRUG_CONCEPT_ID|Do no create DRUG_ERAs where the DRUG_EXPOSURE.DRUG_CONCEPT_ID is 0. Use the map above to map DRUG_EXPOSURE.DRUG_CONCEPT_ID to the ingredient level DRUG_CONCEPT_ID used in the DRUG_ERA.||
|DRUG_ERA_START_DATE|DRUG_EXPOSURE_START_DATE||The start date for the drug era constructed from the individual instances of drug exposures. It is the start date of the very first chronologically recorded instance of utilization of a drug.|
|DRUG_ERA_END_DATE|DRUG_EXPOSURE.START_DATE|||
|DRUG_EXPOSURE_COUNT|-|Sum up the number of DRUG_EXPOSURES for this PERSON_ID and this CONCEPT_ID during the exposure window being built.||
