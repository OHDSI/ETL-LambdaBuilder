create index idx_stem_source_concept_id on {TARGET_SCHEMA}.stem_source (source_concept_id);
drop index if exists {TARGET_SCHEMA}.idx_stem_domain_id;
truncate table {TARGET_SCHEMA}.stem;
truncate table {TARGET_SCHEMA}.condition_occurrence;
truncate table {TARGET_SCHEMA}.procedure_occurrence;
truncate table {TARGET_SCHEMA}.measurement;
truncate table {TARGET_SCHEMA}.device_exposure;
truncate table {TARGET_SCHEMA}.drug_exposure;
truncate table {TARGET_SCHEMA}.observation;

--insert into stem from stem_source, this is the vocab mapping portion
insert into {TARGET_SCHEMA}.stem(domain_id, person_id, visit_occurrence_id, visit_detail_id, provider_id, id, concept_id, source_value,
                                         source_concept_id, type_concept_id, start_date, end_date, start_time, days_supply, dose_unit_concept_id,
                                         dose_unit_source_value, effective_drug_dose, lot_number, modifier_source_value, operator_concept_id, qualifier_concept_id,
                                         qualifier_source_value, quantity, range_high, range_low, refills, route_concept_id, route_source_value,
                                         sig, stop_reason, unique_device_id, unit_concept_id, unit_source_value, value_as_concept_id, value_as_number,
                                         value_as_string, value_source_value, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id,
                                         anatomic_site_source_value, disease_status_source_value, modifier_concept_id, stem_source_table, stem_source_id)
    select case when v.target_domain_id is NULL
                then 'Observation'
                else v.target_domain_id
            end as domain_id,
           s.person_id,
           s.visit_occurrence_id,
           s.visit_detail_id,
           s.provider_id,
           row_number()over(order by s.person_id),
           case when v.target_concept_id is NULL then 0
               when s.source_value = 'Referral record' then 4144684
               else v.target_concept_id
            end as concept_id,
           s.source_value,
           s.source_concept_id,
           s.type_concept_id,
           s.start_date,
           s.end_date,
           s.start_time,
           s.days_supply,
           s.dose_unit_concept_id,
           s.dose_unit_source_value,
           s.effective_drug_dose,
           s.lot_number,
           s.modifier_source_value,
           s.operator_concept_id,
           s.qualifier_concept_id,
           s.qualifier_source_value,
           s.quantity,
           s.range_high,
           s.range_low,
           s.refills,
           s.route_concept_id,
           s.route_source_value,
           s.sig, s.stop_reason, s.unique_device_id, s.unit_concept_id, s.unit_source_value, s.value_as_concept_id, s.value_as_number,
           s.value_as_string, s.value_source_value, s.anatomic_site_concept_id, s.disease_status_concept_id, s.specimen_source_id,
           s.anatomic_site_source_value, s.disease_status_source_value, s.modifier_concept_id,
           s.stem_source_table,
           s.stem_source_id
    from {TARGET_SCHEMA}.stem_source s
    left join {TARGET_SCHEMA}.source_to_standard_vocab_map v
        on s.source_concept_id = v.source_concept_id
        and s.source_concept_id <> 0;

create index idx_stem_domain_id on {TARGET_SCHEMA}.stem (domain_id, visit_occurrence_id);


--insert into condition_occurrence from stem
insert into {TARGET_SCHEMA}.condition_occurrence(condition_occurrence_id, person_id, condition_concept_id, condition_start_date,
                                                  condition_start_datetime, condition_end_date, condition_end_datetime,
                                                  condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id,
                                                  visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id,
                                                  condition_status_source_value)
select s.id,
       s.person_id,
       s.concept_id,
       case when s.start_date is NULL
         then v.visit_start_date
        else s.start_date end,
       case when s.start_date is NULL
         then v.visit_start_date
        else s.start_date end,
       s.end_date,
       s.end_date,
       s.type_concept_id,
       0,
       s.stop_reason,
       s.provider_id,
       s.visit_occurrence_id,
       s.visit_detail_id,
       s.source_value,
       s.source_concept_id,
       NULL
from {TARGET_SCHEMA}.stem s
join {TARGET_SCHEMA}.visit_occurrence v
    on s.visit_occurrence_id = v.visit_occurrence_id
where s.domain_id = 'Condition';

--insert into drug_exposure from stem
insert into {TARGET_SCHEMA}.drug_exposure(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date,
                                           drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime,
                                           verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply,
                                           sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id,
                                           drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value)
select s.id,
       s.person_id,
       s.concept_id,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       case when s.end_date is NULL
           then v.visit_start_date
        else s.end_date end,
       case when s.end_date is NULL
           then v.visit_start_date
        else s.end_date end,
       NULL,
       s.type_concept_id,
       s.stop_reason,
       s.refills,
       s.quantity,
       s.days_supply,
       s.sig,
       s.route_concept_id,
       s.lot_number,
       s.provider_id,
       s.visit_occurrence_id,
       s.visit_detail_id,
       s.source_value,
       s.source_concept_id,
       s.route_source_value,
       s.dose_unit_source_value
from {TARGET_SCHEMA}.stem s
join {TARGET_SCHEMA}.visit_occurrence v
    on s.visit_occurrence_id = v.visit_occurrence_id
where s.domain_id = 'Drug';


--insert vaccinations that don't have a visit_occurrence_id
insert into {TARGET_SCHEMA}.drug_exposure(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date,
                                           drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime,
                                           verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply,
                                           sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id,
                                           drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value)
