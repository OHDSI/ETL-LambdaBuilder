
set search_path to {SOURCE_SCHEMA};

truncate table {TARGET_SCHEMA}.location;
truncate table {TARGET_SCHEMA}.care_site;
truncate table {TARGET_SCHEMA}.provider;
truncate table {TARGET_SCHEMA}.person;
truncate table {TARGET_SCHEMA}.death;
truncate table {TARGET_SCHEMA}.observation_period;
truncate table {TARGET_SCHEMA}.visit_detail;
truncate table {TARGET_SCHEMA}.visit_occurrence;
truncate table {TARGET_SCHEMA}.stem_source;

--these drops and truncations are for the specific tables created during the build. These are not CDM tables.
truncate table {TARGET_SCHEMA}.stem_source;
drop table if exists {SOURCE_SCHEMA}.temp_visit_detail;
drop table if exists {SOURCE_SCHEMA}.temp_visit_occurrence;
drop table if exists {SOURCE_SCHEMA}.temp_concept_map;
drop table if exists {SOURCE_SCHEMA}.temp_drug_concept_map;
drop index if exists {SOURCE_SCHEMA}.idx_temp_visit_d_id;
drop index if exists {SOURCE_SCHEMA}.idx_temp_visit_d_o;
drop index if exists {SOURCE_SCHEMA}.idx_temp_visit_o;


--insert the location table
insert into {TARGET_SCHEMA}.location (location_id, address_1, address_2, city,
                                       state, zip, county, location_source_value)
select distinct region,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                r."description"
from {SOURCE_SCHEMA}.practice p
left join {SOURCE_SCHEMA}.lkpregion r
    on p.region = r.regionid
where p.region is not null
;

--insert the care_site table
insert into {TARGET_SCHEMA}.care_site(care_site_id, care_site_name, place_of_service_concept_id,
                                       location_id, care_site_source_value, place_of_service_source_value)
select distinct pracid,
       NULL,
       8977,
       region,
       cast(pracid as varchar),
       NULL
from {SOURCE_SCHEMA}.practice
;

--insert the provider table
insert into {TARGET_SCHEMA}.provider(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id,
                                      year_of_birth, gender_concept_id, provider_source_value, specialty_source_value,
                                      specialty_source_concept_id, gender_source_value, gender_source_concept_id)
select distinct staffid,
       NULL,
       NULL,
       NULL,
       0,
       pracid,
       cast(NULL as int),
       0,
       cast(staffid as varchar),
       j."description",
       0,
       NULL,
       0
from {SOURCE_SCHEMA}.staff s
left join {SOURCE_SCHEMA}.lkpjobcategory j
    on s.jobcatid = j.jobcatid
;

--insert the person table
insert into {TARGET_SCHEMA}.person (
  person_id				,
  gender_concept_id		,
  year_of_birth				,
  month_of_birth			,
  day_of_birth				,
  birth_datetime			,
  race_concept_id			,
  ethnicity_concept_id		,
  location_id					,
  provider_id					,
  care_site_id					,
  person_source_value			,
  gender_source_value			,
  gender_source_concept_id	  	,
  race_source_value				,
  race_source_concept_id		,
  ethnicity_source_value		,
  ethnicity_source_concept_id
)
select
    patid,
    case when gender = 2 then 8532
         when gender = 1 then 8507
    else 0 end,
    yob,
    mob,
    NULL,
    NULL,
    0,
    0,
    NULL,
    NULL,
    pracid,
    CAST(patid AS VARCHAR),
    case when gender = 2 then 'F'
         when gender = 1 then 'M'
    else 'Unknown' end,
    0,
    NULL,
    0,
    NULL,
    0
FROM {SOURCE_SCHEMA}.patient
WHERE acceptable = 1 and gender in (1,2);

insert into {TARGET_SCHEMA}.death(person_id, death_date, death_datetime, death_type_concept_id,
                                   cause_concept_id, cause_source_value, cause_source_concept_id)
select patid,
       cprd_ddate,
       NULL,
       32815,
       0,
       NULL,
       0
from {SOURCE_SCHEMA}.patient pa
join {TARGET_SCHEMA}.person p
    on cast(pa.patid as varchar)  = p.person_source_value
where cprd_ddate is not NULL
;



insert into {TARGET_SCHEMA}.observation_period(observation_period_id, person_id, observation_period_start_date,
                                                observation_period_end_date, period_type_concept_id)
select row_number()over(order by patid),
       p.patid,
       p.regstartdate,
       least(p.cprd_ddate, p.regenddate, pr.lcd),
       32882
from {SOURCE_SCHEMA}.patient p
left join (select distinct pracid, lcd from {SOURCE_SCHEMA}.practice) pr
    on p.pracid = pr.pracid
where p.acceptable = 1 and p.gender in (1,2)
;


create table {SOURCE_SCHEMA}.temp_visit_detail as
select row_number() over (order by a.visit_detail_source_id) as visit_detail_id, a.*
from (
         select o.obsid as visit_detail_source_id,
                o.patid as person_id,
                case
                    when consdate is NULL then obsdate
                    else consdate
                    end as visit_detail_start_date,
                case
                    when consdate is NULL then obsdate
                    else consdate
                    end as visit_detail_end_date,
                c.staffid as provider_id,
                o.pracid as care_site_id,
                o.parentobsid as parent_visit_detail_source_id,
                'Observation' as source_table
         from observation o
                  left join consultation c
                            on o.consid = c.consid
         UNION
         select c.consid   as visit_detail_source_id,
                c.patid    as person_id,
                c.consdate as visit_detail_start_date,
                c.consdate as visit_detail_end_date,
                c.staffid  as provider_id,
                c.pracid   as care_site_id,
                NULL       as parent_visit_detail_id,
                'Consultation' as source_table
         from consultation c
     ) a
