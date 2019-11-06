--Query to map medcodes in the CPRD referral table to vocabulary.
--This is not the offical way but can give an idea to the different domains
--represented in the table.

select c.medcode as referral_medcode,
       m.read_code,
       c1.concept_name as read_code_name,
       c2.concept_id,
       c2.concept_name,
       c2.vocabulary_id,
       c2.domain_id,
       count(*) as freq     
from native.referral c
join native.medical m
  on c.medcode = m.medcode
left join cdm.concept c1
  on m.read_code = c1.concept_code
  and lower(c1.vocabulary_id) = 'read'
left join cdm.concept_relationship cr
  on c1.concept_id = cr.concept_id_1
  and lower(cr.relationship_id) = 'maps to'
left join cdm.concept c2
  on cr.concept_id_2 = c2.concept_id
  and c2.invalid_reason is NULL 
  and c2.standard_concept = 'S'
group by c.medcode, m.read_code, c1.concept_name,
         c2.concept_id, c2.concept_name, c2.vocabulary_id, c2.domain_id