select s.id,
       s.person_id,
       s.concept_id,
       s.start_date,
       s.start_date,
       s.end_date,
       s.end_date,
       NULL,
       s.type_concept_id,
       s.stop_reason,
       s.refills,
       s.quantity,
       s.days_supply,
       s.sig,
       s.route_concept_id,
       s.lot_number,
       s.provider_id,
       s.visit_occurrence_id,
       s.visit_detail_id,
       s.source_value,
       s.source_concept_id,
       s.route_source_value,
       s.dose_unit_source_value
from {TARGET_SCHEMA}.stem s
where source_concept_id in (
    35891522, --AstraZeneca vaccine
    35891709  --Pfizer vaccine
) and visit_occurrence_id is null


--insert into device_exposure from stem
insert into {TARGET_SCHEMA}.device_exposure(device_exposure_id, person_id, device_concept_id, device_exposure_start_date,
                                             device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime,
                                             device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id,
                                             visit_detail_id, device_source_value, device_source_concept_id)
select s.id,
       s.person_id,
       s.concept_id,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       s.end_date,
       s.end_date,
       s.type_concept_id,
       s.unique_device_id,
       s.quantity,
       s.provider_id,
       s.visit_occurrence_id,
       s.visit_detail_id,
       s.source_value,
       s.source_concept_id
from {TARGET_SCHEMA}.stem s
join {TARGET_SCHEMA}.visit_occurrence v
    on s.visit_occurrence_id = v.visit_occurrence_id
where s.domain_id = 'Device';


--insert into procedure_occurrence from stem
insert into {TARGET_SCHEMA}.procedure_occurrence(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date,
                                                  procedure_datetime, procedure_type_concept_id, modifier_concept_id, quantity,
                                                  provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value,
                                                  procedure_source_concept_id, modifier_source_value)
select s.id,
       s.person_id,
       s.concept_id,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       s.type_concept_id,
       s.modifier_concept_id,
       s.quantity,
       s.provider_id,
       s.visit_occurrence_id,
       s.visit_detail_id,
       s.source_value,
       s.source_concept_id,
       s.modifier_source_value
from {TARGET_SCHEMA}.stem s
join {TARGET_SCHEMA}.visit_occurrence v
    on s.visit_occurrence_id = v.visit_occurrence_id
where s.domain_id = 'Procedure';

--insert into measurement from stem
insert into {TARGET_SCHEMA}.measurement(measurement_id, person_id, measurement_concept_id, measurement_date,
                                         measurement_datetime, measurement_time, measurement_type_concept_id,
                                         operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id,
                                         range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id,
                                         measurement_source_value, measurement_source_concept_id, unit_source_value,
                                         value_source_value)
select s.id,
       s.person_id,
       s.concept_id,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       NULL,
       s.type_concept_id,
       s.operator_concept_id,
       s.value_as_number,
       s.value_as_concept_id,
       case when stsvm.target_concept_id is NULL
           then 0
           else stsvm.target_concept_id end as unit_concept_id,
       s.range_low,
       s.range_high,
       s.provider_id,
       s.visit_occurrence_id,
       s.visit_detail_id,
       s.source_value,
       s.source_concept_id,
       s.unit_source_value,
       s.value_source_value
from {TARGET_SCHEMA}.stem s
left join {TARGET_SCHEMA}.source_to_standard_vocab_map stsvm
    on s.unit_source_value = stsvm.source_code
	and stsvm.source_vocabulary_id = 'UCUM'
join {TARGET_SCHEMA}.visit_occurrence v
    on s.visit_occurrence_id = v.visit_occurrence_id
where s.domain_id = 'Measurement'
;


-- Update covid tests in measurement with concept_id and value_as_concept_id from covid_test_mappings
update {TARGET_SCHEMA}.measurement m
set value_as_concept_id = t.value_as_concept_id
from {SOURCE_SCHEMA}.covid_test_mappings t
where m.measurement_source_value = t.measurement_source_value
;

update {TARGET_SCHEMA}.measurement m
set measurement_concept_id = t.concept_id
from {SOURCE_SCHEMA}.covid_test_mappings t
where m.measurement_source_value = t.measurement_source_value
    and t.concept_id is not null
;


--insert into observation from stem
insert into {TARGET_SCHEMA}.observation (observation_id, person_id, observation_concept_id, observation_date,
                                          observation_datetime, observation_type_concept_id, value_as_number, value_as_string,
                                          value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id,
                                          visit_occurrence_id, visit_detail_id, observation_source_value,
                                          observation_source_concept_id, unit_source_value, qualifier_source_value)
select s.id,
       s.person_id,
       s.concept_id,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       case when s.start_date is NULL
           then v.visit_start_date
        else s.start_date end,
       s.type_concept_id,
       s.value_as_number,
       s.value_as_string,
       s.value_as_concept_id,
       s.qualifier_concept_id,
       case when stsvm.target_concept_id is NULL
           then 0
           else stsvm.target_concept_id end as unit_concept_id,
       s.provider_id,
       s.visit_occurrence_id,
       s.visit_detail_id,
       s.source_value,
       s.source_concept_id,
       s.unit_source_value,
       s.qualifier_source_value
from {TARGET_SCHEMA}.stem s
left join {TARGET_SCHEMA}.source_to_standard_vocab_map stsvm
    on s.unit_source_value = stsvm.source_code
	and stsvm.source_vocabulary_id = 'UCUM'
join {TARGET_SCHEMA}.visit_occurrence v
    on s.visit_occurrence_id = v.visit_occurrence_id
where s.domain_id not in ('Condition','Procedure', 'Measurement','Drug', 'Device')
;