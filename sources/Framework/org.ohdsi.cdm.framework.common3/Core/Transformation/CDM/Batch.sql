select * from
(
SELECT DISTINCT PERSON_ID, PERSON_ID
FROM {sc}.PERSON
where PERSON_ID in (SELECT distinct PERSON_ID FROM {sc}.drug_exposure where drug_source_value = 'J9380')
) a
order by 1
limit 1000000;