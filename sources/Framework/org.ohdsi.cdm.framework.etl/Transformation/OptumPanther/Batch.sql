-- SELECT DISTINCT {0} row_number() over (order by ptid) person_id, ptid
-- FROM {sc}.patient
-- order by 1

SELECT DISTINCT {0} cast(replace(ptid, 'PT', '') as int) person_id, ptid
FROM {sc}.patient
where ptid in
(
select distinct ptid from {sc}.alz_assessment
union
select distinct ptid from {sc}.alz_biomarker
union
select distinct ptid from {sc}.alz_imaging
union
select distinct ptid from {sc}.alz_medication
union
select distinct ptid from {sc}.alz_problem
)
order by 1