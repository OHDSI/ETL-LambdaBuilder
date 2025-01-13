SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT person_source_value FROM native_hv_cc_quarterly_sample._ch
) a