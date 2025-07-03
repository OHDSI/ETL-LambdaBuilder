{base},
Standard as (
SELECT distinct lower(SOURCE_CODE_DESCRIPTION), TARGET_CONCEPT_ID, TARGET_DOMAIN_ID, SOURCE_VALID_START_DATE as VALID_START_DATE, SOURCE_VALID_END_DATE as VALID_END_DATE
FROM Source_to_Standard
WHERE lower(SOURCE_VOCABULARY_ID) IN ('snomed')
AND lower(TARGET_STANDARD_CONCEPT) = 's'
and lower(TARGET_CONCEPT_CLASS_ID) in ('qualifier value') 
)

select distinct Standard.*
from Standard