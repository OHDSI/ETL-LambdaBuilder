SELECT distinct concept_id, vocabulary_id, domain_id
FROM {sc}.concept
where domain_id in ('Condition', 'Device', 'Drug', 'Measurement', 'Observation', 'Procedure');