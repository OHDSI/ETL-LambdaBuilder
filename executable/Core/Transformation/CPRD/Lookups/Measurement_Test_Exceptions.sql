{base},
Standard as (
SELECT distinct SOURCE_CODE, TARGET_CONCEPT_ID, 'Measurement' as TARGET_DOMAIN_ID, SOURCE_VALID_START_DATE, SOURCE_VALID_END_DATE
FROM Source_to_Standard
WHERE lower(SOURCE_VOCABULARY_ID)='jnj_cprd_t_et_loinc'
)

select distinct Standard.*
from Standard