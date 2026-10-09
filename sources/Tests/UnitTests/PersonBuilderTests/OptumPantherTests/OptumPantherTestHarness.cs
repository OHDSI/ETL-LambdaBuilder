using System.Globalization;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.etl.Transformation.OptumPanther;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.OptumPantherTests;

internal sealed record OptumPantherBuildResult(ChunkData Data, Attrition Attrition)
{
    internal IEnumerable<VisitOccurrence> SourceVisits =>
        Data.VisitOccurrences.Where(item => !OptumPantherInMemoryScenario.IsBaseline(item));

    internal IEnumerable<VisitDetail> SourceVisitDetails =>
        Data.VisitDetails.Where(item => !OptumPantherInMemoryScenario.IsBaseline(item));
}

internal sealed record OptumPantherStaticData(
    IReadOnlyList<Provider> Providers,
    IReadOnlyList<Location> Locations);

/// <summary>
/// In-memory equivalent of the Optum Panther source schema used by the R tests.
/// </summary>
internal sealed class OptumPantherInMemoryScenario
{
    private const string BaselineMarker = "unit_test_baseline";
    private readonly OptumPantherTestVocabulary _vocabulary = new();
    private readonly List<PatientRow> _patients = [];
    private readonly List<EncounterRow> _encounters = [];
    private readonly List<VisitRow> _visits = [];
    private readonly List<DiagnosisRow> _diagnoses = [];
    private readonly List<ProcedureRow> _procedures = [];
    private readonly List<MedicationAdministrationRow> _medicationAdministrations = [];
    private readonly List<PrescriptionRow> _prescriptions = [];
    private readonly List<ReportedMedicationRow> _reportedMedications = [];
    private readonly List<ImmunizationRow> _immunizations = [];
    private readonly List<LabRow> _labs = [];
    private readonly List<NlpMeasurementRow> _nlpMeasurements = [];
    private readonly List<ObservationRow> _observations = [];
    private readonly List<MicrobiologyRow> _microbiology = [];
    private readonly List<NlpDrugRow> _nlpDrugs = [];
    private readonly List<NlpBiomarkerRow> _nlpBiomarkers = [];
    private readonly List<InsuranceRow> _insurance = [];
    private readonly List<ProviderRow> _providers = [];
    private long _nextEntityId = 1;

    internal OptumPantherTestVocabulary Vocabulary => _vocabulary;

    internal static bool IsBaseline(IEntity entity) =>
        entity.AdditionalFields is not null &&
        entity.AdditionalFields.TryGetValue(BaselineMarker, out var value) &&
        value == "true";

    internal static string EncounterId(long sequence) => $"E0000{sequence}";

    internal void AddStandardPerson(
        long personId,
        string gender = "Female",
        string? birthYear = "1933 and Earlier",
        string race = "Caucasian",
        string ethnicity = "Not Hispanic",
        string region = "Midwest",
        string division = "East North Central",
        bool idnIndicator = true,
        string firstMonthActive = "200601",
        string lastMonthActive = "202206",
        string? deathYearMonth = null,
        bool deceased = false)
    {
        _patients.Add(new PatientRow(
            personId,
            gender,
            birthYear,
            race,
            ethnicity,
            region,
            division,
            idnIndicator,
            firstMonthActive,
            lastMonthActive,
            deathYearMonth,
            deceased));
    }

    internal void AddEncounter(
        long personId,
        string encid,
        string interactionType = "Other patient type",
        string interactionDate = "2012-12-31",
        long? providerId = null,
        string? visitId = null)
    {
        _encounters.Add(new EncounterRow(
            personId,
            encid,
            interactionType,
            Date(interactionDate),
            providerId,
            visitId,
            false));
    }

    internal void AddVisit(
        long personId,
        string visitId,
        string startDate,
        string endDate,
        string visitType = "Inpatient")
    {
        _visits.Add(new VisitRow(
            personId,
            visitId,
            Date(startDate),
            Date(endDate),
            visitType));
    }

    internal void AddDiagnosis(
        long personId,
        string? diagnosisCode = "I10",
        string? diagnosisCodeType = "ICD10",
        string diagnosisStatus = "Diagnosis of",
        string diagnosisDate = "2014-01-26",
        string encid = "",
        string primaryDiagnosis = "0",
        string admittingDiagnosis = "0",
        string dischargeDiagnosis = "0")
    {
        _diagnoses.Add(new DiagnosisRow(
            personId,
            diagnosisCode,
            diagnosisCodeType,
            diagnosisStatus,
            Date(diagnosisDate),
            encid,
            primaryDiagnosis,
            admittingDiagnosis,
            dischargeDiagnosis));
    }

    internal void AddProcedure(
        long personId,
        string procedureCode,
        string procedureCodeType = "CPT4",
        string procedureDate = "2019-07-22",
        string encid = "",
        long? providerId = null)
    {
        _procedures.Add(new ProcedureRow(
            personId,
            procedureCode,
            procedureCodeType,
            Date(procedureDate),
            encid,
            providerId));
    }

    internal void AddMedicationAdministration(
        long personId,
        string ndc = "69374096750",
        string orderDate = "2017-09-06",
        string encid = "",
        long? providerId = null,
        string route = "Oral",
        decimal? quantityOfDose = null,
        string strengthUnit = "mg")
    {
        _medicationAdministrations.Add(new MedicationAdministrationRow(
            personId,
            ndc,
            Date(orderDate),
            encid,
            providerId,
            route,
            quantityOfDose,
            strengthUnit));
    }

