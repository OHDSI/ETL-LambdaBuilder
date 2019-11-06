--Query to get specialities and counts from CPRD

SELECT role as source_code, 
       l.text as source_code_description, 
       COUNT(*) as frequency
FROM native.staff s
JOIN native.lookup l
  ON s.role = l.code
  AND lookup_type_id = 76
GROUP BY role, l.text