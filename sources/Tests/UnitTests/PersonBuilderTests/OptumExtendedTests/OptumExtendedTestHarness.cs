using System.Globalization;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.etl.Transformation.OptumExtended;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumExtendedTests;

internal enum OptumExtendedFlavor
{
    Ses,
    Dod
}

internal sealed record OptumExtendedBuildResult(ChunkData Data, Attrition Attrition)
{
    internal IEnumerable<VisitOccurrence> SourceVisits =>
        Data.VisitOccurrences.Where(item => !OptumExtendedInMemoryScenario.IsBaseline(item));

    internal IEnumerable<VisitDetail> SourceVisitDetails =>
        Data.VisitDetails.Where(item => !OptumExtendedInMemoryScenario.IsBaseline(item));
}

internal sealed record OptumExtendedStaticData(
    IReadOnlyList<CareSite> CareSites,
    IReadOnlyList<Provider> Providers,
    IReadOnlyList<Location> Locations);

/// <summary>
/// In-memory replacement for the Optum source schema used by the R tests.
/// </summary>
internal sealed class OptumExtendedInMemoryScenario
{
    private const string BaselineMarker = "unit_test_baseline";
    private readonly OptumExtendedFlavor _flavor;
    private readonly OptumExtendedTestVocabulary _vocabulary = new();
    private readonly List<ContinuousEnrollmentRow> _continuousEnrollments = [];
    private readonly List<MemberEnrollmentRow> _memberEnrollments = [];
    private readonly List<MedicalClaimRow> _medicalClaims = [];
    private readonly List<DiagnosisRow> _diagnoses = [];
    private readonly List<ProcedureRow> _procedures = [];
    private readonly List<RxRow> _rxClaims = [];
    private readonly List<LabRow> _labs = [];
    private readonly List<InpatientRow> _inpatient = [];
    private readonly List<DeathRow> _deaths = [];
    private readonly List<ProviderRow> _providers = [];
    private readonly List<ProviderBridgeRow> _providerBridges = [];

    internal OptumExtendedInMemoryScenario(OptumExtendedFlavor flavor = OptumExtendedFlavor.Ses)
    {
        _flavor = flavor;
    }

    internal OptumExtendedTestVocabulary Vocabulary => _vocabulary;

    internal static bool IsBaseline(IEntity entity) =>
        entity.AdditionalFields is not null &&
        entity.AdditionalFields.TryGetValue(BaselineMarker, out var value) &&
        value == "true";

    internal void AddStandardPerson(
        long personId,
        string start = "2010-05-01",
        string end = "2014-10-31",
        string gender = "F",
        int yearOfBirth = 1969,
        string race = "U",
        string ethnicity = "U",
        string? region = null,
        string? state = null)
    {
        AddContinuousEnrollment(personId, start, end, gender, yearOfBirth);
        AddMemberEnrollment(
            personId,
            start,
            end,
            race: race,
            ethnicity: ethnicity,
            region: region,
            state: state);
    }

    internal void AddContinuousEnrollment(
        long personId,
        string start,
        string end,
        string gender = "M",
        int yearOfBirth = 1969)
    {
        _continuousEnrollments.Add(new ContinuousEnrollmentRow(
            personId,
            Date(start),
            Date(end),
            gender,
            yearOfBirth));
    }

    internal void AddMemberEnrollment(
        long personId,
        string start,
        string end,
        string race = "U",
        string ethnicity = "U",
        string bus = "COM",
        string healthExchange = "0",
        string product = "HMO",
        int cdhp = 3,
        string aso = "N",
        string? groupNumber = null,
        string? familyId = null,
        string? region = null,
        string? state = null,
        string? planId = null)
    {
        _memberEnrollments.Add(new MemberEnrollmentRow(
            personId,
            Date(start),
            Date(end),
            race,
            ethnicity,
            bus,
            healthExchange,
            product,
            cdhp,
            aso,
            groupNumber,
            familyId,
            region,
            state,
            planId ?? personId.ToString(CultureInfo.InvariantCulture)));
    }

    internal void AddMedicalClaim(
        long personId,
        string claimId,
        string start,
        string? end = null,
        string positionOfService = "11",
        string? procedureCode = null,
        string icdFlag = "9",
        string? ndc = null,
        string? revenueCode = null,
        string claimSequence = "001",
        string locationCode = "",
        string paidStatus = "P",
        string? confinementId = null,
        string? provider = "111111",
        string? providerCategory = "5678",
        int units = 1,
        bool died = false,
        string? planId = null)
    {
        _medicalClaims.Add(new MedicalClaimRow(
            personId,
            planId ?? personId.ToString(CultureInfo.InvariantCulture),
            claimId,
            claimSequence,
            Date(start),
            Date(end ?? start),
            positionOfService,
            procedureCode,
            icdFlag,
            ndc,
            revenueCode,
            locationCode,
            paidStatus,
            confinementId,
            provider,
            providerCategory,
            units,
            died));
    }

