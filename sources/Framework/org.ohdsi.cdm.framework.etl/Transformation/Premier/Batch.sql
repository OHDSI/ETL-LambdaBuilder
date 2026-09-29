WITH unique_keys AS (
    SELECT DISTINCT medrec_key
    FROM {sc}.pat
    WHERE medrec_key IS NOT NULL
)
SELECT 
    row_number() OVER (ORDER BY medrec_key) AS person_id,
    medrec_key
FROM unique_keys
order by 1