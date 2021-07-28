alter table {SOURCE_SCHEMA}.patient add constraint pk_patient primary key (patid);

--alter table {SOURCE_SCHEMA}.practice add constraint pk_practice primary key (pracid)

alter table {SOURCE_SCHEMA}.consultation add constraint pk_consultation primary key (consid);

--The following removes duplicates from observation before creating the pk
create index idx_observation_obsid on {SOURCE_SCHEMA}.observation (obsid);

select distinct *
into temporary observation_dupes
from {SOURCE_SCHEMA}.observation
where obsid in (
	select obsid
	from {SOURCE_SCHEMA}.observation
	group by observation
	having count(1) > 1
);

delete from {SOURCE_SCHEMA}.observation
where obsid in (select obsid from observation_dupes);

insert into {SOURCE_SCHEMA}.observation
select * from observation_dupes;

alter table {SOURCE_SCHEMA}.observation add constraint xpk_observation primary key (obsid);

drop index idx_observation_obsid;

drop temporary table observation_dupes;



alter table {SOURCE_SCHEMA}.problem add constraint pk_problem primary key (obsid);

alter table {SOURCE_SCHEMA}.referral add constraint pk_referral primary key (obsid);


create index idx_consultation_patid on {SOURCE_SCHEMA}.consultation(patid);
cluster {SOURCE_SCHEMA}.consultation using idx_consultation_patid;
create index idx_consultation_consmedcodeid on {SOURCE_SCHEMA}.consultation (consmedcodeid);

create index idx_observation_patid on {SOURCE_SCHEMA}.observation (patid);
cluster {SOURCE_SCHEMA}.observation using idx_observation_patid;
create index idx_observation_medcodeid on {SOURCE_SCHEMA}.observation (medcodeid);
create index idx_observation_consid on {SOURCE_SCHEMA}.observation (consid);
create index idx_observation_numunitid on {SOURCE_SCHEMA}.observation (numunitid);

create index idx_drugissue_patid on {SOURCE_SCHEMA}.drugissue (patid);
cluster {SOURCE_SCHEMA}.drugissue using idx_drugissue_patid;
create index idx_drugissue_prodcodeid on {SOURCE_SCHEMA}.drugissue (prodcodeid);
create index idx_drugissue_probobsid on {SOURCE_SCHEMA}.drugissue (probobsid);
create index idx_drugissue_quantunitid on {SOURCE_SCHEMA}.drugissue (quantunitid);

create index idx_problem_patid on {SOURCE_SCHEMA}.problem(patid);
cluster {SOURCE_SCHEMA}.problem using idx_problem_patid;

create index idx_referral_patid on {SOURCE_SCHEMA}.referral(patid);
cluster {SOURCE_SCHEMA}.referral using idx_referral_patid;
create index idx_referral_refservicetypeid on {SOURCE_SCHEMA}.referral(refservicetypeid);
