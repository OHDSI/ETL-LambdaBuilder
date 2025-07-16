SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT hvid FROM {sc}.enrollment 
where hvid != '' and hvid is not null and data_vendor {param1} 
union
SELECT hvid FROM {sc}.medical_claims
where hvid != '' and hvid is not null and data_vendor {param1} 
union
SELECT hvid FROM {sc}.pharmacy_claims
where hvid != '' and hvid is not null and data_vendor {param1} 
) a 
order by 1
limit 100000