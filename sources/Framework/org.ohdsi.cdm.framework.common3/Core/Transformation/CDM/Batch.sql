select * from
(
SELECT DISTINCT PERSON_ID, PERSON_ID
FROM {sc}.PERSON
where PERSON_ID in (
SELECT distinct PERSON_ID 
FROM {sc}.drug_exposure 
where drug_source_value in ('J1440', 'J9350', 'J9380')
union
SELECT  distinct PERSON_ID  
FROM {sc}.procedure_occurrence
where procedure_source_value = 'G0050'
union
SELECT distinct PERSON_ID
FROM {sc}.condition_occurrence
where condition_source_value = '010.05' 
union
SELECT distinct PERSON_ID  
FROM {sc}.PERSON
where PERSON_ID > 283787864
)
) a
order by 1
limit 1000000;