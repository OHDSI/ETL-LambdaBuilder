createProviderTests <- function()
{
  add_lookup(lookup_id=942, lookup_type_id=76, code=2, text='Partner')
  add_lookuptype(lookup_type_id=76, name='ROL', description='Role of Staff')
  add_lookup(lookup_id=943, lookup_type_id=76, code=68, text='Radiographer')
  add_lookup(lookup_id=944, lookup_type_id=76, code=0, text='Data Not Entered')

  provider <- createProvider();
  declareTest(id = provider$provider_id, 'valid GP: role=2 (Partner); provider_concept_id=32577 id is provider_id')
  add_staff(staffid = 1001, role=2)
  expect_provider(provider_id = 1001, specialty_source_value = "Partner", specialty_concept_id = 32577)

  provider <- createProvider();
  declareTest(id = provider$provider_id, 'valid GP: role=68 (Radiographer ); provider_concept_id=45756825 id is provider_id')
  add_staff(staffid = provider$staffid, role=68)
  expect_provider(provider_id = provider$staffid, specialty_source_value = "Radiographer", specialty_concept_id = 45756825)

  provider <- createProvider();
  declareTest(id = provider$provider_id, 'valid GP: role=0 (Data Not Entered ) provider concept_id=0 id is provider_id')
  add_staff(staffid = provider$staffid, role=0)
  expect_provider(provider_id = provider$staffid, specialty_source_value = "Data Not Entered", specialty_concept_id = 38004514)

}
