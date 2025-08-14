---

layout: default

title: Multiple myeloma treatment Episodes

nav\_order: 17

description: "Drug Era Logic"



---





Multiple Myeloma - Line of Therapy Algorithm

============================================



Background

----------



Drug data available in observational health databases can be abstracted on 4 principal levels: drug exposure (single drug administration or prescription), drug era (continuous drug administration or prescription), treatment regimen (drugs used in combination with fixed schedule), line of therapy (several regimens used consecutively united by one clinical intent). The first two levels exist in our OMOP common data model (CDM) datasets, and we need an effective way of capturing and storing lines and regimen.



Rules applied

-------------



\### Rules for Regimen building



1\.  The first regimen starts as the first multiple myeloma (MM)s-specific drug exposure after or on the day of the first MM diagnosis (concept\\\_id = 437233 \[Multiple myeloma](https://athena.ohdsi.org/search-terms/terms/437233))

2\.  All MM-specific drugs (see appendix 1) within 30 days of a regimen start are considered part of same regimen (applicable to the first and subsequent regimen)

3\.  The regimen ends if either:

&nbsp;   1.  A new drug is added after the first 30 days

&nbsp;   2.  Any drug from the first regimen is discontinued (not used for more than 90 days), note if other drugs are discontinued within 30 days of this event, the last event within these 30 days is considered the regimen end date.

4\.  A new regimen starts as either

&nbsp;   1.  The day after the previous regimen end

&nbsp;   2.  Start of the new drug era, if there was gap between previous regimens

5\.  Steps 2 - 4 are repeated until all drug eras of drugs of interest are covered

6\.  Add CAR-T regimens. Currently the CAR-T events are divided into 3 groups (subject of a discussion):

&nbsp;   1.  ‘Apheresis Aph\&CART’ - when both Apheresis procedure and CAR-T injection event are present in the data. Apheresis date is both start and end date of the regimen.

&nbsp;   2.  ‘CAR-T’: drug\\\_exposure\\\_start\\\_date and drug\\\_exposure\\\_end\\\_date are considered a regimen start and end date.

&nbsp;   3.  ‘Apheresis no CART’: Apheresis procedure is documented, but the CAR-T is not. Apheresis date is both start and end date of the regimen. Later both ‘Apheresis Aph\&CART’ and ‘Apheresis no CART’ are mapped to the same Apheresis concept, but it’s reflected in episode\\\_source\\\_value, so we can track the Apheresis procedures which don’t have CAR-T infusion afterwards. Apheresis concept\\\_ids: 927059 “Chimeric antigen receptor T-cell (CAR-T) therapy; harvesting of blood-derived T lymphocytes for development of genetically modified autologous CAR-T cells, per day” CAR-T codes are in Appendix 2.

7\.  Add Transplant regimen. Transplant date is regimen\\\_start\\\_date as well as regimen\\\_end\\\_date. If two transplants are given within 180 days, only the first one is written into regimen. See the list of codes in appendix 3.

8\.  Regimen source names are the names of drugs or procedures in alphabetical order



\### Lines of therapy rules



Regimens are combined into lines of therapy using the following rules:



9\.  The regimen is marked as Maintenance therapy (will be used as a component of line of therapy) when:

&nbsp;   1.  It’s ‘bortezomib’, ‘lenalidomide’, ‘thalidomide’ or ‘ixazomib’ monotherapy, and a previous regimen was polytherapy, and length of a previous regimen is more than 30 days, and length of a current regimen is more than 60 days, and the current regimen starts within 180 days after the previous regimen end.

&nbsp;   2.  If It’s daratumumab monotherapy, apply rules from previous step, and additionally a previous regimen should include daratumumab

&nbsp;   3.  It’s any drug monotherapy after the transplant that appears within a year after transplantation date.

10\.  Regimens are grouped into line of therapy when they are:

&nbsp;   1.  HSCT (autologous stem cell transplantation) and therapies that surround it, for example: bortezomib, lenalidomide (induction) then HSCT (autologous stem cell transplantation) then lenalidomide (maintenance); Melphalan (Pre-Transplant Conditioning) then HSCT.

&nbsp;   2.  Sometimes drug data is missing, so we end up with incomplete therapies, for example bortezomib then HSCT, which requires lenalidomide as part of induction therapy

&nbsp;   3.  Apheresis, anti-plasma cell treatment (cyclophosphamide, fludarabine or cyclophosphamide monotherapy), CAR-T

&nbsp;   4.  Regimen and its corresponding maintenance therapy

&nbsp;   5.  Addition of immunomodulatory (IMIDS = lenalidomide, pomalidomide, thalidomide) or proteasome inhibitor drugs (PI = bortezomib, carfilzomib, ixazomib) within the first 90 days of the previous regimen start, if the previous regimen doesn’t have the drugs from the same group (2 IMIDs or 2 PIs can’t be in the same line)

&nbsp;   6.  The addition of lenalidomide in 1L to a line that already contained cyclophosphamide does not advance the line. Note: this addition must occur within 60 days of line start for this rule to be applied

11\.  Most of the regimen are mapped to HemOnc concepts by matching ingredients and populate EPISODE.episode\\\_object\\\_concept\\\_id, if there’s no corresponding concept, it was mapped to 0. Procedures are mapped as follows:



&nbsp; 



\*\*Source Concept Name\*\*



\*\*Target Concept ID\*\*



\*\*Target Concept Name\*\*



HSCT



4120445



Hemopoietic stem cell transplant



CAR-T



37557245



Cellular therapy conditioning regimen



Apheresis Aph\&CART



4132856



Apheresis



Apheresis no CART



4132856



Apheresis



12\.  Line of treatment concepts are mapped to 0, since HemOnc vocabulary doesn’t support lines, the value will be only stored in episode\\\_source\\\_value as names of regimen in their temporal order separated by ‘ then ’.

13\.  The start date of line of therapy is the start date of the first regimen, the end date of the line of therapy is the end date of the last regimen the line is made from.

14\.  The line of treatment becomes a parent episode of treatment regimen



Mapping to the EPISODE table

----------------------------



&nbsp;



\*\*target column name\*\*



\*\*logic\*\*



episode\\\_id



autoincrement



person\\\_id



drug\\\_era.person\\\_id



episode\\\_concept\\\_id



For treatment regimen: 32531– Treatment Regimen For lines of therapy: 32941 – Cancer Drug Treatment – can’t find Line of Therapy episode concept. this is the closest we have now



episode\\\_start\\\_date



as described in the logic above



episode\\\_start\\\_datetime



NULL



episode\\\_end\\\_date



as described in the logic above



episode\\\_end\\\_datetime



NULL



episode\\\_parent\\\_id



episode\\\_id of line of therapy which contains this regimen



episode\\\_number



based on the order of dates of episodes/lines for a given patient



episode\\\_object\\\_concept\\\_id



mapped HemOnc regimen concept or 0 for episodes, 0 for lines of treatment



episode\\\_type\\\_concept\\\_id



32880– Standard algorithm



episode\\\_source\\\_value



for regimen: names of drugs or procedures in alphabetical order separated by ’ ,’  

&nbsp; 

for lines of therapy: names of regimen in their temporal order separated by ‘ then ‘



episode\\\_source\\\_concept\\\_id



0



Appendix

--------



\### Chemo/immunotherapy drugs



\*\*concept\\\_id\*\*



\*\*concept\\\_name\*\*



740067



melphalan flufenamide



741578



teclistamab



746340



talquetamab



746391



elranatamab



902725



Doxorubicin pegylated liposomal



902728



Vincristine liposomal



1301267



melphalan



1308290



vincristine



1310317



cyclophosphamide



1336825



bortezomib



1338512



doxorubicin



1350504



etoposide



1361191



selinexor



1395557



fludarabine



1397599



cisplatin



19026972



lenalidomide



19137042



thalidomide



35604032



elotuzumab



35604205



venetoclax



35605744



daratumumab



35606214



ixazomib



36849790



4-HYDROXYCYCLOPHOSPHAMIDE



36858740



FLUDARABINE F-18



37002419



belantamab mafodotin



37002429



belantamab



37498969



isatuximab



42873638



carfilzomib



43014237



pomalidomide



\### CAR-T



\*\*concept\\\_id\*\*



\*\*concept\\\_name\*\*



739856



lisocabtagene maraleucel



779144



ciltacabtagene autoleucel



792737



tisagenlecleucel



792844



axicabtagene ciloleucel



36026868



idecabtagene vicleucel



37002369



brexucabtagene autoleucel



\### Stem cell transplant codes



&nbsp;



\*\*concept\\\_id\*\*



\*\*concept\\\_name\*\*



2002363



Autologous hematopoietic stem cell transplant without purging



2002364



Allogeneic hematopoietic stem cell transpant without purging



2002365



Cord blood stem cell transplant



2002366



Autologous hematopoietic stem cell transplant with purging



2002367



Allogeneic hematopoietic stem cell transplant with purging



2721124



Cord blood-derived stem-cell transplantation, allogeneic



2721125



Bone marrow or blood-derived stem cells (peripheral or umbilical), allogeneic or autologous, harvesting, transplantation, and related complications; including: pheresis and cell preparation/storage; marrow ablative therapy; drugs, supplies, hospitaliza…



2785921



Transfusion of Autologous Cord Blood Stem Cells into Central Artery, Percutaneous Approach (Deprecated)



2785922



Transfusion of Nonautologous Cord Blood Stem Cells into Central Artery, Percutaneous Approach (Deprecated)



2785923



Transfusion of Autologous Hematopoietic Stem Cells into Central Artery, Percutaneous Approach (Deprecated)



2785924



Transfusion of Nonautologous Hematopoietic Stem Cells into Central Artery, Percutaneous Approach (Deprecated)



2788483



Transfusion of Embryonic Stem Cells into Peripheral Vein, Open Approach (Deprecated)



2788671



Transfusion of Autologous Bone Marrow into Peripheral Vein, Open Approach (Deprecated)



2788672



Transfusion of Nonautologous Bone Marrow into Peripheral Vein, Open Approach (Deprecated)



2788699



Transfusion of Autologous Cord Blood Stem Cells into Peripheral Vein, Open Approach (Deprecated)



2788700



Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Vein, Open Approach (Deprecated)



2788701



Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Vein, Open Approach (Deprecated)



2788702



Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Vein, Open Approach (Deprecated)



2788703



Transfusion of Embryonic Stem Cells into Peripheral Vein, Percutaneous Approach



2788704



Transfusion of Autologous Bone Marrow into Peripheral Vein, Percutaneous Approach



2788705



Transfusion of Nonautologous Bone Marrow into Peripheral Vein, Percutaneous Approach (Deprecated)



2788732



Transfusion of Autologous Cord Blood Stem Cells into Peripheral Vein, Percutaneous Approach



2788733



Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Vein, Percutaneous Approach (Deprecated)



2788734



Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Vein, Percutaneous Approach



2788925



Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Vein, Percutaneous Approach (Deprecated)



2788926



Transfusion of Embryonic Stem Cells into Central Vein, Open Approach (Deprecated)



2788927



Transfusion of Autologous Bone Marrow into Central Vein, Open Approach (Deprecated)



2788928



Transfusion of Nonautologous Bone Marrow into Central Vein, Open Approach (Deprecated)



2788955



Transfusion of Autologous Cord Blood Stem Cells into Central Vein, Open Approach (Deprecated)



2788956



Transfusion of Nonautologous Cord Blood Stem Cells into Central Vein, Open Approach (Deprecated)



2788957



Transfusion of Autologous Hematopoietic Stem Cells into Central Vein, Open Approach (Deprecated)



2788958



Transfusion of Nonautologous Hematopoietic Stem Cells into Central Vein, Open Approach (Deprecated)



2788959



Transfusion of Embryonic Stem Cells into Central Vein, Percutaneous Approach



2788960



Transfusion of Autologous Bone Marrow into Central Vein, Percutaneous Approach



2788961



Transfusion of Nonautologous Bone Marrow into Central Vein, Percutaneous Approach (Deprecated)



2788988



Transfusion of Autologous Cord Blood Stem Cells into Central Vein, Percutaneous Approach



2789176



Transfusion of Nonautologous Cord Blood Stem Cells into Central Vein, Percutaneous Approach (Deprecated)



2789177



Transfusion of Autologous Hematopoietic Stem Cells into Central Vein, Percutaneous Approach



2789178



Transfusion of Nonautologous Hematopoietic Stem Cells into Central Vein, Percutaneous Approach (Deprecated)



2789179



Transfusion of Autologous Bone Marrow into Peripheral Artery, Open Approach (Deprecated)



2789180



Transfusion of Nonautologous Bone Marrow into Peripheral Artery, Open Approach (Deprecated)



2789207



Transfusion of Autologous Cord Blood Stem Cells into Peripheral Artery, Open Approach (Deprecated)



2789208



Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Artery, Open Approach (Deprecated)



2789209



Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Artery, Open Approach (Deprecated)



2789210



Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Artery, Open Approach (Deprecated)



2789211



Transfusion of Autologous Bone Marrow into Peripheral Artery, Percutaneous Approach (Deprecated)



2789212



Transfusion of Nonautologous Bone Marrow into Peripheral Artery, Percutaneous Approach (Deprecated)



2789428



Transfusion of Autologous Cord Blood Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)



2789429



Transfusion of Nonautologous Cord Blood Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)