    internal void AddDiagnosis(
        long personId,
        string claimId,
        string diagnosis,
        string start = "2013-07-01",
        string icdFlag = "9",
        string diagnosisPosition = "01",
        string presentOnAdmission = "Y",
        string locationCode = "",
        string? planId = null)
    {
        _diagnoses.Add(new DiagnosisRow(
            personId,
            planId ?? personId.ToString(CultureInfo.InvariantCulture),
            claimId,
            diagnosis,
            Date(start),
            icdFlag,
            diagnosisPosition.PadLeft(2, '0'),
            presentOnAdmission,
            locationCode));
    }

    internal void AddProcedure(
        long personId,
        string claimId,
        string procedure,
        string start = "2013-07-01",
        string icdFlag = "9",
        int procedurePosition = 1)
    {
        _procedures.Add(new ProcedureRow(
            personId,
            personId.ToString(CultureInfo.InvariantCulture),
            claimId,
            procedure,
            Date(start),
            icdFlag,
            procedurePosition));
    }

    internal void AddRxClaim(
        long personId,
        string claimId,
        string ndc = "55111067101",
        string fillDate = "2013-10-01",
        int daysSupply = 30,
        decimal quantity = 1m,
        bool specialty = false,
        bool mail = false,
        long? pharmacyId = null)
    {
        _rxClaims.Add(new RxRow(
            personId,
            personId.ToString(CultureInfo.InvariantCulture),
            claimId,
            ndc,
            Date(fillDate),
            daysSupply,
            quantity,
            specialty,
            mail,
            pharmacyId));
    }

    internal void AddLabResult(
        long personId,
        string claimId,
        string start = "2013-07-01",
        string? loinc = null,
        string? procedureCode = null,
        decimal? resultNumber = null,
        string? resultText = null,
        string? unit = null,
        decimal? rangeLow = null,
        decimal? rangeHigh = null)
    {
        _labs.Add(new LabRow(
            personId,
            personId.ToString(CultureInfo.InvariantCulture),
            claimId,
            Date(start),
            loinc,
            procedureCode,
            resultNumber,
            resultText,
            unit,
            rangeLow,
            rangeHigh));
    }

    internal void AddInpatientConfinement(
        long personId,
        string confinementId,
        string admitDate,
        string dischargeDate,
        string positionOfService = "21",
        string icdFlag = "9",
        string? diagnosis1 = null,
        string? diagnosis2 = null,
        string? diagnosis3 = null,
        string? procedure1 = null,
        string? procedure2 = null,
        string? procedure3 = null)
    {
        _inpatient.Add(new InpatientRow(
            personId,
            personId.ToString(CultureInfo.InvariantCulture),
            confinementId,
            Date(admitDate),
            Date(dischargeDate),
            positionOfService,
            icdFlag,
            [diagnosis1, diagnosis2, diagnosis3],
            [procedure1, procedure2, procedure3]));
    }

    internal void AddDeath(long personId, string yearMonthOfDeath)
    {
        _deaths.Add(new DeathRow(personId, YearMonth(yearMonthOfDeath)));
    }

    internal void AddProvider(
        long providerId,
        string? providerType = null,
        string? providerCategory = null,
        string? taxonomy1 = null,
        string? taxonomy2 = null,
        string? region = null,
        string? state = null)
    {
        _providers.Add(new ProviderRow(
            providerId,
            providerType,
            providerCategory,
            taxonomy1,
            taxonomy2,
            region,
            state));
    }

    internal void AddProviderBridge(long providerId, string? provider = null, string? dea = null, string? npi = null)
    {
        _providerBridges.Add(new ProviderBridgeRow(providerId, provider, dea, npi));
    }

    internal OptumExtendedBuildResult Build(long personId)
    {
        var builder = new OptumExtendedPersonBuilder(
            _flavor == OptumExtendedFlavor.Ses
                ? new OptumExtendedPersonBuilder.OptumExtendedSESVendor()
                : new OptumExtendedPersonBuilder.OptumExtendedDODVendor());
        builder.JoinToVocabulary(_vocabulary);

        var continuous = _continuousEnrollments.Where(row => row.PersonId == personId).ToArray();
        var member = _memberEnrollments.Where(row => row.PersonId == personId).ToArray();
        foreach (var row in continuous)
        {
            MemberEnrollmentRow?[] matchingMemberRows = member.Length == 0
                ? [null]
                : member.Cast<MemberEnrollmentRow?>().ToArray();
            foreach (var memberRow in matchingMemberRows)
            {
                builder.AddData(ToPerson(row, memberRow));
            }
        }

        foreach (var row in member)
            builder.AddData(ToPayerPlanPeriod(row));

        if (continuous.Length > 0)
            builder.AddData(ToBaselineVisit(personId, continuous.Min(row => ClampEnrollmentStart(row.Start))));

        foreach (var row in _medicalClaims.Where(row => row.PersonId == personId))
            AddMedicalClaimEntities(builder, row);
        foreach (var row in _diagnoses.Where(row => row.PersonId == personId))
            AddDiagnosisEntities(builder, row);
        foreach (var row in _procedures.Where(row => row.PersonId == personId))
            AddProcedureEntities(builder, row);
        foreach (var row in _rxClaims.Where(row => row.PersonId == personId))
            AddRxEntities(builder, row);
        foreach (var row in _labs.Where(row => row.PersonId == personId))
            AddLabEntities(builder, row);
        foreach (var row in _inpatient.Where(row => row.PersonId == personId))
            AddInpatientEntities(builder, row);
        foreach (var row in _deaths.Where(row => row.PersonId == personId))
            builder.AddData(new Death(BaseEntity(row.PersonId, row.Date, 0, 32885, "DOD", Guid.NewGuid(), [])));

        var data = new ChunkData(chunkId: 0, subChunkId: 0);
        var attrition = builder.Build(data, new KeyMasterOffsetManager(chunkId: 0, prefix: 0, attempt: 0));
        return new OptumExtendedBuildResult(data, attrition);
    }

