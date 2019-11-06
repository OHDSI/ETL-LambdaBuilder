--Query to map CPRD prodcodes to standard concepts. This should not be used as the 
--official way to map but to get an idea of the domains represented.

select c.prodcode as therapy_prodcode,
       m.gemscriptcode,
       c1.concept_name as gemscript_code_name,
       c2.concept_id,
       c2.concept_name,
       c2.vocabulary_id,
       c2.domain_id,
       count(*) as freq     
from native.therapy c
join native.product m
  on c.prodcode = m.prodcode
left join cdm.concept c1
  on m.gemscriptcode = c1.concept_code
  and lower(c1.vocabulary_id) = 'gemscript'
left join cdm.concept_relationship cr
  on c1.concept_id = cr.concept_id_1
  and lower(cr.relationship_id) = 'maps to'
left join cdm.concept c2
  on cr.concept_id_2 = c2.concept_id
  and c2.invalid_reason is NULL 
  and c2.standard_concept = 'S'
group by c.prodcode, m.gemscriptcode, c1.concept_name,
         c2.concept_id, c2.concept_name, c2.vocabulary_id, c2.domain_id