2789430



Transfusion of Autologous Hematopoietic Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)



2789431



Transfusion of Nonautologous Hematopoietic Stem Cells into Peripheral Artery, Percutaneous Approach (Deprecated)



2789432



Transfusion of Autologous Bone Marrow into Central Artery, Open Approach (Deprecated)



2789433



Transfusion of Nonautologous Bone Marrow into Central Artery, Open Approach (Deprecated)



2789460



Transfusion of Autologous Cord Blood Stem Cells into Central Artery, Open Approach (Deprecated)



2789461



Transfusion of Nonautologous Cord Blood Stem Cells into Central Artery, Open Approach (Deprecated)



2789462



Transfusion of Autologous Hematopoietic Stem Cells into Central Artery, Open Approach (Deprecated)



2789463



Transfusion of Nonautologous Hematopoietic Stem Cells into Central Artery, Open Approach (Deprecated)



2789464



Transfusion of Autologous Bone Marrow into Central Artery, Percutaneous Approach (Deprecated)



2789465



Transfusion of Nonautologous Bone Marrow into Central Artery, Percutaneous Approach (Deprecated)



4028623



Transplantation of bone marrow



4059885



Autologous bone marrow transplant without purging



4081380



Peripheral blood stem cell graft



4083057



Cord cell transfusion



