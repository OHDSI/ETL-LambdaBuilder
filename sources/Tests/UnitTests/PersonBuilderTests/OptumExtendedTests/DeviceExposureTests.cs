namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

public sealed class DeviceExposureTests
{
    [Fact]
    public void Build_OptumExtended_DeviceExposure_R1101_RoutesMedicalNdcToDevice()
    {
        var source = Person(1101);
        source.AddMedicalClaim(1101, "C1101", "2013-07-01", positionOfService: "21", ndc: "24840153001", locationCode: "2");

        var result = source.Build(1101);

        Assert.Contains(result.SourceVisits, item => item.ConceptId == 9201);
        var device = Assert.Single(result.Data.DeviceExposure);
        Assert.Equal(46358737, device.ConceptId);
        Assert.Equal("24840153001", device.SourceValue);
        Assert.Empty(result.Data.ConditionOccurrences);
    }

    [Fact]
    public void Build_OptumExtended_DeviceExposure_R1102_RoutesMedProcedureCodeToDeviceNotProcedure()
    {
        var source = Person(1102);
        source.AddMedicalClaim(1102, "C1102", "2013-07-01", positionOfService: "11", locationCode: "2");
        source.AddProcedure(1102, "C1102", "K0901");

        var result = source.Build(1102);

        Assert.Contains(result.SourceVisits, item => item.ConceptId == 9202);
        Assert.Contains(result.Data.DeviceExposure, item => item.SourceValue == "K0901");
        Assert.DoesNotContain(result.Data.ProcedureOccurrences, item => item.SourceValue == "K0901");
    }

    [Fact]
    public void Build_OptumExtended_DeviceExposure_R1103_RoutesMedicalProcedureCodeToDeviceNotProcedure()
    {
        var source = Person(1103);
        source.AddMedicalClaim(1103, "C1103", "2013-07-01", procedureCode: "K0901");

        var result = source.Build(1103);

        Assert.Contains(result.SourceVisits, item => item.ConceptId == 9202);
        Assert.Contains(result.Data.DeviceExposure, item => item.SourceValue == "K0901");
        Assert.DoesNotContain(result.Data.ProcedureOccurrences, item => item.SourceValue == "K0901");
    }

    private static OptumExtendedInMemoryScenario Person(long personId)
    {
        var source = new OptumExtendedInMemoryScenario();
        source.AddStandardPerson(personId, "2010-05-01", "2013-10-31");
        return source;
    }
}
