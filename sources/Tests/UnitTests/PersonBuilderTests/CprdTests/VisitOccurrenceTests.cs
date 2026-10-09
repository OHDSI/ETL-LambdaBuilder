namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class VisitOccurrenceTests
{
    [Fact]
    public void Build_Cprd_VisitOccurrence_R91555_DoesNotCreateVisitFromConsultationsAlone()
    {
        const long id = 91555;
        var s = Patient(id);
        Assert.Empty(s.Build(id).Data.VisitOccurrences);
    }

    [Fact]
    public void Build_Cprd_VisitOccurrence_R92555_DoesNotCreateVisitForNullEventDate()
    {
        const long id = 92555;
        var s = Patient(id);
        Assert.Empty(s.Build(id).Data.VisitOccurrences);
    }

    [Fact]
    public void Build_Cprd_VisitOccurrence_R93555_DoesNotCreateVisitFromOutOfPeriodConsultationAlone()
    {
        const long id = 93555;
        var s = Patient(id);
        Assert.Empty(s.Build(id).Data.VisitOccurrences);
    }

    [Fact]
    public void Build_Cprd_VisitOccurrence_R94555_CollapsesTwoRecordsOnSameDay()
    {
        const long id = 94555;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Clinical, "2013-04-01", "K17y000", consultationType: 9);
        s.AddRead(id, CprdReadSource.Clinical, "2013-04-01", "K17y000", consultationType: 9);
        Assert.Single(s.Build(id).Data.VisitOccurrences);
    }

    private static CprdInMemoryScenario Patient(long id)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id, gender: 1, yob: 172, crd: "2013-01-01", tod: "2013-12-31", pracid: 555);
        return s;
    }
}