4120445



Hemopoietic stem cell transplant



4121104



Syngeneic bone marrow transplant



4122920



T-cell depleted allogeneic bone marrow graft



4125486



Imperfect T-cell depleted allogeneic bone marrow graft



4125487



Allogeneic related bone marrow transplant



4125488



Allogeneic unrelated bone marrow transplant



4139690



Grafting of cord blood to bone marrow



4142405



Allograft of bone marrow from sibling donor



4143404



Allogeneic peripheral blood stem cell transplant



4144157



Autologous peripheral blood stem cell transplant



4144882



Allograft of bone marrow from matched unrelated donor



4145532



Allograft of cord blood to bone marrow



4186582



Autologous bone marrow transplant with purging



4240337



Autologous bone marrow transplant



4242257



Allogeneic bone marrow transplantation



37152106



High-dose chemotherapy with stem cell transplant



40484034



Grafting of bone marrow using allograft from unmatched unrelated donor



40486968



Allogeneic bone marrow transplantation with purging



40492289



Allogeneic bone marrow transplantation without purging



44514755



Other specified graft of bone marrow



44515878



Other specified graft of cord blood stem cells to bone marrow



44783964



Syngeneic peripheral blood stem cell transplantation



44790154



Allograft of bone marrow from haploidentical donor



