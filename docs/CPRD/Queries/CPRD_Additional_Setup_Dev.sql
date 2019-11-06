--Query used to develop the mapping strategy for the additional table

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data1 as data,       
       case when e.data1lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data1_value 
       end as value_as_number, 
       case when e.data1lkup = 'Medical Dictionary' then m.read_code 
        when e.data1lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data1lkup = 'dd/mm/yyyy' then a.data1_date
       end as value_as_date,
       case when a.enttype in (13,488) then 'kg'
        when a.enttype = 476 then 'cm'
        when a.enttype in (119,61,60,120) then 'week'
        when a.enttype = 14 then 'm' 
        else '' 
       end as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data1lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data1_value
  left join native.medical m
  on m.medcode = a.data1_value
  and e.data1lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data1_value
  and e.data1lkup = 'Product Dictionary'
where e.data_fields > 0 and a.enttype not in (72,116,372,78)
group by e.category, a.enttype, e.description, e.data_fields, e.data1,
        a.data1_value, lu.text, e.data1lkup, m.read_code, m.description, a.data1_date,
        p.productname, p.gemscriptcode

UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data2 as data,       
       case when e.data2lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data2_value 
       end as value_as_number, 
       case when e.data2lkup = 'Medical Dictionary' then m.read_code 
        when e.data2lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data2lkup = 'dd/mm/yyyy' then a.data2_date
       end as value_as_date,
       case when a.enttype = 52 then 'hour'
        when a.enttype = 69 then 'week'
        when a.enttype = 150 then 'day'
        else '' 
       end as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data2lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data2_value
  left join native.medical m
  on m.medcode = a.data2_value
  and e.data2lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data2_value
  and e.data2lkup = 'Product Dictionary'
where e.data_fields > 1 and a.enttype not in (72,116,78,60,119,120)
group by e.category, a.enttype, e.description, e.data_fields, e.data2,
        a.data2_value, lu.text, e.data2lkup, m.read_code, m.description, a.data2_date,
        p.productname, p.gemscriptcode
        
UNION

select count(*),  
       a.enttype, 
       e.category,
       e.description, 
       e.data3 as data,       
       case when e.data3lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data3_value 
       end as value_as_number, 
       case when e.data3lkup = 'Medical Dictionary' then m.read_code 
        when e.data3lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data3lkup = 'dd/mm/yyyy' then a.data3_date
       end as value_as_date,
       '' as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data3lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data3_value
  left join native.medical m
  on m.medcode = a.data3_value
  and e.data3lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data3_value
  and e.data3lkup = 'Product Dictionary'
where e.data_fields > 2 and a.enttype not in (372,78,126)
group by e.category, a.enttype, e.description, e.data_fields, e.data3,
        a.data3_value, lu.text, e.data3lkup, m.read_code, m.description, a.data3_date,
        p.productname, p.gemscriptcode

UNION

select count(*),  
       a.enttype, 
       e.category,
       e.description, 
       e.data4 as data,       
       case when e.data4lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data4_value 
       end as value_as_number, 
       case when e.data4lkup = 'Medical Dictionary' then m.read_code 
        when e.data4lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data4lkup = 'dd/mm/yyyy' then a.data4_date
       end as value_as_date,
       '' as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data4lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data4_value
  left join native.medical m
  on m.medcode = a.data4_value
  and e.data4lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data4_value
  and e.data4lkup = 'Product Dictionary'
where e.data_fields > 3 and a.enttype not in (372,78,126)
group by e.category, a.enttype, e.description, e.data_fields, e.data4,
        a.data4_value, lu.text, e.data4lkup, m.read_code, m.description, a.data4_date,
        p.productname, p.gemscriptcode
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data5 as data,       
       case when e.data5lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data5_value 
       end as value_as_number, 
       case when e.data5lkup = 'Medical Dictionary' then m.read_code 
        when e.data5lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data5lkup = 'dd/mm/yyyy' then a.data5_date
       end as value_as_date,
       '' as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data5lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data5_value
  left join native.medical m
  on m.medcode = a.data5_value
  and e.data5lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data5_value
  and e.data5lkup = 'Product Dictionary'
where e.data_fields > 4 and a.enttype not in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data5,
        a.data5_value, lu.text, e.data5lkup, m.read_code, m.description, a.data5_date,
        p.productname, p.gemscriptcode
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data6 as data,       
       case when e.data6lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data6_value 
       end as value_as_number, 
       case when e.data6lkup = 'Medical Dictionary' then m.read_code 
        when e.data6lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data6lkup = 'dd/mm/yyyy' then a.data6_date
       end as value_as_date,
       '' as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data6lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data6_value
  left join native.medical m
  on m.medcode = a.data6_value
  and e.data6lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data6_value
  and e.data6lkup = 'Product Dictionary'
where e.data_fields > 5 and a.enttype not in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data6,
        a.data6_value, lu.text, e.data6lkup, m.read_code, m.description, a.data6_date,
        p.productname, p.gemscriptcode
        
UNION

select count(*), 
       a.enttype, 
       e.category,
       e.description, 
       e.data7 as data,       
       case when e.data7lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data7_value 
       end as value_as_number, 
       case when e.data7lkup = 'Medical Dictionary' then m.read_code 
        when e.data7lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data7lkup = 'dd/mm/yyyy' then a.data7_date
       end as value_as_date,
       '' as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data7lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data7_value
  left join native.medical m
  on m.medcode = a.data7_value
  and e.data7lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data7_value
  and e.data7lkup = 'Product Dictionary'
where e.data_fields > 6 and a.enttype not in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data7,
        a.data7_value, lu.text, e.data7lkup, m.read_code, m.description, a.data7_date,
        p.productname, p.gemscriptcode
        
