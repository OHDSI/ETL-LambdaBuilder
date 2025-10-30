SELECT DISTINCT p.person_id, a.hvid
from 
(
SELECT hvid FROM native_hv.events 
where hvid != '' and hvid is not null
union
SELECT hvid FROM native_hv.enrollment 
where hvid != '' and hvid is not null
union
SELECT hvid FROM native_hv.medical_claims
where hvid != '' and hvid is not null
union
SELECT hvid FROM native_hv.pharmacy_claims
where hvid != '' and hvid is not null
) a
join native_hv.crosswalk_table ct on ct.hvid = a.hvid
join native_hv.users u on u.evidation_id = ct.evidation_id
join cdm_heartline_hv_2025_r02.person p on p.person_source_value = u.uuid
order by 1