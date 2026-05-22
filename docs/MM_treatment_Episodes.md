---
layout: default
title: Multiple myeloma treatment Episodes
nav_order: 17
description: "Drug Era Logic"

---
# Multiple myeloma treatment episodes in EPISODE. Creation logic

## 

## Background

Drug data available in observational health databases can be abstracted
on 4 principal levels: drug exposure (single drug administration or
prescription), drug era (continuous drug administration or
prescription), treatment regimen (drugs used in combination with fixed
schedule), line of therapy (several regimens used consecutively united
by one clinical intent). The first two levels exist in our OMOP common
data model (CDM) datasets, and we need an effective way of capturing and
storing lines and regimen.

## Rules applied 

### Rules for Regimen building

1.  The first regimen starts as the first multiple myeloma
    (MM)s-specific drug exposure after or on the day of the first MM
    diagnosis (concept_id = 437233 [Multiple
    myeloma](https://athena.ohdsi.org/search-terms/terms/437233))

2.  All MM-specific drugs (see appendix 1) within 30 days of a regimen
    start are considered part of same regimen (applicable to the first
    and subsequent regimen)

3.  The regimen ends if either:

    1.  A new drug is added after the first 30 days

    2.  Any drug from the first regimen is discontinued (not used for
        more than 90 days), note if other drugs are discontinued within
        30 days of this event, the last event within these 30 days is
        considered the regimen end date.

4.  A new regimen starts as either

    1.  The day after the previous regimen end

    2.  Start of the new drug era, if there was gap between previous
        regimens

5.  Steps 2 – 4 are repeated until all drug eras of drugs of interest
    are covered

6.  Add CAR-T regimens. Currently the CAR-T events are divided into 3
    groups (subject of a discussion):

    1.  'Apheresis' – Apheresis procedure Apheresis date is both start
and end date of the regimen.

        If severeal Apheresis codes appear within one month, take the earliest one.

      3.  CAR-T': drug_exposure_start_date and drug_exposure_end_date are considered a regimen start and end date.

**Apheresis concept_ids:** 927059 “Chimeric antigen receptor T-cell
(CAR-T) therapy; harvesting of blood-derived T lymphocytes for
development of genetically modified autologous CAR-T cells, per day”

**CAR-T** codes are in Appendix 2.

Note, if patient has CAR-T drug codes and CAR-T procedure codes, take the date of drug code, since it's more specific 

7.  Add Transplant regimen. Transplant date is regimen_start_date as
    well as regimen_end_date. If two transplants are given within 180
    days, only the first one is written into regimen. See the list of
    codes in appendix 3.

8.  Regimen source names are the names of drugs or procedures in
    alphabetical order

### Lines of therapy rules

Regimens are combined into lines of therapy using the following rules:

9.  The regimen is marked as Maintenance therapy (will be used as a
    component of line of therapy) when:

    1.  It’s 'bortezomib', 'lenalidomide', 'thalidomide' or 'ixazomib'
        monotherapy, and a previous regimen was polytherapy, and length
        of a previous regimen is more than 30 days, and length of a
        current regimen is more than 60 days, and the current regimen
        starts within 180 days after the previous regimen end.

    2.  If It’s daratumumab monotherapy, apply rules from previous step,
        and additionally a previous regimen should include daratumumab

    3.  It’s any drug monotherapy after the transplant that appears
        within a year after transplantation date.

10. Regimens are grouped into line of therapy when they are:

    1.  HSCT (autologous stem cell transplantation) and therapies that
        surround it, for example: bortezomib, lenalidomide
        (**induction**) then HSCT (**autologous stem cell
        transplantation**) then lenalidomide (**maintenance);**
        Melphalan **(Pre-Transplant Conditioning)** then HSCT.
        
           Sometimes drug data is missing, so we end up with incomplete
            therapies, for example **bortezomib then HSCT**, which
            requires lenalidomide as part of induction therapy (we don't fix it)

    3.  Apheresis, anti-plasma cell treatment (cyclophosphamide,
        fludarabine or cyclophosphamide monotherapy), CAR-T

    4.  Regimen and its corresponding maintenance therapy

    5.  Addition of immunomodulatory (IMIDS = lenalidomide,
        pomalidomide, thalidomide) or proteasome inhibitor drugs (PI =
        bortezomib, carfilzomib, ixazomib) within the first 90 days of
        the previous regimen start, if the previous regimen doesn’t have
        the drugs from the same group (2 IMIDs or 2 PIs can’t be in the
        same line)

    6.  The addition of lenalidomide in 1L to a line that already
        contained cyclophosphamide does not advance the line. Note: this
        addition must occur within 60 days of line start for this rule
        to be applied
    7. Once all lines are defined, we additionaly aggregare two consequtive
       lines into one line where previous line contains Bortezomib + Lenalidomide or Carfilzomib + Lenalidomide or Bortezomib + Thalidomide
       and doesn't contain 'stem cell transplant' and the next line includes stem cell transplant'.
    8. If regimen is not combined with any other lines, it will create a line containing from a single regimen. 

11. Most of the regimen are mapped to HemOnc concepts by matching
    ingredients and populate EPISODE.episode_object_concept_id, if
    there’s no corresponding concept, it was mapped to 0. Procedures are
    mapped as follows:

| **Source Concept Name** | **Target Concept ID** | **Target Concept Name**               |
|-------------------------|-----------------------|---------------------------------------|
| HSCT                    | 4120445               | Hemopoietic stem cell transplant      |
| CAR-T                   | 37557245              | Cellular therapy conditioning regimen |
| Apheresis Aph&CART      | 4132856               | Apheresis                             |
| Apheresis no CART       | 4132856               | Apheresis                             |

12. Line of treatment concepts are mapped to 0, since HemOnc vocabulary
    doesn’t support lines, the value will be only stored in
    episode_source_value as names of regimen in their temporal order
    separated by ‘ then ‘.

13. The start date of line of therapy is the start date of the first
    regimen, the end date of the line of therapy is the end date of the
    last regimen the line is made from.

14. The line of treatment becomes a parent episode of treatment regimen

### Mapping to the EPISODE table

<table>
<colgroup>
<col style="width: 26%" />
<col style="width: 73%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>target column name</strong></th>
<th><strong>logic</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>episode_id</td>
<td>autoincrement</td>
</tr>
<tr class="even">
<td>person_id</td>
<td>drug_era.person_id</td>
</tr>
<tr class="odd">
<td>episode_concept_id</td>
<td>For treatment regimen: 32531-- Treatment Regimen<br />
For lines of therapy: 32941 -- Cancer Drug Treatment -- can't find Line
of Therapy episode concept. this is the closest we have now</td>
</tr>
<tr class="even">
<td>episode_start_date</td>
<td>as described in the logic above</td>
</tr>
<tr class="odd">
<td>episode_start_datetime</td>
<td>NULL</td>
</tr>
<tr class="even">
<td>episode_end_date</td>
<td>as described in the logic above</td>
</tr>
<tr class="odd">
<td>episode_end_datetime</td>
<td>NULL</td>
</tr>
<tr class="even">
<td>episode_parent_id</td>
<td>episode_id of line of therapy which contains this regimen</td>
</tr>
<tr class="odd">
<td>episode_number</td>
<td>based on the order of dates of episodes/lines for a given
patient</td>
</tr>
<tr class="even">
<td>episode_object_concept_id</td>
<td>mapped HemOnc regimen concept or 0 for episodes, 0 for lines of
treatment made from several regimen, mapped HemOnc regimen if line consists from a single regimen</td>
</tr>
<tr class="odd">
<td>episode_type_concept_id</td>
<td>32880-- Standard algorithm</td>
</tr>
<tr class="even">
<td>episode_source_value</td>
<td>for regimen: names of drugs or procedures in alphabetical order
separated by ' ,'<br />
for lines of therapy: names of regimen in their temporal order separated
by ‘ then ‘</td>
</tr>
<tr class="odd">
<td>episode_source_concept_id</td>
<td>0</td>
</tr>
</tbody>
</table>

### Appendix.

## Codesets used

1.  Chemo/immunotherapy drugs:

| concept_id | concept_name                    |
|------------|---------------------------------|
| 740067     | melphalan flufenamide           |
| 741578     | teclistamab                     |
| 746340     | talquetamab                     |
| 746391     | elranatamab                     |
| 902725     | Doxorubicin pegylated liposomal |
| 902728     | Vincristine liposomal           |
| 1301267    | melphalan                       |
| 1308290    | vincristine                     |
| 1310317    | cyclophosphamide                |
| 1336825    | bortezomib                      |
| 1338512    | doxorubicin                     |
| 1350504    | etoposide                       |
| 1361191    | selinexor                       |
| 1395557    | fludarabine                     |
| 1397599    | cisplatin                       |
| 19026972   | lenalidomide                    |
| 19137042   | thalidomide                     |
| 35604032   | elotuzumab                      |
| 35604205   | venetoclax                      |
| 35605744   | daratumumab                     |
| 35606214   | ixazomib                        |
| 36849790   | 4-HYDROXYCYCLOPHOSPHAMIDE       |
| 36858740   | FLUDARABINE F-18                |
| 37002419   | belantamab mafodotin            |
| 37002429   | belantamab                      |
| 37498969   | isatuximab                      |
| 42873638   | carfilzomib                     |
| 43014237   | pomalidomide                    |

2.  CAR-T

| concept_id | concept_name              |
|------------|---------------------------|
| 779144     | ciltacabtagene autoleucel |
| 36026868   | idecabtagene vicleucel    |
| 43018384   | Introduction of Engineered Autologous Chimeric Antigen Receptor T-cell Immunotherapy into Peripheral Vein... |
| 43018388   | 	Introduction of Engineered Autologous Chimeric Antigen Receptor T-cell Immunotherapy into Central Vein...   |

3.  Stem cell Transplant codes

| concept_id | concept_name                                                                                                                                                                                                                                                    |
|------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 2002363    | Autologous hematopoietic stem cell transplant without purging                                                                                                                                                                                                   |
| 2002364    | Allogeneic hematopoietic stem cell transpant without purging                                                                                                                                                                                                    |
| 2002365    | Cord blood stem cell transplant                                                                                                                                                                                                                                 |
| 2002366    | Autologous hematopoietic stem cell transplant with purging                                                                                                                                                                                                      |
| 2002367    | Allogeneic hematopoietic stem cell transplant with purging                                                                                                                                                                                                      |
| 2721124    | Cord blood-derived stem-cell transplantation, allogeneic                                                                                                                                                                                                        |
| 2721125    | Bone marrow or blood-derived stem cells (peripheral or umbilical), allogeneic or autologous, harvesting, transplantation, and related complications; including: pheresis and cell preparation/storage; marrow ablative therapy; drugs, supplies, hospitaliza... |
| 2785921    | Transfusion of Autologous Cord Blood Stem Cells into Central Artery, Percutaneous Approach (Deprecated)                                                                                                                                                         |
| 2785922    | Transfusion of Nonautologous Cord Blood Stem Cells into Central Artery, Percutaneous Approach (Deprecated)                                                                                                                                                      |
| 2785923    | Transfusion of Autologous Hematopoietic Stem Cells into Central Artery, Percutaneous Approach (Deprecated)                                                                                                                                                      |
| 2785924    | Transfusion of Nonautologous Hematopoietic Stem Cells into Central Artery, Percutaneous Approach (Deprecated)                                                                                                                                                   |
| 2788483    | Transfusion of Embryonic Stem Cells into Peripheral Vein, Open Approach (Deprecated)                                                                                                                                                                            |
| 2788671    | Transfusion of Autologous Bone Marrow into Peripheral Vein, Open Approach (Deprecated)                                                                                                                                                                          |
| 2788672    | Transfusion of Nonautologous Bone Marrow into Peripheral Vein, Open Approach (Deprecated)                                                                                                                                                                       |
| 2788699    | Transfusion of Autologous Cord Blood Stem Cells into Peripheral Vein, Open Approach (Deprecated)                                                                                                                                                                |
| 2788700    | Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Vein, Open Approach (Deprecated)                                                                                                                                                             |
| 2788701    | Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Vein, Open Approach (Deprecated)                                                                                                                                                             |
| 2788702    | Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Vein, Open Approach (Deprecated)                                                                                                                                                          |
| 2788703    | Transfusion of Embryonic Stem Cells into Peripheral Vein, Percutaneous Approach                                                                                                                                                                                 |
| 2788704    | Transfusion of Autologous Bone Marrow into Peripheral Vein, Percutaneous Approach                                                                                                                                                                               |
| 2788705    | Transfusion of Nonautologous Bone Marrow into Peripheral Vein, Percutaneous Approach (Deprecated)                                                                                                                                                               |
| 2788732    | Transfusion of Autologous Cord Blood Stem Cells into Peripheral Vein, Percutaneous Approach                                                                                                                                                                     |
| 2788733    | Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Vein, Percutaneous Approach (Deprecated)                                                                                                                                                     |
| 2788734    | Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Vein, Percutaneous Approach                                                                                                                                                                  |
| 2788925    | Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Vein, Percutaneous Approach (Deprecated)                                                                                                                                                  |
| 2788926    | Transfusion of Embryonic Stem Cells into Central Vein, Open Approach (Deprecated)                                                                                                                                                                               |
| 2788927    | Transfusion of Autologous Bone Marrow into Central Vein, Open Approach (Deprecated)                                                                                                                                                                             |
| 2788928    | Transfusion of Nonautologous Bone Marrow into Central Vein, Open Approach (Deprecated)                                                                                                                                                                          |
| 2788955    | Transfusion of Autologous Cord Blood Stem Cells into Central Vein, Open Approach (Deprecated)                                                                                                                                                                   |
| 2788956    | Transfusion of Nonautologous Cord Blood Stem Cells into Central Vein, Open Approach (Deprecated)                                                                                                                                                                |
| 2788957    | Transfusion of Autologous Hematopoietic Stem Cells into Central Vein, Open Approach (Deprecated)                                                                                                                                                                |
| 2788958    | Transfusion of Nonautologous Hematopoietic Stem Cells into Central Vein, Open Approach (Deprecated)                                                                                                                                                             |
| 2788959    | Transfusion of Embryonic Stem Cells into Central Vein, Percutaneous Approach                                                                                                                                                                                    |
| 2788960    | Transfusion of Autologous Bone Marrow into Central Vein, Percutaneous Approach                                                                                                                                                                                  |
| 2788961    | Transfusion of Nonautologous Bone Marrow into Central Vein, Percutaneous Approach (Deprecated)                                                                                                                                                                  |
| 2788988    | Transfusion of Autologous Cord Blood Stem Cells into Central Vein, Percutaneous Approach                                                                                                                                                                        |
| 2789176    | Transfusion of Nonautologous Cord Blood Stem Cells into Central Vein, Percutaneous Approach (Deprecated)                                                                                                                                                        |
| 2789177    | Transfusion of Autologous Hematopoietic Stem Cells into Central Vein, Percutaneous Approach                                                                                                                                                                     |
| 2789178    | Transfusion of Nonautologous Hematopoietic Stem Cells into Central Vein, Percutaneous Approach (Deprecated)                                                                                                                                                     |
| 2789179    | Transfusion of Autologous Bone Marrow into Peripheral Artery, Open Approach (Deprecated)                                                                                                                                                                        |
| 2789180    | Transfusion of Nonautologous Bone Marrow into Peripheral Artery, Open Approach (Deprecated)                                                                                                                                                                     |
| 2789207    | Transfusion of Autologous Cord Blood Stem Cells into Peripheral Artery, Open Approach (Deprecated)                                                                                                                                                              |
| 2789208    | Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Artery, Open Approach (Deprecated)                                                                                                                                                           |
| 2789209    | Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Artery, Open Approach (Deprecated)                                                                                                                                                           |
| 2789210    | Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Artery, Open Approach (Deprecated)                                                                                                                                                        |
| 2789211    | Transfusion of Autologous Bone Marrow into Peripheral Artery, Percutaneous Approach (Deprecated)                                                                                                                                                                |
| 2789212    | Transfusion of Nonautologous Bone Marrow into Peripheral Artery, Percutaneous Approach (Deprecated)                                                                                                                                                             |
| 2789428    | Transfusion of Autologous Cord Blood Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)                                                                                                                                                      |
| 2789429    | Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)                                                                                                                                                   |
| 2789430    | Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)                                                                                                                                                   |
| 2789431    | Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)                                                                                                                                                |
| 2789432    | Transfusion of Autologous Bone Marrow into Central Artery, Open Approach (Deprecated)                                                                                                                                                                           |
| 2789433    | Transfusion of Nonautologous Bone Marrow into Central Artery, Open Approach (Deprecated)                                                                                                                                                                        |
| 2789460    | Transfusion of Autologous Cord Blood Stem Cells into Central Artery, Open Approach (Deprecated)                                                                                                                                                                 |
| 2789461    | Transfusion of Nonautologous Cord Blood Stem Cells into Central Artery, Open Approach (Deprecated)                                                                                                                                                              |
| 2789462    | Transfusion of Autologous Hematopoietic Stem Cells into Central Artery, Open Approach (Deprecated)                                                                                                                                                              |
| 2789463    | Transfusion of Nonautologous Hematopoietic Stem Cells into Central Artery, Open Approach (Deprecated)                                                                                                                                                           |
| 2789464    | Transfusion of Autologous Bone Marrow into Central Artery, Percutaneous Approach (Deprecated)                                                                                                                                                                   |
| 2789465    | Transfusion of Nonautologous Bone Marrow into Central Artery, Percutaneous Approach (Deprecated)                                                                                                                                                                |
| 4028623    | Transplantation of bone marrow                                                                                                                                                                                                                                  |
| 4059885    | Autologous bone marrow transplant without purging                                                                                                                                                                                                               |
| 4081380    | Peripheral blood stem cell graft                                                                                                                                                                                                                                |
| 4083057    | Cord cell transfusion                                                                                                                                                                                                                                           |
| 4120445    | Hemopoietic stem cell transplant                                                                                                                                                                                                                                |
| 4121104    | Syngeneic bone marrow transplant                                                                                                                                                                                                                                |
| 4122920    | T-cell depleted allogeneic bone marrow graft                                                                                                                                                                                                                    |
| 4125486    | Imperfect T-cell depleted allogeneic bone marrow graft                                                                                                                                                                                                          |
| 4125487    | Allogeneic related bone marrow transplant                                                                                                                                                                                                                       |
| 4125488    | Allogeneic unrelated bone marrow transplant                                                                                                                                                                                                                     |
| 4139690    | Grafting of cord blood to bone marrow                                                                                                                                                                                                                           |
| 4142405    | Allograft of bone marrow from sibling donor                                                                                                                                                                                                                     |
| 4143404    | Allogeneic peripheral blood stem cell transplant                                                                                                                                                                                                                |
| 4144157    | Autologous peripheral blood stem cell transplant                                                                                                                                                                                                                |
| 4144882    | Allograft of bone marrow from matched unrelated donor                                                                                                                                                                                                           |
| 4145532    | Allograft of cord blood to bone marrow                                                                                                                                                                                                                          |
| 4186582    | Autologous bone marrow transplant with purging                                                                                                                                                                                                                  |
| 4240337    | Autologous bone marrow transplant                                                                                                                                                                                                                               |
| 4242257    | Allogeneic bone marrow transplantation                                                                                                                                                                                                                          |
| 37152106   | High-dose chemotherapy with stem cell transplant                                                                                                                                                                                                                |
| 40484034   | Grafting of bone marrow using allograft from unmatched unrelated donor                                                                                                                                                                                          |
| 40486968   | Allogeneic bone marrow transplantation with purging                                                                                                                                                                                                             |
| 40492289   | Allogeneic bone marrow transplantation without purging                                                                                                                                                                                                          |
| 44514755   | Other specified graft of bone marrow                                                                                                                                                                                                                            |
| 44515878   | Other specified graft of cord blood stem cells to bone marrow                                                                                                                                                                                                   |
| 44783964   | Syngeneic peripheral blood stem cell transplantation                                                                                                                                                                                                            |
| 44790154   | Allograft of bone marrow from haploidentical donor                                                                                                                                                                                                              |
| 44793170   | Allograft of bone marrow from unmatched unrelated donor                                                                                                                                                                                                         |
| 46271079   | Transplantation of autologous hematopoietic stem cell                                                                                                                                                                                                           |
