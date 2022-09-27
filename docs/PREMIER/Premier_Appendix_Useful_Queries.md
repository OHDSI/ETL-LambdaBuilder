---
title: "Useful Queries"
author: "Andryc, A; Fortin, S"
parent: Appendix
grand_parent: Premier
nav_order: 99
layout: default
---

# Appendix:  Useful Queries

## Vocabulary - Source to Source
```r
--SOURCE TO SOURCE 
WITH CTE_VOCAB_MAP AS ( 
       SELECT c.concept_code AS SOURCE_CODE, c.concept_id AS SOURCE_CONCEPT_ID, c.vocabulary_id AS SOURCE_VOCABULARY_ID, c.domain_id AS SOURCE_DOMAIN_ID, c.concept_class_id AS SOURCE_CONCEPT_CLASS_ID,  
                     c.invalid_reason AS SOURCE_INVALID_REASON,  
                     c.concept_ID as TARGET_CONCEPT_ID, c.vocabulary_id AS TARGET_VOCABULARY_ID, c.domain_id AS TARGET_DOMAIN_ID, c.concept_class_id AS TARGET_CONCEPT_CLASS_ID, c.INVALID_REASON AS TARGET_INVALID_REASON,  
                     c.STANDARD_CONCEPT AS TARGET_STANDARD_CONCEPT 
       FROM CONCEPT c 
       UNION 
       SELECT source_code, SOURCE_CONCEPT_ID, source_vocabulary_id, c1.domain_id AS SOURCE_DOMAIN_ID, c2.CONCEPT_CLASS_ID AS SOURCE_CONCEPT_CLASS_ID,  
                     stcm.INVALID_REASON AS SOURCE_INVALID_REASON,target_concept_id, target_vocabulary_id, c2.domain_id AS TARGET_DOMAIN_ID, c2.concept_class_id AS TARGET_CONCEPT_CLASS_ID,  
                     c2.INVALID_REASON AS TARGET_INVALID_REASON, c2.standard_concept AS TARGET_STANDARD_CONCEPT 
       FROM source_to_concept_map stcm 
              LEFT OUTER JOIN CONCEPT c1 
                     ON c1.concept_id = stcm.source_concept_id 
              LEFT OUTER JOIN CONCEPT c2 
                     ON c2.CONCEPT_ID = stcm.target_concept_id 
       WHERE stcm.INVALID_REASON IS NULL 
) 
```

## Vocabulary - Source to Standard

```r
--SOURCE TO STANDARD 
WITH CTE_VOCAB_MAP AS ( 
       SELECT c.concept_code AS SOURCE_CODE, c.concept_id AS SOURCE_CONCEPT_ID, c.vocabulary_id AS SOURCE_VOCABULARY_ID,  
                           c.domain_id AS SOURCE_DOMAIN_ID, c.CONCEPT_CLASS_ID AS SOURCE_CONCEPT_CLASS_ID, c.INVALID_REASON AS SOURCE_INVALID_REASON, 
                           c1.concept_id AS TARGET_CONCEPT_ID, c1.VOCABULARY_ID AS TARGET_VOCABUALRY_ID, c1.domain_id AS TARGET_DOMAIN_ID, c1.concept_class_id AS TARGET_CONCEPT_CLASS_ID,  
                           c1.INVALID_REASON AS TARGET_INVALID_REASON, c1.standard_concept AS TARGET_STANDARD_CONCEPT 
       FROM CONCEPT C 
             JOIN CONCEPT_RELATIONSHIP CR 
                        ON C.CONCEPT_ID = CR.CONCEPT_ID_1 
                        AND CR.invalid_reason IS NULL 
                        AND cr.relationship_id = 'Maps To' 
              JOIN CONCEPT C1 
                        ON CR.CONCEPT_ID_2 = C1.CONCEPT_ID 
                        AND C1.INVALID_REASON IS NULL 
       UNION 
       SELECT source_code, SOURCE_CONCEPT_ID, source_vocabulary_id, c1.domain_id AS SOURCE_DOMAIN_ID, c2.CONCEPT_CLASS_ID AS SOURCE_CONCEPT_CLASS_ID,  
                           stcm.INVALID_REASON AS SOURCE_INVALID_REASON, 
        target_concept_id, target_vocabulary_id, c2.domain_id AS TARGET_DOMAIN_ID, c2.concept_class_id AS TARGET_CONCEPT_CLASS_ID, c2.INVALID_REASON AS TARGET_INVALID_REASON, 
                           c2.standard_concept AS TARGET_STANDARD_CONCEPT 
       FROM source_to_concept_map stcm 
              LEFT OUTER JOIN CONCEPT c1 
                     ON c1.concept_id = stcm.source_concept_id 
              LEFT OUTER JOIN CONCEPT c2 
                     ON c2.CONCEPT_ID = stcm.target_concept_id 
       WHERE stcm.INVALID_REASON IS NULL 
) 
```