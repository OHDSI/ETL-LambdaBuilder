SELECT DISTINCT {0} CAST(RIGHT(member_id, LEN(member_id) - 1) AS BIGINT) AS person_id, member_id
FROM {sc}.Enrollment
order by 1
limit 1000000