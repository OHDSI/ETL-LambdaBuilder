using System.Globalization;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.etl.Transformation.JMDC;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

/// <summary>
/// In-memory equivalent of the source tables populated by the JMDC R tests.
/// </summary>
internal sealed class JmdcInMemoryScenario
{
    private const long BaselineVisitIdOffset = 9_000_000_000_000_000;
    private const long BaselineVisitDetailIdOffset = 8_000_000_000_000_000;

    private readonly JmdcTestVocabulary _vocabulary = new();

    private readonly List<EnrollmentRow> _enrollments = [];
    private readonly List<ClaimRow> _claims = [];
    private readonly List<DiagnosisRow> _diagnoses = [];
    private readonly List<DrugRow> _drugs = [];
    private readonly List<ProcedureRow> _procedures = [];
    private readonly List<AnnualHealthCheckupRow> _checkups = [];
    private readonly List<MedicalFacilityRow> _facilities = [];
    private readonly Dictionary<long, string> _diagnosisMaster = new()
    {
        [123] = "J309"
    };
    private readonly Dictionary<(long Code, string Version), string> _procedureMaster = new()
    {
        [(123, "201404")] = "9394"
    };

    internal JmdcTestVocabulary Vocabulary => _vocabulary;

    internal void AddEnrollment(
        string memberId,
        string genderOfMember = "Male",
        string monthAndYearOfBirth = "199407",
        string observationStart = "201001",
        string observationEnd = "201712",
        bool withdrawalDeath = false)
    {
        _enrollments.Add(new EnrollmentRow(
            memberId,
            genderOfMember,
            monthAndYearOfBirth,
            observationStart,
            observationEnd,
            withdrawalDeath));
    }

    internal void AddClaim(
        string memberId,
        string claimId,
        string typeOfClaim = "Outpatient",
        string monthAndYearOfMedicalCare = "202312",
        string? admissionDate = null,
        int daysOfMedicalCare = 1,
        string medicalFacilityId = "F0024811",
        decimal? totalPoint = 350m)
    {
        _claims.Add(new ClaimRow(
            memberId,
            claimId,
            typeOfClaim,
            monthAndYearOfMedicalCare,
            admissionDate,
            daysOfMedicalCare,
            medicalFacilityId,
            totalPoint));
    }

    internal void AddDiagnosis(
        string memberId,
        string claimId,
        long standardDiseaseCode = 123,
        string standardDiseaseName = "allergic rhinitis",
        string typeOfClaim = "Outpatient",
        string medicalFacilityId = "F0231947",
        string dateOfMedicalCareStart = "2022-09-26",
        int outcome = 1,
        int? suspicionFlag = null)
    {
        _diagnoses.Add(new DiagnosisRow(
            memberId,
            claimId,
            standardDiseaseCode,
            standardDiseaseName,
            typeOfClaim,
            medicalFacilityId,
            dateOfMedicalCareStart,
            outcome,
            suspicionFlag));
    }

    internal void AddDiagnosisMaster(long standardDiseaseCode, string icd10Level4Code)
    {
        _diagnosisMaster[standardDiseaseCode] = icd10Level4Code.Replace("-", string.Empty);
    }

    internal void AddDrug(
        string memberId,
        string claimId,
        string typeOfClaim = "Pharmacy",
        long jmdcDrugCode = 100000067351,
        string? dateOfPrescription = null,
        int? administeredDays = 1,
        string medicalFacilityId = "F0231947",
        string prescribedAmountPerDay = "1.0",
        string unitOfAdministeredAmount = "T",
        string? asNeededMedicationFlag = null,
        string administeredAmount = "1.0",
        decimal drugPrice = 10.1m,
        decimal actualPoint = 0m)
    {
        _drugs.Add(new DrugRow(
            memberId,
            claimId,
            typeOfClaim,
            jmdcDrugCode,
            dateOfPrescription,
            administeredDays,
            medicalFacilityId,
            prescribedAmountPerDay,
            unitOfAdministeredAmount,
            asNeededMedicationFlag,
            administeredAmount,
            drugPrice,
            actualPoint));
    }

