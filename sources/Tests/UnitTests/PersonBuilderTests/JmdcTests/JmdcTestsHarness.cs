using System.Globalization;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.etl.Transformation.JMDC;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.JmdcTests;

/// <summary>
/// In-memory equivalent of the source tables populated by the JMDC R tests.
/// Add* methods store source rows. Build performs the source-to-entity projection
/// and then invokes the real JmdcPersonBuilder.
/// </summary>
internal sealed class JmdcInMemoryScenario
{
    private const long BaselineVisitIdOffset = 9_000_000_000_000_000;
    private const long BaselineVisitDetailIdOffset = 8_000_000_000_000_000;

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
        string prescribedAmountPerDay = "1",
        string unitOfAdministeredAmount = "T",
        string? asNeededMedicationFlag = null,
        string administeredAmount = "1",
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
        string icd9cmLevel1 = "9394")
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
        var vocabulary = new JmdcTestVocabulary();
        builder.JoinToVocabulary(vocabulary);

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

            foreach (var entity in ToDiagnosisEntities(personId, diagnosis, claim, vocabulary))
                builder.AddData(entity);
        }

        long drugEventId = 0;
        foreach (var drug in _drugs.Where(row => row.MemberId == memberId))
        {
            if (!claims.TryGetValue(drug.ClaimId, out var claim))
                throw new InvalidOperationException($"Claim {drug.ClaimId} was not added.");

            builder.AddData(ToDrug(personId, drug, claim, ++drugEventId));
        }

        long procedureEventId = 0;
        foreach (var procedure in _procedures.Where(row => row.MemberId == memberId))
        {
            if (!claims.TryGetValue(procedure.ClaimId, out var claim))
                throw new InvalidOperationException($"Claim {procedure.ClaimId} was not added.");

            foreach (var entity in ToProcedureEntities(personId, procedure, claim, ++procedureEventId))
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
                ConceptId = facility.MediumClassificationOfDepartment == "Cardiology" ? 38004451 : 0,
                SpecialtySourceConceptId = 0,
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
        var mapping = DiagnosisMapping.For(icd10);
        var sourceValue = $"{row.StandardDiseaseCode}|{row.StandardDiseaseName}";
        var typeConceptId = row.TypeOfClaim == "Outpatient" ? 32859 : 32853;
        var normalizedStart = ParseDate(row.DateOfMedicalCareStart).ToString("yyyyMMdd", CultureInfo.InvariantCulture);
        var entity = new Entity
        {
            PersonId = personId,
            ConceptId = mapping.ConceptId,
            Domain = mapping.Domain,
            StartDate = ClaimStart(claim),
            TypeConceptId = typeConceptId,
            VisitOccurrenceId = ParseClaimId(row.ClaimId),
            ProviderId = ParseFacilityId(row.MedicalFacilityId),
            SourceValue = sourceValue,
            SourceConceptId = mapping.SourceConceptId,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = new Dictionary<string, string>
            {
                ["month_and_year_of_start"] = normalizedStart,
                ["start_m_and_y_date"] = normalizedStart,
                ["month_and_year"] = claim.MonthAndYearOfMedicalCare,
                ["suspicion_flag"] = row.SuspicionFlag?.ToString(CultureInfo.InvariantCulture) ?? string.Empty
            }
        };

        if (mapping.ValueConceptId.HasValue)
            vocabulary.WithValue(sourceValue, mapping.ValueConceptId.Value);

        // Diagnosis.xml always loads a ConditionOccurrence. Its mapped concept domain
        // is used later by AddToChunk to route the built record to the target CDM table.
        yield return new ConditionOccurrence(entity);

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
        long eventId)
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

        var drug = new DrugExposure(new Entity
        {
            PersonId = personId,
            ConceptId = row.JmdcDrugCode == 100000008105 ? 35152527 : 0,
            StartDate = row.DateOfPrescription is null ? DateTime.MinValue : ParseDate(row.DateOfPrescription),
            TypeConceptId = row.TypeOfClaim is "Outpatient" or "Pharmacy" ? 32869 : 32818,
            VisitOccurrenceId = ParseClaimId(row.ClaimId),
            ProviderId = ParseFacilityId(row.MedicalFacilityId),
            SourceValue = row.JmdcDrugCode.ToString(CultureInfo.InvariantCulture),
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
        long eventId)
    {
        _procedureMaster.TryGetValue(
            (row.StandardizedProcedureCode, row.StandardizedProcedureVersion),
            out var icd9);
        icd9 ??= row.StandardizedProcedureCode.ToString(CultureInfo.InvariantCulture);
        var mapped = icd9 == "9394";
        var typeConceptId = row.TypeOfClaim == "Outpatient" ? 32859 : 32853;
        var sourceRecordGuid = Guid.NewGuid();
        var common = new Entity
        {
            PersonId = personId,
            StartDate = row.DateOfProcedure is null ? DateTime.MinValue : ParseDate(row.DateOfProcedure),
            VisitOccurrenceId = ParseClaimId(row.ClaimId),
            ProviderId = ParseFacilityId(row.MedicalFacilityId),
            SourceValue = icd9,
            SourceRecordGuid = sourceRecordGuid,
            AdditionalFields = new Dictionary<string, string>
            {
                ["procedure_type_concept_id"] = typeConceptId.ToString(CultureInfo.InvariantCulture)
            }
        };

        var icd9Procedure = new ProcedureOccurrence(common)
        {
            Id = eventId,
            ConceptId = mapped ? 4206920 : 0,
            SourceConceptId = mapped ? 2007683 : 0,
            TypeConceptId = 0
        };
        icd9Procedure.ProcedureCosts =
        [
            new ProcedureCost(icd9Procedure)
            {
                TotalPaid = row.ActualPoint * 10m,
                PaidByCoordinationBenefits = row.NumberOfTimes * 10m * row.ProcedureStandardPoint,
                CurrencyConceptId = 44818592
            }
        ];

        var jnjProcedure = new ProcedureOccurrence(common)
        {
            Id = eventId,
            ConceptId = 0,
            TypeConceptId = 1
        };
        jnjProcedure.ProcedureCosts =
        [
            new ProcedureCost(jnjProcedure)
            {
                TotalPaid = row.ActualPoint * 10m,
                PaidByCoordinationBenefits = row.NumberOfTimes * 10m * row.ProcedureStandardPoint,
                CurrencyConceptId = 44818592
            }
        ];

        yield return icd9Procedure;
        yield return jnjProcedure;
    }

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

    private sealed record DiagnosisMapping(
        string Domain,
        long ConceptId,
        long SourceConceptId,
        long? ValueConceptId)
    {
        internal static DiagnosisMapping For(string icd10) => icd10 switch
        {
            "I10" => new("Condition", 320128, 45591453, null),
            "Z043" => new("Procedure", 4085923, 0, null),
            "R824" => new("Measurement", 4042243, 0, 4181412),
            "Z914" => new("Observation", 1340204, 45590771, 439990),
            _ => new("Condition", 0, 0, null)
        };
    }
}

internal sealed record StaticDataResult(
    IReadOnlyList<CareSite> CareSites,
    IReadOnlyList<Provider> Providers);

internal sealed class JmdcTestVocabulary : IVocabulary
{
    private readonly Dictionary<string, long> _values = [];

    internal JmdcTestVocabulary WithValue(string sourceValue, long conceptId)
    {
        _values[sourceValue] = conceptId;
        return this;
    }

    public void Fill(bool forLookup)
    {
    }

    public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
    {
        if (key == "JMDC-ICD10-MapsToValue" &&
            sourceValue is not null &&
            _values.TryGetValue(sourceValue, out var conceptId))
        {
            return [new LookupValue { ConceptId = conceptId }];
        }

        return [];
    }

    public int? LookupGender(string genderSourceValue) => null;

    public IEnumerable<PregnancyConcept> LookupPregnancyConcept(long conceptId) => [];

    public string? GetSourceVocabularyId(long conceptId) => null;

    public string? GetSourceDomain(long conceptId) => null;
}