    internal OptumExtendedStaticData BuildStaticData()
    {
        var careSites = new List<CareSite>();
        var providers = new List<Provider>();
        var locations = new List<Location>();

        foreach (var row in _providers)
        {
            var providerSource = row.ProviderId.ToString(CultureInfo.InvariantCulture);
            var locationSource = _flavor == OptumExtendedFlavor.Ses ? row.Region : row.State;
            long? locationId = null;
            if (!string.IsNullOrWhiteSpace(locationSource))
            {
                locationId = Entity.GetId(locationSource);
                AddLocation(locations, locationSource);
            }

            if (row.ProviderType is null or "" or "2" or "3" or "4" or "5")
            {
                careSites.Add(new CareSite
                {
                    Id = row.ProviderId,
                    SourceValue = providerSource,
                    ConceptId = row.ProviderType switch
                    {
                        "2" => 8717,
                        "3" => 38004693,
                        _ => 0
                    },
                    LocationId = locationId,
                    AdditionalFields = []
                });
            }

            if (row.ProviderType is null or "" or "1" or "unknown")
            {
                var specialtySource = row.Taxonomy1 ?? row.Taxonomy2 ?? row.ProviderCategory ?? string.Empty;
                var specialty = _vocabulary.Lookup(specialtySource, "Specialty", DateTime.MinValue).FirstOrDefault();
                providers.Add(new Provider
                {
                    Id = row.ProviderId,
                    ProviderSourceValue = providerSource,
                    SourceValue = specialtySource,
                    ConceptId = specialty?.ConceptId ?? 0,
                    SpecialtySourceConceptId = SourceConceptId(specialty),
                    AdditionalFields = []
                });
            }
        }

        foreach (var pharmacyId in _rxClaims.Where(row => row.PharmacyId.HasValue).Select(row => row.PharmacyId!.Value).Distinct())
        {
            careSites.Add(new CareSite
            {
                Id = pharmacyId,
                SourceValue = pharmacyId.ToString(CultureInfo.InvariantCulture),
                ConceptId = 38004340,
                AdditionalFields = []
            });
        }

        foreach (var row in _memberEnrollments)
        {
            var source = _flavor == OptumExtendedFlavor.Ses ? row.Region : row.State;
            if (!string.IsNullOrWhiteSpace(source))
                AddLocation(locations, source);
        }

        return new OptumExtendedStaticData(careSites, providers, locations);
    }

    private void AddMedicalClaimEntities(OptumExtendedPersonBuilder builder, MedicalClaimRow row)
    {
        var sourceGuid = Guid.NewGuid();
        var additional = VisitFields(row.PlanId, row.ClaimId, row.LocationCode);
        additional["clmseq"] = row.ClaimSequence;
        additional["paid_status"] = row.PaidStatus;
        additional["conf_id"] = row.ConfinementId ?? string.Empty;
        var posMapping = RequiredMapping(row.PositionOfService, "CMS", row.Start);
        builder.AddData(new VisitOccurrence(BaseEntity(
            row.PersonId,
            row.Start,
            posMapping.ConceptId ?? 0,
            32810,
            row.PositionOfService,
            sourceGuid,
            additional,
            "MEDICAL_CLAIMS"))
        {
            EndDate = row.End,
            CareSiteId = ParseNullableLong(row.ProviderCategory),
            ProviderId = ParseNullableLong(row.Provider)
        });

        if (!string.IsNullOrWhiteSpace(row.ProcedureCode))
        {
            foreach (var mapping in Mappings(row.ProcedureCode, row.IcdFlag == "10" ? "ProcedureICD10" : "ProcedureICD9", row.Start))
            {
                builder.AddData(new ProcedureOccurrence(MappedEntity(
                    row.PersonId,
                    row.Start,
                    row.End,
                    row.ProcedureCode,
                    32810,
                    sourceGuid,
                    additional,
                    mapping,
                    "MEDICAL_CLAIMS"))
                {
                    Quantity = row.Units
                });
            }
        }

        if (!string.IsNullOrWhiteSpace(row.Ndc))
        {
            foreach (var mapping in Mappings(row.Ndc, "DrugRx", row.Start))
            {
                var drugFields = new Dictionary<string, string>(additional);
                if ((mapping.ConceptId ?? 0) > 0)
                    drugFields["itndc"] = "1";
                builder.AddData(new DrugExposure(MappedEntity(
                    row.PersonId,
                    row.Start,
                    row.Start,
                    row.Ndc,
                    32810,
                    sourceGuid,
                    drugFields,
                    mapping,
                    "MEDICAL_CLAIMS"))
                {
                    DaysSupply = 1,
                    Quantity = 1
                });
            }
        }

        if (!string.IsNullOrWhiteSpace(row.RevenueCode))
        {
            foreach (var mapping in Mappings(row.RevenueCode, "RevenueCode", row.Start))
            {
                builder.AddData(new Observation(MappedEntity(
                    row.PersonId,
                    row.Start,
                    row.End,
                    row.RevenueCode,
                    32810,
                    sourceGuid,
                    additional,
                    mapping,
                    "MEDICAL_CLAIMS")));
            }
        }

        if (row.Died)
        {
            builder.AddData(new Death(BaseEntity(
                row.PersonId,
                row.Start,
                0,
                32810,
                "medical claim death",
                sourceGuid,
                additional,
                "MEDICAL_CLAIMS"))
            {
                Primary = true
            });
        }
    }