    internal void AddProcedure(
        string memberId,
        string claimId,
        long standardizedProcedureCode = 123,
        string standardizedProcedureVersion = "201404",
        string typeOfClaim = "Outpatient",
        string? dateOfProcedure = null,
        string medicalFacilityId = "F0231947",
        int numberOfTimes = 1,
        decimal procedureStandardPoint = 11m,
        decimal actualPoint = 0m)
    {
        _procedures.Add(new ProcedureRow(
            memberId,
            claimId,
            standardizedProcedureCode,
            standardizedProcedureVersion,
            typeOfClaim,
            dateOfProcedure,
            medicalFacilityId,
            numberOfTimes,
            procedureStandardPoint,
            actualPoint));
    }

    internal void AddProcedureMaster(
        long standardizedProcedureCode,
        string standardizedProcedureVersion,
        string icd9cmLevel1 = "")
    {
        _procedureMaster[(standardizedProcedureCode, standardizedProcedureVersion)] = icd9cmLevel1;
    }

    internal void AddAnnualHealthCheckup(
        string memberId,
        string dateOfHealthCheckup = "2015-04-01",
        string? bmi = "22.3",
        int? ecg = null,
        string? triglyceride = null,
        string? ast = "18",
        string? alt = "14",
        string? systolicBp = "120",
        string? diastolicBp = "70",
        int? sleep = 1)
    {
        _checkups.Add(new AnnualHealthCheckupRow(
            memberId,
            dateOfHealthCheckup,
            bmi,
            ecg,
            triglyceride,
            ast,
            alt,
            systolicBp,
            diastolicBp,
            sleep));
    }

    internal void AddMedicalFacility(
        string medicalFacilityId,
        string mediumClassificationOfDepartment = "General Internal Medicine")
    {
        _facilities.Add(new MedicalFacilityRow(
            medicalFacilityId,
            mediumClassificationOfDepartment));
    }

    internal ChunkData Build(string memberId)
    {
        var personId = ParseMemberId(memberId);
        var builder = new JmdcPersonBuilder(new JmdcPersonBuilder.JmdcVendor());
        builder.JoinToVocabulary(_vocabulary);

        var enrollments = _enrollments
            .Where(row => row.MemberId == memberId)
            .ToArray();

        foreach (var enrollment in enrollments)
        {
            builder.AddData(ToPerson(enrollment));

            if (enrollment.WithdrawalDeath)
            {
                builder.AddData(new Death(new Entity
                {
                    PersonId = personId,
                    StartDate = LastDayOfMonth(enrollment.ObservationEnd),
                    TypeConceptId = 32815,
                    SourceRecordGuid = Guid.NewGuid(),
                    AdditionalFields = []
                })
                {
                    Primary = false
                });
            }
        }

        if (enrollments.Length > 0)
        {
            var enrollment = enrollments.OrderBy(row => row.ObservationStart).First();
            var baselineVisit = ToBaselineVisit(personId, enrollment);
            builder.AddData(baselineVisit);
            builder.AddData(ToBaselineVisitDetail(personId, baselineVisit));
        }

        var claims = _claims
            .Where(row => row.MemberId == memberId)
            .ToDictionary(row => row.ClaimId);

        foreach (var claim in claims.Values)
        {
            builder.AddData(ToVisit(personId, claim));
        }

        foreach (var diagnosis in _diagnoses.Where(row => row.MemberId == memberId))
        {
            if (!claims.TryGetValue(diagnosis.ClaimId, out var claim))
                throw new InvalidOperationException($"Claim {diagnosis.ClaimId} was not added.");

            foreach (var entity in ToDiagnosisEntities(personId, diagnosis, claim, _vocabulary))
                builder.AddData(entity);
        }

        long drugEventId = 0;
        foreach (var drug in _drugs.Where(row => row.MemberId == memberId))
        {
            if (!claims.TryGetValue(drug.ClaimId, out var claim))
                throw new InvalidOperationException($"Claim {drug.ClaimId} was not added.");

            builder.AddData(ToDrug(personId, drug, claim, ++drugEventId, _vocabulary));
        }

        long procedureEventId = 0;
        foreach (var procedure in _procedures.Where(row => row.MemberId == memberId))
        {
            if (!claims.TryGetValue(procedure.ClaimId, out var claim))
                throw new InvalidOperationException($"Claim {procedure.ClaimId} was not added.");

            foreach (var entity in ToProcedureEntities(
                         personId,
                         procedure,
                         claim,
                         ++procedureEventId,
                         _vocabulary))
                builder.AddData(entity);
        }

        foreach (var checkup in _checkups.Where(row => row.MemberId == memberId))
        {
            foreach (var entity in ToCheckupEntities(personId, checkup))
                builder.AddData(entity);
        }

        var data = new ChunkData(chunkId: 0, subChunkId: 0);
        var attrition = builder.Build(
            data,
            new KeyMasterOffsetManager(chunkId: 0, prefix: 0, attempt: 0));

        Assert.Equal(Attrition.None, attrition);

        if (enrollments.Length > 0)
        {
            var baselineVisitId = BaselineVisitIdOffset + personId;
            var baselineVisitDetailId = BaselineVisitDetailIdOffset + personId;
            Assert.Contains(data.VisitOccurrences, item => item.Id == baselineVisitId);
            Assert.Contains(data.VisitDetails, item =>
                item.Id == baselineVisitDetailId &&
                item.VisitOccurrenceId == baselineVisitId);
        }

        return data;
    }

