drop index if exists {TARGET_SCHEMA}.idx_stem_source_concept_id;

--insert into temp table from observation
insert into {TARGET_SCHEMA}.stem_source(person_id, visit_occurrence_id, visit_detail_id, provider_id, source_value,
					 source_concept_id, type_concept_id, start_date, end_date, start_time, dose_unit_concept_id,
					 operator_concept_id, qualifier_concept_id,
					 range_high, range_low, route_concept_id, unit_concept_id,
					 unit_source_value, value_as_concept_id, value_as_number,
					 value_source_value, anatomic_site_concept_id, disease_status_concept_id, modifier_concept_id, stem_source_table, stem_source_id)
select ch.person_id, 
	   vd.visit_occurrence_id visit_occurrence_id,
	   v.visit_detail_id visit_detail_id,
	   c.staffid provider_id,
	   case when m.cleansedreadcode is null
			then concat(m.snomedctconceptid,'-',m.term)
		   else concat(m.cleansedreadcode,'-',m.term)
		end as source_value,
	   case when m.cleansedreadcode is null
			then t.SNOMED_source_concept_id
		   else t.Read_source_concept_id
		end as source_concept_id,
	   32827 type_concept_id,
	   o.obsdate start_date,
	   case when p.probenddate is null
		   then o.obsdate
		   else p.probenddate
		end as end_date,
	   cast('00:00:00' as time) start_time,
	   0 dose_unit_concept_id,
	   0 operator_concept_id,
	   0 qualifier_concept_id,
	   cast(o.numrangehigh as double precision) range_high,
	   cast(o.numrangelow as double precision) range_low,
	   0 route_concept_id,
	   0 unit_concept_id,
	   n.description unit_source_value,
	   0 value_as_concept_id,
	   o.value value_as_number,
	   CAST(o.value as varchar) value_source_value,
	   0 anatomic_site_concept_id,
	   0 disease_status_concept_id,
	   0 modifier_concept_id,
	   'Observation' stem_source_table,
	   o.obsid stem_source_id
from {SOURCE_SCHEMA}.chunk ch
left join {SOURCE_SCHEMA}.observation o
	on ch.person_id = o.patid
left join {SOURCE_SCHEMA}.consultation c
	on o.consid = c.consid
left join {SOURCE_SCHEMA}.problem p
	on o.obsid = p.obsid
left join {SOURCE_SCHEMA}.temp_visit_detail v
    on o.obsid = v.visit_detail_source_id
	and v.source_table = 'Observation'
left join {TARGET_SCHEMA}.visit_detail vd
    on v.visit_detail_id = vd.visit_detail_id
left join {SOURCE_SCHEMA}.medicaldictionary m
    on o.medcodeid = m.medcodeid
left join {SOURCE_SCHEMA}.lkpnumericunit n
    on o.numunitid = n.numunitid
left join {SOURCE_SCHEMA}.temp_concept_map t
    on o.medcodeid = t.medcodeid
where ch.chunk_id = {CHUNK_ID}
	and o.obsdate is not null
;



--insert into stem_source from consultation
insert into {TARGET_SCHEMA}.stem_source(domain_id, person_id, visit_occurrence_id, visit_detail_id, provider_id, concept_id, source_value,
                                         source_concept_id, type_concept_id, start_date, end_date, start_time, days_supply, dose_unit_concept_id,
                                         dose_unit_source_value, effective_drug_dose, lot_number, modifier_source_value, operator_concept_id, qualifier_concept_id,
                                         qualifier_source_value, quantity, range_high, range_low, refills, route_concept_id, route_source_value,
                                         sig, stop_reason, unique_device_id, unit_concept_id, unit_source_value, value_as_concept_id, value_as_number,
                                         value_as_string, value_source_value, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id,
                                         anatomic_site_source_value, disease_status_source_value, modifier_concept_id, stem_source_table, stem_source_id)
    select NULL,
           c.patid,
           vd.visit_occurrence_id,
           v.visit_detail_id,
           c.staffid,
           NULL,
           case when m.cleansedreadcode is null
                then concat(cast(m.snomedctconceptid as varchar) ,'-',m.term)
               else concat(m.cleansedreadcode,'-',m.term)
            end as source_value,
           case when m.cleansedreadcode is null
                then t.SNOMED_source_concept_id
               else t.Read_source_concept_id
            end as source_concept_id,
           32827,
           c.consdate,
           c.consdate,
           '00:00:00',
           NULL,
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           0,
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           0,
           NULL,
           0,
           NULL,
           NULL,
           NULL,
           0,
           0,
           NULL,
           NULL,
           NULL,
           0,
           'Consultation',
           c.consid
    from {SOURCE_SCHEMA}.chunk ch
    left join {SOURCE_SCHEMA}.consultation c
        on ch.person_id = c.patid
    left join {SOURCE_SCHEMA}.medicaldictionary m
        on c.consmedcodeid = m.medcodeid
    left join {SOURCE_SCHEMA}.temp_visit_detail v
        on c.consid = v.visit_detail_source_id
        and v.source_table = 'Consultation'
    left join {TARGET_SCHEMA}.visit_detail vd
        on v.visit_detail_id = vd.visit_detail_id
    left join {SOURCE_SCHEMA}.temp_concept_map t
        on c.consmedcodeid = t.medcodeid
    where ch.chunk_id = {CHUNK_ID}
        and c.consdate is not NULL
	;
		
    

