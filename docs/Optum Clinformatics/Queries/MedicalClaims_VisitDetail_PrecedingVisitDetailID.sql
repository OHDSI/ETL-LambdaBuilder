with rows as
(
  select top 2 patid, pat_planid, clmid, clmseq, paid_status
  from optum_extended_dod.native.medical_claims
  group by patid, pat_planid, clmid, clmseq, paid_status
  having count(*) > 1
  order by patid, pat_planid, clmid, clmseq, paid_status
)
select a.*
from optum_extended_dod.native.medical_claims a
inner join (select distinct patid, pat_planid, clmid from rows) b
on a.patid = b.patid and
  a.pat_planid = b.pat_planid and
  a.clmid = b.clmid 
