with states as
(
    SELECT 'AK' as Abbreivation, 'Alaska' as FullName union 
    SELECT 'AL' as Abbreivation, 'Alabama' as FullName union 
    SELECT 'AR' as Abbreivation, 'Arkansas' as FullName union 
    SELECT 'AZ' as Abbreivation, 'Arizona' as FullName union 
    SELECT 'CA' as Abbreivation, 'California' as FullName union 
    SELECT 'CO' as Abbreivation, 'Colorado' as FullName union 
    SELECT 'CT' as Abbreivation, 'Connecticut' as FullName union 
    SELECT 'DC' as Abbreivation, 'District of Columbia' as FullName union 
    SELECT 'DE' as Abbreivation, 'Delaware' as FullName union 
    SELECT 'FL' as Abbreivation, 'Florida' as FullName union 
    SELECT 'GA' as Abbreivation, 'Georgia' as FullName union 
    SELECT 'HI' as Abbreivation, 'Hawaii' as FullName union 
    SELECT 'IA' as Abbreivation, 'Iowa' as FullName union 
    SELECT 'ID' as Abbreivation, 'Idaho' as FullName union 
    SELECT 'IL' as Abbreivation, 'Illinois' as FullName union 
    SELECT 'IN' as Abbreivation, 'Indiana' as FullName union 
    SELECT 'KS' as Abbreivation, 'Kansas' as FullName union 
    SELECT 'KY' as Abbreivation, 'Kentucky' as FullName union 
    SELECT 'LA' as Abbreivation, 'Louisiana' as FullName union 
    SELECT 'MA' as Abbreivation, 'Massachusetts' as FullName union 
    SELECT 'MD' as Abbreivation, 'Maryland' as FullName union 
    SELECT 'ME' as Abbreivation, 'Maine' as FullName union 
    SELECT 'MH' as Abbreivation, 'Marshall Islands' as FullName union 
    SELECT 'MI' as Abbreivation, 'Michigan' as FullName union 
    SELECT 'MN' as Abbreivation, 'Minnesota' as FullName union 
    SELECT 'MO' as Abbreivation, 'Missouri' as FullName union 
    SELECT 'MS' as Abbreivation, 'Mississippi' as FullName union 
    SELECT 'MT' as Abbreivation, 'Montana' as FullName union 
    SELECT 'NC' as Abbreivation, 'North Carolina' as FullName union 
    SELECT 'ND' as Abbreivation, 'North Dakota' as FullName union 
    SELECT 'NE' as Abbreivation, 'Nebraska' as FullName union 
    SELECT 'NH' as Abbreivation, 'New Hampshire' as FullName union 
    SELECT 'NJ' as Abbreivation, 'New Jersey' as FullName union 
    SELECT 'NM' as Abbreivation, 'New Mexico' as FullName union 
    SELECT 'NV' as Abbreivation, 'Nevada' as FullName union 
    SELECT 'NY' as Abbreivation, 'New York' as FullName union 
    SELECT 'OH' as Abbreivation, 'Ohio' as FullName union 
    SELECT 'OK' as Abbreivation, 'Oklahoma' as FullName union 
    SELECT 'OR' as Abbreivation, 'Oregon' as FullName union 
    SELECT 'PA' as Abbreivation, 'Pennsylvania' as FullName union 
    SELECT 'PR' as Abbreivation, 'Puerto Rico' as FullName union 
    SELECT 'RI' as Abbreivation, 'Rhode Island' as FullName union 
    SELECT 'SC' as Abbreivation, 'South Carolina' as FullName union 
    SELECT 'SD' as Abbreivation, 'South Dakota' as FullName union 
    SELECT 'TN' as Abbreivation, 'Tennessee' as FullName union 
    SELECT 'TX' as Abbreivation, 'Texas' as FullName union 
    SELECT 'UT' as Abbreivation, 'Utah' as FullName union 
    SELECT 'VA' as Abbreivation, 'Virginia' as FullName union 
    SELECT 'VT' as Abbreivation, 'Vermont' as FullName union 
    SELECT 'WA' as Abbreivation, 'Washington' as FullName union 
    SELECT 'WI' as Abbreivation, 'Wisconsin' as FullName union 
    SELECT 'WV' as Abbreivation, 'West Virginia' as FullName union 
    SELECT 'WY' as Abbreivation, 'Wyoming' as FullName 

)
, stateWithConcept as
(
  select a.*, b.concept_name, b.concept_id
  from states as a
  left join
  (
    select concept_name, concept_id
    from optum_extended_dod.cdm.concept 
    where vocabulary_id = 'OSM'
    and concept_class_id = '4th level'
    and invalid_reason is null
    and standard_concept = 'S'
    ) as b
  on a.FullName = b.concept_name
)
, datastate as
(
   select State, count(*) count
   from optum_extended_dod.native.member_enrollment
   group by state
   
   union
   
  select prov_state as state, count(*) count
  from optum_extended_dod.native.provider
  group by prov_state
)
, datastate2 as
(
  select state, sum(count) count
  from datastate 
  group by state
 )
 select a.*, b.FullName, b.concept_name, b.concept_id
 from datastate2 as a
 left join stateWithConcept as b
 on a.state = b.Abbreivation
order by a.state
