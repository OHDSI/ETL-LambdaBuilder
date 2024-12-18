SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT hvid FROM {sc}.events 
where hvid != '' and hvid is not null
union
SELECT hvid FROM {sc}.enrollment 
where hvid != '' and hvid is not null
union
SELECT hvid FROM {sc}.medical_claims
where hvid != '' and hvid is not null
union
SELECT hvid FROM {sc}.pharmacy_claims
where hvid != '' and hvid is not null
) a 
order by 1