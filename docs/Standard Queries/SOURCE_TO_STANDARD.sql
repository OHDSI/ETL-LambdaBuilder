WITH CTE_VOCAB_MAP AS (
SELECT c.concept_code AS SOURCE_CODE, c.concept_id AS SOURCE_CONCEPT_ID, c.concept_name AS SOURCE_CODE_DESCRIPTION, c.vocabulary_id AS SOURCE_VOCABULARY_ID, 
                           c.domain_id AS SOURCE_DOMAIN_ID, c.CONCEPT_CLASS_ID AS SOURCE_CONCEPT_CLASS_ID, 
                                                   c.VALID_START_DATE AS SOURCE_VALID_START_DATE, c.VALID_END_DATE AS SOURCE_VALID_END_DATE, c.INVALID_REASON AS SOURCE_INVALID_REASON, 
                           c1.concept_id AS TARGET_CONCEPT_ID, c1.concept_name AS TARGET_CONCEPT_NAME, c1.VOCABULARY_ID AS TARGET_VOCABULARY_ID, c1.domain_id AS TARGET_DOMAIN_ID, c1.concept_class_id AS TARGET_CONCEPT_CLASS_ID, 
                           c1.INVALID_REASON AS TARGET_INVALID_REASON, c1.standard_concept AS TARGET_STANDARD_CONCEPT, CR2.CONCEPT_ID_2 AS TARGET_VALUE_AS_CONCEPT_ID
       FROM {sc}.CONCEPT C
              JOIN {sc}.CONCEPT_RELATIONSHIP CR
                        ON C.CONCEPT_ID = CR.CONCEPT_ID_1
                        AND (CR.invalid_reason IS NULL or CR.invalid_reason = '')
                        AND lower(cr.relationship_id) = 'maps to'
              LEFT JOIN {sc}.CONCEPT_RELATIONSHIP CR2 
						ON C.CONCEPT_ID = CR2.CONCEPT_ID_1
                        AND CR2.invalid_reason IS NULL
                        AND lower(cr2.relationship_id) = 'maps to value'
              JOIN {sc}.CONCEPT C1
                        ON CR.CONCEPT_ID_2 = C1.CONCEPT_ID
                        AND (C1.INVALID_REASON IS NULL or C1.INVALID_REASON = '')
       UNION
       SELECT source_code, SOURCE_CONCEPT_ID, SOURCE_CODE_DESCRIPTION, source_vocabulary_id, c1.domain_id AS SOURCE_DOMAIN_ID, c2.CONCEPT_CLASS_ID AS SOURCE_CONCEPT_CLASS_ID,
                                        c1.VALID_START_DATE AS SOURCE_VALID_START_DATE, c1.VALID_END_DATE AS SOURCE_VALID_END_DATE, 
                     stcm.INVALID_REASON AS SOURCE_INVALID_REASON,target_concept_id, c2.CONCEPT_NAME AS TARGET_CONCEPT_NAME, target_vocabulary_id, c2.domain_id AS TARGET_DOMAIN_ID, c2.concept_class_id AS TARGET_CONCEPT_CLASS_ID, 
                     c2.INVALID_REASON AS TARGET_INVALID_REASON, c2.standard_concept AS TARGET_STANDARD_CONCEPT, NULL AS TARGET_VALUE_AS_CONCEPT_ID
       FROM {sc}.source_to_concept_map stcm
              LEFT OUTER JOIN {sc}.CONCEPT c1
                     ON c1.concept_id = stcm.source_concept_id
              LEFT OUTER JOIN {sc}.CONCEPT c2
                     ON c2.CONCEPT_ID = stcm.target_concept_id
       WHERE (stcm.INVALID_REASON IS NULL or stcm.INVALID_REASON = '')
)
SELECT *
FROM CTE_VOCAB_MAP
/*EXAMPLE FILTERS*/
WHERE SOURCE_VOCABULARY_ID IN ('NDC')
AND TARGET_VOCABULARY_ID IN ('RxNorm','RxNorm Extension') 
AND SOURCE_CODE = '50242005306' --NDC = 50 ML rituximab 10 MG/ML Injection [Rituxan]
