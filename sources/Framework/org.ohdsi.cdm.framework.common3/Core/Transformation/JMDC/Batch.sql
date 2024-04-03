SELECT DISTINCT {0} CAST(RIGHT(Member_ID, LEN(Member_ID) - 1) AS BIGINT) AS person_id, Member_ID
FROM {sc}.Enrollment
order by 1