SELECT distinct c.person_id, c.person_source_value 
FROM native_hv_cc_quarterly_sample._ch c
join {sc}.enrollment e on e.hvid = c.person_source_value
where lower(e.benefit_type) = 'medical' or lower(e.benefit_type) = 'pharmacy' or e.benefit_type is null
order by 1