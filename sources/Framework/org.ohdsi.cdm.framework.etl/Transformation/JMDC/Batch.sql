--SELECT DISTINCT {0} CAST(RIGHT([Member ID], LEN([Member ID]) - 1) AS BIGINT) AS person_id, [Member ID]
--FROM {sc}.Enrollment
--order by 1

with a as
(
 SELECT CAST(RIGHT(Member_ID, LEN(Member_ID) - 1) AS BIGINT) AS person_id,
 Member_ID AS person_source_value,
 cast(left(Month_and_year_of_birth_of_member, 4) as int) AS year_of_birth,
 cast(right(Month_and_year_of_birth_of_member, 2) as int) AS month_of_birth,
 lower(Gender_of_member) AS gender_source_value,
 CAST(CAST(e.observation_start AS VARCHAR(6)) + '01' AS DATE) AS observation_period_start_date,
 DATEADD(DAY, -1, DATEADD(MONTH, 1, CAST(CAST(e.observation_end AS VARCHAR(6)) + '01' AS DATE))) AS observation_period_end_date,
 CASE
 WHEN withdrawal_death_flag = 'true' THEN 1
 ELSE 0
 END as died,
 family_id,
 case
 when family_id != '' then 1
 else 0
 end as has_payerplan,
 case
 when family_id != '' then cast(replace(family_id, 'M', '') as int)
 else 0
 end as payerplan_id
 FROM native.Enrollment e
 --limit 100
 ), a2 as
 (
 SELECT CAST(RIGHT(Member_ID, LEN(Member_ID) - 1) AS BIGINT) AS person_id,
 Member_ID AS person_source_value,
 cast(left(Month_and_year_of_birth_of_member, 4) as int) AS year_of_birth,
 cast(right(Month_and_year_of_birth_of_member, 2) as int) AS month_of_birth,
 lower(Gender_of_member) AS gender_source_value,
 CAST(CAST(e.observation_start AS VARCHAR(6)) + '01' AS DATE) AS observation_period_start_date,
 family_id
 FROM native.Enrollment e
 ), a3 as
 (
select a.*,
m2.person_id as baby_person_id,
min(CAST((CAST(m2.year_of_birth AS VARCHAR) || '-' || CAST(m2.month_of_birth AS VARCHAR) || '-01') AS DATE) ) as baby_dob,
32813 as PeriodTypeConceptId
from a
left join a2 m2 on a.person_id != m2.person_id and a.gender_source_value = 'female' and a.family_id is not null and a.family_id = m2.family_id and m2.year_of_birth - DATE_PART('YEAR', m2.observation_period_start_date) = 0
where m2.person_id is not null
group by a.person_id, a.person_source_value, a.year_of_birth, a.month_of_birth, a.gender_source_value, a.observation_period_start_date, a.observation_period_end_date, a.died, a.family_id, a.has_payerplan, a.payerplan_id, baby_person_id, m2.year_of_birth, m2.month_of_birth, m2.observation_period_start_date
)

select distinct person_id, person_source_value
from a3
order by 1