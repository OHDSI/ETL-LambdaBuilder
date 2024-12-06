SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT distinct e.hvid
from {sc}.events e
join {sc}.medical_claims m on e.hvid = m.hvid and m.date_service > dateadd(day, 60, e.event_date)
join {sc}.enrollment enr on e.hvid = enr.hvid
where lower(enr.benefit_type) = 'medical' or (lower(enr.benefit_type) = 'pharmacy' or enr.benefit_type is null)
union
SELECT DISTINCT hvid FROM {sc}.enrollment 
where lower(benefit_type) = 'medical'
union
SELECT DISTINCT hvid FROM {sc}.enrollment 
where lower(benefit_type) = 'pharmacy' or benefit_type is null
) a 
where hvid != '' and hvid is not null
order by 1
limit 100000;