    private void AddDiagnosisEntities(OptumExtendedPersonBuilder builder, DiagnosisRow row)
    {
        var status = Status(row.PresentOnAdmission, row.DiagnosisPosition);
        foreach (var mapping in Mappings(row.Diagnosis, row.IcdFlag == "10" ? "ConditionICD10" : "ConditionICD9", row.Start))
        {
            builder.AddData(new ConditionOccurrence(MappedEntity(
                row.PersonId,
                row.Start,
                row.Start,
                row.Diagnosis,
                32810,
                Guid.NewGuid(),
                VisitFields(row.PlanId, row.ClaimId, row.LocationCode),
                mapping,
                "MED_DIAGNOSIS"))
            {
                StatusConceptId = status,
                StatusSourceValue = $"{row.PresentOnAdmission};{row.DiagnosisPosition}"
            });
        }
    }

    private void AddProcedureEntities(OptumExtendedPersonBuilder builder, ProcedureRow row)
    {
        foreach (var mapping in Mappings(row.Procedure, row.IcdFlag == "10" ? "ProcedureICD10" : "ProcedureICD9", row.Start))
        {
            builder.AddData(new ProcedureOccurrence(MappedEntity(
                row.PersonId,
                row.Start,
                null,
                row.Procedure,
                row.ProcedurePosition == 1 ? 44786630 : 44786631,
                Guid.NewGuid(),
                VisitFields(row.PlanId, row.ClaimId),
                mapping,
                "MED_PROCEDURE")));
        }
    }

    private void AddRxEntities(OptumExtendedPersonBuilder builder, RxRow row)
    {
        var sourceGuid = Guid.NewGuid();
        var fields = VisitFields(row.PlanId, row.ClaimId);
        foreach (var mapping in Mappings(row.Ndc, "DrugRx", row.FillDate))
        {
            var drugFields = new Dictionary<string, string>(fields);
            if ((mapping.ConceptId ?? 0) > 0)
                drugFields["itndc"] = "1";
            builder.AddData(new DrugExposure(MappedEntity(
                row.PersonId,
                row.FillDate,
                null,
                row.Ndc,
                row.Mail ? 32857 : 32869,
                sourceGuid,
                drugFields,
                mapping,
                "RX_CLAIMS"))
            {
                DaysSupply = row.DaysSupply < 0 ? 1 : row.DaysSupply > 365 ? 365 : row.DaysSupply,
                Quantity = row.Quantity
            });
        }

        if (!row.Mail)
        {
            var rawConcept = row.Specialty ? 38004348 : 581458;
            builder.AddData(new VisitOccurrence(BaseEntity(
                row.PersonId,
                row.FillDate,
                rawConcept,
                row.Specialty ? 32869 : 32869,
                row.Specialty ? "Specialty Pharmacy" : "Pharmacy",
                sourceGuid,
                fields,
                "RX_CLAIMS"))
            {
                EndDate = row.FillDate,
                CareSiteId = row.PharmacyId
            });
        }
    }

    private void AddLabEntities(OptumExtendedPersonBuilder builder, LabRow row)
    {
        var guid = Guid.NewGuid();
        var fields = VisitFields(row.PlanId, row.ClaimId);
        if (!string.IsNullOrWhiteSpace(row.Loinc))
        {
            foreach (var mapping in Mappings(row.Loinc, "Lab", row.Start))
                builder.AddData(ToMeasurement(row, row.Loinc, 100, guid, fields, mapping));
        }

        if (!string.IsNullOrWhiteSpace(row.ProcedureCode))
        {
            foreach (var mapping in Mappings(row.ProcedureCode, "Procedure", row.Start))
                builder.AddData(ToMeasurement(row, row.ProcedureCode, 101, guid, fields, mapping));
        }
    }

