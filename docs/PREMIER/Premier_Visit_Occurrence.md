---
title: "Visit Occurrence"
author: "Andryc, A; Fortin, S"
parent: Premier
nav_order: 19
layout: default
---

# Table Name: VISIT_OCCURRENCE

Premier data are visit oriented; thus, each visit has its own unique visit identifier. The PAT table includes admission date and discharge date for each visit. Each visit is stored as a date but the day of the stay is always coded as the first of the month. Because a person can have more than one visit in the same year-month combination, an additional field is included to preserve the order of visits because the day of month is unavailable. The field PAT.DISC_MON_SEQ is included to preserve the order of visits based on discharge order. The LOS field on the PAT table is populated for inpatient stays and is recorded as the number of 24 hour increments that a patient spends in the hospital. The LOS field is usually off by one calendar day for inpatient visits. Outpatient visits have a LOS of 0 and are typically only one day in length which is represented in the billing tables. For about 6% of outpatient visits, a single visit is comprised of multiple procedures that occur on different days for procedures such as chemotherapy or dialysis. The Premier billing system does not separate these into individual visits and for purposes of the ETL these will be considered one continuous visit. The PATBILL table houses billing records that occur each calendar day during the visit. Some visits may include a service day record of zero, which are considered pre-visit tests or procedures. For the purposes of the ETL, the information is considered as the first day of the visit, which can occur for inpatient and outpatient stays. The length of the stay is determined by the PAT_BILL table using the field SERV_DAY. 

VISIT_OCCURRENCE logic was revised in September 2020 to utilize READMIT.DAYS_FROM_PRIOR which reports the exact number of days between the discharge date of an inpatient stay and the admission date of the subsequent inpatient stay.  When building VISIT_OCCURRENCE records for an individual person the following 5 variables are leveraged:

 - MEDREC_KEY:  Identifies the specific person.
 - PAT_KEY:  Identified a specific visit for a specific person.
 - DISC_MON:  Identifies, the year, quarter and month at which the discharge took place.
 - DISC_MON_SEQ:  For individuals whom have more >1 discharge in a single DISC_MON, this attribute provides the sequence in which those discharges occurred.
 - DAYS_FROM_PRIOR:  This attribute defines the number of days between discharges.
 - MAX(SERV_DAY) – 1:  This is the maximum number of service days for all services received ruing an inpatient stay.

Records should be filtered by MEDREC_KEY and then ordered by DISC_MON and DISC_MON_SEQ in Descending order.  The most recent VISIT_END_DATE should be set to the last day of the month for which the DISC_MON refers.  This will serve as an anchor point for the rest of the visits, ensuring that the temporality of the data is kept.

VISIT_START_DATE for that same record should be the DISCHARGE_DATE – (MAX(SERV_DAY) – 1).

To calculate the VISIT_END_DATE for the preceding record, take the (VISIT_START_DATE - DAYS_FROM_PRIOR).

To handle errors in the data the following rules must also be incorporated:

 - When DAYS_FROM_PRIOR is negative, set DAYS_FROM_PRIOR = 0
 - When SERV_DAY is negative, set SERV_DAY = 0
 - When DAYS_FROM_PRIOR is blank or NULL, set DAYS_FROM_PRIOR = 0
 - When SERV_DAY is blank or NULL, set SERV_DAY = 0

Note that with this update there will be instances with the calculate VISIT_END_DATE does not match what is expected from DISC_MON.  This is a variance we will evaluate and add to this document in the future.

Logic for ER stays is varied due to data changes from Premier in identifying ER visits. ER Visits in Premier are identified through point of origin or admission source. If a patient visits the ER and then leaves, the visit is considered ER. If an inpatient stay results from an ER visit, that is identified as an ER-to-Inpatient stay. Inpatient stays and outpatient stays with no associated ER visit are simply consider inpatient and outpatient stays, respectively. Additional logic has been added to constrain dates and fields which reflect changes in Premier’s classification of emergency room visits. In Premier, the value of admission source that designates emergency room was discontinued 7/1/2010 because it no longer was a required variable for CMS. Point of origin represents the last physical location of a patient before entering the hospital. This field is populated in Premier after 7/1/2010 with emergency room visits. Thus, a combination of point of origin, admission source, and admission type is used to determine if a patient had a valid ER stay for Premier. LOS, the length of stay field, is not used because each billing record corresponds to a service day in the PATBILL table.