--insert into stem_source table from drug_issue
insert into {TARGET_SCHEMA}.stem_source(domain_id, person_id, visit_occurrence_id, visit_detail_id, provider_id, concept_id, source_value,
                                         source_concept_id, type_concept_id, start_date, end_date, start_time, days_supply, dose_unit_concept_id,
                                         dose_unit_source_value, effective_drug_dose, lot_number, modifier_source_value, operator_concept_id, qualifier_concept_id,
                                         qualifier_source_value, quantity, range_high, range_low, refills, route_concept_id, route_source_value,
                                         sig, stop_reason, unique_device_id, unit_concept_id, unit_source_value, value_as_concept_id, value_as_number,
                                         value_as_string, value_source_value, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id,
                                         anatomic_site_source_value, disease_status_source_value, modifier_concept_id, stem_source_table, stem_source_id)
    select NULL,
           d.patid,
           vd.visit_occurrence_id,
           v.visit_detail_id,
           d.staffid,
           NULL,
           cast(dc.dmdid as varchar),
           t.dmd_source_concept_id,
           32839,
           d.issuedate,
           case when d.duration is null then d.issuedate
               when d.duration = 0 then d.issuedate
               else d.issuedate + (d.duration-1) * INTERVAL '1 day'
            end as end_date,
           '00:00:00',
           d.duration,
           0,
           q.description,
           NULL,
           NULL,
           NULL,
           0,
           0,
           NULL,
           d.quantity,
           NULL,
           NULL,
           NULL,
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           0,
           NULL,
           0,
           NULL,
           NULL,
           NULL,
           0,
           0,
           NULL,
           NULL,
           NULL,
           0,
           'DrugIssue',
           d.issueid
    from {SOURCE_SCHEMA}.chunk ch
    left join {SOURCE_SCHEMA}.drugissue d
        on ch.person_id = d.patid
    left join {SOURCE_SCHEMA}.drugcode dc
        on d.prodcodeid = dc.prodcodeid
    left join {SOURCE_SCHEMA}.temp_visit_detail v
        on d.probobsid = v.visit_detail_source_id
		and v.source_table = 'Observation'
    left join {TARGET_SCHEMA}.visit_detail vd
        on v.visit_detail_id = vd.visit_detail_id
    left join {SOURCE_SCHEMA}.lkpquantityunit q
        on d.quantunitid = q.quantunitid
    left join {SOURCE_SCHEMA}.temp_drug_concept_map t
		on d.prodcodeid = t.prodcodeid
    where ch.chunk_id = {CHUNK_ID}
		and d.issuedate is not null
	;
		

--insert into stem_source table from referral
insert into {TARGET_SCHEMA}.stem_source(domain_id, person_id, visit_occurrence_id, visit_detail_id, provider_id, concept_id, source_value,
                                         source_concept_id, type_concept_id, start_date, end_date, start_time, days_supply, dose_unit_concept_id,
                                         dose_unit_source_value, effective_drug_dose, lot_number, modifier_source_value, operator_concept_id, qualifier_concept_id,
                                         qualifier_source_value, quantity, range_high, range_low, refills, route_concept_id, route_source_value,
                                         sig, stop_reason, unique_device_id, unit_concept_id, unit_source_value, value_as_concept_id, value_as_number,
                                         value_as_string, value_source_value, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id,
                                         anatomic_site_source_value, disease_status_source_value, modifier_concept_id, stem_source_table, stem_source_id)
    select NULL,
           r.patid,
           vd.visit_occurrence_id,
           v.visit_detail_id,
           NULL,
           0,
           'Referral record',
           0,
           32842,
           vd.visit_detail_start_date,
           vd.visit_detail_end_date,
           '00:00:00',
           NULL,
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           0,
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           0,
           NULL,
           case when r.refservicetypeid = 1 then 0
                when r.refservicetypeid = 2 then 45884011
                when r.refservicetypeid = 3 then 36308045
                when r.refservicetypeid = 4 then 45876918
                when r.refservicetypeid = 5 then 45882580
                when r.refservicetypeid = 6 then 0
                when r.refservicetypeid = 7 then 36308045
                when r.refservicetypeid = 8 then 45885153
                when r.refservicetypeid = 9 then 706505
                when r.refservicetypeid = 10 then 45880650
                when r.refservicetypeid = 11 then 45884467
                when r.refservicetypeid = 12 then 45876494
                when r.refservicetypeid = 13 then 706352
            else 0 end,
           NULL,
           rs.description,
           r.refservicetypeid,
           0,
           0,
           NULL,
           NULL,
           NULL,
           0,
           'Referral',
           r.obsid
    from {SOURCE_SCHEMA}.chunk ch
    left join {SOURCE_SCHEMA}.referral r
        on  ch.person_id = r.patid
    left join {SOURCE_SCHEMA}.temp_visit_detail v
        on r.obsid = v.visit_detail_source_id
        and v.source_table = 'Observation'
    left join {TARGET_SCHEMA}.visit_detail vd
        on v.visit_detail_id = vd.visit_detail_id
    left join {SOURCE_SCHEMA}.lkpreferralservicetype rs
        on r.refservicetypeid = rs.refservicetypeid
    where ch.chunk_id = {CHUNK_ID}
        and v.visit_detail_start_date is not null
	;	

update {SOURCE_SCHEMA}.chunk 
set completed = 1 
where chunk_id = {CHUNK_ID};