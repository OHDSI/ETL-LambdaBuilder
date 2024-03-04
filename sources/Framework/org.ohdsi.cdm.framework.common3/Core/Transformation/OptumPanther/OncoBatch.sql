SELECT DISTINCT {0} row_number() over (order by a.ptid) person_id, a.ptid
from 
(
select distinct ptid from {sc}.onc_evaluation_system union
select distinct ptid from {sc}.onc_lines_of_therapy union
select distinct ptid from {sc}.onc_metastatic_location union
select distinct ptid from {sc}.onc_neoplasm_histology union
select distinct ptid from {sc}.onc_stage union
select distinct ptid from {sc}.onc_treatment_response union
select distinct ptid from {sc}.onc_tumor_grade union
select distinct ptid from {sc}.onc_tumor_node_metastasis union
select distinct ptid from {sc}.onc_biomarker union
select distinct ptid from {sc}.onc_characteristic union
select distinct ptid from {sc}.onc_tumor_progression union
select distinct ptid from {sc}.onc_tumor_size
) as a
join {sc}.patient as p on p.ptid = a.ptid
order by 1