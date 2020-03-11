with claims as
(
  select pos, count(*) count
  from optum_extended_dod.native.medical_claims
  group by pos
  order by pos desc
 )
 , concepts as
 (
   select *
   from optum_extended_dod.cdm.concept
   where vocabulary_id = 'CMS Place of Service'
)
select *
from claims as a
left join concepts as b
on a.pos = b.concept_code
order by a.pos