44793170



Allograft of bone marrow from unmatched unrelated donor



46271079



Transplantation of autologous hematopoietic stem cell



// add bootstrap table styles to pandoc tables function bootstrapStylePandocTables() { $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed'); } $(document).ready(function () { bootstrapStylePandocTables(); }); $(document).ready(function () { window.buildTabsets("TOC"); }); $(document).ready(function () { $('.tabset-dropdown > .nav-tabs > li').click(function () { $(this).parent().toggleClass('nav-tabs-open'); }); }); $(document).ready(function () { // temporarily add toc-ignore selector to headers for the consistency with Pandoc $('.unlisted.unnumbered').addClass('toc-ignore') // move toc-ignore selectors from section div to header $('div.section.toc-ignore') .removeClass('toc-ignore') .children('h1,h2,h3,h4,h5').addClass('toc-ignore'); // establish options var options = { selectors: "h1,h2,h3", theme: "bootstrap3", context: '.toc-content', hashGenerator: function (text) { return text.replace(/\\\[.\\\\\\\\/?\&!#<>\\]/g, '').replace(/\\\\s/g, '\\\_'); }, ignoreSelector: ".toc-ignore", scrollTo: 0 }; options.showAndHide = true; options.smoothScroll = true; // tocify var toc = $("#TOC").tocify(options).data("toc-tocify"); }); (function () { var script = document.createElement("script"); script.type = "text/javascript"; script.src = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML\\\_HTMLorMML"; document.getElementsByTagName("head")\\\[0\\].appendChild(script); })();

