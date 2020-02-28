--Query to count and group record from the TEST table in order to map them to MEASUREMENT concepts using usagi

SELECT count(*),
       CAST(e.code as varchar)||'-'||e.description as source_value,       
       e.code,
       e.description
FROM native.test t
JOIN native.entity e
  ON t.enttype = e.code
GROUP BY e.code, e.description