-- SELECT DISTINCT {0} row_number() over (order by ptid) person_id, ptid
-- FROM {sc}.patient
-- order by 1

SELECT DISTINCT {0} cast(replace(ptid, 'PT', '') as int) person_id, ptid
FROM {sc}.patient
order by 1
limit 1000000