--Query to create an intermediate table that will facilitate mapping of the CPRD test table


SELECT top 100 --This is for example, remove the top 100 when performing a full transformation
       t.patid,
       t.eventdate,
       t.constype,
       t.consid,
       t.staffid,
       m.read_code,
       m.description as read_description,
       CAST(e.code as varchar)||'-'||e.description as map_value,       
       e.code as enttype,
       e.description as enttype_desc,
       e.data_fields,
       case when t.data1 <> 0 --In this case 0 means 'data not entered' so it is set to blank
        then l.text else '' end as operator, --Data1 is the coded operator (<,>,=,>=,<=). The join on line 29 looks up the text value and stores that here. 
       t.data2 as value_as_number,
       case when t.data3 <> 0 then l2.text --Here the number 0 means 'data not entered' so it is set to blank
         when e.code = 284 and (t.data2 is not null and t.data2 <> 0) then 'week' --Enttype (code) 284 refers to gestational age in weeks so the unit is hard coded
         else '' end as unit, --Data3 is the coded unit of the laboratory test. The join on line 32 looks up the text value and stores that here.
       case when t.data4 <> 0 then l3.text else '' end as value_as_concept_id, --In this case 0 means 'data not entered' so it is set to blank. Data4 is the coded qualifier (high,low). The join on line 35 looks up the text value and stores that value here.
       t.data5 as range_low,
       t.data6 as range_high     
FROM native_1224.test t
JOIN native_1224.entity e
  ON t.enttype = e.code
JOIN native_1224.medical m
  ON t.medcode = m.medcode
JOIN native_1224.lookup l
  ON t.data1 = l.code
  AND l.lookup_type_id = 56 /*OPR - Operator*/
JOIN native_1224.lookup l2
  ON t.data3 = l2.code
  AND l2.lookup_type_id = 83 /*SUM - Specimen Unit of Measure*/
JOIN native_1224.lookup l3
  ON t.data4 = l3.code
  AND l3.lookup_type_id = 85 /*TQU - Test Qualifier*/ 
WHERE e.data_fields in (7,8) --When data_fields equals 7 or 8 then both operators and units may be present. 

UNION

SELECT top 100 --This is for example, remove the top 100 when performing a full transformation
       t.patid,
       t.eventdate,
       t.constype,
       t.consid,
       t.staffid,
       m.read_code,
       m.description as read_description,
       CAST(e.code as varchar)||'-'||e.description as map_value,
       e.code as enttype,
       e.description as enttype_desc,
       e.data_fields,
       '' as operator,
       NULL as value_as_number,
       '' as unit,
       case when t.data1 <> 0 then l.text else '' end as value_as_concept_id, --In this case 0 means 'data not entered' so it is set to blank. Data1 is the coded value for the qualifier (high,low) so the join on line 64 looks up the value and stores the text here.
       t.data2 as range_low,
       t.data3 as range_high     
FROM native_1224.test t
JOIN native_1224.entity e
  ON t.enttype = e.code
JOIN native_1224.medical m
  ON t.medcode = m.medcode
JOIN native_1224.lookup l
  ON t.data1 = l.code
  AND l.lookup_type_id = 85 /*TQU - Test Qualifier*/ 
WHERE e.data_fields = 4 --When data_fields equals 4 then only the value of the text and qualifier is available.

