SELECT DISTINCT {0}  patid, patid
FROM {sc}.MEMBER_CONTINUOUS_ENROLLMENT
WHERE patid in (SELECT distinct patid FROM {sc}.death)
order by 1