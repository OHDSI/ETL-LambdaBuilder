---
layout: default
title: Drug Era Logic
nav_order: 16
description: "Drug Era Logic"

---

# Standard Drug Eras and How they are built

A Drug Era is defined as a span of time when the Person is assumed to be exposed to a particular active ingredient. A Drug Era is not the same as a Drug Exposure: Exposures are individual records corresponding to the source when Drug was delivered to the Person, while successive periods of Drug Exposures are combined under certain rules to produce continuous Drug Eras. To create Drug Eras, Drug Concepts in the DRUG_EXPOSURE table are mapped to active ingredients. Then, Drug Exposures to the same ingredient are strung together if they have <= 30 days between them. 

The Drug Era Start Date is the start date of the first Drug Exposure for a given ingredient, with at least 31 days since the previous exposure.

The Drug Era End Date is the end date of the last Drug Exposure. The End Date of each Drug Exposure is either taken from the field DRUG_EXPOSURE.drug_exposure_end_date or, as it is typically not available, inferred using the following rules: For pharmacy prescription data, the date when the drug was dispensed plus the number of days of supply are used to extrapolate the End Date for the Drug Exposure. Depending on the country-specific healthcare system, this supply information is either explicitly provided in the day_supply field or inferred from package size or similar information. For Procedure Drugs, usually the drug is administered on a single date (i.e., the administration date). A standard Persistence Window of 30 days (gap, slack) is permitted between two subsequent such extrapolated DRUG_EXPOSURE records to be considered to be merged into a single Drug Era.

The SQL script for generating DRUG_ERA records can be found [here](https://ohdsi.github.io/CommonDataModel/sqlScripts.html#drug_eras).

## ETL-LambdaBuilder Implementation

The ETL-LambdaBuilder creates Drug Eras through a 4-step process that handles various scenarios for determining drug exposure dates, particularly when explicit end dates are not available.

### Step 1: Normalize Drug Exposure End Dates

The first step normalizes drug exposure end dates using a COALESCE cascade. When an explicit `drug_exposure_end_date` is not available, the algorithm attempts to calculate it from the `days_supply` field, with a default fallback:

```sql
COALESCE(
  drug_exposure_end_date,
  drug_exposure_start_date + (INTERVAL '1 day' * days_supply),
  drug_exposure_start_date + INTERVAL '1 day'
)
```

**Days Supply Scenarios:**

| Scenario | days_supply Value | Calculation | Result |
|----------|-------------------|-------------|--------|
| **Explicit End Date** | Any | N/A | Uses `drug_exposure_end_date` directly |
| **Valid Days Supply** | 30 | start_date + 30 days | Ends 30 days after start |
| **NULL Days Supply** | NULL | Falls through COALESCE | Default to start_date + 1 day |
| **Zero Days Supply** | 0 | start_date + (0 days) → NULL | Falls through to default 1-day exposure |
| **Negative Days Supply** | -5 | start_date + (-5 days) | Creates end_date **before** start_date ⚠️ |

**Important Notes:**
- When `days_supply` is 0, the NULLIF comparison (start + 0 days = start) evaluates to NULL, causing the COALESCE to fall through to the default 1-day exposure.
- Negative `days_supply` values create invalid date ranges (end_date < start_date), which can break downstream joins and era calculations. The ETL-LambdaBuilder currently allows these values; data quality validation is recommended before processing.

### Step 2: Collapse Overlapping Exposures

The second step uses window functions to identify and group overlapping drug exposures for the same ingredient. Exposures that overlap or are adjacent are grouped together as sub-exposures:

```sql
ROW_NUMBER() OVER (
  PARTITION BY person_id, drug_concept_id 
  ORDER BY drug_exposure_start_date
) - ROW_NUMBER() OVER (
  PARTITION BY person_id, drug_concept_id, overlapping_group
  ORDER BY drug_exposure_start_date
) AS exposure_group
```

This creates sequential groups for continuous or overlapping exposure periods.

### Step 3: Apply 30-Day Persistence Window

The third step applies a 30-day gap tolerance (persistence window). Exposure groups are padded by 30 days to identify natural gaps:

- Each normalized exposure end date is extended by 30 days
- If the next exposure starts before this padded end date, the two exposures are merged into a single era
- If there is a gap of 31 days or more, a new era begins

### Step 4: Create Final Eras and Calculate Gap Metrics

The final step creates the actual `DRUG_ERA` records and calculates the `gap_days` metric:

```sql
gap_days = (era_end_date - era_start_date) - SUM(days_exposed)
```

Where:
- **era_end_date** = end date of the last exposure in the era
- **era_start_date** = start date of the first exposure in the era
- **SUM(days_exposed)** = total calendar days covered by all exposures in the era

This metric provides insight into gaps within the era due to the 30-day persistence window allowing for lapsed periods.