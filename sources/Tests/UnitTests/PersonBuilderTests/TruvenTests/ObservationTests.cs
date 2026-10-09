namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

public class ObservationTests
{
    [Fact]
    public void Build_Truven_Observation_R149_KeepsHraMeasurementOutsideObservationPeriod()
    {
        var s = Scenario(149);
        s.AddHealthRiskAssessment(149, "2013-10-13", bmi: "20.0");
        Assert.Contains(s.Build(149).Data.Measurements,
            x => x.SourceValue == "BMI" && x.ValueAsNumber == 20m && x.StartDate == new DateTime(2013, 10, 13));
    }

    [Fact] public void Build_Truven_Observation_R151_MapsExerciseFrequency() => AssertHraValue(151, "2012-05-25", "EXERWEEK", "3", 3m);
    [Fact] public void Build_Truven_Observation_R153_MapsCigarettePackAmount() => AssertHraValue(153, "2012-03-14", "CGTPKAMT", "2", 2m);

    [Fact]
    public void Build_Truven_Observation_R155_MapsFluShotAnswer()
    {
        var s = Scenario(155);
        s.AddHealthRiskAssessment(155, "2012-05-25", fluShot: "1");
        Assert.Contains(s.Build(155).Data.Observations, x => x.SourceValue == "FLU_SHOT");
    }

    [Fact] public void Build_Truven_Observation_R157_KeepsHraObservationOutsidePeriod() => AssertHraValue(157, "2022-03-14", "CGTPKAMT", "2", 2m);

    private static void AssertHraValue(long id, string date, string source, string value, decimal expected)
    {
        var s = Scenario(id);
        if (source == "EXERWEEK") s.AddHealthRiskAssessment(id, date, exerweek: value);
        else s.AddHealthRiskAssessment(id, date, cgtpkamt: value);
        Assert.Contains(s.Build(id).Data.Observations,
            x => x.SourceValue == source && x.ValueAsNumber == expected && x.StartDate == DateTime.Parse(date));
    }

    private static TruvenInMemoryScenario Scenario(long id)
    {
        var s = new TruvenInMemoryScenario();
        s.AddEnrollmentDetail(id, "2012-01-01", "2012-12-31");
        return s;
    }
}