UNION

select count(*),
       a.enttype, 
       e.category,
       e.description, 
       e.data1 as data,       
       case when e.data1lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data1_value 
       end as value_as_number, 
       case when e.data1lkup = 'Medical Dictionary' then m.read_code 
        when e.data1lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data1lkup = 'dd/mm/yyyy' then a.data1_date
       end as value_as_date,
       case when lu2.text = 'week' then 'week'
        else lu2.text end as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data1lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data1_value
  left join native.lookuptype lt2
  on e.data2lkup = lt2.name
  left join native.lookup lu2
  on lt2.lookup_type_id = lu2.lookup_type_id
  and lu2.code = a.data2_value
  left join native.medical m
  on m.medcode = a.data1_value
  and e.data1lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data1_value
  and e.data1lkup = 'Product Dictionary'
where a.enttype in (72,116,78)
group by e.category, a.enttype, e.description, e.data_fields, e.data1,
        a.data1_value, lu.text, e.data1lkup, m.read_code, m.description, a.data1_date,
        p.productname, p.gemscriptcode, lu2.text
        
UNION

select count(*),
       a.enttype, 
       e.category,
       e.description, 
       e.data3 as data,       
       case when e.data3lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data3_value 
       end as value_as_number, 
       case when e.data3lkup = 'Medical Dictionary' then m.read_code 
        when e.data3lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data3lkup = 'dd/mm/yyyy' then a.data3_date
       end as value_as_date,
       lu2.text as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data3lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data3_value
  left join native.lookuptype lt2
  on e.data4lkup = lt2.name
  left join native.lookup lu2
  on lt2.lookup_type_id = lu2.lookup_type_id
  and lu2.code = a.data4_value
  left join native.medical m
  on m.medcode = a.data3_value
  and e.data1lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data3_value
  and e.data1lkup = 'Product Dictionary'
where a.enttype in (126,78)
group by e.category, a.enttype, e.description, e.data_fields, e.data3,
        a.data3_value, lu.text, e.data3lkup, m.read_code, m.description, a.data3_date,
        p.productname, p.gemscriptcode, lu2.text
        
UNION

select count(*),
       a.enttype, 
       e.category,
       e.description, 
       e.data5 as data,       
       case when e.data5lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data5_value 
       end as value_as_number, 
       case when e.data5lkup = 'Medical Dictionary' then m.read_code 
        when e.data5lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data5lkup = 'dd/mm/yyyy' then a.data5_date
       end as value_as_date,
       lu2.text as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data5lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data5_value
  left join native.lookuptype lt2
  on e.data6lkup = lt2.name
  left join native.lookup lu2
  on lt2.lookup_type_id = lu2.lookup_type_id
  and lu2.code = a.data6_value
  left join native.medical m
  on m.medcode = a.data5_value
  and e.data1lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data5_value
  and e.data1lkup = 'Product Dictionary'
where a.enttype in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data5,
        a.data5_value, lu.text, e.data5lkup, m.read_code, m.description, a.data5_date,
        p.productname, p.gemscriptcode, lu2.text
        
UNION

select count(*),
       a.enttype, 
       e.category,
       e.description, 
       e.data5 as data,       
       case when e.data5lkup in ('Medical Dictionary', 'Product Dictionary') then null
        else a.data5_value 
       end as value_as_number, 
       case when e.data5lkup = 'Medical Dictionary' then m.read_code 
        when e.data5lkup = 'Product Dictionary' then p.gemscriptcode
        else lu.text 
       end as value_as_string,
       case when e.data5lkup = 'dd/mm/yyyy' then a.data5_date
       end as value_as_date,
       lu2.text as unit_source_value,
       '' as qualifier_source_value,
       m.description as read_code_description,
       p.productname as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.lookuptype lt
  on e.data5lkup = lt.name
  left join native.lookup lu
  on lt.lookup_type_id = lu.lookup_type_id
  and lu.code = a.data5_value
  left join native.lookuptype lt2
  on e.data6lkup = lt2.name
  left join native.lookup lu2
  on lt2.lookup_type_id = lu2.lookup_type_id
  and lu2.code = a.data6_value
  left join native.medical m
  on m.medcode = a.data5_value
  and e.data1lkup = 'Medical Dictionary'
  left join native.product p
  on p.prodcode = a.data5_value
  and e.data1lkup = 'Product Dictionary'
where a.enttype in (78)
group by e.category, a.enttype, e.description, e.data_fields, e.data5,
        a.data5_value, lu.text, e.data5lkup, m.read_code, m.description, a.data5_date,
        p.productname, p.gemscriptcode, lu2.text
        
UNION

select count(*),
       a.enttype, 
       e.category,
       e.description, 
       sm.scoring_method as data,       
       a.data1_value as value_as_number, 
       '' as value_as_string,
       case when e.data1lkup = 'dd/mm/yyyy' then a.data1_date
       end as value_as_date,
       '' as unit_source_value,
       lu4.text as qualifier_source_value,
       '' as read_code_description,
       '' as gemscript_description,
       e.data_fields         
from native.additional a
  join native.entity e
  on a.enttype = e.code
  left join native.scoringmethod sm
  on a.data3_value = sm.code
  left join native.lookuptype lt4
  on e.data4lkup = lt4.name
  left join native.lookup lu4
  on lt4.lookup_type_id = lu4.lookup_type_id
  and lu4.code = a.data4_value
where a.enttype in (372)
group by e.category, a.enttype, e.description, e.data_fields, sm.scoring_method,
        a.data1_value, lu4.text, e.data4lkup, a.data1_date, e.data1lkup