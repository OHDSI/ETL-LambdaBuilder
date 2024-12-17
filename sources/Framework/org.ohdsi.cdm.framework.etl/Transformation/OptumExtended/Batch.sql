SELECT distinct patid, patid
FROM {sc}.med_diagnosis
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
SELECT distinct patid, patid
FROM {sc}.medical_claims
where DSTATUS IN ('20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '40', '41', '42')
union
SELECT distinct patid, patid
FROM {sc}.DEATH