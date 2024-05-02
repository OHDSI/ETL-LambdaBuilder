SELECT distinct concept_id, vocabulary_id, domain_id
FROM {sc}.concept
where domain_id in ('Condition', 'Device', 'Drug', 'Measurement', 'Observation', 'Procedure')
--where vocabulary_id in
--(
--'CPT4',
--'HCPCS',
--'ICD10CM',
--'ICD10PCS',
--'ICD10',
--'LOINC',
--'ICD9CM',
--'ICD9Proc',
--'NDC',
--'Revenue Code'
--)