    private Measurement ToMeasurement(
        LabRow row,
        string sourceValue,
        long typeConceptId,
        Guid guid,
        Dictionary<string, string> fields,
        LookupValue mapping)
    {
        var measurement = new Measurement(MappedEntity(
            row.PersonId,
            row.Start,
            row.Start,
            sourceValue,
            typeConceptId,
            guid,
            fields,
            mapping,
            "LAB_RESULTS"))
        {
            ValueAsNumber = row.ResultNumber,
            ValueSourceValue = $"{row.ResultNumber?.ToString(CultureInfo.InvariantCulture) ?? string.Empty};{row.ResultText ?? string.Empty}",
            RangeLow = row.RangeLow,
            RangeHigh = row.RangeHigh,
            UnitSourceValue = row.Unit
        };
        if (!string.IsNullOrWhiteSpace(row.Unit))
            measurement.UnitConceptId = _vocabulary.Lookup(row.Unit, "Lab_Units", row.Start).FirstOrDefault()?.ConceptId ?? 0;
        return measurement;
    }

    private void AddInpatientEntities(OptumExtendedPersonBuilder builder, InpatientRow row)
    {
        var guid = Guid.NewGuid();
        var fields = VisitFields(row.PlanId, row.ConfinementId);
        fields["conf_id"] = row.ConfinementId;
        var pos = RequiredMapping(row.PositionOfService, "CMS", row.AdmitDate);
        builder.AddData(new VisitOccurrence(BaseEntity(
            row.PersonId,
            row.AdmitDate,
            pos.ConceptId ?? 0,
            32855,
            row.PositionOfService,
            guid,
            fields,
            "INPATIENT_CONFINEMENT"))
        {
            EndDate = row.DischargeDate
        });

        for (var i = 0; i < row.Diagnoses.Length; i++)
        {
            var code = row.Diagnoses[i];
            if (string.IsNullOrWhiteSpace(code))
                continue;
            foreach (var mapping in Mappings(code, row.IcdFlag == "10" ? "ConditionICD10" : "ConditionICD9", row.AdmitDate))
            {
                builder.AddData(new ConditionOccurrence(MappedEntity(
                    row.PersonId,
                    row.AdmitDate,
                    row.DischargeDate,
                    code,
                    i + 1,
                    guid,
                    fields,
                    mapping,
                    "INPATIENT_CONFINEMENT")));
            }
        }

        for (var i = 0; i < row.Procedures.Length; i++)
        {
            var code = row.Procedures[i];
            if (string.IsNullOrWhiteSpace(code))
                continue;
            foreach (var mapping in Mappings(code, row.IcdFlag == "10" ? "ProcedureICD10" : "ProcedureICD9", row.AdmitDate))
            {
                builder.AddData(new ProcedureOccurrence(MappedEntity(
                    row.PersonId,
                    row.AdmitDate,
                    row.DischargeDate,
                    code,
                    i + 11,
                    guid,
                    fields,
                    mapping,
                    "INPATIENT_CONFINEMENT")));
            }
        }
    }

    private IEnumerable<LookupValue> Mappings(string source, string lookup, DateTime eventDate)
    {
        var mappings = _vocabulary.Lookup(source, lookup, eventDate);
        if (mappings.Count == 0)
            throw new InvalidOperationException($"No OptumExtended test mapping for {lookup}:{source}.");
        return mappings;
    }

    private LookupValue RequiredMapping(string source, string lookup, DateTime eventDate) =>
        Mappings(source, lookup, eventDate).First();

    private Person ToPerson(ContinuousEnrollmentRow row, MemberEnrollmentRow? member)
    {
        var location = member is null
            ? null
            : _flavor == OptumExtendedFlavor.Ses ? member.Region : member.State;
        return new Person
        {
            PersonId = row.PersonId,
            PersonSourceValue = row.PersonId.ToString(CultureInfo.InvariantCulture),
            GenderConceptId = _vocabulary.LookupGender(row.Gender),
            GenderSourceValue = row.Gender,
            YearOfBirth = row.YearOfBirth,
            RaceConceptId = Race(member?.Race),
            RaceSourceValue = member?.Race,
            EthnicityConceptId = Ethnicity(member?.Ethnicity),
            EthnicitySourceValue = member?.Ethnicity,
            LocationSourceValue = location,
            StartDate = ClampEnrollmentStart(row.Start),
            EndDate = row.End,
            TypeConceptId = 32813,
            ObservationPeriodGap = 32,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = []
        };
    }