    internal void AddPrescription(
        long personId,
        string prescriptionDate,
        string ndc = "00406012301",
        string route = "Oral",
        string? quantityOfDose = "",
        string? quantityPerFill = "30 tablet",
        string? refills = "0",
        string? daysSupply = "",
        string strength = "10",
        string strengthUnit = "mg",
        string dosageForm = "Tablet",
        string doseFrequency = "")
    {
        _prescriptions.Add(new PrescriptionRow(
            personId,
            Date(prescriptionDate),
            ndc,
            route,
            quantityOfDose,
            quantityPerFill,
            refills,
            daysSupply,
            strength,
            strengthUnit,
            dosageForm,
            doseFrequency));
    }

    internal void AddReportedMedication(
        long personId,
        string reportedDate,
        string ndc = "69618004610",
        string route = "Oral",
        decimal? quantityOfDose = null)
    {
        _reportedMedications.Add(new ReportedMedicationRow(
            personId,
            Date(reportedDate),
            ndc,
            route,
            quantityOfDose));
    }

    internal void AddImmunization(
        long personId,
        string? immunizationDate,
        string? ndc = "70461032103",
        string immunizationDescription = "TDAP",
        string patientReported = " ")
    {
        _immunizations.Add(new ImmunizationRow(
            personId,
            immunizationDate is null ? null : Date(immunizationDate),
            ndc,
            immunizationDescription,
            patientReported));
    }

    internal void AddLab(
        long personId,
        string resultDate,
        string testName = "Oxygen saturation (SpO2).pulse oximetry",
        string testResult = "negative",
        string resultUnit = "%",
        string relativeIndicator = "",
        string normalRange = "",
        string encid = "")
    {
        _labs.Add(new LabRow(
            personId,
            Date(resultDate),
            testName,
            testResult,
            resultUnit,
            relativeIndicator,
            normalRange,
            encid));
    }

    internal void AddNlpMeasurement(
        long personId,
        string measurementDate,
        string measurementType = "WEIGHT",
        string measurementValue = "normal",
        string measurementDetail = "",
        string encid = "")
    {
        _nlpMeasurements.Add(new NlpMeasurementRow(
            personId,
            Date(measurementDate),
            measurementType,
            measurementValue,
            measurementDetail,
            encid));
    }

    internal void AddObservation(
        long personId,
        string observationDate,
        string observationType = "SBP",
        string observationTime = "04:00:00",
        string observationResult = "Never smoked",
        string observationUnit = "mm Hg",
        string encid = "")
    {
        _observations.Add(new ObservationRow(
            personId,
            Date(observationDate),
            observationType,
            observationTime,
            observationResult,
            observationUnit,
            encid));
    }

    internal void AddMicrobiology(
        long personId,
        string collectDate,
        string specimenSource = "Urine",
        string organism = "E. coli",
        string collectTime = "04:00:00",
        string encid = "")
    {
        _microbiology.Add(new MicrobiologyRow(
            personId,
            Date(collectDate),
            specimenSource,
            organism,
            collectTime,
            encid));
    }

    internal void AddNlpDrugRationale(
        long personId,
        string noteDate,
        string drugName = "ASPIRIN",
        string? drugAction = "N/A",
        string? sentiment = "",
        string reason = "",
        string encid = "")
    {
        _nlpDrugs.Add(new NlpDrugRow(
            personId,
            Date(noteDate),
            drugName,
            drugAction,
            sentiment,
            reason,
            encid));
    }

    internal void AddNlpBiomarker(
        long personId,
        string noteDate,
        string biomarker = "ER",
        string variationDetail = "",
        string biomarkerStatus = "negative")
    {
        _nlpBiomarkers.Add(new NlpBiomarkerRow(
            personId,
            Date(noteDate),
            biomarker,
            variationDetail,
            biomarkerStatus));
    }

    internal void AddInsurance(
        long personId,
        string insuranceDate,
        string insuranceType = "Commercial",
        string insuranceTime = "04:00:00",
        string encid = "")
    {
        _insurance.Add(new InsuranceRow(
            personId,
            Date(insuranceDate),
            insuranceType,
            insuranceTime,
            encid));
    }

    internal void AddProvider(long providerId, string specialty, string primarySpecialty = "1")
    {
        _providers.Add(new ProviderRow(providerId, specialty, primarySpecialty));
    }

    internal void AddDeathProbe(long personId, string tableName, string date, string encid)
    {
        switch (tableName)
        {
            case "diagnosis":
                AddDiagnosis(personId, "7061", "ICD9", diagnosisDate: date, encid: encid);
                break;
            case "encounter":
                AddEncounter(personId, encid, interactionDate: date);
                break;
            case "immunizations":
                AddImmunization(personId, date);
                break;
            case "insurance":
                AddInsurance(personId, date, encid: encid);
                break;
            case "labs":
                AddLab(personId, date, encid: encid);
                break;
            case "medication_administrations":
                AddMedicationAdministration(personId, orderDate: date, encid: encid);
                break;
            case "microbiology":
                AddMicrobiology(personId, date, encid: encid);
                break;
            case "nlp_biomarkers":
                AddNlpBiomarker(personId, date);
                // Raw NOTE rows are ignored by AddData in the current builder. Keep a dated
                // source-domain entity as the death probe so this R case still exercises the
                // builder's post-death activity rule rather than bypassing it.
                AddObservation(personId, date, "BIOMARKER");
                break;
            case "nlp_drug_rationale":
                AddNlpDrugRationale(personId, date);
                break;
            case "nlp_measurement":
                AddNlpMeasurement(personId, date, encid: encid);
                break;
            case "nlp_sds":
            case "nlp_sds_family":
                AddObservation(personId, date, "SDS", encid: encid);
                break;
            case "observations":
                AddObservation(personId, date, encid: encid);
                break;
            case "patient_reported_medications":
                AddReportedMedication(personId, date);
                break;
            case "prescriptions_written":
                AddPrescription(personId, date);
                break;
            case "procedure":
                AddProcedure(personId, "36415", procedureDate: date, encid: encid);
                break;
            case "visit":
                AddVisit(personId, $"V{personId}", date, date);
                break;
            default:
                throw new ArgumentOutOfRangeException(nameof(tableName), tableName, "Unknown R death probe table.");
        }
    }