    internal StaticDataResult BuildStaticData()
    {
        var careSites = new List<CareSite>();
        var providers = new List<Provider>();

        foreach (var facility in _facilities)
        {
            var id = ParseFacilityId(facility.MedicalFacilityId);
            var specialty = _vocabulary
                .Lookup(facility.MediumClassificationOfDepartment, "JMDC_SPECIALTY", DateTime.MinValue)
                .FirstOrDefault();
            careSites.Add(new CareSite
            {
                Id = id,
                SourceValue = facility.MedicalFacilityId,
                Name = facility.MedicalFacilityId,
                AdditionalFields = []
            });
            providers.Add(new Provider
            {
                Id = id,
                CareSiteId = id,
                ProviderSourceValue = facility.MedicalFacilityId,
                SourceValue = facility.MediumClassificationOfDepartment,
                ConceptId = specialty?.ConceptId ?? 0,
                SpecialtySourceConceptId = specialty is null ? 0 : GetSourceConceptId(specialty),
                AdditionalFields = []
            });
        }

        return new StaticDataResult(careSites, providers);
    }

    private static Person ToPerson(EnrollmentRow row)
    {
        var gender = row.GenderOfMember.ToLowerInvariant();
        return new Person
        {
            PersonId = ParseMemberId(row.MemberId),
            PersonSourceValue = row.MemberId,
            GenderConceptId = gender == "male" ? 8507 : gender == "female" ? 8532 : 8551,
            GenderSourceValue = gender,
            RaceConceptId = 0,
            RaceSourceValue = string.Empty,
            YearOfBirth = int.Parse(row.MonthAndYearOfBirth[..4], CultureInfo.InvariantCulture),
            MonthOfBirth = int.Parse(row.MonthAndYearOfBirth[4..6], CultureInfo.InvariantCulture),
            StartDate = FirstDayOfMonth(row.ObservationStart),
            EndDate = LastDayOfMonth(row.ObservationEnd),
            TypeConceptId = 32813,
            ObservationPeriodGap = 0,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = []
        };
    }

    private static VisitOccurrence ToVisit(long personId, ClaimRow row)
    {
        var visitId = ParseClaimId(row.ClaimId);
        var visit = new VisitOccurrence(new Entity
        {
            PersonId = personId,
            ConceptId = row.TypeOfClaim == "Outpatient" ? 9202 : 9201,
            StartDate = ClaimStart(row),
            TypeConceptId = 32810,
            SourceValue = row.TypeOfClaim,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = new Dictionary<string, string>
            {
                ["num_of_days"] = row.DaysOfMedicalCare.ToString(CultureInfo.InvariantCulture)
            }
        })
        {
            Id = visitId,
            CareSiteId = ParseFacilityId(row.MedicalFacilityId)
        };

        if (row.TotalPoint.HasValue)
        {
            visit.VisitCosts =
            [
                new VisitCost(visit)
                {
                    TotalPaid = row.TotalPoint.Value * 10m,
                    CurrencyConceptId = 44818592
                }
            ];
        }

        return visit;
    }

    private static VisitOccurrence ToBaselineVisit(long personId, EnrollmentRow row)
    {
        var startDate = FirstDayOfMonth(row.ObservationStart);
        return new VisitOccurrence(new Entity
        {
            PersonId = personId,
            ConceptId = 9202,
            StartDate = startDate,
            EndDate = startDate,
            TypeConceptId = 32810,
            SourceValue = "Unit test baseline visit",
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = new Dictionary<string, string>
            {
                ["num_of_days"] = "1"
            }
        })
        {
            Id = BaselineVisitIdOffset + personId
        };
    }