Admitting and discharge information is captured in Premier as the place of service from which the patient arrived and the place to service to which the patient is discharged.

TODO: The READMIT table includes the field READMIT.DAYS_FROM_PRIOR, which reports the exact number of days between the discharge date of an inpatient stay and the admission date of the subsequent inpatient stay. Build into visit logic to accurately assign number of days between visits. The visit_occurrence logic described above estimates this value. When patients are discharged from inpatient visits twice in the same month, the visit_occurrence logic assumes a single day gap between visits, which underestimates the true number of days between visits by -0.9085 days on average. Conversely, for discharges that happen in difference months, the visit_occurrence logic overestimates the true number of days between visits by 0.9333 days. Across all inpatient visits, the visit_occurrence logic slightly overestimates the true number of days between visits by 0.3098 days. 80% of the visit_occurrence logic estimates are approximately +/- 2 weeks of the true value, and outliers are observed. 20% of the intervals are >2 weeks which is likely unacceptable precision for readmission studies. We will build READMIT.DAYS_FROM_PRIOR into the ETL in an upcoming sprint. The query for evaluating the correspondence between the visit_occurrence algorithm and READMIT.DAYS_FROM_PRIOR is below.

|Destination Field|Source Field|Applied Rule|Comment|
|---|---|---|---|
|VISIT_OCCURRENCE_ID|PAT.PAT_KEY|
|PERSON_ID|PAT.MEDREC_KEY|
|VISIT_CONCEPT_ID||When PAT.ADM_DATE <= ‘6/1/2010’ and ADM_SOURCE=7 and I_O_IND =’O’ then concept_id=9203<br>When PAT.ADM_DATE <= ‘6/1/2010’ and ADM_SOURCE=7 and I_O_IND =’I’ then concept_id=262<br>When PAT.ADM_DATE >= ‘7/1/2010’ and (POINT_OF_ORIGIN=7 or ADM_SOURCE =1) and I_O_IND =’O’ then concept_id=9203<br>When PAT.ADM_DATE >= ‘7/1/2010’ and (POINT_OF_ORIGIN=7 or ADM_SOURCE =1) and I_O_IND =’I’ then concept_id=262<br>When  I_O_IND =’I’ then concept_id=9201<br>When I_O_IND =’O’ then concept_id=9202||
|VISIT_START_DATE|PAT.ADM_DATE <br>PATBILL.SERV_DAY<br>PAT.DISC_MON_SEQ|||
|VISIT_START_DATETIME||||
|VISIT_END_DATE|PAT.DISC_DATE<br>PATBILL.SERV_DAY<br>PAT.DISC_MON_SEQ|||
|VISIT_END_DATETIME||||
|VISIT_TYPE_CONCEPT_ID| - | All records within the visit_occurence table should have a visit_type_concept_id = 32875 (Provider financial system) | |
|PROVIDER_ID|PAT.ADM_PHY|||
|CARE_SITE_ID|PAT.PROV_ID|||
|VISIT_SOURCE_VALUE|PAT.I_O_IND|||
|VISIT_SOURCE_CONCEPT_ID|-|||
|ADMITTING_SOURCE_CONCEPT_ID|PAT.POINT_OF_ORIGIN|if POINT_OF_ORIGIN then ADMITTING_SOURCE_CONCEPT_ID<br>0 then 8976<br>1 then 8844<br>2 then 8716<br>3 then 8844<br>4 then 8717<br>45 then 581384<br>46 then 8650<br>5 then 8863<br>6 then 8844<br>7 then 8870<br>8 then 8844<br>9 then 8844<br>A then 8761<br>B then 8536<br>C then 8536<br>D then 8717<br>E then 8883<br>F then 8546<br>||
|ADMITTING_SOURCE_VALUE|PAT. POINT_OF_ORIGIN|PAT. POINT_OF_ORIGIN||
|DISCHARGE_TO_CONCEPT_ID|PAT.DISC_STATUS|If DISC_STATUS then DISCHARGE_TO_CONCEPT_ID<br>1 then 8536, 2 then 8844<br>3 then 8863, 4 then 8863<br>5 then 8844, 6 then 8536<br>7 then 8844, 8 then 8536<br>9 then 8717, 20 then NULL<br>21 then 8844, 30 then 8844<br>40 then 8546, 41 then 8546<br>42 then 8546, 43 then 8966<br>50 then 8546, 51 then 8546<br>61 then 8863, 62 then 8920<br>63 then 8970, 64 then 8676<br>65 then 8971, 66 then 581379<br>69 then 8844, 70 then 8844<br>71 then 8844, 72 then 8717<br>81 then 8536, 82 then 581379<br>83 then 8863, 84 then 8827<br>85 then 8844, 86 then 8536<br>87 then 8844, 88 then 8966<br>89 then 8863, 90 then 581379<br>91 then 581379, 92 then 8676<br>93 then 8971, 94 then 581379<br>95 then 8844, 99 then 8844<br>||
|DISCHARGE_TO_SOURCE_VALUE|PAT.DISC_STATUS|PAT.DISC_STATUS||
|PRECEDING_VISIT_OCCURRENCE_ID|VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID|For a given person, find the visit prior to this one and reference it here|A foreign key to the VISIT_OCCURRENCE table of the visit immediately preceding this visit|


