SELECT DISTINCT {0} row_number() over (order by hvid) person_id, hvid
from 
(
SELECT distinct hvid
FROM health_verity.cdm_etl_temp.hvids
) a