{base},
Standard as (
SELECT distinct SOURCE_CODE, TARGET_CONCEPT_ID, TARGET_DOMAIN_ID, SOURCE_VALID_START_DATE as VALID_START_DATE, SOURCE_VALID_END_DATE as VALID_END_DATE, SOURCE_VOCABULARY_ID, TARGET_VALUE_AS_CONCEPT_ID
FROM Source_to_Standard
WHERE lower(SOURCE_VOCABULARY_ID) IN ('jnj_pmr_drug_chrg_cd', 'premier_covid_vax')
AND lower(TARGET_DOMAIN_ID) = 'drug'
)

select distinct Standard.SOURCE_CODE, Standard.TARGET_CONCEPT_ID, Standard.TARGET_DOMAIN_ID, Standard.VALID_START_DATE, Standard.VALID_END_DATE, Standard.SOURCE_VOCABULARY_ID, NULL as SOURCE_TARGET_CONCEPT_ID, NULL as SOURCE_VALID_START_DATE, NULL AS SOURCE_VALID_END_DATE, ingredient_level.ingredient_concept_id, Standard.TARGET_VALUE_AS_CONCEPT_ID
from Standard
left join ingredient_level on ingredient_level.concept_id = Standard.TARGET_CONCEPT_ID