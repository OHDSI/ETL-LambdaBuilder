source("R/ConditionOccurrenceTests.R");
source("R/CostTests.R");
source("R/DeathTests.R");
source("R/DeviceExposureTests.R");
source("R/DrugExposureTests.R");
source("R/LocationTests.R");
source("R/MeasurementTests.R");
source("R/ObservationPeriodTests.R");
source("R/ObservationTests.R");
source("R/PayerPlanPeriodTests.R");
source("R/PersonTests.R");
source("R/ProcedureOccurrenceTests.R");
source("R/ProviderTests.R");
source("R/VisitOccurrenceTests.R");

createTests <- function() {
  # declareTestGroup("Condition Occurrence")
  createConditionOccurrenceTests();
  # declareTestGroup("Cost")
  createCostTests();
  # declareTestGroup("Death")
  # createDeathTests();
  # declareTestGroup("Device Exposure")
  createDeviceExposureTests();
  # declareTestGroup("Drug Exposure")
  createDrugExposureTests();
  # declareTestGroup("Location")
  createLocationTests();
  # declareTestGroup("Measurement")
  createMeasurementTests();
  # declareTestGroup("Observation Period")
  createObservationPeriodTests();
  # declareTestGroup("Observation")
  createObservationTests();
  # declareTestGroup("Payer Plan Period")
  createPayerPlanPeriodTests();
  # declareTestGroup("Person");
  createPersonTests();
  # declareTestGroup("Procedure Occurrence")
  createProcedureOccurrenceTests();
  # declareTestGroup("Provider")
  createProviderTests();
  # declareTestGroup("Visit Occurrence")
  createVisitOccurrenceTests();
}