;

create index idx_temp_visit_d_id on {SOURCE_SCHEMA}.temp_visit_detail (visit_detail_source_id);
create index idx_temp_visit_d_o on {SOURCE_SCHEMA}.temp_visit_detail (person_id, visit_detail_start_date, care_site_id); 

create table {SOURCE_SCHEMA}.temp_visit_occurrence as
select row_number() over (order by person_id, visit_detail_start_date, care_site_id) as visit_occurrence_id,
       person_id,
       visit_detail_start_date as visit_start_date,
       care_site_id,
       count(*) as visit_detail_count
from temp_visit_detail
where visit_detail_start_date is not null
group by person_id, visit_detail_start_date, care_site_id
;

create index idx_temp_visit_o on temp_visit_occurrence (person_id, visit_start_date, care_site_id);

create table if not exists {SOURCE_SCHEMA}.temp_concept_map as
select 
    m.medcodeid,
    m.term,
    m.cleansedreadcode,
    m.snomedctconceptid,
    st1.target_concept_id as Read_source_concept_id,
    st2.target_concept_id as SNOMED_source_concept_id
from {SOURCE_SCHEMA}.medicaldictionary m
left join {TARGET_SCHEMA}.source_to_source_vocab_map st1
    on m.cleansedreadcode = st1.source_code
    and st1.source_vocabulary_id = 'Read'
left join {TARGET_SCHEMA}.source_to_source_vocab_map st2
    on cast(m.snomedctconceptid as varchar) = st2.source_code
    and st2.source_vocabulary_id = 'SNOMED'
;

alter table {SOURCE_SCHEMA}.temp_concept_map add constraint pk_temp_concept_map primary key (medcodeid);


create table if not exists {SOURCE_SCHEMA}.temp_drug_concept_map as
select d.prodcodeid,
    d.termfromemis,
    d.dmdid,
    st1.target_concept_id as dmd_source_concept_id
from {SOURCE_SCHEMA}.drugcode d
left join {TARGET_SCHEMA}.source_to_source_vocab_map st1
    on cast(d.dmdid as varchar) = st1.source_code
    and st1.source_vocabulary_id = 'dm+d';

alter table {SOURCE_SCHEMA}.temp_drug_concept_map add constraint pk_temp_drug_concept_map primary key (prodcodeid);


--Visit detail and visit occurrence temp tables to facilitate inserts
ALTER TABLE {TARGET_SCHEMA}.visit_detail DROP CONSTRAINT IF EXISTS xpk_visit_detail;
DROP INDEX IF EXISTS {TARGET_SCHEMA}.idx_visit_detail_person_id;
--insert into visit_detail
--this first round does not take into account the field preceding_visit_detail_id
insert into {TARGET_SCHEMA}.visit_detail(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date,
                                          visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime,
                                          visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value,
                                          visit_detail_source_concept_id, admitting_source_value, admitting_source_concept_id,
                                          discharge_to_source_value, discharge_to_concept_id, preceding_visit_detail_id,
                                          visit_detail_parent_id, visit_occurrence_id)
select tvd.visit_detail_id,
       tvd.person_id,
       581477,
       tvd.visit_detail_start_date,
       NULL,
       tvd.visit_detail_start_date,
       NULL,
       32827,
       tvd.provider_id,
       tvd.care_site_id,
       NULL,
       0,
       NULL,
       0,
       NULL,
       0,
       NULL,
       tvd2.visit_detail_id as visit_detail_parent_id,
       tvo.visit_occurrence_id
from {SOURCE_SCHEMA}.temp_visit_detail tvd
left join {SOURCE_SCHEMA}.temp_visit_occurrence tvo
    on tvd.person_id = tvo.person_id
    and tvd.visit_detail_start_date = tvo.visit_start_date
    and tvd.care_site_id = tvo.care_site_id
left join {SOURCE_SCHEMA}.temp_visit_detail tvd2
    on tvd.parent_visit_detail_source_id = tvd2.visit_detail_source_id
	and tvd2.source_table = 'Observation'
where tvd.visit_detail_start_date is not null
;

ALTER TABLE {TARGET_SCHEMA}.visit_detail ADD CONSTRAINT xpk_visit_detail PRIMARY KEY (visit_detail_id);
CREATE INDEX idx_visit_detail_person_id  ON {TARGET_SCHEMA}.visit_detail (person_id);
CLUSTER {TARGET_SCHEMA}.visit_detail  USING idx_visit_detail_person_id;

ALTER TABLE {TARGET_SCHEMA}.visit_occurrence DROP CONSTRAINT IF EXISTS xpk_visit_occurrence;

insert into {TARGET_SCHEMA}.visit_occurrence(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime,
                                              visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id,
                                              visit_source_value, visit_source_concept_id, admitting_source_concept_id, admitting_source_value,
                                              discharge_to_concept_id, discharge_to_source_value, preceding_visit_occurrence_id)
select visit_occurrence_id,
       tvo.person_id,
       581477,
       tvo.visit_start_date,
       NULL,
       tvo.visit_start_date, 
       NULL,
       32827,
       NULL,
       tvo.care_site_id,
       NULL,
       0,
       0,
       NULL,
       0,
       NULL,
       NULL
from {SOURCE_SCHEMA}.temp_visit_occurrence tvo
;

alter table {TARGET_SCHEMA}.visit_occurrence add constraint xpk_visit_occurrence primary key (visit_occurrence_id) ;


