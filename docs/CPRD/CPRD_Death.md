---
layout: default
title: Death
nav_order: 10
parent: CPRD
description: "Death Logic"

---

# CDM Table: DEATH

If deathdate is populated with a date in the Patient table then the patient will be included in the Death table.  CPRD created an algorithm to create this deathdate field.  We will rely on this already performed algorithm to identify death in the CDM.   

The algorithm utilizes the following:

1.  transfer out date (tod) where the toreason=1 or 'death'
2. Event date for records in the clinical file (only) which have one of the Read codes in our "Statement of Death" Read code set 
3. Event date for the clinical record associated with a record in the 'Death Administration' structured data area (entity 148)
4. The date of death (dod) recorded in data1 field of the 'Death Administration' structured data area (entity 148)
 The algorithm also will:
1.  Ignore death dates prior to the database inception (<01 Jan 1987)
2.  For #2 above -- where present -- require the following
    must be supported by death information in at least one of the other 2 sources 
    frd < DOD eventdate < practice lcd
    event date must be wtihin 95 days of a valid tod
3. #3/4 above (note that these are processed together) -- ignore event dates and dod if < frd and /or > practice lcd
    DOD = earliest of (dod, event date)
Per CPRD the mortality recording in CPRD (deathdate in the patient file) is highly accurate when confirming death and has good concordance between CPRD and the ONS (Office of National Statistics) mortality data which can be linked to CPRD for a select population. The ONS data is likely to be more accurate than the CPRD death algorithm though approximately 5% of deaths are registered within 1 to 2 years after the actual death occurs.  This means that there can be missing deaths in ONS in the most recently available calendar time frame and that this gets corrected as time progresses.  As a result, the CPRD algorithms are likely better in more recent calendar time.  In terms of the deathdate algorithm, error may be introduced from the fact that GPs use the Statement of Death (SoD) read codes to record deaths and also the deaths of loved ones.  So the death being referred to might not be the death of the patient.  For this reason, the current CPRD death algorithm requires the GP to transfer the patient out of the practice within 95 days of a SoD code.   
Per CPRD cause-specific mortality is not reliably recorded in the General Practice data.  


**Destination Field**|**Source Field**|**Applied Rule**|**Comment**
:-----:|:-----:|:-----:|:-----:
PERSON_ID|Patient.Patid||
DEATH_DATE|Patient.Deathdate|
DEATH_DATETIME|Set time to 00:00:00 UTC Tz||
DEATH_TYPE_CONCEPT_ID|32815 (Death Certificate)
CAUSE_OF_DEATH_CONCEPT_ID|0||
CAUSE_OF_DEATH_SOURCE_VALUE|0||
CAUSE_SOURCE_CONCEPT_ID|0||