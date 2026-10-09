using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

public sealed class DeviceExposureTests
{
    [Fact]
    public void Build_OptumPanther_DeviceExposure_R134_RoutesHcpcsProcedureToDevice()
    {
        var source = StandardPerson(134);
        source.AddProcedure(134, "A4217", "HCPCS", "2009-01-01");

        var result = Build(source, 134);
        var device = Assert.Single(result.Data.DeviceExposure);

        Assert.Equal(2614697, device.ConceptId);
        Assert.Equal("A4217", device.SourceValue);
        Assert.DoesNotContain(result.Data.ProcedureOccurrences, item => item.SourceValue == "A4217");
    }

    [Fact]
    public void Build_OptumPanther_DeviceExposure_R135_RoutesSnomedDiagnosisToDevice()
    {
        var source = StandardPerson(135);
        source.AddDiagnosis(135, "156009", "SNOMED", diagnosisDate: "2009-01-01");

        var result = Build(source, 135);
        var device = Assert.Single(result.Data.DeviceExposure);

        Assert.Equal(4048868, device.ConceptId);
        Assert.Equal("156009", device.SourceValue);
        Assert.DoesNotContain(result.Data.ConditionOccurrences, item => item.SourceValue == "156009");
    }

    private static OptumPantherInMemoryScenario StandardPerson(long personId)
    {
        var source = new OptumPantherInMemoryScenario();
        source.AddStandardPerson(personId, "Male", "1950", idnIndicator: false,
            firstMonthActive: "200701", lastMonthActive: "201001");
        return source;
    }

    private static OptumPantherBuildResult Build(OptumPantherInMemoryScenario source, long personId)
    {
        var result = source.Build(personId);
        Assert.Equal(Attrition.None, result.Attrition);
        return result;
    }
}
