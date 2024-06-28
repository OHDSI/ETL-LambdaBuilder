SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT DISTINCT hvid FROM cdm_health_verity_cc_ehr_cce_v2776.enrollment 
where lower(benefit_type) = 'medical'
union
SELECT DISTINCT hvid FROM cdm_health_verity_cc_ehr_cce_v2776.enrollment 
where lower(benefit_type) = 'pharmacy' or benefit_type is null
) a 
where hvid != '' and hvid is not null
order by 1