    private static PayerPlanPeriod ToPayerPlanPeriod(MemberEnrollmentRow row)
    {
        var payerSource = row.Bus + row.HealthExchange;
        return new PayerPlanPeriod
        {
            PersonId = row.PersonId,
            StartDate = ClampEnrollmentStart(row.Start),
            EndDate = row.End,
            PayerConceptId = row.Bus == "MCR"
                ? 281
                : row.HealthExchange == "1"
                    ? 275
                    : row.HealthExchange is "2" or "3"
                        ? 276
                        : row.Bus == "COM" ? 327 : 0,
            PayerSourceValue = payerSource,
            PlanSourceValue = row.Product + row.Cdhp.ToString(CultureInfo.InvariantCulture),
            SponsorSourceValue = row.Aso + (row.GroupNumber ?? string.Empty),
            FamilySourceValue = row.FamilyId,
            AdditionalFields = []
        };
    }

    private static VisitOccurrence ToBaselineVisit(long personId, DateTime start)
    {
        return new VisitOccurrence(BaseEntity(
            personId,
            start,
            581477,
            32810,
            "UNIT TEST BASELINE",
            Guid.NewGuid(),
            new Dictionary<string, string>
            {
                ["pat_planid"] = personId.ToString(CultureInfo.InvariantCulture),
                ["clmid"] = "UNIT-TEST-BASELINE",
                ["clmseq"] = "001",
                ["loc_cd"] = string.Empty,
                [BaselineMarker] = "true"
            },
            "UNIT_TEST"))
        {
            EndDate = start,
            CareSiteId = 9_999_999_999
        };
    }

    private static Entity MappedEntity(
        long personId,
        DateTime start,
        DateTime? end,
        string sourceValue,
        long typeConceptId,
        Guid sourceGuid,
        Dictionary<string, string> additional,
        LookupValue mapping,
        string sourceFile)
    {
        return new Entity
        {
            PersonId = personId,
            ConceptId = mapping.ConceptId ?? 0,
            Domain = mapping.Domain,
            SourceValue = sourceValue,
            VocabularySourceValue = mapping.SourceCode,
            SourceConceptId = SourceConceptId(mapping),
            SourceConcepts = [.. mapping.SourceConcepts],
            Ingredients = mapping.Ingredients is null ? null : [.. mapping.Ingredients],
            ValidStartDate = mapping.ValidStartDate,
            ValidEndDate = mapping.ValidEndDate,
            StartDate = start,
            EndDate = end,
            TypeConceptId = typeConceptId,
            SourceRecordGuid = sourceGuid,
            SourceFile = sourceFile,
            AdditionalFields = new Dictionary<string, string>(additional)
        };
    }

    private static Entity BaseEntity(
        long personId,
        DateTime start,
        long conceptId,
        long typeConceptId,
        string sourceValue,
        Guid sourceGuid,
        Dictionary<string, string> additional,
        string sourceFile = "UNIT_TEST")
    {
        return new Entity
        {
            PersonId = personId,
            ConceptId = conceptId,
            StartDate = start,
            TypeConceptId = typeConceptId,
            SourceValue = sourceValue,
            SourceRecordGuid = sourceGuid,
            SourceFile = sourceFile,
            AdditionalFields = new Dictionary<string, string>(additional)
        };
    }

    private static Dictionary<string, string> VisitFields(string planId, string claimId, string locationCode = "") =>
        new()
        {
            ["pat_planid"] = planId,
            ["clmid"] = claimId,
            ["loc_cd"] = locationCode
        };

    private static long Status(string poa, string position)
    {
        var primary = position == "01";
        return poa.ToUpperInvariant() switch
        {
            "Y" or "1" => primary ? 32901 : 32890,
            "N" or "U" or "W" or "0" => primary ? 32902 : 32908,
            _ => 0
        };
    }

    private static long Race(string? source) => source?.ToUpperInvariant() switch
    {
        "A" => 8515,
        "B" => 8516,
        "W" => 8527,
        _ => 0
    };

    private static long Ethnicity(string? source) => source?.ToUpperInvariant() switch
    {
        "H" => 38003563,
        "N" => 38003564,
        _ => 0
    };

    private static DateTime ClampEnrollmentStart(DateTime date) =>
        date < new DateTime(2000, 5, 1) ? new DateTime(2000, 5, 1) : date;

    private static DateTime Date(string value) =>
        DateTime.ParseExact(value, "yyyy-MM-dd", CultureInfo.InvariantCulture);

    private static DateTime YearMonth(string value) =>
        DateTime.ParseExact(value + "01", "yyyyMMdd", CultureInfo.InvariantCulture);

    private static long? ParseNullableLong(string? value) =>
        long.TryParse(value, NumberStyles.Integer, CultureInfo.InvariantCulture, out var parsed) ? parsed : null;

    private static long SourceConceptId(LookupValue? mapping) =>
        mapping?.SourceConcepts.FirstOrDefault()?.ConceptId ?? 0;

    private static void AddLocation(List<Location> locations, string source)
    {
        if (locations.Any(item => item.SourceValue == source))
            return;
        locations.Add(new Location
        {
            Id = Entity.GetId(source),
            SourceValue = source,
            State = source,
            AdditionalFields = []
        });
    }

