namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class ProcedureOccurrenceTests
{
    [Fact]
    public void Build_Cprd_Procedure_R82311_MapsClinicalProcedureWithVisit() =>
        AssertProcedure(82311, CprdReadSource.Clinical, "2012-01-01", "7J46z00", 4074106, 45419444, 32817);

    [Fact]
    public void Build_Cprd_Procedure_R83311_MapsClinicalProcedureWithoutConsultation() =>
        AssertProcedure(83311, CprdReadSource.Clinical, "2012-03-01", "7414200", 4336549, 45425628, 32817);

    [Fact]
    public void Build_Cprd_Procedure_R84311_RetainsProcedureOutsideObservationPeriod() =>
        AssertProcedure(84311, CprdReadSource.Clinical, "2009-03-01", "744C.00", 4192131, 45425639, 32817);

    [Fact]
    public void Build_Cprd_Procedure_R85311_MapsImmunisationProcedure() =>
        AssertProcedure(85311, CprdReadSource.Immunisation, "2011-03-01", "744C.00", 4192131, 45425639, 32818);

    [Fact]
    public void Build_Cprd_Procedure_R86311_MapsReferralProcedure() =>
        AssertProcedure(86311, CprdReadSource.Referral, "2011-03-01", "744C.00", 4192131, 45425639, 32817);

    [Fact]
    public void Build_Cprd_Procedure_R87311_MapsTestProcedureAsMeasurement()
    {
        const long id = 87311;
        var s = Patient(id);
        s.AddTestResult(id, "2011-03-01", "744C.00", "215-Clotting Tests");
        var measurement = Assert.Single(s.Build(id).Data.Measurements);
        CprdRAssert.Common(measurement, id, 4199172, "2011-03-01", "744C.00", 45425639, 32856);
    }

    private static void AssertProcedure(long id, CprdReadSource source, string date, string code,
        long concept, long sourceConcept, long type)
    {
        var s = Patient(id);
        s.AddRead(id, source, date, code);
        var procedure = Assert.Single(s.Build(id).Data.ProcedureOccurrences);
        CprdRAssert.Common(procedure, id, concept, date, code, sourceConcept, type);
        Assert.Equal(1001, procedure.ProviderId);
    }

    private static CprdInMemoryScenario Patient(long id)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id);
        return s;
    }
}
