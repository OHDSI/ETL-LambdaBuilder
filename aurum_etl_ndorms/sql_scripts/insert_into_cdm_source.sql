-- Insert into the cdm_source
insert into cdm_source(cdm_source_name, cdm_source_abbreviation, cdm_holder,
                                        source_description, source_documentation_reference,
                                        cdm_etl_reference, source_release_date, cdm_release_date,
                                        cdm_version, vocabulary_version)
select 'p20_059_cdm_aurum', 'p20_059_cdm_aurum', 'University of Oxford', 'CPRD Aurum is a UK general practioner database containing diagnosis, lab, procedure, and prescriptions written data from contributing practices.',
NULL, NULL, '17-May-2021', '2018-06-14', 'v5.3.1', 'v5.0 05-MAY-2021'
;