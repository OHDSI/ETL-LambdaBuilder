SELECT distinct concept_id, vocabulary_id
FROM {sc}.concept
where vocabulary_id in
(
'CPT4',
'HCPCS',
'ICD10CM',
'ICD10PCS',
'ICD9CM',
'ICD9Proc',
'NDC',
'Revenue Code'
)