SELECT DISTINCT medrec_key, medrec_key
FROM {sc}.pat
JOIN {sc}.patcpt cpt ON PAT.PAT_KEY = cpt.pat_key
where cpt.cpt_code in
(
'G0050',
'G0308',
'G0309',
'G0310',
'G0311',
'G0312',
'G0313',
'G0314',
'G0315',
'G0316',
'G0317',
'G0318',
'G0320',
'G0321',
'G0322',
'G0323',
'G0327'
)
order by 1
limit 1000000