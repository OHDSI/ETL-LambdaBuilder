namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class ConditionOccurrenceTests
{
    [Fact]
    public void Build_Cprd_ConditionOccurrence_R2311_MapsClinicalConditionWithVisit() =>
        AssertCondition(2311, CprdReadSource.Clinical, "2012-01-01", "F563500", 75555, 45436713, 32817);

    [Fact]
    public void Build_Cprd_ConditionOccurrence_R3311_MapsClinicalConditionWithoutConsultation() =>
        AssertCondition(3311, CprdReadSource.Clinical, "2012-03-01", "K17y000", 195862, 45453481, 32817);

    [Fact]
    public void Build_Cprd_ConditionOccurrence_R4311_RetainsConditionOutsideObservationPeriod() =>
        AssertCondition(4311, CprdReadSource.Clinical, "2009-03-01", "K17y000", 195862, 45453481, 32817);

    [Fact]
    public void Build_Cprd_ConditionOccurrence_R5311_MapsClinicalImmunisationCodeAsCondition() =>
        AssertCondition(5311, CprdReadSource.Clinical, "2011-03-01", "J040.14", 4123595, 45463565, 32817);

    [Fact]
    public void Build_Cprd_ConditionOccurrence_R6311_MapsReferralCondition() =>
        AssertCondition(6311, CprdReadSource.Referral, "2011-03-01", "P00..00", 377368, 45420722, 32817);

    [Fact]
    public void Build_Cprd_ConditionOccurrence_R7111_RemovesFutureClinicalCondition()
    {
        const long id = 7111;
        var s = Patient(id, 111);
        s.AddRead(id, CprdReadSource.Clinical, "2099-01-01", "F563500");
        Assert.Empty(s.Build(id).Data.ConditionOccurrences);
    }

    [Fact]
    public void Build_Cprd_ConditionOccurrence_R8111_RemovesFutureTestCondition()
    {
        const long id = 8111;
        var s = Patient(id, 111);
        s.AddTestResult(id, "2099-03-01", "PB2z.00", "215-Clotting Tests");
        Assert.Empty(s.Build(id).Data.ConditionOccurrences);
    }

    private static void AssertCondition(long id, CprdReadSource source, string date, string code,
        long concept, long sourceConcept, long type)
    {
        var s = Patient(id);
        s.AddRead(id, source, date, code);
        var data = s.Build(id).Data;
        var condition = Assert.Single(data.ConditionOccurrences);
        CprdRAssert.Common(condition, id, concept, date, code, sourceConcept, type);
        Assert.Equal(1001, condition.ProviderId);
    }

    private static CprdInMemoryScenario Patient(long id, long pracid = 311)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, pracid: pracid);
        return s;
    }
}