## Date fit logic

The code below creates a date fit scoring rubric in which the logic above is deployed, each discharge date possibility is then tested and the results are then scored on a weighted scale.  1 point for getting the month correct and 2 points for getting the year correct.  The most recent discharge date with the highest score is then selected and all prior visit dates are calculated based on that date.

```r
library(DatabaseConnector)
library(lubridate)

connectionDetails <- createConnectionDetails(dbms = "",
                                             server = "",
                                             extraSettings = "",
                                             port = ,
                                             user = "",
                                             password = "")
conn <- connect(connectionDetails)

visitRecordsRaw <- dbGetQuery(conn = conn,
                              statement = "select p.medrec_key, p.pat_key, p.adm_mon, p.adm_date, p.disc_mon, p.disc_date, p.disc_mon_seq, p.i_o_ind, max(serv_day) as max_serv_day, r.days_from_prior, r.days_from_index
from native.pat p
join native.patbill pb on p.pat_key = pb.pat_key
join native.readmit r on (r.medrec_key = p.medrec_key AND r.pat_key = p.pat_key)
where p.medrec_key = -104556548
group by p.medrec_key, p.pat_key, p.adm_mon, p.adm_date, p.disc_mon, p.disc_date, p.disc_mon_seq, p.i_o_ind, r.days_from_prior, r.days_from_index
                              order by disc_mon ASC, disc_mon_seq ASC;")

numberOfVisits <- nrow(visitRecordsRaw)

#Reshuffles order of visits for a person if the order sorted by disc_mon and disc_mon_seq do not align with days_from_index.
checkPass <- 1
daysFromIndexCounter <- numberOfVisits
while(checkPass == 1){
  if (visitRecordsRaw$days_from_index[daysFromIndexCounter] >= visitRecordsRaw$days_from_index[daysFromIndexCounter - 1]){
    print("days_from_index test passed")
    checkPass = 1
  }else{
    checkPass = 0
    print("days_from_index reshuffle")
    visitRecordsRaw <- visitRecordsRaw[order(visitRecordsRaw$days_from_index),]
  }
  daysFromIndexCounter <- daysFromIndexCounter - 1
}

estDates <- data.frame(visitRecordsRaw$adm_date, visitRecordsRaw$disc_date)
colnames(estDates) <- c("est_adm_date", "est_disc_date")
visitRecordsRaw <- cbind(visitRecordsRaw,estDates)
rm(estDates)


estimatedMostRecentDiscDate <- (visitRecordsRaw$disc_date[numberOfVisits] %m+% months(1)) - days(1)

#while(estimatedMostRecentDiscDate != visitRecordsRaw$disc_date[numberOfVisits]){
while(estimatedMostRecentDiscDate > as.Date("2004-08-30",origin="yyyy-mm-dd")){
  
  visitRecordsRaw$est_disc_date[numberOfVisits] <- as.Date(estimatedMostRecentDiscDate,origin="yyyy-mm-dd")
  
  #This IF statement account for a max serve day of 0.  If we don't adjust for this, we end up with admission dates that are after discharge dates.
  if(visitRecordsRaw$max_serv_day[numberOfVisits] == 0){
    estimatedMostRecentAdmDate <- estimatedMostRecentDiscDate - visitRecordsRaw$max_serv_day[numberOfVisits]
  }else{
    estimatedMostRecentAdmDate <- estimatedMostRecentDiscDate - visitRecordsRaw$max_serv_day[numberOfVisits] + 1
  }
  
  estimatedMostRecentAdmDate <- estimatedMostRecentDiscDate - visitRecordsRaw$max_serv_day[numberOfVisits] + 1
  visitRecordsRaw$est_adm_date[numberOfVisits] <- estimatedMostRecentAdmDate
  
  visitPos <- numberOfVisits - 1
  
  while(visitPos > 0){
    
    estimatedDiscDate <- visitRecordsRaw$est_adm_date[visitPos + 1] - visitRecordsRaw$days_from_prior[visitPos + 1]
    
    #Tests to ensure estimated date is within 1 months of disc_date provided
    if(estimatedDiscDate >= visitRecordsRaw$disc_date[visitPos] + 32 || estimatedDiscDate <= visitRecordsRaw$disc_date[visitPos] - 32){
      estimatedDiscDate <- as.Date(paste0(year(visitRecordsRaw$disc_date[visitPos]),"-",month(visitRecordsRaw$disc_date[visitPos]),"-29"),origin="yyyy-mm-dd")
      visitRecordsRaw$est_disc_date[visitPos] <- estimatedDiscDate
      print("Data issue")
    }else{
      visitRecordsRaw$est_disc_date[visitPos] <- estimatedDiscDate
    }
    
    estimatedAdmDate <- estimatedDiscDate - visitRecordsRaw$max_serv_day[visitPos] + 1
    
    #This IF statement account for a max serve day of 0.  If we don't adjust for this, we end up with admission dates that are after discharge dates.
    if(visitRecordsRaw$max_serv_day[visitPos] == 0){
      estimatedAdmDate <- estimatedDiscDate - visitRecordsRaw$max_serv_day[visitPos]
    }else{
      estimatedAdmDate <- estimatedDiscDate - visitRecordsRaw$max_serv_day[visitPos] + 1
    }
    
    #Tests to ensure estimated date is within 1 months of adm_date provided
    if(estimatedAdmDate >= visitRecordsRaw$adm_date[visitPos] + 32 || estimatedAdmDate <= visitRecordsRaw$adm_date[visitPos] - 32){
      estimatedAdmDate <- as.Date(paste0(year(visitRecordsRaw$adm_date[visitPos]),"-",month(visitRecordsRaw$adm_date[visitPos]),"-15"),origin="yyyy-mm-dd")
      visitRecordsRaw$est_adm_date[visitPos] <- estimatedAdmDate
      print("Data issue")
    }else{
      visitRecordsRaw$est_adm_date[visitPos] <- estimatedAdmDate 
    }
    
    visitPos = visitPos - 1
  }
  
  #Creates scoring rubric
  for(i in 1:nrow(visitRecordsRaw)){
    
    if(exists("monthCount") == FALSE){
      monthCount <- c(identical(month(visitRecordsRaw$disc_date[i]),month(visitRecordsRaw$est_disc_date[i])))
    }
    else{
      monthCount <- c(monthCount,identical(month(visitRecordsRaw$disc_date[i]),month(visitRecordsRaw$est_disc_date[i])))  
    }
    
    if(exists("yearCount") == FALSE){
      yearCount <- c(identical(year(visitRecordsRaw$disc_date[i]),year(visitRecordsRaw$est_disc_date[i])))
    }
    else{
      yearCount <- c(yearCount,identical(year(visitRecordsRaw$disc_date[i]),year(visitRecordsRaw$est_disc_date[i])))  
    }
    
  }
  
  dateScore <- sum(monthCount) + sum(yearCount*2) #Totals score
  
  #Records Score
  if(exists("scoringFrame") == FALSE){
    scoringFrame <- data.frame(as.Date(visitRecordsRaw$est_disc_date[numberOfVisits],origin="yyyy-mm-dd"), dateScore)
  }else{
    scoringFrame <- rbind(scoringFrame,data.frame(as.Date(visitRecordsRaw$est_disc_date[numberOfVisits],origin="yyyy-mm-dd"), dateScore))
  }
  
  rm(monthCount)
  rm(yearCount)
  
  estimatedMostRecentDiscDate <- as.Date(estimatedMostRecentDiscDate - 1)
  
}


colnames(scoringFrame) <- c("est_disc_date","dateScore")
bestScore <- scoringFrame[which.max(scoringFrame$dateScore),]
print(bestScore$est_disc_date)
```

## Change Log:
* 2021.08.11:  Updated VISIT_TYPE_CONCEPT_ID to leverage standard concept id.