    internal OptumPantherBuildResult Build(long personId)
    {
        var builder = new OptumPantherPersonBuilder(new OptumPantherPersonBuilder.OptumPantherVendor());
        builder.JoinToVocabulary(_vocabulary);

        var patientRows = _patients.Where(row => row.PersonId == personId).ToArray();
        foreach (var row in patientRows)
        {
            builder.AddData(ToPerson(row));
            if (row.IdnIndicator)
                builder.AddData(ToIdnObservation(row));
            if (row.Deceased && !string.IsNullOrWhiteSpace(row.DeathYearMonth))
                builder.AddData(ToDeath(row));
        }

        var encounters = _encounters.Where(row => row.PersonId == personId).ToList();
        var visits = _visits.Where(row => row.PersonId == personId).ToList();
        if (encounters.Count == 0 && visits.Count == 0)
        {
            encounters.Add(new EncounterRow(
                personId,
                $"UT_BASELINE_{personId}",
                "Other patient type",
                new DateTime(2009, 1, 1),
                null,
                null,
                true));
        }

        foreach (var row in visits)
            builder.AddData(ToVisit(row));
        foreach (var row in encounters.Distinct())
            builder.AddData(ToEncounter(row));
        foreach (var row in _diagnoses.Where(row => row.PersonId == personId))
            builder.AddData(ToDiagnosis(row));
        foreach (var row in _procedures.Where(row => row.PersonId == personId))
            builder.AddData(ToProcedure(row));
        foreach (var row in _medicationAdministrations.Where(row => row.PersonId == personId).Distinct())
            builder.AddData(ToMedicationAdministration(row));
        foreach (var row in _prescriptions.Where(row => row.PersonId == personId))
            builder.AddData(ToPrescription(row));
        foreach (var row in _reportedMedications.Where(row => row.PersonId == personId))
            builder.AddData(ToReportedMedication(row));
        foreach (var row in _immunizations.Where(row => row.PersonId == personId && row.Date.HasValue))
            builder.AddData(ToImmunization(row));
        foreach (var row in _labs.Where(row => row.PersonId == personId))
            builder.AddData(ToLab(row));
        foreach (var row in _nlpMeasurements.Where(row => row.PersonId == personId))
            builder.AddData(ToNlpMeasurement(row));
        foreach (var row in _observations.Where(row => row.PersonId == personId))
            builder.AddData(ToObservation(row));
        foreach (var row in _microbiology.Where(row => row.PersonId == personId))
            builder.AddData(ToMicrobiology(row));
        foreach (var row in _nlpDrugs.Where(row => row.PersonId == personId && IsAcceptedNlpDrug(row)))
            builder.AddData(ToNlpDrug(row));
        foreach (var row in _insurance.Where(row => row.PersonId == personId))
            builder.AddData(ToInsurance(row));

        // nlp_biomarker.xml produces NOTE rows. PersonBuilder.AddData intentionally
        // ignores raw Note entities in the current implementation, but retaining
        // the source rows here keeps death/source scenarios faithful to R.
        _ = _nlpBiomarkers.Count(row => row.PersonId == personId);

        var data = new ChunkData(chunkId: 0, subChunkId: 0);
        var attrition = builder.Build(data, new KeyMasterOffsetManager(chunkId: 0, prefix: 0, attempt: 0));

        if (attrition == Attrition.None)
        {
            Assert.NotEmpty(data.VisitOccurrences);
            Assert.NotEmpty(data.VisitDetails);
        }

        return new OptumPantherBuildResult(data, attrition);
    }

    internal OptumPantherStaticData BuildStaticData()
    {
        var locations = _patients
            .Select(row => $"{row.Region}_{row.Division}")
            .Distinct(StringComparer.Ordinal)
            .Select(source => new Location
            {
                Id = Entity.GetId(source),
                SourceValue = source,
                CountryConceptId = 42046186,
                AdditionalFields = []
            })
            .ToArray();

        var providers = _providers
            .GroupBy(row => row.ProviderId)
            .Select(group => group
                .OrderByDescending(row => row.PrimarySpecialty, StringComparer.Ordinal)
                .ThenBy(row => row.Specialty, StringComparer.Ordinal)
                .First())
            .Select(row =>
            {
                var mapping = OptionalMapping(row.Specialty, "Specialty", DateTime.MinValue);
                return new Provider
                {
                    Id = row.ProviderId,
                    ProviderSourceValue = row.ProviderId.ToString(CultureInfo.InvariantCulture),
                    SourceValue = row.Specialty,
                    ConceptId = mapping?.ConceptId ?? 0,
                    SpecialtySourceConceptId = SourceConceptId(mapping),
                    AdditionalFields = []
                };
            })
            .ToArray();

        return new OptumPantherStaticData(providers, locations);
    }

    private Person ToPerson(PatientRow row)
    {
        var year = ParseBirthYear(row.BirthYear);
        return new Person
        {
            Id = NextId(),
            PersonId = row.PersonId,
            PersonSourceValue = $"PT{row.PersonId}",
            GenderConceptId = _vocabulary.LookupGender(row.Gender) ?? 8551,
            GenderSourceValue = row.Gender.ToLowerInvariant(),
            YearOfBirth = year,
            RaceConceptId = Race(row.Race),
            RaceSourceValue = row.Race,
            EthnicityConceptId = Ethnicity(row.Ethnicity),
            EthnicitySourceValue = row.Ethnicity,
            LocationSourceValue = $"{row.Region}_{row.Division}",
            StartDate = YearMonth(row.FirstMonthActive),
            EndDate = YearMonth(row.LastMonthActive).AddMonths(1).AddDays(-1),
            TypeConceptId = 32827,
            ObservationPeriodGap = 0,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = []
        };
    }