    private static VisitDetail ToBaselineVisitDetail(long personId, VisitOccurrence visit)
    {
        return new VisitDetail(new Entity
        {
            PersonId = personId,
            ConceptId = visit.ConceptId,
            StartDate = visit.StartDate,
            EndDate = visit.EndDate,
            TypeConceptId = visit.TypeConceptId,
            VisitOccurrenceId = visit.Id,
            SourceValue = "Unit test baseline visit detail",
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = []
        })
        {
            Id = BaselineVisitDetailIdOffset + personId
        };
    }

    private IEnumerable<IEntity> ToDiagnosisEntities(
        long personId,
        DiagnosisRow row,
        ClaimRow claim,
        JmdcTestVocabulary vocabulary)
    {
        _diagnosisMaster.TryGetValue(row.StandardDiseaseCode, out var icd10);
        icd10 ??= string.Empty;
        var sourceValue = $"{row.StandardDiseaseCode}|{row.StandardDiseaseName}";
        var typeConceptId = row.TypeOfClaim == "Outpatient" ? 32859 : 32853;
        var normalizedStart = ParseDate(row.DateOfMedicalCareStart).ToString("yyyyMMdd", CultureInfo.InvariantCulture);
        var sourceRecordGuid = Guid.NewGuid();

        foreach (var mapping in vocabulary.Lookup(icd10, "JMDC-ICD10-SNOMED", ClaimStart(claim)))
        {
            if (mapping.ValueAsConceptIds is not null)
            {
                foreach (var valueConceptId in mapping.ValueAsConceptIds)
                {
                    vocabulary.WithMapping(
                        "JMDC-ICD10-MapsToValue",
                        sourceValue,
                        valueConceptId,
                        mapping.Domain);
                }
            }

            var entity = new Entity
            {
                PersonId = personId,
                ConceptId = mapping.ConceptId ?? 0,
                Domain = mapping.Domain,
                StartDate = DiagnosisStart(claim),
                TypeConceptId = typeConceptId,
                VisitOccurrenceId = ParseClaimId(row.ClaimId),
                ProviderId = ParseFacilityId(row.MedicalFacilityId),
                SourceValue = sourceValue,
                SourceConceptId = GetSourceConceptId(mapping),
                SourceRecordGuid = sourceRecordGuid,
                VocabularySourceValue = mapping.SourceCode,
                ValidStartDate = mapping.ValidStartDate,
                ValidEndDate = mapping.ValidEndDate,
                Ingredients = mapping.Ingredients is null ? null : [.. mapping.Ingredients],
                SourceConcepts = [.. mapping.SourceConcepts],
                ValueAsConceptId = mapping.ValueAsConceptIds?.FirstOrDefault(),
                AdditionalFields = new Dictionary<string, string>
                {
                    ["month_and_year_of_start"] = normalizedStart,
                    ["start_m_and_y_date"] = normalizedStart,
                    ["month_and_year"] = claim.MonthAndYearOfMedicalCare,
                    ["suspicion_flag"] = row.SuspicionFlag?.ToString(CultureInfo.InvariantCulture) ?? string.Empty
                }
            };

            // Diagnosis.xml first loads a ConditionOccurrence. JmdcPersonBuilder later
            // routes it by the domain returned from JMDC-ICD10-SNOMED.
            yield return new ConditionOccurrence(entity);
        }

        var isDpcDeath = row.TypeOfClaim == "DPC" && row.Outcome is 6 or 7;
        var isOtherDeath = row.TypeOfClaim != "DPC" && row.Outcome == 3;
        if (isDpcDeath || isOtherDeath)
        {
            yield return new Death(new Entity
            {
                PersonId = personId,
                StartDate = ClaimStart(claim),
                TypeConceptId = isDpcDeath ? 1 : 2,
                VisitOccurrenceId = ParseClaimId(row.ClaimId),
                SourceRecordGuid = Guid.NewGuid(),
                AdditionalFields = []
            })
            {
                Primary = true
            };
        }
    }

