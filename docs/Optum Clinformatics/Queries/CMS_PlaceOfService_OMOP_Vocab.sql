/*Visit Concept Roll-up Logic*/

/*Find terminal ancestors in the Visit domain*/
WITH top_level
AS
(SELECT concept_id, concept_name
  FROM concept 
  LEFT JOIN concept_ancestor 
 	ON concept_id=descendant_concept_id 
    AND ancestor_concept_id!=descendant_concept_id
  WHERE domain_id='Visit' 
 	AND standard_concept='S'
    AND ancestor_concept_id IS NULL
)

/*Find all descendants of those ancestors*/
SELECT top_level.concept_id as terminal_ancestor_concept_id, 
	   top_level.concept_name as terminal_ancestor_concept_name, 
	   descendant.concept_id as descendant_concept_id, 
	   descendant.concept_name as descendant_concept_name
FROM concept_ancestor
JOIN top_level  
	ON top_level.concept_id = ancestor_concept_id
JOIN concept descendant 
	ON descendant.concept_id = descendant_concept_id
WHERE descendant.domain_id = 'Visit';

/*This can be used in conjunction with the source_to_standard query. Source_to_standard
is used to find the visit concepts that the CMS place of service codes map to. From there,
those standard concepts can be joined to the above table on TARGET_STANDARD_CONCEPT = DESCENDANT_CONCEPT_ID
to find the high-level terminal ancestor of each standard Visit concept. The high-level ancestors should then
become the VISIT_CONCEPT_IDs in the VISIT_OCCURRENCE table. 