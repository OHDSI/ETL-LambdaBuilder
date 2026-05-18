Select distinct A.concept_id as concept_id, C.concept_id as ingredient_concept_id, 'Drug' as Domain, to_date('1900/1/1', 'yyyy/M/d') as VALID_START_DATE, to_date('2100/1/1', 'yyyy/M/d') as VALID_END_DATE
FROM {sc}.CONCEPT C
JOIN {sc}.CONCEPT_ANCESTOR CA
	ON CA.ancestor_concept_id = C.concept_id
	and lower(c.standard_concept) = 's'
	and lower(c.concept_class_id) = 'ingredient'
	and (invalid_reason is null or invalid_reason = '')
JOIN {sc}.CONCEPT A
	ON CA.descendant_CONCEPT_ID = A.CONCEPT_ID