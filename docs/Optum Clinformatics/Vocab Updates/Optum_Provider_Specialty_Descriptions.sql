/*Getting counts of providers by provcat for vocab mapping*/

select count(*), p.provcat
from medical_claims m
join provider_bridge pb
  on m.prov = pb.prov
join provider p
  on pb.prov_unique = p.prov_unique
group by p.provcat

/* Optum does not provide a relational lookup table for provcat so these values need to be crosswalked to descriptions using the excel file "CDM-Data-Reference-Lookup-Tables-V8-0.xls."