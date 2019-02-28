{base},
Standard as (
SELECT distinct ROW_NUMBER() OVER(partition by SOURCE_CODE ORDER BY SOURCE_VOCABULARY_ID ASC) AS row_num, SOURCE_CODE, TARGET_CONCEPT_ID, TARGET_DOMAIN_ID, SOURCE_VALID_START_DATE as VALID_START_DATE, SOURCE_VALID_END_DATE as VALID_END_DATE, SOURCE_VOCABULARY_ID
FROM Source_to_Standard
WHERE lower(SOURCE_VOCABULARY_ID) in ('gemscript', 'jnj_cprd_gs_rxn') AND (lower(TARGET_VOCABULARY_ID)='multilex' OR lower(TARGET_VOCABULARY_ID)='rxnorm') 
AND lower(TARGET_DOMAIN_ID)='drug' AND (TARGET_INVALID_REASON is NULL or TARGET_INVALID_REASON = '')
), Source as (
SELECT distinct ROW_NUMBER() OVER(partition by SOURCE_CODE ORDER BY SOURCE_VOCABULARY_ID ASC) AS row_num, SOURCE_CODE, TARGET_CONCEPT_ID, SOURCE_VALID_START_DATE, SOURCE_VALID_END_DATE
FROM Source_to_Source
WHERE lower(SOURCE_VOCABULARY_ID) in ('gemscript', 'jnj_cprd_gs_rxn') AND (lower(TARGET_VOCABULARY_ID)='multilex' OR lower(TARGET_VOCABULARY_ID)='rxnorm' OR lower(TARGET_VOCABULARY_ID)='gemscript') 
AND lower(TARGET_DOMAIN_ID)='drug' AND (TARGET_INVALID_REASON is NULL or TARGET_INVALID_REASON = '')
), S_S as
(
select SOURCE_CODE 
from Standard
union 
select SOURCE_CODE 
from Source
)

select distinct S_S.SOURCE_CODE, Standard.TARGET_CONCEPT_ID, Standard.TARGET_DOMAIN_ID, Standard.VALID_START_DATE, Standard.VALID_END_DATE, Standard.SOURCE_VOCABULARY_ID, Source.TARGET_CONCEPT_ID as SOURCE_TARGET_CONCEPT_ID, Source.SOURCE_VALID_START_DATE as SOURCE_VALID_START_DATE, Source.SOURCE_VALID_END_DATE, ingredient_level.ingredient_concept_id
from S_S
left join Standard on Standard.SOURCE_CODE = S_S.SOURCE_CODE and Standard.row_num = 1
left join Source on Source.SOURCE_CODE = S_S.SOURCE_CODE  and Source.row_num = 1
left join ingredient_level on ingredient_level.concept_id = Standard.TARGET_CONCEPT_ID