    private static DrugExposure ToDrug(
        long personId,
        DrugRow row,
        ClaimRow claim,
        long eventId,
        JmdcTestVocabulary vocabulary)
    {
        int? daysSupply = row.AdministeredDays switch
        {
            null => null,
            < 1 => 1,
            > 180 => 180,
            _ => row.AdministeredDays
        };
        var sig = $"{row.PrescribedAmountPerDay} {row.UnitOfAdministeredAmount} per day";
        if (row.AsNeededMedicationFlag == "1")
            sig += " as needed";
        if (!string.IsNullOrEmpty(row.AdministeredAmount))
            sig += $", {row.AdministeredAmount} {row.UnitOfAdministeredAmount} total";

        var sourceValue = row.JmdcDrugCode.ToString(CultureInfo.InvariantCulture);
        var mapping = RequiredMapping(
            vocabulary,
            sourceValue,
            "JMDC_DRUGCODE_RXNORM",
            row.DateOfPrescription is null ? ClaimStart(claim) : ParseDate(row.DateOfPrescription));
        var drug = new DrugExposure(new Entity
        {
            PersonId = personId,
            ConceptId = mapping.ConceptId ?? 0,
            Domain = mapping.Domain,
            StartDate = row.DateOfPrescription is null ? DateTime.MinValue : ParseDate(row.DateOfPrescription),
            TypeConceptId = row.TypeOfClaim is "Outpatient" or "Pharmacy" ? 32869 : 32818,
            VisitOccurrenceId = ParseClaimId(row.ClaimId),
            ProviderId = ParseFacilityId(row.MedicalFacilityId),
            SourceValue = sourceValue,
            SourceConceptId = GetSourceConceptId(mapping),
            VocabularySourceValue = mapping.SourceCode,
            ValidStartDate = mapping.ValidStartDate,
            ValidEndDate = mapping.ValidEndDate,
            Ingredients = mapping.Ingredients is null ? null : [.. mapping.Ingredients],
            SourceConcepts = [.. mapping.SourceConcepts],
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = []
        })
        {
            Id = eventId,
            DaysSupply = daysSupply,
            Sig = sig,
            Quantity = decimal.Parse(row.AdministeredAmount, CultureInfo.InvariantCulture)
        };

        drug.DrugCost = new DrugCost(drug)
        {
            TotalPaid = row.ActualPoint * 10m,
            PaidByCoordinationBenefits = row.DrugPrice * drug.Quantity,
            CurrencyConceptId = 44818592
        };
        return drug;
    }

    private IEnumerable<ProcedureOccurrence> ToProcedureEntities(
        long personId,
        ProcedureRow row,
        ClaimRow claim,
        long eventId,
        JmdcTestVocabulary vocabulary)
    {
        _procedureMaster.TryGetValue(
            (row.StandardizedProcedureCode, row.StandardizedProcedureVersion),
            out var icd9);
        icd9 ??= row.StandardizedProcedureCode.ToString(CultureInfo.InvariantCulture);
        var typeConceptId = row.TypeOfClaim == "Outpatient" ? 32859 : 32853;
        var sourceRecordGuid = Guid.NewGuid();
        var eventDate = row.DateOfProcedure is null ? ClaimStart(claim) : ParseDate(row.DateOfProcedure);
        var mappings = vocabulary.Lookup(icd9, "JMDC-ICDProcedure", eventDate)
            .Select(value => (Value: value, DefinitionType: 0L))
            .Concat(vocabulary
                .Lookup(
                    row.StandardizedProcedureCode.ToString(CultureInfo.InvariantCulture),
                    "JMDC-JNJProcedure",
                    eventDate)
                .Select(value => (Value: value, DefinitionType: 1L)))
            .ToArray();

        if (mappings.Length == 0)
        {
            throw new InvalidOperationException(
                $"No JMDC procedure vocabulary mapping for ICD procedure '{icd9}' " +
                $"or standardized procedure '{row.StandardizedProcedureCode}'.");
        }

        foreach (var (mapping, definitionType) in mappings)
        {
            var procedure = new ProcedureOccurrence(new Entity
            {
                PersonId = personId,
                ConceptId = mapping.ConceptId ?? 0,
                Domain = mapping.Domain,
                StartDate = row.DateOfProcedure is null ? DateTime.MinValue : ParseDate(row.DateOfProcedure),
                VisitOccurrenceId = ParseClaimId(row.ClaimId),
                ProviderId = ParseFacilityId(row.MedicalFacilityId),
                SourceValue = icd9,
                SourceConceptId = GetSourceConceptId(mapping),
                VocabularySourceValue = mapping.SourceCode,
                ValidStartDate = mapping.ValidStartDate,
                ValidEndDate = mapping.ValidEndDate,
                Ingredients = mapping.Ingredients is null ? null : [.. mapping.Ingredients],
                SourceConcepts = [.. mapping.SourceConcepts],
                SourceRecordGuid = sourceRecordGuid,
                AdditionalFields = new Dictionary<string, string>
                {
                    ["procedure_type_concept_id"] = typeConceptId.ToString(CultureInfo.InvariantCulture)
                }
            })
            {
                Id = eventId,
                TypeConceptId = definitionType
            };
            procedure.ProcedureCosts =
            [
                new ProcedureCost(procedure)
                {
                    TotalPaid = row.ActualPoint * 10m,
                    PaidByCoordinationBenefits = row.NumberOfTimes * 10m * row.ProcedureStandardPoint,
                    CurrencyConceptId = 44818592
                }
            ];

            yield return procedure;
        }
    }

