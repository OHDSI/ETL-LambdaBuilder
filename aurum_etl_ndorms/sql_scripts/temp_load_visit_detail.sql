insert into visit_detail(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date,
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
from source.chunk ch
left join source.temp_visit_detail tvd
	on ch.person_id = tvd.person_id
left join source.temp_visit_occurrence tvo --left join because some of the visit_occurrence_ids are null
    on tvd.person_id = tvo.person_id
    and tvd.visit_detail_start_date = tvo.visit_start_date
    and tvd.care_site_id = tvo.care_site_id
left join source.temp_visit_detail tvd2
    on tvd.parent_visit_detail_source_id = tvd2.visit_detail_source_id
	and tvd2.source_table = 'Observation' -- This condition wasn't in Clair's etl, but it avoids garbage duplication of rows where parentobsid = consid
where ch.chunk_id = {CHUNK_ID}
	and tvd.visit_detail_start_date is not null
;