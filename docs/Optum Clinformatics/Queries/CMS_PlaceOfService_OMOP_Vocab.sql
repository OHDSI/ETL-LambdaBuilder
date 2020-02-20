/*Visit Concept Roll-up Logic*/

/*Find terminal ancestors in the Visit domain*/
with cteAncestors as (
    select concept_id, concept_name, count(*) 
    from concept c
    join concept_ancestor ca
      on c.concept_id = ca.descendant_concept_id
    where lower(domain_id) = 'visit' and standard_concept = 'S'
    group by concept_id, concept_name
    having count(*) = 1
 ),
/*Find all CMS place of service codes, their mappings, and their terminal ancestors*/

ctePosMaps as (
SELECT c.concept_id, 
       c.concept_name, 
       c.concept_code, 
       c.vocabulary_id,
       case when c2.concept_id is NULL then 9202 else c2.concept_id end as maps_to_concept, 
       c2.concept_name as maps_to_concept_name
FROM concept c
LEFT JOIN concept_relationship cr
  on c.concept_id = cr.concept_id_1
  and lower(cr.relationship_id) = 'maps to'
LEFT JOIN concept c2
  on cr.concept_id_2 = c2.concept_id
  and c2.invalid_reason is NULL
  and c2.standard_concept = 'S'
WHERE c.vocabulary_id = 'CMS Place of Service'
)

select pm.*, an.concept_id as terminal_ancestor, an.concept_name as terminal_ancestor_name
from ctePosMaps pm
join concept_ancestor ca
  on pm.maps_to_concept = ca.descendant_concept_id
join cteAncestors an
  on ca.ancestor_concept_id = an.concept_id
  
 /*This creates a table with the source codes and concepts representing the CMS place of service codes, the concepts they map to, and the terminal ancestors of those concepts.*/