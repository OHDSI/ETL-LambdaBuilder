select date_part_year(fill_dt) as year, count(*) count
from optum_extended_dod.native.rx_claims
group by date_part_year(fill_dt)
order by date_part_year(fill_dt) desc;


select date_part_year(Fst_Dt) as year, count(*) count
from optum_extended_dod.native.med_procedure
group by date_part_year(Fst_Dt)
order by date_part_year(Fst_Dt) desc;

select date_part_year(Lst_Dt) as year, count(*) count
from optum_extended_dod.native.medical_claims
group by date_part_year(Lst_Dt)
order by date_part_year(Lst_Dt) desc;

select proc_cd, count(*) count
from optum_extended_dod.native.medical_claims
group by proc_cd
order by proc_cd;