--Query to produce appendix 1: CPRD Test Table Read Codes Mapped to OMOP Concepts

SELECT count(*) as count_records,
       m.read_code,
       m.description,
       e.code,
       e.description,
       e.data_fields,
       c2.concept_id,
       c2.concept_name,
       c2.domain_id   
FROM native.test t
JOIN native.entity e
  ON t.enttype = e.code
JOIN native.medical m
  ON t.medcode = m.medcode
LEFT JOIN cdm.concept c1
  ON m.read_code = c1.concept_code
  AND lower(c1.vocabulary_id) = 'read'
LEFT JOIN cdm.concept_relationship cr
  ON c1.concept_id = cr.concept_id_1
  AND lower(cr.relationship_id) = 'maps to'
LEFT JOIN cdm.concept c2
  ON cr.concept_id_2 = c2.concept_id
WHERE e.data_fields in (7,8)
GROUP BY m.read_code, m.description, e.code,
       e.description, e.data_fields, c2.concept_id,
       c2.concept_name, c2.domain_id 