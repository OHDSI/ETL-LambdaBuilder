--Query to get covid vaccines from Optum EHR COVID

select count(*), immunization_desc, ndc, ndc_source
from native.immunizations
where immunization_desc ilike ('%pfizer%') or
      immunization_desc ilike ('%covid%') or
      immunization_desc ilike ('%moderna%') or 
      immunization_desc ilike ('%astra%') or
      immunization_desc ilike ('%janssen%')
group by immunization_desc, ndc, ndc_source
;

select top 100 *
from native.immunizations
where immunization_desc ilike ('%pfizer%') or
      immunization_desc ilike ('%covid%') or
      immunization_desc ilike ('%moderna%') or 
      immunization_desc ilike ('%astra%') or
      immunization_desc ilike ('%janssen%')
group by immunization_desc, ndc, ndc_source
