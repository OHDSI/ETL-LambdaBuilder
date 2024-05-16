SELECT DISTINCT {0} medrec_key, medrec_key
FROM {sc}.pat
WHERE medrec_key is not NULL and medrec_key in
(
SELECT DISTINCT cast(pat.medrec_key as bigint) as medrec_key
FROM {sc}.pat
JOIN {sc}.patcpt cpt ON PAT.PAT_KEY = cpt.pat_key
where cpt.cpt_code in
(
'A4560',
'CS',
'G0030',
'G0031',
'G0032',
'G0033',
'G0034',
'G0035',
'G0036',
'G0037',
'G0038',
'G0039',
'G0040',
'G0041',
'G0042',
'G0043',
'G0044',
'G0045',
'G0046',
'G0047',
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
'G0327',
'J1440',
'J9350',
'J9380',
'Q2040',
'Q2041',
'Q2042'
)
)
order by 1
limit 1000000