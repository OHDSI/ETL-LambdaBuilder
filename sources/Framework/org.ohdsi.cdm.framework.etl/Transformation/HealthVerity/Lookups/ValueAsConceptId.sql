with a as
(
SELECT concept_name, min(concept_id) concept_id
FROM {sc}.concept
where domain_id = 'Meas Value' and standard_concept = 'S' and invalid_reason is NULL
group by concept_name
)

select concept_name, concept_id, 'None' as Domain, to_date('1900/1/1', 'yyyy/M/d') as VALID_START_DATE, to_date('2100/1/1', 'yyyy/M/d') as VALID_END_DATE
from a