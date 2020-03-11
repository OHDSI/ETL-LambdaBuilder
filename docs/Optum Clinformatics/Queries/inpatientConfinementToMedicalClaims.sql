with inptConf as
(
  select patid,
          pat_planid,
          admit_date,
          disch_date,
          conf_id
  from optum_extended_dod.native.inpatient_confinement
)
, medclaims as
(
  select patid,
        pat_planid,
        Clmid,
        Clmseq,
        conf_id,
        Fst_Dt,
        Lst_Dt
  FROM optum_extended_dod.native.medical_claims
)
, medclaimsNotInConfinement as
(
  select distinct b.patid, b.pat_planid, a.clmid, a.clmseq, 
        b.admit_date, b.disch_date, b.conf_id as inpt_conf_id
  from medclaims as a
  inner join inptconf as b
  on a.patid = b.patid and
      a.pat_planid = b.pat_planid and
      a.fst_dt >= b.admit_date and
      a.lst_dt <= b.disch_date 
   where a.conf_id = ''
 )
 select distinct a.*
          , case when a.conf_id = b.inpt_conf_id then 'Y' else 'N' end as match
          , b.admit_date
          , b.disch_date
          , b.inpt_conf_id
 from optum_extended_dod.native.medical_claims a
 inner join medclaimsNotInConfinement b
 on a.clmid = b.clmid and
    a.clmseq = b.clmseq and
    a.patid = b.patid and
    a.pat_planid = b.pat_planid and
    a.fst_dt >= b.admit_date
 where a.patid = '33055471081'
 and a.pat_planid = '53008000290'
 order by a.fst_dt, a.clmid, a.clmseq;