    private Observation ToIdnObservation(PatientRow row)
    {
        return new Observation(BaseEntity(
            row.PersonId,
            new DateTime(2009, 1, 1),
            44804235,
            32817,
            "IDN",
            "Observation",
            []))
        {
            ValueAsNumber = 1
        };
    }

    private Death ToDeath(PatientRow row)
    {
        return new Death(BaseEntity(
            row.PersonId,
            YearMonth(row.DeathYearMonth!),
            1,
            32885,
            string.Empty,
            "Death",
            []))
        {
            Primary = false
        };
    }

    private VisitOccurrence ToEncounter(EncounterRow row)
    {
        var visit = VisitEntity(
            row.PersonId,
            row.Encid,
            row.InteractionType,
            row.Date,
            row.Date,
            row.ProviderId,
            row.IsBaseline);
        return visit;
    }

    private VisitOccurrence ToVisit(VisitRow row) => VisitEntity(
        row.PersonId,
        row.VisitId,
        row.VisitType,
        row.StartDate,
        row.EndDate,
        null,
        false);

    private VisitOccurrence VisitEntity(
        long personId,
        string encid,
        string visitType,
        DateTime start,
        DateTime end,
        long? providerId,
        bool baseline)
    {
        var mapping = OptionalMapping(visitType, "Visits", start);
        var additional = new Dictionary<string, string>
        {
            ["encid"] = encid,
            ["sort_index"] = "1"
        };
        if (baseline)
            additional[BaselineMarker] = "true";

        return new VisitOccurrence(MappedEntity(
            personId,
            start,
            end,
            visitType,
            32827,
            additional,
            mapping,
            "Visit"))
        {
            Id = NextId(),
            ProviderId = providerId
        };
    }

    private ConditionOccurrence ToDiagnosis(DiagnosisRow row)
    {
        var code = row.Code?.Trim() ?? string.Empty;
        var codeType = row.CodeType?.Trim().ToUpperInvariant() ?? string.Empty;
        var lookup = codeType switch
        {
            "ICD9" => "ConditionIcd9",
            "ICD10" => "ConditionIcd10",
            "SNOMED" or "SNOMEDCT" => "ConditionSNOMED",
            "CPT4" => "ConditionCPT4",
            _ => string.Empty
        };
        var key = codeType is "ICD9" or "ICD10" ? code.Replace(".", string.Empty) : code;
        var mapping = OptionalMapping(key, lookup, row.Date);
        var entity = MappedEntity(
            row.PersonId,
            row.Date,
            null,
            code,
            32840,
            EncidFields(row.Encid),
            mapping,
            "Condition");
        var condition = new ConditionOccurrence(entity)
        {
            Id = NextId(),
            StatusConceptId = DiagnosisStatus(row),
            StatusSourceValue = DiagnosisStatusSource(row)
        };
        return condition;
    }

    private ProcedureOccurrence ToProcedure(ProcedureRow row)
    {
        var type = row.CodeType.Trim().ToUpperInvariant();
        var lookup = type switch
        {
            "CPT4" or "HCPCS" or "ICD10" => "ConditionFromProcedure",
            "ICD9" => "Icd9Proc",
            "SNOMED" or "SNOMEDCT" => "ConditionSNOMED",
            _ => string.Empty
        };
        var key = type is "CPT4" or "HCPCS" or "ICD10"
            ? row.Code.Replace(".", string.Empty)
            : row.Code;
        var mapping = OptionalMapping(key, lookup, row.Date);
        var procedure = new ProcedureOccurrence(MappedEntity(
            row.PersonId,
            row.Date,
            null,
            row.Code,
            32833,
            EncidFields(row.Encid),
            mapping,
            "Procedure"))
        {
            Id = NextId(),
            ProviderId = row.ProviderId
        };
        return procedure;
    }

    private DrugExposure ToMedicationAdministration(MedicationAdministrationRow row)
    {
        var mapping = OptionalMapping(row.Ndc, "Drug", row.Date);
        var additional = EncidFields(row.Encid);
        additional["itndc"] = "1";
        var drug = new DrugExposure(MappedEntity(
            row.PersonId,
            row.Date,
            row.Date,
            row.Ndc,
            32818,
            additional,
            mapping,
            "Drug"))
        {
            Id = NextId(),
            ProviderId = row.ProviderId,
            Quantity = row.Quantity,
            DoseUnitSourceValue = row.StrengthUnit
        };
        SetRoute(drug, row.Route, row.Date);
        return drug;
    }

    private DrugExposure ToPrescription(PrescriptionRow row)
    {
        var mapping = OptionalMapping(row.Ndc, "Drug", row.Date);
        var additional = new Dictionary<string, string>
        {
            ["encid"] = string.Empty,
            ["itndc"] = "1",
            ["quantity_of_dose"] = row.QuantityOfDose ?? string.Empty,
            ["quantity_per_fill"] = row.QuantityPerFill ?? string.Empty
        };
        var drug = new DrugExposure(MappedEntity(
            row.PersonId,
            row.Date,
            row.Date,
            row.Ndc,
            32838,
            additional,
            mapping,
            "Drug"))
        {
            Id = NextId(),
            Quantity = ParseLeadingDecimal(row.QuantityPerFill) ?? ParseLeadingDecimal(row.QuantityOfDose),
            Refills = ParseNullableInt(row.Refills),
            DaysSupply = ParseNullableInt(row.DaysSupply) ?? 1,
            DoseUnitSourceValue = $"{row.Strength};{row.StrengthUnit};{row.DosageForm};{row.DoseFrequency}"
        };
        SetRoute(drug, row.Route, row.Date);
        return drug;
    }