    private static LookupValue RequiredMapping(
        JmdcTestVocabulary vocabulary,
        string sourceValue,
        string lookup,
        DateTime eventDate)
    {
        var values = vocabulary.Lookup(sourceValue, lookup, eventDate);
        if (values.Count == 0)
        {
            throw new InvalidOperationException(
                $"No test vocabulary mapping for lookup '{lookup}' and source value '{sourceValue}'.");
        }

        return values[0];
    }

    private static long GetSourceConceptId(LookupValue mapping) =>
        mapping.SourceConcepts.FirstOrDefault()?.ConceptId ?? 0;

    private static IEnumerable<IEntity> ToCheckupEntities(long personId, AnnualHealthCheckupRow row)
    {
        var date = ParseDate(row.DateOfHealthCheckup);

        if (row.Bmi is not null)
            yield return Measurement(personId, date, 3038553, "BMI", row.Bmi, 9531);
        if (row.Triglyceride is not null)
            yield return Measurement(personId, date, 3022038, "Triglyceride", row.Triglyceride, 8840);
        if (row.Ast is not null)
            yield return Measurement(personId, date, 3003792, "AST", row.Ast, 8645);
        if (row.Alt is not null)
            yield return Measurement(personId, date, 3006923, "ALT", row.Alt, 8645);
        if (row.SystolicBp is not null)
            yield return Measurement(personId, date, 3004249, "Systolic blood pressure", row.SystolicBp, null, 60, 300);
        if (row.DiastolicBp is not null)
            yield return Measurement(personId, date, 3012888, "Diastolic blood pressure", row.DiastolicBp, null, 30, 150);

        if (row.Ecg == 1)
        {
            yield return new ConditionOccurrence(new Entity
            {
                PersonId = personId,
                ConceptId = 320536,
                StartDate = date,
                TypeConceptId = 32836,
                SourceValue = "Electrocardiogram abnormal",
                SourceRecordGuid = Guid.NewGuid(),
                AdditionalFields = []
            });
        }

        if (row.Sleep.HasValue)
        {
            yield return new Observation(new Entity
            {
                PersonId = personId,
                ConceptId = 40764749,
                StartDate = date,
                TypeConceptId = 32836,
                SourceValue = "Sleep",
                ValueAsConceptId = row.Sleep == 1 ? 4188539 : 4188540,
                SourceRecordGuid = Guid.NewGuid(),
                AdditionalFields = []
            });
        }
    }

    private static Measurement Measurement(
        long personId,
        DateTime date,
        long conceptId,
        string sourceValue,
        string valueSourceValue,
        long? unitConceptId,
        decimal? rangeLow = null,
        decimal? rangeHigh = null)
    {
        return new Measurement(new Entity
        {
            PersonId = personId,
            ConceptId = conceptId,
            StartDate = date,
            TypeConceptId = 32836,
            SourceValue = sourceValue,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = []
        })
        {
            ValueSourceValue = valueSourceValue,
            UnitConceptId = unitConceptId,
            RangeLow = rangeLow,
            RangeHigh = rangeHigh
        };
    }

    private static DateTime ClaimStart(ClaimRow row)
    {
        var month = FirstDayOfMonth(row.MonthAndYearOfMedicalCare);
        if (row.AdmissionDate is null)
            return month.AddDays(14);

        var admission = ParseDate(row.AdmissionDate);
        return admission.Year == month.Year && admission.Month == month.Month
            ? admission
            : month;
    }

