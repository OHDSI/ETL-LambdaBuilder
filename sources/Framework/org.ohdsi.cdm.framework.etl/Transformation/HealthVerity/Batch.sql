SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT distinct e.hvid
from {sc}.events e
join {sc}.medical_claims m on e.hvid = m.hvid and m.date_service > dateadd(day, 60, e.event_date)
join {sc}.enrollment enr on e.hvid = enr.hvid
where lower(enr.benefit_type) = 'medical' or (lower(enr.benefit_type) = 'pharmacy' or enr.benefit_type is null)
union
SELECT distinct e.hvid
from {sc}.events e
join {sc}.enrollment p on p.hvid = e.hvid and p.patient_year_of_birth > DATE_PART_YEAR(e.event_date)
union
select distinct hvid
from (
SELECT distinct e.hvid,  min(p.date_start) as op_start, min(e.event_date) as death_date
from {sc}.events e
join {sc}.enrollment p on p.hvid = e.hvid
group by e.hvid
) as t
where op_start > death_date
) a 
where hvid != '' and hvid is not null
order by 1
limit 100000;