    private DrugExposure ToReportedMedication(ReportedMedicationRow row)
    {
        var mapping = OptionalMapping(row.Ndc, "Drug", row.Date);
        var additional = new Dictionary<string, string>
        {
            ["encid"] = string.Empty,
            ["itndc"] = "1"
        };
        var drug = new DrugExposure(MappedEntity(
            row.PersonId,
            row.Date,
            row.Date,
            row.Ndc,
            32865,
            additional,
            mapping,
            "Drug"))
        {
            Id = NextId(),
            Quantity = row.Quantity
        };
        SetRoute(drug, row.Route, row.Date);
        return drug;
    }

    private DrugExposure ToImmunization(ImmunizationRow row)
    {
        var date = row.Date!.Value;
        var ndc = row.Ndc ?? string.Empty;
        var mapping = row.Ndc is null
            ? OptionalMapping(row.Description, "EhrVax", date)
            : OptionalMapping(ndc, "Drug", date);
        var source = row.Ndc is null
            ? row.Description
            : $"{row.Ndc}-{row.Description}";
        var additional = new Dictionary<string, string>
        {
            ["encid"] = string.Empty,
            ["itndc"] = "1",
            ["immunization_desc"] = row.Description,
            ["immunization_source"] = source
        };
        return new DrugExposure(MappedEntity(
            row.PersonId,
            date,
            date,
            ndc,
            32818,
            additional,
            mapping,
            "Drug"))
        {
            Id = NextId()
        };
    }

    private Measurement ToLab(LabRow row)
    {
        var mapping = OptionalMapping(row.TestName, "LabNam", row.Date);
        var unit = OptionalMapping(row.Unit, "Lab_Units", row.Date);
        var result = OptionalMapping(row.Result, "LabRes", row.Date);
        return new Measurement(MappedEntity(
            row.PersonId,
            row.Date,
            null,
            row.TestName,
            32856,
            new Dictionary<string, string>
            {
                ["encid"] = row.Encid,
                ["test_result"] = row.Result,
                ["normal_range"] = row.NormalRange
            },
            mapping,
            "Measurement"))
        {
            Id = NextId(),
            OperatorConceptId = Operator(row.RelativeIndicator),
            ValueSourceValue = row.Result,
            ValueAsConceptId = result?.ConceptId,
            UnitConceptId = unit?.ConceptId ?? 0,
            UnitSourceValue = row.Unit
        };
    }

    private Measurement ToNlpMeasurement(NlpMeasurementRow row)
    {
        var mapping = OptionalMapping(row.Type, "Nlpm", row.Date);
        var unit = OptionalMapping(row.Detail, "Lab_Units", row.Date);
        var result = OptionalMapping(row.Value, "LabRes", row.Date);
        return new Measurement(MappedEntity(
            row.PersonId,
            row.Date,
            null,
            row.Type,
            32858,
            new Dictionary<string, string>
            {
                ["encid"] = row.Encid,
                ["test_result"] = row.Value
            },
            mapping,
            "Measurement"))
        {
            Id = NextId(),
            ValueSourceValue = row.Value,
            ValueAsConceptId = result?.ConceptId,
            UnitConceptId = unit?.ConceptId ?? 0,
            UnitSourceValue = row.Detail
        };
    }

    private Observation ToObservation(ObservationRow row)
    {
        var mapping = OptionalMapping(row.Type, "Obtype", row.Date);
        var unit = OptionalMapping(row.Unit, "Lab_Units", row.Date);
        var result = OptionalMapping(row.Result, "LabRes", row.Date);
        var start = row.Date.Date + TimeSpan.Parse(row.Time, CultureInfo.InvariantCulture);
        return new Observation(MappedEntity(
            row.PersonId,
            start,
            null,
            row.Type,
            32831,
            new Dictionary<string, string>
            {
                ["encid"] = row.Encid,
                ["source"] = "observations",
                ["test_result"] = row.Result
            },
            mapping,
            "Observation"))
        {
            Id = NextId(),
            ValueSourceValue = row.Result,
            ValueAsConceptId = result?.ConceptId,
            UnitsConceptId = unit?.ConceptId ?? 0,
            UnitsSourceValue = row.Unit
        };
    }

    private Observation ToMicrobiology(MicrobiologyRow row)
    {
        var start = row.Date.Date + TimeSpan.Parse(row.Time, CultureInfo.InvariantCulture);
        return new Observation(BaseEntity(
            row.PersonId,
            start,
            4252364,
            32835,
            row.Specimen,
            "Observation",
            EncidFields(row.Encid)))
        {
            Id = NextId(),
            ValueAsString = row.Organism,
            ValueSourceValue = row.Organism
        };
    }

    private DrugExposure ToNlpDrug(NlpDrugRow row)
    {
        var mapping = OptionalMapping(row.DrugName, "DrugNlp", row.Date);
        return new DrugExposure(MappedEntity(
            row.PersonId,
            row.Date,
            row.Date,
            row.DrugName,
            32831,
            EncidFields(row.Encid),
            mapping,
            "Drug"))
        {
            Id = NextId(),
            StopReason = row.Reason
        };
    }

    private Observation ToInsurance(InsuranceRow row)
    {
        var conceptId = row.Type.ToLowerInvariant() switch
        {
            "commercial" => 418,
            "medicare" => 280,
            "medicaid" => 289,
            _ => 0
        };
        var start = row.Date.Date + TimeSpan.Parse(row.Time, CultureInfo.InvariantCulture);
        return new Observation(BaseEntity(
            row.PersonId,
            start,
            conceptId,
            32867,
            row.Type,
            "Observation",
            EncidFields(row.Encid)))
        {
            Id = NextId(),
            ValueAsString = row.Type
        };
    }

    private static bool IsAcceptedNlpDrug(NlpDrugRow row) =>
        row.Action is "TAKE" or "START" or "ADMINISTER" or "MEDICATE" &&
        !string.IsNullOrWhiteSpace(row.DrugName) &&
        string.IsNullOrWhiteSpace(row.Sentiment);

