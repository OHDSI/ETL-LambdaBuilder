{base},
Standard as (
select c.concept_code as SOURCE_CODE, c1.concept_id as TARGET_CONCEPT_ID, 'Drug' as TARGET_DOMAIN_ID, NULL as valid_start_date, NULL as valid_end_date, NULL SOURCE_VOCABULARY_ID
from {sc}.concept c
join {sc}.concept_relationship cr on c.concept_id = cr.concept_id_1 and lower(cr.relationship_id)='maps to'
join {sc}.concept c1 on cr.concept_id_2 = c1.concept_id and lower(c1.vocabulary_id) = 'rxnorm'
where lower(c.vocabulary_id)='read'
), Source as (
SELECT distinct SOURCE_CODE, TARGET_CONCEPT_ID, SOURCE_VALID_START_DATE, SOURCE_VALID_END_DATE
FROM Source_to_Source
WHERE lower(SOURCE_VOCABULARY_ID) = 'read' AND lower(TARGET_VOCABULARY_ID) = 'read'
), S_S as
(
select SOURCE_CODE from Standard
union 
select SOURCE_CODE from Source
)

select distinct S_S.SOURCE_CODE, Standard.TARGET_CONCEPT_ID, Standard.TARGET_DOMAIN_ID, Standard.VALID_START_DATE, Standard.VALID_END_DATE, Standard.SOURCE_VOCABULARY_ID, Source.TARGET_CONCEPT_ID as SOURCE_TARGET_CONCEPT_ID, Source.SOURCE_VALID_START_DATE as SOURCE_VALID_START_DATE, Source.SOURCE_VALID_END_DATE, ingredient_level.ingredient_concept_id
from S_S
left join Standard on Standard.SOURCE_CODE = S_S.SOURCE_CODE
left join Source on Source.SOURCE_CODE = S_S.SOURCE_CODE 
left join ingredient_level on ingredient_level.concept_id = Standard.TARGET_CONCEPT_ID

