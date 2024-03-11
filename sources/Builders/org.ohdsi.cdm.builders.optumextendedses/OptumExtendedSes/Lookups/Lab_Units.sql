﻿{Source_to_Standard}

SELECT distinct SOURCE_CODE, TARGET_CONCEPT_ID
FROM CTE_VOCAB_MAP
WHERE lower(SOURCE_VOCABULARY_ID) IN ('ucum')
AND lower(TARGET_VOCABULARY_ID) IN ('ucum') 
AND (TARGET_INVALID_REASON IS NULL or TARGET_INVALID_REASON = '')
union
SELECT distinct SOURCE_CODE, TARGET_CONCEPT_ID
FROM CTE_VOCAB_MAP
WHERE lower(SOURCE_VOCABULARY_ID) IN ('jnj_units')
AND (TARGET_INVALID_REASON IS NULL or TARGET_INVALID_REASON = '')