    private Entity MappedEntity(
        long personId,
        DateTime start,
        DateTime? end,
        string source,
        long typeConceptId,
        Dictionary<string, string> additional,
        LookupValue? mapping,
        string fallbackDomain)
    {
        var entity = BaseEntity(
            personId,
            start,
            mapping?.ConceptId ?? 0,
            typeConceptId,
            source,
            mapping?.Domain ?? fallbackDomain,
            additional);
        entity.EndDate = end;
        entity.SourceConceptId = SourceConceptId(mapping);
        entity.VocabularySourceValue = mapping?.SourceCode ?? source;
        entity.ValidStartDate = mapping?.ValidStartDate ?? OptumPantherTestVocabulary.ValidStart;
        entity.ValidEndDate = mapping?.ValidEndDate ?? OptumPantherTestVocabulary.ValidEnd;
        entity.SourceConcepts = mapping?.SourceConcepts is null ? [] : [.. mapping.SourceConcepts];
        entity.Ingredients = mapping?.Ingredients is null ? [] : [.. mapping.Ingredients];
        entity.ValueAsConceptId = mapping?.ValueAsConceptIds?.FirstOrDefault();
        return entity;
    }

    private Entity BaseEntity(
        long personId,
        DateTime start,
        long conceptId,
        long typeConceptId,
        string source,
        string domain,
        Dictionary<string, string> additional)
    {
        return new Entity
        {
            Id = NextId(),
            PersonId = personId,
            ConceptId = conceptId,
            StartDate = start,
            TypeConceptId = typeConceptId,
            SourceValue = source,
            Domain = domain,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = additional,
            SourceConcepts = [],
            Ingredients = [],
            ValidStartDate = OptumPantherTestVocabulary.ValidStart,
            ValidEndDate = OptumPantherTestVocabulary.ValidEnd
        };
    }

    private void SetRoute(DrugExposure drug, string route, DateTime eventDate)
    {
        var mapping = OptionalMapping(route, "Route", eventDate);
        drug.RouteConceptId = mapping?.ConceptId ?? 0;
        drug.RouteSourceValue = route;
    }

    private LookupValue? OptionalMapping(string source, string lookup, DateTime eventDate)
    {
        if (string.IsNullOrWhiteSpace(source) || string.IsNullOrWhiteSpace(lookup))
            return null;
        return _vocabulary.Lookup(source, lookup, eventDate).FirstOrDefault();
    }

    private long NextId() => _nextEntityId++;

    private static Dictionary<string, string> EncidFields(string encid) =>
        new() { ["encid"] = encid };

    private static long SourceConceptId(LookupValue? mapping) =>
        mapping?.SourceConcepts.FirstOrDefault()?.ConceptId ?? 0;

    private static int? ParseBirthYear(string? source)
    {
        if (string.IsNullOrWhiteSpace(source) || source.Equals("Unknown", StringComparison.OrdinalIgnoreCase))
            return null;
        var value = source.Replace(" and earlier", string.Empty, StringComparison.OrdinalIgnoreCase);
        return int.TryParse(value, NumberStyles.Integer, CultureInfo.InvariantCulture, out var year)
            ? year
            : null;
    }

    private static int? ParseNullableInt(string? source)
    {
        if (string.IsNullOrWhiteSpace(source))
            return null;
        if (decimal.TryParse(source, NumberStyles.Number, CultureInfo.InvariantCulture, out var value))
            return decimal.ToInt32(value);
        return null;
    }

    private static decimal? ParseLeadingDecimal(string? source)
    {
        if (string.IsNullOrWhiteSpace(source))
            return null;

        var token = new string(source.Trim()
            .TakeWhile(character => char.IsDigit(character) || character is '.' or ',' or '-')
            .ToArray())
            .Replace(',', '.');

        return decimal.TryParse(token, NumberStyles.Number, CultureInfo.InvariantCulture, out var value)
            ? value
            : null;
    }

    private static long Race(string source) => source.Trim().ToLowerInvariant() switch
    {
        "caucasian" => 8527,
        "african american" => 8516,
        "asian" => 8515,
        _ => 0
    };

    private static long Ethnicity(string source) => source.Trim().ToLowerInvariant() switch
    {
        "hispanic" => 38003563,
        "not hispanic" => 38003564,
        _ => 0
    };

    private static long? DiagnosisStatus(DiagnosisRow row)
    {
        if (row.Status.Trim().Equals("Possible diagnosis of", StringComparison.OrdinalIgnoreCase))
            return 32899;
        if (row.Status.Trim().Equals("History of", StringComparison.OrdinalIgnoreCase))
            return 1340204;
        if (row.Primary == "1" && row.Admitting == "1")
            return 32901;
        if (row.Primary == "1" && row.Admitting != "1" && row.Discharge != "1")
            return 32902;
        if (row.Primary == "1" && row.Admitting != "1" && row.Discharge == "1")
            return 32903;
        if (row.Primary != "1" && row.Admitting == "1")
            return 32890;
        if (row.Primary != "1" && row.Admitting != "1" && row.Discharge == "1")
            return 32896;
        return null;
    }

    private static string DiagnosisStatusSource(DiagnosisRow row) =>
        $"{row.Status};" +
        (row.Admitting == "1" ? "ADMITTING_DIAGNOSIS;" : string.Empty) +
        (row.Discharge == "1" ? "DISCHARGE_DIAGNOSIS;" : string.Empty) +
        (row.Primary == "1" ? "PRIMARY_DIAGNOSIS;" : string.Empty);

    private static long? Operator(string source) => source switch
    {
        "<=" => 4171754,
        ">=" => 4171755,
        "<" => 4171756,
        "=" => 4172703,
        ">" => 4172704,
        "" => null,
        _ => 0
    };

