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