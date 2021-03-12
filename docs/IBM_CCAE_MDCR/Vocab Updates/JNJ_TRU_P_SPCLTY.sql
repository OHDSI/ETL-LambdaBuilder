--Query to find frequencies of STDPROV (provider specialty) variable in IBM databases.
---Remove LAB and add LONG_TERM_CARE when running this for IBM MDCD

select sum(freq), stdprov
from(
  SELECT count(*) as freq, STDPROV
  FROM FACILITY_HEADER
  group by stdprov
  UNION
  SELECT count(*) as freq, STDPROV
  FROM OUTPATIENT_SERVICES
  group by stdprov
  UNION
  SELECT count(*) as freq, STDPROV
  FROM INPATIENT_SERVICES
  group by stdprov
  UNION
  SELECT count(*) as freq, STDPROV
  FROM LAB
  group by stdprov
) a
group by stdprov