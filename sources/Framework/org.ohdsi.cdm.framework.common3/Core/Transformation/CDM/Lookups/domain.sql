SELECT distinct concept_id, 0, domain_id as Domain, cast('1900/1/1' as date) as VALID_START_DATE, cast('2100/1/1' as date) as VALID_END_DATE
FROM {sc}.concept
where domain_id in ('Condition', 'Device', 'Drug', 'Measurement', 'Observation', 'Procedure')