SELECT DISTINCT {0} row_number() over (order by person_source_value) person_id, person_source_value
from 
(
SELECT person_source_value FROM native_hv_cc_quarterly_sample._ch
) a