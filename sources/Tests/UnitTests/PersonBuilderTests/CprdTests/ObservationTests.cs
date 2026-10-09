namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

public class ObservationTests
{
    [Fact]
    public void Build_Cprd_Observation_R50311_MapsClinicalObservationWithVisit() =>
        AssertReadObservation(50311, CprdReadSource.Clinical, "2012-01-01", "65PT.11", 40479404, 45425506, 32817);

    [Fact]
    public void Build_Cprd_Observation_R51311_MapsClinicalObservationWithoutConsultation() =>
        AssertReadObservation(51311, CprdReadSource.Clinical, "2012-03-01", "65PT.11", 40479404, 45425506, 32817);

    [Fact]
    public void Build_Cprd_Observation_R52311_RetainsObservationOutsideObservationPeriod() =>
        AssertReadObservation(52311, CprdReadSource.Clinical, "2009-03-01", "R100.00", 4044812, 45474099, 32817);

    [Fact]
    public void Build_Cprd_Observation_R53311_MapsImmunisationObservation() =>
        AssertReadObservation(53311, CprdReadSource.Immunisation, "2011-03-01", "R100.00", 4044812, 45474099, 32818);

    [Fact]
    public void Build_Cprd_Observation_R54311_MapsReferralObservation() =>
        AssertReadObservation(54311, CprdReadSource.Referral, "2011-03-01", "R100.00", 4044812, 45474099, 32817);

    [Fact]
    public void Build_Cprd_Observation_R55311_MapsTestReadToZeroConceptObservation()
    {
        const long id = 55311;
        var s = Patient(id);
        s.AddTestResult(id, "2011-03-01", "R100.00", "311-PF current");
        var o = Assert.Single(s.Build(id).Data.Observations);
        CprdRAssert.Common(o, id, 0, "2011-03-01", "R100.00", 45474099, 32856);
    }

    [Fact]
    public void Build_Cprd_Observation_R56311_KeepsUnmappedTestObservation()
    {
        const long id = 56311;
        var s = Patient(id);
        s.AddTestResult(id, "2011-03-01", "Z5A6200", "311-PF current");
        var o = Assert.Single(s.Build(id).Data.Observations);
        CprdRAssert.Common(o, id, 0, "2011-03-01", "Z5A6200", 0, 32856);
    }

