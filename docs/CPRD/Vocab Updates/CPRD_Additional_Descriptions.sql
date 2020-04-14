--Query to produce appendix 2: CPRD Additional Table Descriptions

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data1 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data1 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where e.data_fields > 0 and a.enttype not in (72,116,372,78)
group by e.category, a.enttype, e.description, e.data_fields, e.data1

UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data2 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data2 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where e.data_fields > 1 and a.enttype not in (72,116,78,60,119,120)
group by e.category, a.enttype, e.description, e.data_fields, e.data2       
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data3 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data3 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where e.data_fields > 2 and a.enttype not in (372,78,126)
group by e.category, a.enttype, e.description, e.data_fields, e.data3

UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data4 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data4 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where e.data_fields > 3 and a.enttype not in (372,78,126)
group by e.category, a.enttype, e.description, e.data_fields, e.data4
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data5 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data5 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where e.data_fields > 4 and a.enttype not in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data5
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data6 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data6 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where e.data_fields > 5 and a.enttype not in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data6

UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data7 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data7 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where e.data_fields > 6 and a.enttype not in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data7
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data1 as data,
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data1 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where a.enttype in (72,116,78)
group by e.category, a.enttype, e.description, e.data_fields, e.data1
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data3 as data,
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data3 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where a.enttype in (126,78)
group by e.category, a.enttype, e.description, e.data_fields, e.data3
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data5 as data,       
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||e.data5 as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
where a.enttype in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data5

UNION


select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       sm.scoring_method as data,
       e.data_fields,
       a.enttype||'-'||e.category||'-'||e.description||'-'||sm.scoring_method as source_value         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.scoringmethod sm
  on a.data3_value = sm.code
where a.enttype in (372)
group by e.category, a.enttype, e.description, e.data_fields, sm.scoring_method