    private static DateTime Date(string source) =>
        DateTime.ParseExact(source, "yyyy-MM-dd", CultureInfo.InvariantCulture);

    private static DateTime YearMonth(string source) =>
        DateTime.ParseExact(source + "01", "yyyyMMdd", CultureInfo.InvariantCulture);

    private sealed record PatientRow(
        long PersonId,
        string Gender,
        string? BirthYear,
        string Race,
        string Ethnicity,
        string Region,
        string Division,
        bool IdnIndicator,
        string FirstMonthActive,
        string LastMonthActive,
        string? DeathYearMonth,
        bool Deceased);

    private sealed record EncounterRow(
        long PersonId,
        string Encid,
        string InteractionType,
        DateTime Date,
        long? ProviderId,
        string? VisitId,
        bool IsBaseline);

    private sealed record VisitRow(
        long PersonId,
        string VisitId,
        DateTime StartDate,
        DateTime EndDate,
        string VisitType);

    private sealed record DiagnosisRow(
        long PersonId,
        string? Code,
        string? CodeType,
        string Status,
        DateTime Date,
        string Encid,
        string Primary,
        string Admitting,
        string Discharge);

    private sealed record ProcedureRow(
        long PersonId,
        string Code,
        string CodeType,
        DateTime Date,
        string Encid,
        long? ProviderId);

    private sealed record MedicationAdministrationRow(
        long PersonId,
        string Ndc,
        DateTime Date,
        string Encid,
        long? ProviderId,
        string Route,
        decimal? Quantity,
        string StrengthUnit);

    private sealed record PrescriptionRow(
        long PersonId,
        DateTime Date,
        string Ndc,
        string Route,
        string? QuantityOfDose,
        string? QuantityPerFill,
        string? Refills,
        string? DaysSupply,
        string Strength,
        string StrengthUnit,
        string DosageForm,
        string DoseFrequency);

    private sealed record ReportedMedicationRow(
        long PersonId,
        DateTime Date,
        string Ndc,
        string Route,
        decimal? Quantity);

    private sealed record ImmunizationRow(
        long PersonId,
        DateTime? Date,
        string? Ndc,
        string Description,
        string PatientReported);

    private sealed record LabRow(
        long PersonId,
        DateTime Date,
        string TestName,
        string Result,
        string Unit,
        string RelativeIndicator,
        string NormalRange,
        string Encid);

    private sealed record NlpMeasurementRow(
        long PersonId,
        DateTime Date,
        string Type,
        string Value,
        string Detail,
        string Encid);

    private sealed record ObservationRow(
        long PersonId,
        DateTime Date,
        string Type,
        string Time,
        string Result,
        string Unit,
        string Encid);

    private sealed record MicrobiologyRow(
        long PersonId,
        DateTime Date,
        string Specimen,
        string Organism,
        string Time,
        string Encid);

    private sealed record NlpDrugRow(
        long PersonId,
        DateTime Date,
        string DrugName,
        string? Action,
        string? Sentiment,
        string Reason,
        string Encid);

    private sealed record NlpBiomarkerRow(
        long PersonId,
        DateTime Date,
        string Biomarker,
        string Variation,
        string Status);

    private sealed record InsuranceRow(
        long PersonId,
        DateTime Date,
        string Type,
        string Time,
        string Encid);

    private sealed record ProviderRow(long ProviderId, string Specialty, string PrimarySpecialty);
}

internal sealed class OptumPantherTestVocabulary : IVocabulary
{
    internal static readonly DateTime ValidStart = new(1900, 1, 1);
    internal static readonly DateTime ValidEnd = new(2099, 12, 31);

    private readonly Dictionary<string, List<LookupValue>> _mappings = new(StringComparer.Ordinal);
    private readonly Dictionary<long, string> _domains = [];
    private readonly Dictionary<long, string> _vocabularies = [];