    [Fact]
    public void Build_Cprd_Observation_R57311_KeepsUnmappedClinicalAsCondition()
    {
        const long id = 57311;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Clinical, "2011-01-01", "Z5A6200");
        var condition = Assert.Single(s.Build(id).Data.ConditionOccurrences);
        CprdRAssert.Common(condition, id, 0, "2011-01-01", "Z5A6200", 0, 32817);
    }

    [Fact]
    public void Build_Cprd_Observation_R58311_KeepsUnmappedReferralAsObservation()
    {
        const long id = 58311;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Referral, "2011-01-01", "Z5A6200");
        var o = Assert.Single(s.Build(id).Data.Observations);
        CprdRAssert.Common(o, id, 0, "2011-01-01", "Z5A6200", 0, 32817);
    }

    [Fact]
    public void Build_Cprd_Observation_R59311_MapsUnmappedTestReadToGenericMeasurement()
    {
        const long id = 59311;
        var s = Patient(id);
        s.AddTestResult(id, "2011-01-01", "Z5A6200", "215-Clotting Tests");
        var m = Assert.Single(s.Build(id).Data.Measurements);
        CprdRAssert.Common(m, id, 4199172, "2011-01-01", "Z5A6200", 0, 32856);
    }

    [Fact]
    public void Build_Cprd_Observation_R60311_KeepsUnmappedImmunisationAsObservation()
    {
        const long id = 60311;
        var s = Patient(id);
        s.AddRead(id, CprdReadSource.Immunisation, "2011-01-01", "Z5A6200");
        var o = Assert.Single(s.Build(id).Data.Observations);
        CprdRAssert.Common(o, id, 0, "2011-01-01", "Z5A6200", 0, 32818);
    }

    [Fact]
    public void Build_Cprd_Observation_R61311_MapsFourFieldTestToMeasurement()
    {
        const long id = 61311;
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", "65PT.11", "215-Clotting Tests", valueSource: "Normal");
        var m = Assert.Single(s.Build(id).Data.Measurements);
        Assert.Equal(4199172, m.ConceptId);
        Assert.Equal(CprdRAssert.Date("2012-01-01"), m.StartDate);
        Assert.Equal(32856, m.TypeConceptId);
        Assert.Equal("65PT.11", m.SourceValue);
    }

    [Fact]
    public void Build_Cprd_Observation_R62311_MapsSevenFieldTestObservation()
    {
        const long id = 62311;
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", "66Ya.00", "412-Airway ...",
            value: 3.7m, valueSource: "High", qualifierConceptId: 4172703,
            qualifierSource: "=", unitSource: "%", rangeLow: 3.4m, rangeHigh: 5.1m);
        var o = Assert.Single(s.Build(id).Data.Observations);
        Assert.Equal(0, o.ConceptId);
        Assert.Equal(3.7m, o.ValueAsNumber);
        Assert.Equal(4172703, o.QualifierConceptId);
        Assert.Equal("66Ya.00", o.SourceValue);
        Assert.Equal("%", o.UnitsSourceValue);
    }

    [Fact]
    public void Build_Cprd_Observation_R63311_PreservesUppercaseReadSourceConcept() => AssertCaseSensitive(63311, "339A.00", 45455049);

    [Fact]
    public void Build_Cprd_Observation_R64311_PreservesLowercaseReadSourceConcept() => AssertCaseSensitive(64311, "339a.00", 45421972);

    [Fact]
    public void Build_Cprd_Observation_R65311_MapsAdditionalDrugCode()
    {
        var o = Allergy("21-Allergy-Allergy-Drug Code");
        Assert.Equal("72487020", o.ValueAsString);
        Assert.Equal(1539463, o.ValueAsConceptId);
        Assert.Equal(0, o.ConceptId);
    }

    [Fact]
    public void Build_Cprd_Observation_R65311_MapsAdditionalReactionType()
    {
        var o = Allergy("21-Allergy-Allergy-Reaction Type");
        Assert.Equal("Intolerance", o.ValueAsString);
        Assert.Equal(0, o.ConceptId);
    }

    [Fact]
    public void Build_Cprd_Observation_R65311_MapsAdditionalSeverity()
    {
        var o = Allergy("21-Allergy-Allergy-Severity");
        Assert.Equal(3m, o.ValueAsNumber);
    }

    [Fact]
    public void Build_Cprd_Observation_R65311_MapsAdditionalCertainty()
    {
        var o = Allergy("21-Allergy-Allergy-Certainty");
        Assert.Equal(3m, o.ValueAsNumber);
    }

    [Fact]
    public void Build_Cprd_Observation_R65311_MapsAdditionalReactionReadCode()
    {
        var o = Allergy("21-Allergy-Allergy-Read Code For Reaction");
        Assert.Equal("M240012", o.ValueAsString);
    }

    [Fact]
    public void Build_Cprd_Observation_R66311_MapsUnmappedScoreCondition()
    {
        const long id = 66311;
        var s = Patient(id);
        s.AddObservation(id, "2010-01-01", 0, "372-0-100977", valueAsString: "1JJ..00");
        var o = Assert.Single(s.Build(id).Data.Observations);
        Assert.Equal(0, o.ConceptId);
        Assert.Equal(32817, o.TypeConceptId);
        Assert.Equal("1JJ..00", o.ValueAsString);
    }

    [Fact]
    public void Build_Cprd_Observation_R67311_DoesNotPutMappedScoreInObservation()
    {
        const long id = 67311;
        var s = Patient(id);
        s.AddMeasurement(id, "2010-01-01", 40769009, "372-0-10302", valueAsNumber: 500m);
        Assert.DoesNotContain(s.Build(id).Data.Observations,
            o => o.ConceptId == 40769009 && o.SourceValue == "372-0-10302" && o.ValueAsNumber == 500m);
    }

    [Fact]
    public void Build_Cprd_Observation_R68311_MapsScoreConditionField()
    {
        const long id = 68311;
        var s = Patient(id);
        s.AddObservation(id, "2010-01-01", 0,
            "372-Diagnostic Tests-Scoring test result-Condition", valueAsString: "7913");
        var o = Assert.Single(s.Build(id).Data.Observations);
        Assert.Equal(0, o.ConceptId);
        Assert.Equal("372-Diagnostic Tests-Scoring test result-Condition", o.SourceValue);
    }

    [Fact]
    public void Build_Cprd_Observation_R69311_MapsPregnancyDischargeDate()
    {
        const long id = 69311;
        var s = Patient(id);
        s.AddObservation(id, "2010-01-01", 0,
            "114-Maternity-Preg out-Discharge Date", valueAsString: "2003-12-07");
        var o = Assert.Single(s.Build(id).Data.Observations);
        Assert.Equal(0, o.ConceptId);
        Assert.Equal("114-Maternity-Preg out-Discharge Date", o.SourceValue);
    }

    [Fact]
    public void Build_Cprd_Observation_R70311_MapsGestationWeeksAndUnit()
    {
        const long id = 70311;
        var s = Patient(id);
        s.AddObservation(id, "2010-01-01", 0,
            "60-Maternity-Ante-natal booking-Weeks gestation", valueAsNumber: 8m,
            unitSourceValue: "week");
        var o = Assert.Single(s.Build(id).Data.Observations);
        Assert.Equal(8m, o.ValueAsNumber);
        Assert.Equal("week", o.UnitsSourceValue);
    }

    private static void AssertReadObservation(long id, CprdReadSource source, string date, string code,
        long concept, long sourceConcept, long type)
    {
        var s = Patient(id);
        s.AddRead(id, source, date, code);
        var o = Assert.Single(s.Build(id).Data.Observations);
        CprdRAssert.Common(o, id, concept, date, code, sourceConcept, type);
    }

    private static void AssertCaseSensitive(long id, string code, long sourceConcept)
    {
        var s = Patient(id);
        s.AddTestResult(id, "2012-01-01", code, "380-Pulmonary function tests", valueSource: "Normal");
        var o = Assert.Single(s.Build(id).Data.Observations);
        Assert.Equal(code, o.SourceValue);
        Assert.Equal(sourceConcept, o.SourceConceptId);
        Assert.Equal(32856, o.TypeConceptId);
    }

    private static org.ohdsi.cdm.framework.common.Omop.Observation Allergy(string sourceValue)
    {
        const long id = 65311;
        var s = Patient(id);
        s.AddObservation(id, "2010-01-01", 0, "21-Allergy-Allergy-Drug Code",
            valueAsString: "72487020", valueAsConceptId: 1539463);
        s.AddObservation(id, "2010-01-01", 0, "21-Allergy-Allergy-Reaction Type", valueAsString: "Intolerance");
        s.AddObservation(id, "2010-01-01", 0, "21-Allergy-Allergy-Severity", valueAsNumber: 3m);
        s.AddObservation(id, "2010-01-01", 0, "21-Allergy-Allergy-Certainty", valueAsNumber: 3m);
        s.AddObservation(id, "2010-01-01", 0, "21-Allergy-Allergy-Read Code For Reaction", valueAsString: "M240012");
        return CprdRAssert.Single(s.Build(id).Data.Observations, o => o.SourceValue == sourceValue);
    }

    private static CprdInMemoryScenario Patient(long id)
    {
        var s = new CprdInMemoryScenario();
        s.AddPatient(id);
        return s;
    }
}