    private static DateTime DiagnosisStart(ClaimRow row) =>
        row.AdmissionDate is null
            ? FirstDayOfMonth(row.MonthAndYearOfMedicalCare).AddDays(14)
            : ParseDate(row.AdmissionDate);

    private static DateTime FirstDayOfMonth(string value) =>
        DateTime.ParseExact(value + "01", "yyyyMMdd", CultureInfo.InvariantCulture);

    private static DateTime LastDayOfMonth(string value)
    {
        var first = FirstDayOfMonth(value);
        return first.AddMonths(1).AddDays(-1);
    }

    private static DateTime ParseDate(string value) =>
        DateTime.ParseExact(value, "yyyy-MM-dd", CultureInfo.InvariantCulture);

    private static long ParseMemberId(string memberId) =>
        long.Parse(memberId.TrimStart('M'), CultureInfo.InvariantCulture);

    private static long ParseClaimId(string claimId) =>
        long.Parse(claimId.TrimStart('C'), CultureInfo.InvariantCulture);

    private static long ParseFacilityId(string facilityId) =>
        long.Parse("1" + facilityId.TrimStart('F'), CultureInfo.InvariantCulture);

    private sealed record EnrollmentRow(
        string MemberId,
        string GenderOfMember,
        string MonthAndYearOfBirth,
        string ObservationStart,
        string ObservationEnd,
        bool WithdrawalDeath);

    private sealed record ClaimRow(
        string MemberId,
        string ClaimId,
        string TypeOfClaim,
        string MonthAndYearOfMedicalCare,
        string? AdmissionDate,
        int DaysOfMedicalCare,
        string MedicalFacilityId,
        decimal? TotalPoint);

    private sealed record DiagnosisRow(
        string MemberId,
        string ClaimId,
        long StandardDiseaseCode,
        string StandardDiseaseName,
        string TypeOfClaim,
        string MedicalFacilityId,
        string DateOfMedicalCareStart,
        int Outcome,
        int? SuspicionFlag);

    private sealed record DrugRow(
        string MemberId,
        string ClaimId,
        string TypeOfClaim,
        long JmdcDrugCode,
        string? DateOfPrescription,
        int? AdministeredDays,
        string MedicalFacilityId,
        string PrescribedAmountPerDay,
        string UnitOfAdministeredAmount,
        string? AsNeededMedicationFlag,
        string AdministeredAmount,
        decimal DrugPrice,
        decimal ActualPoint);

    private sealed record ProcedureRow(
        string MemberId,
        string ClaimId,
        long StandardizedProcedureCode,
        string StandardizedProcedureVersion,
        string TypeOfClaim,
        string? DateOfProcedure,
        string MedicalFacilityId,
        int NumberOfTimes,
        decimal ProcedureStandardPoint,
        decimal ActualPoint);

    private sealed record AnnualHealthCheckupRow(
        string MemberId,
        string DateOfHealthCheckup,
        string? Bmi,
        int? Ecg,
        string? Triglyceride,
        string? Ast,
        string? Alt,
        string? SystolicBp,
        string? DiastolicBp,
        int? Sleep);

    private sealed record MedicalFacilityRow(
        string MedicalFacilityId,
        string MediumClassificationOfDepartment);

}

internal sealed record StaticDataResult(
    IReadOnlyList<CareSite> CareSites,
    IReadOnlyList<Provider> Providers);

internal sealed class JmdcTestVocabulary : IVocabulary
{
    private static readonly DateTime DefaultValidStart = new(1900, 1, 1);
    private static readonly DateTime DefaultValidEnd = new(2099, 12, 31);

    private readonly Dictionary<string, List<LookupValue>> _mappings =
        new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<long, string> _conceptDomains = [];
    private readonly Dictionary<long, string> _conceptVocabularies = [];