    private sealed record ContinuousEnrollmentRow(long PersonId, DateTime Start, DateTime End, string Gender, int YearOfBirth);
    private sealed record MemberEnrollmentRow(
        long PersonId, DateTime Start, DateTime End, string Race, string Ethnicity,
        string Bus, string HealthExchange, string Product, int Cdhp, string Aso,
        string? GroupNumber, string? FamilyId, string? Region, string? State, string PlanId);
    private sealed record MedicalClaimRow(
        long PersonId, string PlanId, string ClaimId, string ClaimSequence,
        DateTime Start, DateTime End, string PositionOfService, string? ProcedureCode,
        string IcdFlag, string? Ndc, string? RevenueCode, string LocationCode,
        string PaidStatus, string? ConfinementId, string? Provider, string? ProviderCategory,
        int Units, bool Died);
    private sealed record DiagnosisRow(
        long PersonId, string PlanId, string ClaimId, string Diagnosis, DateTime Start,
        string IcdFlag, string DiagnosisPosition, string PresentOnAdmission, string LocationCode);
    private sealed record ProcedureRow(
        long PersonId, string PlanId, string ClaimId, string Procedure, DateTime Start,
        string IcdFlag, int ProcedurePosition);
    private sealed record RxRow(
        long PersonId, string PlanId, string ClaimId, string Ndc, DateTime FillDate,
        int DaysSupply, decimal Quantity, bool Specialty, bool Mail, long? PharmacyId);
    private sealed record LabRow(
        long PersonId, string PlanId, string ClaimId, DateTime Start, string? Loinc,
        string? ProcedureCode, decimal? ResultNumber, string? ResultText, string? Unit,
        decimal? RangeLow, decimal? RangeHigh);
    private sealed record InpatientRow(
        long PersonId, string PlanId, string ConfinementId, DateTime AdmitDate,
        DateTime DischargeDate, string PositionOfService, string IcdFlag,
        string?[] Diagnoses, string?[] Procedures);
    private sealed record DeathRow(long PersonId, DateTime Date);
    private sealed record ProviderRow(
        long ProviderId, string? ProviderType, string? ProviderCategory, string? Taxonomy1,
        string? Taxonomy2, string? Region, string? State);
    private sealed record ProviderBridgeRow(long ProviderId, string? Provider, string? Dea, string? Npi);
}

internal sealed class OptumExtendedTestVocabulary : IVocabulary
{
    private static readonly DateTime ValidStart = new(1900, 1, 1);
    private static readonly DateTime ValidEnd = new(2099, 12, 31);
    private readonly Dictionary<string, List<LookupValue>> _mappings = new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<long, string> _domains = [];
    private readonly Dictionary<long, string> _vocabularies = [];

    internal OptumExtendedTestVocabulary()
    {
        Map("CMS", "21", 8717, "Visit");
        Map("CMS", "11", 581477, "Visit");
        Map("CMS", "23", 8870, "Visit");
        Map("CMS", "13", 8615, "Visit");
        Map("CMS", "22", 8756, "Visit");
        Map("CMS", "17", 38003620, "Visit");
        Map("CMSPlaceOfService", "8717", 9201, "Visit");
        Map("CMSPlaceOfService", "581477", 9202, "Visit");
        Map("CMSPlaceOfService", "8870", 9203, "Visit");
        Map("CMSPlaceOfService", "8615", 42898160, "Visit");
        Map("CMSPlaceOfService", "8756", 9202, "Visit");
        Map("CMSPlaceOfService", "38003620", 9202, "Visit");
        Map("CMSPlaceOfService", "581458", 581458, "Visit");
        Map("CMSPlaceOfService", "38004348", 581458, "Visit");
        Map("CMSPlaceOfService", "9202", 9202, "Visit");

        MapCondition("7061", 141095);
        MapCondition("99999", 0);
        MapCondition("24910", 443727);
        MapCondition("24910", 195771);
        MapCondition("7872", 31317);
        MapCondition("V1582", 0);
        MapCondition("250.00", 201826);
        MapCondition("7616", 439393);
        Map("ConditionICD9", "V5789", 4180248, "Procedure", 44820919, "ICD9CM");
        Map("ConditionICD9", "V8271", 4237017, "Measurement", 44820920, "ICD9CM");
        Map("ConditionICD9", "E001", 40481919, "Observation", 44820921, "ICD9CM");
        Map("ConditionICD10", "A921", 4310683, "Condition", vocabularyId: "ICD10CM");

        MapProcedure("92928", 43527998);
        MapProcedure("70481", 2211331);
        MapProcedure("2", 0);
        MapProcedure("0000000", 0);
        MapProcedure("64475", 2102325);
        MapProcedure("V5789", 4180248, "Procedure");
        MapProcedure("J0456", 35603391, "Drug");
        MapProcedure("K0901", 45890555, "Device");
        MapProcedure("87517", 2213127, "Measurement");
        MapProcedure("90651", 45892510, "Drug");
        MapProcedure("A0170", 46221652, "Observation");
        Map("ProcedureICD10", "XW033A7", 36617027, "Drug", 76500001, "ICD10PCS", [36617027]);

        Map("DrugRx", "55111067101", 1322189, "Drug", 44923712, "NDC", [1322189]);
        Map("DrugRx", "58487000102", 0, "Drug", 44923713, "NDC");
        Map("DrugRx", "24840153001", 46358737, "Device", 44923714, "NDC");

        Map("Lab", "22962-5", 3012939, "Measurement", 30000001, "LOINC");
        Map("Lab", "76345-8", 40771922, "Observation", 30000002, "LOINC");
        Map("Lab", "75415-0", 40771923, "Observation", 30000003, "LOINC");
        Map("Lab", "000", 0, "Measurement");
        Map("Procedure", "87517", 2213127, "Measurement", 30000004, "CPT4");
        Map("Procedure", "90651", 45892510, "Drug", 30000005, "CPT4", [45892510]);
        Map("Lab_Units", "cal", 9472, "Unit");

        Map("RevenueCode", "A0170", 46221652, "Observation");
        Map("Specialty", "103TC2200X", 38003640, "Provider");
        Map("Specialty", "207PE0004X", 38004510, "Provider");
        Map("Specialty", "1001", 0, "Provider");
    }

