-- Admit_Chan,Cob,Enctr,loc_cd,proc_cd
with claims as
(
   select pos, admit_type, Rvnu_Cd,Bill_Type,count(*) count          
   from optum_extended_dod.native.medical_claims
   group by pos, admit_type, Rvnu_Cd,Bill_Type
 )
 , pos as
 (
   select a.pos code, 
          'pos' as code_type,
          1 as priority,
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason,
          sum(count) count        
   from claims as a
   inner join (select * from optum_extended_dod.cdm.concept where vocabulary_id = 'CMS Place of Service') b
   on a.pos = b.concept_code
   where length(trim(pos)) = 2
   group by a.pos,
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason
 )
 , bill_type as
 (
   select a.bill_type code, 
          'bill_code' as code_type,
          2 as priority,
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason,
          sum(count) count
   from claims as a
   inner join (select * from optum_extended_dod.cdm.concept where vocabulary_id = 'UB04 Typ bill') b
   on a.bill_type = b.concept_code
   where length(trim(bill_type)) = 3
   group by a.bill_type, 
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason
 )
, Rvnu_Cd as
 (
   select a.Rvnu_Cd code, 
          'Rvnu_Cd' as code_type,
          3 as priority,
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason,
          sum(count) count
   from claims as a
   inner join (select * from optum_extended_dod.cdm.concept where vocabulary_id = 'Revenue Code') b
   on a.Rvnu_Cd = b.concept_code
   group by a.Rvnu_Cd, 
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason
 )
, admit_type as
 (
   select a.admit_type code, 
          'admit_type' as code_type,
          4 as priority,
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason,
          sum(count) count
   from claims as a
   inner join (select * from optum_extended_dod.cdm.concept where vocabulary_id = 'UB04 Pri Typ of Adm') b
   on a.admit_type = b.concept_code
   group by a.admit_type, 
          b.concept_id,
          b.concept_name,
          b.vocabulary_id,
          b.domain_id,
          b.invalid_reason
 )
, mapping as
(
  select *
  from pos
  union
  select *
  from bill_type
  union
  select *
  from rvnu_cd
  union
  select *
  from admit_type
  order by priority, code
)
, mapped_records as
(
  select case when b.code is not null then 'pos'
              when c.code is not null then 'bill_type'
              when f.conf_id is not null then 'inpatient confinement'
              when d.code is not null then 'rvnu_cd'
              when e.code is not null then 'admit_type'
              else 'unk'
            end as mapped
          ,a.*
  from optum_extended_dod.native.medical_claims as a
  left join pos as b
  on a.pos = b.code
  left join bill_type as c
  on a.bill_type = c.code
  left join rvnu_cd as d
  on a.rvnu_cd = d.code
  left join admit_type as e
  on a.admit_type = e.code
  left join optum_extended_dod.native.inpatient_confinement as f
  on a.patid = f.patid and
    a.pat_planid = f.pat_planid and
    a.conf_id = f.conf_id
 )
--  select mapped, count(*) count
--  from mapped_records
--  group by mapped
select tos_cd, tos_ext, _visittype, count(*) count
from mapped_records
where mapped = 'unk'
group by tos_cd, tos_ext, _visittype
order by tos_cd, tos_ext, _visittype