    internal JmdcTestVocabulary()
    {
        // Diagnosis.xml: condition_lookup_key -> standard concept/domain.
        WithMapping("JMDC-ICD10-SNOMED", "J309", 0, "Condition");
        WithMapping("JMDC-ICD10-SNOMED", "I10", 320128, "Condition", 45591453, "SNOMED");
        WithMapping("JMDC-ICD10-SNOMED", "Z043", 4085923, "Procedure", vocabularyId: "SNOMED");
        WithMapping(
            "JMDC-ICD10-SNOMED",
            "R824",
            4042243,
            "Measurement",
            vocabularyId: "SNOMED",
            valueAsConceptIds: [4181412]);
        WithMapping(
            "JMDC-ICD10-SNOMED",
            "Z914",
            1340204,
            "Observation",
            45590771,
            "SNOMED",
            [439990]);

        // JmdcPersonBuilder asks this lookup by the final source_value.
        WithMapping("JMDC-ICD10-MapsToValue", "3|allergic rhinitis", 4181412, "Measurement");
        WithMapping("JMDC-ICD10-MapsToValue", "4|allergic rhinitis", 439990, "Observation");

        // Drug.xml: known source codes used by the JMDC R cases.
        WithMapping("JMDC_DRUGCODE_RXNORM", "100000067351", 0, "Drug");
        WithMapping("JMDC_DRUGCODE_RXNORM", "100000008105", 35152527, "Drug", vocabularyId: "RxNorm");
        WithMapping("JMDC_DRUGCODE_RXNORM", "1", 0, "Drug");

        // Procedure.xml has two independent source vocabularies for one source row.
        WithMapping("JMDC-ICDProcedure", "9394", 4206920, "Procedure", 2007683, "SNOMED");
        WithMapping("JMDC-JNJProcedure", "123", 0, "Procedure");
        WithMapping("JMDC-JNJProcedure", "1", 0, "Procedure");
        WithMapping("JMDC-JNJProcedure", "2", 0, "Procedure");

        // L_PROVIDER.xml.
        WithMapping("JMDC_SPECIALTY", "General Internal Medicine", 0, "Provider");
        WithMapping("JMDC_SPECIALTY", "Cardiology", 38004451, "Provider");
    }

    internal int MappingCount => _mappings.Values.Sum(values => values.Count);

    internal JmdcTestVocabulary WithMapping(
        string lookup,
        string sourceValue,
        long conceptId,
        string domain,
        long sourceConceptId = 0,
        string? vocabularyId = null,
        long[]? valueAsConceptIds = null)
    {
        var key = MappingKey(lookup, sourceValue);
        if (!_mappings.TryGetValue(key, out var values))
        {
            values = [];
            _mappings.Add(key, values);
        }

        if (values.Any(value =>
                value.ConceptId == conceptId &&
                string.Equals(value.Domain, domain, StringComparison.Ordinal) &&
                string.Equals(value.SourceCode, sourceValue, StringComparison.OrdinalIgnoreCase)))
        {
            return this;
        }

        var sourceConcepts = new HashSet<SourceConcepts>();
        if (sourceConceptId > 0)
        {
            sourceConcepts.Add(new SourceConcepts
            {
                ConceptId = sourceConceptId,
                ValidStartDate = DefaultValidStart,
                ValidEndDate = DefaultValidEnd
            });
        }

        values.Add(new LookupValue
        {
            ConceptId = conceptId,
            Domain = domain,
            SourceCode = sourceValue,
            ValidStartDate = DefaultValidStart,
            ValidEndDate = DefaultValidEnd,
            SourceConcepts = sourceConcepts,
            ValueAsConceptIds = valueAsConceptIds is null ? null : [.. valueAsConceptIds]
        });

        if (conceptId > 0)
        {
            _conceptDomains[conceptId] = domain;
            if (!string.IsNullOrWhiteSpace(vocabularyId))
                _conceptVocabularies[conceptId] = vocabularyId;
        }

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
            .Where(value => eventDate.Date >= value.ValidStartDate.Date &&
                            eventDate.Date <= value.ValidEndDate.Date)
            .ToList();
    }

    public int? LookupGender(string genderSourceValue) => genderSourceValue?.Trim().ToLowerInvariant() switch
    {
        "male" or "m" => 8507,
        "female" or "f" => 8532,
        _ => 8551
    };

    public IEnumerable<PregnancyConcept> LookupPregnancyConcept(long conceptId) => [];

    public string? GetSourceVocabularyId(long conceptId) =>
        _conceptVocabularies.GetValueOrDefault(conceptId);

    public string? GetSourceDomain(long conceptId) =>
        _conceptDomains.GetValueOrDefault(conceptId);

    private static string MappingKey(string lookup, string sourceValue) =>
        $"{lookup.Trim()}\u001f{sourceValue.Trim()}";
}