    internal OptumPantherTestVocabulary()
    {
        Map("Visits", "Inpatient", 8717, "Visit");
        Map("Visits", "Other patient type", 581477, "Visit");
        Map("CMSPlaceOfService", "8717", 9201, "Visit");
        Map("CMSPlaceOfService", "581477", 9202, "Visit");
        Map("CMSPlaceOfService", "9201", 9201, "Visit");
        Map("CMSPlaceOfService", "9202", 9202, "Visit");

        Map("ConditionIcd9", "7061", 141095, "Condition", vocabularyId: "ICD9CM");
        Map("ConditionIcd10", "H44611", 381850, "Condition", vocabularyId: "ICD10CM");
        Map("ConditionIcd9", "7953", 4189544, "Measurement", 44828170, "ICD9CM");
        Map("ConditionSNOMED", "145003003", 4120300, "Measurement", vocabularyId: "SNOMED");
        Map("ConditionSNOMED", "156009", 4048868, "Device", vocabularyId: "SNOMED");
        Map("ConditionIcd9", "7606", 4301351, "Procedure", vocabularyId: "ICD9CM");
        Map("ConditionIcd10", "Z01110", 4134565, "Procedure", vocabularyId: "ICD10CM");
        Map("ConditionSNOMED", "10019001", 4001760, "Procedure", vocabularyId: "SNOMED");
        Map("ConditionIcd9", "4019", 320128, "Condition", vocabularyId: "ICD9CM");
        Map("ConditionIcd9", "2724", 432867, "Condition", vocabularyId: "ICD9CM");
        Map("ConditionIcd10", "R42", 433316, "Observation", 45568132, "ICD10CM");
        Map("ConditionIcd9", "7061", 141095, "Condition", 44820501, "ICD9CM");

        Map("ConditionFromProcedure", "G9312", 4334801, "Condition", vocabularyId: "HCPCS");
        Map("ConditionFromProcedure", "A4217", 2614697, "Device", vocabularyId: "HCPCS");
        Map("ConditionFromProcedure", "36415", 4102442, "Procedure", vocabularyId: "CPT4");
        Map("ConditionFromProcedure", "C9743", 37204304, "Procedure", vocabularyId: "HCPCS");
        Map("Icd9Proc", "33.50", 4337138, "Procedure", vocabularyId: "ICD9Proc");
        Map("ConditionFromProcedure", "0J8S0", 2863829, "Procedure", vocabularyId: "ICD10PCS");
        Map("ConditionFromProcedure", "J9310", 46275081, "Drug", 2718907, "HCPCS", [46275081]);

        Map("Drug", "55111067101", 1322189, "Drug", 45071548, "NDC", [1322189]);
        Map("Drug", "66521011802", 46275888, "Drug", 46364505, "NDC", [46275888]);
        Map("Drug", "58487000102", 0, "Drug", vocabularyId: "NDC");
        Map("Drug", "69374096750", 0, "Drug", vocabularyId: "NDC");
        Map("Drug", "00406012301", 0, "Drug", vocabularyId: "NDC");
        Map("Drug", "69618004610", 0, "Drug", vocabularyId: "NDC");
        Map("Drug", "70461032103", 0, "Drug", vocabularyId: "NDC");
        Map("EhrVax", "COVID-19 VACCINE, PFIZER", 37003436, "Drug", vocabularyId: "JNJ_OPTUM_EHR_VAX", ingredients: [37003436]);
        Map("EhrVax", "COVID-19 VACCINE, MODERNA", 37003518, "Drug", vocabularyId: "JNJ_OPTUM_EHR_VAX", ingredients: [37003518]);
        Map("EhrVax", "SARS-COV-2 (COVID-19) vaccine, UNSPECIFIED", 724904, "Drug", vocabularyId: "JNJ_OPTUM_EHR_VAX", ingredients: [724904]);
        Map("DrugNlp", "COUMADIN", 1310149, "Drug", vocabularyId: "JNJ_OPTUM_NLP_DRUG", ingredients: [1310149]);
        Map("Route", "Oral", 4132161, "Route");

        Map("LabNam", "Oxygen.partial pressure (PO2).unspecified specimen", 3027315, "Measurement");
        Map("LabNam", "O2 saturation.oximetry", 3016502, "Measurement");
        Map("LabNam", "Oxygen saturation (SpO2).pulse oximetry", 3016502, "Measurement");
        Map("LabRes", "positive", 45884084, "Meas Value");
        Map("LabRes", "normal", 4069590, "Meas Value");
        Map("Lab_Units", "pH", 8482, "Unit");
        Map("Lab_Units", "kilogram", 9529, "Unit");
        Map("Lab_Units", "kg", 9529, "Unit");
        Map("Nlpm", "WEIGHT", 3025315, "Measurement");
        Map("Obtype", "SBP", 3004249, "Measurement");
        Map("Obtype", "SMOKE", 40766362, "Observation");

        Map("Specialty", "Internal Medicine", 38004456, "Provider");
        Map("Specialty", "Family Medicine", 38004453, "Provider");
        Map("Specialty", "Primary Medicine", 0, "Provider");
    }

    internal int MappingCount => _mappings.Values.Sum(items => items.Count);

    internal OptumPantherTestVocabulary WithMapping(
        string lookup,
        string source,
        long conceptId,
        string domain,
        long sourceConceptId = 0,
        string? vocabularyId = null,
        long[]? ingredients = null,
        long[]? valueAsConceptIds = null)
    {
        Map(lookup, source, conceptId, domain, sourceConceptId, vocabularyId, ingredients, valueAsConceptIds);
        return this;
    }

    public void Fill(bool forLookup)
    {
    }

    public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
    {
        if (string.IsNullOrWhiteSpace(sourceValue) || string.IsNullOrWhiteSpace(key))
            return [];
        if (!_mappings.TryGetValue(MappingKey(key, sourceValue), out var values))
            return [];
        if (eventDate == DateTime.MinValue)
            return [.. values];
        return values
            .Where(value => eventDate.Date >= value.ValidStartDate.Date && eventDate.Date <= value.ValidEndDate.Date)
            .ToList();
    }

    public int? LookupGender(string genderSourceValue) => genderSourceValue?.Trim().ToLowerInvariant() switch
    {
        "male" or "m" => 8507,
        "female" or "f" => 8532,
        _ => 8551
    };

    public IEnumerable<PregnancyConcept> LookupPregnancyConcept(long conceptId) => [];

    public string? GetSourceVocabularyId(long conceptId) => _vocabularies.GetValueOrDefault(conceptId);

    public string? GetSourceDomain(long conceptId) => _domains.GetValueOrDefault(conceptId);

    private void Map(
        string lookup,
        string source,
        long conceptId,
        string domain,
        long sourceConceptId = 0,
        string? vocabularyId = null,
        long[]? ingredients = null,
        long[]? valueAsConceptIds = null)
    {
        var key = MappingKey(lookup, source);
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
            Ingredients = ingredients is null ? new HashSet<long>() : [.. ingredients],
            ValueAsConceptIds = valueAsConceptIds is null ? new HashSet<long>() : [.. valueAsConceptIds]
        });
        if (conceptId > 0)
        {
            _domains[conceptId] = domain;
            if (!string.IsNullOrWhiteSpace(vocabularyId))
                _vocabularies[conceptId] = vocabularyId;
        }
    }

    private static string MappingKey(string lookup, string source)
    {
        var normalizedLookup = lookup.Trim().ToUpperInvariant();
        var normalizedSource = normalizedLookup == "LAB_UNITS"
            ? source.Trim()
            : source.Trim().ToUpperInvariant();
        return $"{normalizedLookup}\u001f{normalizedSource}";
    }
}
