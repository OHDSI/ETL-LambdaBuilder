select distinct *
from
(
SELECT distinct t.patid, t.patid
FROM {sc}.med_diagnosis t
join {sc}.MEMBER_CONTINUOUS_ENROLLMENT t1 on t.patid = t1.patid
where diag in
(
'798', --	"Sudden death, cause unknown"
'E978', --	Legal execution
'P95', --	Fetal death of unspecified cause
'R95', --	Sudden infant death syndrome
'R96', --	"Other sudden death, cause unknown"
'R99' --	Ill-defined and unknown cause of mortality
)
union
SELECT distinct t.patid, t.patid
FROM {sc}.medical_claims t
join {sc}.MEMBER_CONTINUOUS_ENROLLMENT t1 on t.patid = t1.patid
where DSTATUS IN ('20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '40', '41', '42')
union
SELECT distinct t.patid, t.patid
FROM {sc}.DEATH t
join {sc}.MEMBER_CONTINUOUS_ENROLLMENT t1 on t.patid = t1.patid
) as a
order by 1