SELECT DISTINCT medrec_key, medrec_key
FROM {sc}.pat
JOIN {sc}.patcpt cpt ON PAT.PAT_KEY = cpt.pat_key
where cpt.cpt_code in ('J1440', 'J9350', 'J9380', 'Q2040', 'Q2041', 'Q2042')
order by 1
limit 1000000