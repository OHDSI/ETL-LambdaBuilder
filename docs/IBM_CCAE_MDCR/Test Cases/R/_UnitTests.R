source('R/CareSiteTests.R')
source('R/CostTests.R')
 

createTests <- function(frameworkType) {
  #declareTestGroup("Care Site", 1)
  createCareSiteTests(frameworkType);
  
  #declareTestGroup("Cost", 2)
  #createCostTests(frameworkType);
  
}
