SELECT
  b.prodcode,
  b.ndd,
  b.qty,
  b.numpacks,
  b.numdays
FROM (SELECT
  *,
  ROW_NUMBER() OVER (PARTITION BY prodcode, ndd, qty, numpacks ORDER BY daycount DESC) AS RowNumber
FROM (SELECT
  prodcode,
  ISNULL(d.daily_dose, 0) AS ndd,
  ISNULL(qty, 0) AS qty,
  ISNULL(numpacks, 0) AS numpacks,
  numdays,
  COUNT(prodcode) AS daycount
FROM {sc}.therapy t
LEFT OUTER JOIN {sc}.commondosages d
  ON t.dosageid = d.dosageid
WHERE (numdays > 0
AND numdays <= 365)
AND prodcode > 1
GROUP BY prodcode,
         ISNULL(d.daily_dose, 0),
         ISNULL(qty, 0),
         ISNULL(numpacks, 0),
         numdays) a) b
WHERE RowNumber = 1

UNION ALL

SELECT
  b.prodcode,
  -1,
  -1,
  -1,
  b.numdays
FROM (SELECT
  a.prodcode,
  a.numdays,
  a.daycount,
  ROW_NUMBER() OVER (PARTITION BY a.prodcode ORDER BY a.prodcode, a.daycount DESC) AS RowNumber
FROM (SELECT
  prodcode,
  numdays,
  COUNT(patid) AS daycount
FROM {sc}.therapy
WHERE (numdays > 0
AND numdays <= 365)
AND prodcode > 1
GROUP BY prodcode,
         numdays) a) b
WHERE RowNumber = 1