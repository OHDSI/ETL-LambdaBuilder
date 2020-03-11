with ndc as
(
  select trim(ndc) ndc, count(*) count
  from optum_extended_dod.native.medical_claims
  where trim(ndc) != ''
  group by trim(ndc)
 )
 , concepts as
 (
   select *
   from optum_extended_dod.cdm.concept
   where vocabulary_id = 'NDC'
)
select *
from ndc as a
inner join concepts as b
on a.ndc = b.concept_code
order by a.ndc

