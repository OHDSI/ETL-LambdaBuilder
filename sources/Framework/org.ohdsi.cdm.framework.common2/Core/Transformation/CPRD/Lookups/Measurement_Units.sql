SELECT distinct concept_name, concept_id, 'None' as Domain, NULL AS valid_start_date, NULL AS valid_end_date
FROM {sc}.concept
where lower(domain_id)='unit' and lower(vocabulary_id)='ucum'