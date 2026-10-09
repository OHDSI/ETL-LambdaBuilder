using org.ohdsi.cdm.framework.common.Omop;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

public sealed class DrugExposureTests
{
    [Fact]
    public void Build_Jmdc_DrugExposure_R801_DrugExposurePersonId()
    {
        const string memberId = "M000000801";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000801");
        source.AddDrug(memberId, "C000000000801");

        Assert.Equal(801L, VisitDrug(source, memberId, 801).PersonId);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R802_DrugExposureVisitOccurrenceId()
    {
        const string memberId = "M000000802";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000802");
        source.AddDrug(memberId, "C000000000802");

        Assert.Equal(802L, VisitDrug(source, memberId, 802).VisitOccurrenceId);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R803_DrugExposureTypeConceptId()
    {
        const string memberId = "M000000803";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000803");
        source.AddDrug(memberId, "C000000000803", typeOfClaim: "Outpatient");
        source.AddClaim(memberId, "C000000000804");
        source.AddDrug(memberId, "C000000000804", typeOfClaim: "Inpatient");
        source.AddClaim(memberId, "C000000000805");
        source.AddDrug(memberId, "C000000000805", typeOfClaim: "DPC");
        source.AddClaim(memberId, "C000000000806");
        source.AddDrug(memberId, "C000000000806", typeOfClaim: "Pharmacy");

        var drugs = source.Build(memberId).DrugExposures;

        Assert.Equal(32869L, Assert.Single(drugs, x => x.VisitOccurrenceId == 803).TypeConceptId);
        Assert.Equal(32818L, Assert.Single(drugs, x => x.VisitOccurrenceId == 804).TypeConceptId);
        Assert.Equal(32818L, Assert.Single(drugs, x => x.VisitOccurrenceId == 805).TypeConceptId);
        Assert.Equal(32869L, Assert.Single(drugs, x => x.VisitOccurrenceId == 806).TypeConceptId);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R804_DrugProviderFromInstitutionId()
    {
        const string memberId = "M000000804";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000807");
        source.AddDrug(memberId, "C000000000807", medicalFacilityId: "F0000007");

        Assert.Equal(10000007L, VisitDrug(source, memberId, 807).ProviderId);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R806_DrugStartDateFromPrescriptionDate()
    {
        const string memberId = "M000000806";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000809");
        source.AddDrug(memberId, "C000000000809", dateOfPrescription: "2010-01-05");

        Assert.Equal(new DateTime(2010, 1, 5), VisitDrug(source, memberId, 809).StartDate);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R807_DrugStartDateFromVisitDate()
    {
        const string memberId = "M000000807";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000810",
            typeOfClaim: "pharmacy", monthAndYearOfMedicalCare: "201002");
        source.AddDrug(memberId, "C000000000810", dateOfPrescription: null);

        var drug = Assert.Single(source.Build(memberId).DrugExposures);

        Assert.Null(drug.VisitOccurrenceId);
        Assert.Equal(new DateTime(2010, 2, 15), drug.StartDate);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R808_DrugEndDate()
    {
        const string memberId = "M000000808";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000811");
        source.AddClaim(memberId, "C000000000812");
        source.AddDrug(memberId, "C000000000811",
            dateOfPrescription: "2010-01-05", administeredDays: 3);
        source.AddDrug(memberId, "C000000000812",
            dateOfPrescription: "2010-01-01", administeredDays: 365);

        var drugs = source.Build(memberId).DrugExposures;

        Assert.Equal(new DateTime(2010, 1, 7),
            Assert.Single(drugs, x => x.VisitOccurrenceId == 811).EndDate);
        Assert.Equal(new DateTime(2010, 1, 1).AddDays(179),
            Assert.Single(drugs, x => x.VisitOccurrenceId == 812).EndDate);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R809_DrugDaysSupply()
    {
        const string memberId = "M000000809";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000813");
        source.AddClaim(memberId, "C000000000814");
        source.AddDrug(memberId, "C000000000813", administeredDays: 3);
        source.AddDrug(memberId, "C000000000814", administeredDays: 365);

        var drugs = source.Build(memberId).DrugExposures;

        Assert.Equal(3, Assert.Single(drugs, x => x.VisitOccurrenceId == 813).DaysSupply);
        Assert.Equal(180, Assert.Single(drugs, x => x.VisitOccurrenceId == 814).DaysSupply);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R810_DrugConceptId()
    {
        const string memberId = "M000000810";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000815");
        source.AddDrug(memberId, "C000000000815", jmdcDrugCode: 100000008105);

        var drug = VisitDrug(source, memberId, 815);

        Assert.Equal(35152527L, drug.ConceptId);
        Assert.Equal("100000008105", drug.SourceValue);
    }

    [Fact]
    public void Build_Jmdc_DrugExposure_R811_DrugSig()
    {
        const string memberId = "M000000811";
        var source = new JmdcInMemoryScenario();
        source.AddEnrollment(memberId);
        source.AddClaim(memberId, "C000000000816");
        source.AddDrug(memberId, "C000000000816",
            prescribedAmountPerDay: "1",
            asNeededMedicationFlag: "1",
            administeredAmount: "20",
            unitOfAdministeredAmount: "g");

        Assert.Equal("1 g per day as needed, 20 g total", VisitDrug(source, memberId, 816).Sig);
    }

    private static DrugExposure VisitDrug(
        JmdcInMemoryScenario source,
        string memberId,
        long visitId)
    {
        return Assert.Single(
            source.Build(memberId).DrugExposures,
            item => item.VisitOccurrenceId == visitId);
    }
}