    internal int MappingCount => _mappings.Values.Sum(items => items.Count);

    internal OptumExtendedTestVocabulary WithMapping(
        string lookup,
        string source,
        long conceptId,
        string domain,
        long sourceConceptId = 0,
        string? vocabularyId = null,
        long[]? ingredients = null)
    {
        Map(lookup, source, conceptId, domain, sourceConceptId, vocabularyId, ingredients);
        return this;
    }

    public void Fill(bool forLookup)
    {
    }

    public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
    {
        if (string.IsNullOrWhiteSpace(sourceValue) || string.IsNullOrWhiteSpace(key))
            return [];
        if (!_mappings.TryGetValue(Key(key, sourceValue), out var values))
            return [];
        if (eventDate == DateTime.MinValue)
            return [.. values];
        return values.Where(value => eventDate >= value.ValidStartDate && eventDate <= value.ValidEndDate).ToList();
    }

    public int? LookupGender(string genderSourceValue) => genderSourceValue?.Trim().ToUpperInvariant() switch
    {
        "M" => 8507,
        "F" => 8532,
        _ => 8551
    };

    public IEnumerable<PregnancyConcept> LookupPregnancyConcept(long conceptId) => [];

    public string? GetSourceVocabularyId(long conceptId) => _vocabularies.GetValueOrDefault(conceptId);

    public string? GetSourceDomain(long conceptId) => _domains.GetValueOrDefault(conceptId);

    private void MapCondition(string source, long conceptId) =>
        Map("ConditionICD9", source, conceptId, "Condition", conceptId == 0 ? 0 : 44800000 + conceptId % 100000, "ICD9CM");

    private void MapProcedure(string source, long conceptId, string domain = "Procedure")
    {
        var sourceConcept = conceptId == 0 ? 0 : 44700000 + conceptId % 100000;
        var ingredients = domain == "Drug" && conceptId > 0 ? new[] { conceptId } : null;
        Map("ProcedureICD9", source, conceptId, domain, sourceConcept, "HCPCS", ingredients);
        Map("ProcedureICD10", source, conceptId, domain, sourceConcept, "ICD10PCS", ingredients);
        Map("Procedure", source, conceptId, domain, sourceConcept, "HCPCS", ingredients);
    }

    private void Map(
        string lookup,
        string source,
        long conceptId,
        string domain,
        long sourceConceptId = 0,
        string? vocabularyId = null,
        long[]? ingredients = null)
    {
        var key = Key(lookup, source);
        if (!_mappings.TryGetValue(key, out var values))
        {
            values = [];
            _mappings.Add(key, values);
        }
        if (values.Any(value => value.ConceptId == conceptId && value.Domain == domain))
            return;

        var sourceConcepts = new HashSet<SourceConcepts>();
        if (sourceConceptId > 0)
        {
            sourceConcepts.Add(new SourceConcepts
            {
                ConceptId = sourceConceptId,
                ValidStartDate = ValidStart,
                ValidEndDate = ValidEnd
            });
        }
        values.Add(new LookupValue
        {
            ConceptId = conceptId,
            Domain = domain,
            SourceCode = source,
            ValidStartDate = ValidStart,
            ValidEndDate = ValidEnd,
            SourceConcepts = sourceConcepts,
            Ingredients = ingredients is null ? null : [.. ingredients]
        });
        if (conceptId > 0)
        {
            _domains[conceptId] = domain;
            if (!string.IsNullOrWhiteSpace(vocabularyId))
                _vocabularies[conceptId] = vocabularyId;
        }
    }

    private static string Key(string lookup, string source) => $"{lookup.Trim()}\u001f{source.Trim()}";
}
