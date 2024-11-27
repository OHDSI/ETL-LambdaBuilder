SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT DISTINCT hvid FROM {sc}.enrollment 
where lower(benefit_type) = 'medical'
union
SELECT DISTINCT hvid FROM {sc}.enrollment 
where lower(benefit_type) = 'pharmacy' or benefit_type is null
union
SELECT DISTINCT hvid FROM {sc}.enrollment 
where hvid in ('00000caf25c3dbcc022d2c1690af3166', 'd885cef572b581672aa0fa27d5f9b9de')
) a 
where hvid != '' and hvid is not null
order by 1
limit 100000;