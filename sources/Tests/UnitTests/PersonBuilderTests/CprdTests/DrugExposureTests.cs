namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class DrugExposureTests
{
    [Fact]
    public void Build_Cprd_DrugExposure_R13311_UsesDaysSupplyDecode() =>
        AssertTherapy(13311, "2012-01-01", "58976020", 29, 19073982, "2012-01-29");

    [Fact]
    public void Build_Cprd_DrugExposure_R14311_DefaultsMissingLookupToOneDay() =>
        AssertTherapy(14311, "2012-01-01", "72487020", 1, 1539463, "2012-01-01");

    [Fact]
    public void Build_Cprd_DrugExposure_R15311_DefaultsUnknownDaysSupplyToOneDay() =>
        AssertTherapy(15311, "2012-01-01", "93680020", 1, 0, "2012-01-01");

    [Fact]
    public void Build_Cprd_DrugExposure_R16311_UsesExplicitFortyDays() =>
        AssertTherapy(16311, "2012-01-01", "58976020", 40, 19073982, "2012-02-09");

    [Fact]
    public void Build_Cprd_DrugExposure_R17311_ReplacesInvalid366DaysWithDecode() =>
        AssertTherapy(17311, "2012-01-01", "58976020", 29, 19073982, "2012-01-29");

    [Fact]
    public void Build_Cprd_DrugExposure_R18311_LinksTherapyVisit()
    {
        const long id = 18311;
        var s = Patient(id);
        s.AddTherapy(id, "2012-03-12", "58976020", 29, consultationType: 9);
        var drug = Assert.Single(s.Build(id).Data.DrugExposures);
        Assert.Equal(CprdRAssert.Date("2012-03-12"), drug.StartDate);
        Assert.NotNull(drug.VisitOccurrenceId);
    }

    [Fact]
    public void Build_Cprd_DrugExposure_R19311_KeepsTherapyWithoutConsultation() =>
        AssertTherapy(19311, "2012-01-01", "58976020", 29, 19073982, "2012-01-29");

    [Fact]
    public void Build_Cprd_DrugExposure_R20311_DropsInvalidMinusOneProduct()
    {
        const long id = 20311;
        var s = Patient(id);
        s.AddTherapy(id, "2012-01-01", "-1", 29);
        Assert.Empty(s.Build(id).Data.DrugExposures);
    }

    [Fact]
    public void Build_Cprd_DrugExposure_R21311_AcceptsImmunisationStatusFour()
    {
        const long id = 21311;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Immunisation, "2012-01-01", "65F5.00");
        Assert.Single(s.Build(id).Data.DrugExposures);
    }

    [Fact]
    public void Build_Cprd_DrugExposure_R22311_MapsImmunisationCodeToProcedureWithVisit() =>
        AssertProcedureRead(22311, CprdReadSource.Immunisation, "2012-01-01", 32818);

    [Fact]
    public void Build_Cprd_DrugExposure_R23311_MapsImmunisationCodeToProcedureWithoutConsultation() =>
        AssertProcedureRead(23311, CprdReadSource.Immunisation, "2012-01-01", 32818);

    [Fact]
    public void Build_Cprd_DrugExposure_R24311_RetainsMappedProcedureOutsideObservationPeriod() =>
        AssertProcedureRead(24311, CprdReadSource.Clinical, "2009-03-01", 32817);

    [Fact]
    public void Build_Cprd_DrugExposure_R25311_MapsImmunisationConditionToConditionDomain()
    {
        const long id = 25311;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Immunisation, "2009-03-01", "F563500");
        Assert.Single(s.Build(id).Data.ConditionOccurrences);
    }

    [Fact]
    public void Build_Cprd_DrugExposure_R26311_MapsClinicalReadToProcedure() =>
        AssertProcedureRead(26311, CprdReadSource.Clinical, "2010-03-01", 32817);

    [Fact]
    public void Build_Cprd_DrugExposure_R27311_MapsReferralReadToProcedure() =>
        AssertProcedureRead(27311, CprdReadSource.Referral, "2010-03-01", 32817);

    [Fact]
    public void Build_Cprd_DrugExposure_R28311_MapsClinicalReadToDrug() => AssertReadDrug(28311);

    [Fact]
    public void Build_Cprd_DrugExposure_R29311_MapsSecondClinicalReadToDrug() => AssertReadDrug(29311);

    [Fact]
    public void Build_Cprd_DrugExposure_R30311_RemovesFutureImmunisationDrug()
    {
        const long id = 30311;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Immunisation, "2099-01-01", "65M4.00");
        Assert.Empty(s.Build(id).Data.DrugExposures);
    }

    [Fact]
    public void Build_Cprd_DrugExposure_R31311_RemovesFutureTherapyDrug()
    {
        const long id = 31311;
        var s = Patient(id);
        s.AddTherapy(id, "2099-01-01", "58976020", 29);
        Assert.Empty(s.Build(id).Data.DrugExposures);
    }

    private static void AssertTherapy(long id, string start, string source, int days,
        long concept, string end)
    {
        var s = Patient(id);
        s.AddTherapy(id, start, source, days);
        var drug = Assert.Single(s.Build(id).Data.DrugExposures);
        Assert.Equal(id, drug.PersonId);
        Assert.Equal(concept, drug.ConceptId);
        Assert.Equal(source, drug.SourceValue);
        Assert.Equal(1m, drug.Quantity);
        Assert.Equal(1, drug.Refills);
        Assert.Equal(CprdRAssert.Date(end), drug.EndDate);
    }

    private static void AssertProcedureRead(long id, CprdReadSource source, string date, long type)
    {
        var s = Patient(id);
        s.AddRead(id, source, date, "65M4.00");
        var procedure = Assert.Single(s.Build(id).Data.ProcedureOccurrences);
        CprdRAssert.Common(procedure, id, 44792015, date, "65M4.00", 45498792, type);
    }

    private static void AssertReadDrug(long id)
    {
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Clinical, "2010-03-01", "65A..00");
        var drug = Assert.Single(s.Build(id).Data.DrugExposures);
        CprdRAssert.Common(drug, id, 40213170, "2010-03-01", "65A..00", 45445397, 32817);
    }

    private static CprdInMemoryScenario Patient(long id)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id);
        return s;
    }
}
