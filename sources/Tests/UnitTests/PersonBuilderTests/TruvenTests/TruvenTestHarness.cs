using System.Globalization;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;
using org.ohdsi.cdm.framework.etl.Transformation.Truven;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.TruvenTests;

internal sealed record TruvenBuildResult(ChunkData Data, Attrition Attrition);
internal sealed record TruvenStaticData(IReadOnlyList<Location> Locations, IReadOnlyList<Provider> Providers);

/// <summary>
/// In-memory form of the CCAE source tables used by the active Truven R suite.
/// </summary>
internal sealed class TruvenInMemoryScenario
{
    private readonly TruvenTestVocabulary _vocabulary = new();
    private readonly List<EnrollmentRow> _enrollment = [];
    private readonly List<ClaimRow> _claims = [];
    private readonly List<DrugRow> _drugs = [];
    private readonly List<LabRow> _labs = [];
    private readonly List<HraRow> _hra = [];
    private readonly Dictionary<string, GeolocRow> _geoloc = new(StringComparer.OrdinalIgnoreCase);

    internal TruvenTestVocabulary Vocabulary => _vocabulary;

    internal void AddEnrollmentDetail(
        long enrolid,
        string dtstart = "2000-01-03",
        string dtend = "2000-01-03",
        string dobyr = "1935",
        string sex = "1",
        string egeoloc = "",
        string datatyp = "1",
        string plantyp = "6",
        string rx = "1") =>
        _enrollment.Add(new EnrollmentRow(
            enrolid, Date(dtstart), Date(dtend), Int(dobyr), sex, egeoloc, datatyp, plantyp, rx));

    internal void AddInpatientServices(
        long enrolid,
        string svcdate = "2024-01-01",
        string? tsvcdat = null,
        long? caseid = null,
        string dxver = "9",
        string? pdx = null,
        string? dx1 = null,
        string? dx4 = null,
        string? dx9 = null,
        string? pproc = null,
        string? proc1 = null,
        string? proc2 = null,
        string? proc3 = null,
        string? proc4 = null,
        string? proc5 = null,
        string? proc6 = null,
        string stdplac = "",
        string revcode = "",
        string dstatus = "",
        string? provid = null,
        string stdprov = "",
        string procmod = "",
        int? qty = 1,
        decimal? copay = null,
        decimal? deduct = null,
        decimal? coins = null,
        decimal? netpay = null,
        decimal? cob = null) =>
        AddClaim("inpatient_services", 32854, enrolid, svcdate, tsvcdat, caseid, dxver,
            pdx, dx1, dx4, dx9, pproc, proc1, proc2, proc3, proc4, proc5, proc6,
            stdplac, revcode, dstatus, provid, stdprov, procmod, qty, copay, deduct, coins, netpay, cob);

    internal void AddInpatientAdmissions(
        long enrolid,
        long? caseid = null,
        string admdate = "2012-01-01",
        string disdate = "2012-12-31",
        string dxver = "9",
        string? pdx = null,
        string? pproc = null,
        string revcode = "",
        string dstatus = "",
        string? provid = null,
        string stdprov = "",
        decimal? copay = null,
        decimal? deduct = null,
        decimal? coins = null,
        decimal? netpay = null,
        decimal? cob = null) =>
        AddClaim("inpatient_admissions", 32855, enrolid, admdate, disdate, caseid, dxver,
            pdx, null, null, null, pproc, null, null, null, null, null, null,
            "", revcode, dstatus, provid, stdprov, "", 1, copay, deduct, coins, netpay, cob);

    internal void AddOutpatientServices(
        long enrolid,
        string svcdate = "2024-01-01",
        string? tsvcdat = null,
        long? fachdid = null,
        string dxver = "9",
        string? pdx = null,
        string? dx1 = null,
        string? dx4 = null,
        string? dx9 = null,
        string? pproc = null,
        string? proc1 = null,
        string? proc2 = null,
        string? proc3 = null,
        string? proc4 = null,
        string? proc5 = null,
        string? proc6 = null,
        string stdplac = "",
        string revcode = "",
        string dstatus = "",
        string? provid = null,
        string stdprov = "",
        string procmod = "",
        int? qty = 1,
        decimal? copay = null,
        decimal? deduct = null,
        decimal? coins = null,
        decimal? netpay = null,
        decimal? cob = null) =>
        AddClaim("outpatient_services", 32860, enrolid, svcdate, tsvcdat, fachdid, dxver,
            pdx, dx1, dx4, dx9, pproc, proc1, proc2, proc3, proc4, proc5, proc6,
            stdplac, revcode, dstatus, provid, stdprov, procmod, qty, copay, deduct, coins, netpay, cob);

    internal void AddFacilityHeader(
        long enrolid,
        string svcdate = "2024-01-01",
        string? tsvcdat = null,
        long? fachdid = null,
        string dxver = "9",
        string? pdx = null,
        string? dx1 = null,
        string? dx4 = null,
        string? dx9 = null,
        string? pproc = null,
        string? proc1 = null,
        string? proc2 = null,
        string? proc3 = null,
        string? proc4 = null,
        string? proc5 = null,
        string? proc6 = null,
        string stdplac = "",
        string revcode = "",
        string dstatus = "",
        string? provid = null,
        string stdprov = "",
        string procmod = "",
        int? qty = 1,
        decimal? copay = null,
        decimal? deduct = null,
        decimal? coins = null,
        decimal? netpay = null,
        decimal? cob = null) =>
        AddClaim("facility_header", 32846, enrolid, svcdate, tsvcdat, fachdid, dxver,
            pdx, dx1, dx4, dx9, pproc, proc1, proc2, proc3, proc4, proc5, proc6,
            stdplac, revcode, dstatus, provid, stdprov, procmod, qty, copay, deduct, coins, netpay, cob);

    internal void AddDrugClaims(
        long enrolid,
        string ndcnum = "00378510501",
        string svcdate = "2012-01-01",
        int? daysupp = 30,
        decimal? metqty = 0,
        decimal? copay = null,
        decimal? ingcost = null,
        decimal? dispfee = null,
        decimal? awp = null) =>
        _drugs.Add(new DrugRow(enrolid, ndcnum, Date(svcdate), daysupp, metqty, copay, ingcost, dispfee, awp, Guid.NewGuid()));

    internal void AddLab(
        long enrolid,
        string svcdate = "2024-01-01",
        string loinccd = "56789-1",
        string? result = null,
        string? resunit = null,
        string? abnormal = null,
        decimal? refhigh = null,
        decimal? reflow = null,
        string? provid = null,
        string stdprov = "") =>
        _labs.Add(new LabRow(enrolid, Date(svcdate), loinccd, result, resunit, abnormal,
            refhigh, reflow, provid, stdprov, Guid.NewGuid()));

    internal void AddHealthRiskAssessment(
        long enrolid,
        string survdate,
        string? ccBackpain = null,
        string? ccAsthma = null,
        string? weight = null,
        string? bmi = null,
        string? exerweek = null,
        string? cgtpkamt = null,
        string? fluShot = null) =>
        _hra.Add(new HraRow(enrolid, Date(survdate), ccBackpain, ccAsthma, weight, bmi,
            exerweek, cgtpkamt, fluShot, Guid.NewGuid()));

    internal void AddGeoloc(string egeoloc, string description, string state) =>
        _geoloc[egeoloc] = new GeolocRow(egeoloc, description, state);

    internal TruvenBuildResult Build(long personId)
    {
        var builder = new TruvenPersonBuilder(new TruvenPersonBuilder.Truven_CCAEVendor());
        builder.JoinToVocabulary(_vocabulary);

        var enrollment = _enrollment.Where(r => r.Enrolid == personId).ToArray();
        foreach (var row in enrollment)
        {
            builder.AddData(ToPerson(row));
            if (row.Rx != "0") builder.AddData(ToPayerPlanPeriod(row));
        }

        foreach (var row in _claims.Where(r => r.Enrolid == personId))
        {
            var visit = ToVisit(row);
            builder.AddData(visit);
            foreach (var entity in ProjectClaim(row)) builder.AddData(entity);
        }

        foreach (var row in _drugs.Where(r => r.Enrolid == personId)) builder.AddData(ProjectDrug(row));
        foreach (var row in _labs.Where(r => r.Enrolid == personId)) builder.AddData(ProjectLab(row));
        foreach (var row in _hra.Where(r => r.Enrolid == personId))
            foreach (var entity in ProjectHra(row)) builder.AddData(entity);

        var data = new ChunkData(chunkId: 0, subChunkId: 0);
        var attrition = builder.Build(data, new KeyMasterOffsetManager(chunkId: 0, prefix: 0, attempt: 0));
        return new TruvenBuildResult(data, attrition);
    }

    internal TruvenStaticData BuildStaticData()
    {
        var locations = _enrollment
            .Where(r => !string.IsNullOrWhiteSpace(r.Egeoloc))
            .Select(r => r.Egeoloc)
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .Select(code => new Location
            {
                Id = Entity.GetId(code),
                State = _geoloc.TryGetValue(code, out var geo) ? geo.State : "UN",
                SourceValue = code,
                AdditionalFields = []
            }).ToArray();

        var providers = _claims
            .Where(r => r.Provid is not null || !string.IsNullOrWhiteSpace(r.Stdprov))
            .Select(r => new Provider
            {
                Id = Entity.GetId($"{r.Provid};{r.Stdprov}"),
                ProviderSourceValue = r.Provid,
                SourceValue = r.Stdprov,
                ConceptId = Specialty(r.Stdprov),
                SpecialtySourceConceptId = 0,
                CareSiteId = 0,
                GenderConceptId = 0,
                GenderSourceConceptId = 0,
                AdditionalFields = []
            }).ToArray();

        var labProviders = _labs
            .Where(r => r.Provid is not null || !string.IsNullOrWhiteSpace(r.Stdprov))
            .Select(r => new Provider
            {
                Id = Entity.GetId($"{r.Provid};{r.Stdprov}"),
                ProviderSourceValue = r.Provid,
                SourceValue = r.Stdprov,
                ConceptId = Specialty(r.Stdprov),
                SpecialtySourceConceptId = 0,
                CareSiteId = 0,
                GenderConceptId = 0,
                GenderSourceConceptId = 0,
                AdditionalFields = []
            });

        return new TruvenStaticData(locations, providers.Concat(labProviders).ToArray());
    }

    private void AddClaim(
        string table, long type, long enrolid, string start, string? end, long? encounter,
        string dxver, string? pdx, string? dx1, string? dx4, string? dx9,
        string? pproc, string? proc1, string? proc2, string? proc3, string? proc4,
        string? proc5, string? proc6, string stdplac, string revcode, string dstatus,
        string? provid, string stdprov, string procmod, int? qty,
        decimal? copay, decimal? deduct, decimal? coins, decimal? netpay, decimal? cob)
    {
        _claims.Add(new ClaimRow(table, type, enrolid, Date(start), Date(end ?? start), encounter,
            dxver, pdx, dx1, dx4, dx9, pproc, proc1, proc2, proc3, proc4, proc5, proc6,
            stdplac, revcode, dstatus, provid, stdprov, procmod, qty,
            copay, deduct, coins, netpay, cob, Guid.NewGuid()));
    }

    private Person ToPerson(EnrollmentRow row) => new()
    {
        PersonId = row.Enrolid,
        PersonSourceValue = row.Enrolid.ToString(CultureInfo.InvariantCulture),
        GenderConceptId = row.Sex switch { "1" => 8507, "2" => 8532, _ => 8551 },
        GenderSourceValue = row.Sex,
        RaceConceptId = 0,
        EthnicityConceptId = 0,
        RaceSourceConceptId = 0,
        EthnicitySourceConceptId = 0,
        GenderSourceConceptId = 0,
        YearOfBirth = row.Dobyr,
        StartDate = row.Start,
        EndDate = row.End,
        TypeConceptId = 32813,
        ObservationPeriodGap = 31,
        LocationId = string.IsNullOrWhiteSpace(row.Egeoloc) ? 0 : Entity.GetId(row.Egeoloc),
        LocationSourceValue = row.Egeoloc,
        SourceRecordGuid = Guid.NewGuid(),
        AdditionalFields = new() { ["missinginsurance"] = row.Rx == "0" ? "1" : "0" }
    };

    private static PayerPlanPeriod ToPayerPlanPeriod(EnrollmentRow row)
    {
        var prefix = row.Datatyp == "2" ? "C" : "N";
        var plan = row.Plantyp switch
        {
            "1" => "Basic/Major Medical",
            "2" => "Comprehensive",
            "5" => "POS",
            _ => "PPO"
        };
        return new PayerPlanPeriod
        {
            PersonId = row.Enrolid,
            StartDate = row.Start,
            EndDate = row.End,
            PayerSourceValue = $"{prefix} Commercial {plan}",
            PlanSourceValue = row.Plantyp,
            FamilySourceValue = row.Enrolid.ToString("00000000000", CultureInfo.InvariantCulture)[..9],
            AdditionalFields = []
        };
    }

    private VisitOccurrence ToVisit(ClaimRow row)
    {
        var rawConcept = row.Stdplac == "23" ? 8870 : 0;
        var visit = new VisitOccurrence(BaseEntity(row, rawConcept, row.Type, row.Stdplac, "Visit"))
        {
            IdUndefined = true,
            ProviderKey = ProviderKey(row.Provid, row.Stdprov),
            DischargeToConceptId = row.Dstatus == "01" ? 581476 : 0,
            DischargeToSourceValue = row.Dstatus,
            VisitCosts = []
        };

        if (HasCost(row))
        {
            visit.VisitCosts.Add(new VisitCost(visit)
            {
                PaidCopay = row.Copay,
                PaidTowardDeductible = row.Deduct,
                PaidCoinsurance = row.Coins,
                PaidByPayer = row.Netpay,
                PaidByCoordinationBenefits = row.Cob,
                TotalPaid = Sum(row.Copay, row.Deduct, row.Coins, row.Netpay, row.Cob),
                CurrencyConceptId = 44818668,
                RevenueCodeConceptId = row.Revcode == "0000" || string.IsNullOrEmpty(row.Revcode) ? 0 : 38003210,
                RevenueCodeSourceValue = row.Revcode
            });
        }

        return visit;
    }

    private IEnumerable<IEntity> ProjectClaim(ClaimRow row)
    {
        foreach (var (source, position) in Diagnoses(row))
        {
            var key = DiagnosisKey(row.Dxver, row.Start);
            foreach (var mapping in _vocabulary.Lookup(source, key, row.Start))
            {
                var entity = MappedEntity(row, source, mapping, 100 + position);
                entity.AdditionalFields["priority"] = ClaimPriority(row.Table);
                entity.AdditionalFields["dxver"] = row.Dxver switch
                {
                    "0" => "0",
                    "9" => "9",
                    _ => row.Start >= new DateTime(2015, 10, 1) ? "0" : "9"
                };
                yield return new ConditionOccurrence(entity);
            }
        }

        foreach (var (source, position) in Procedures(row))
        {
            var mappings = _vocabulary.Lookup(source, "Procedure", row.Start);
            foreach (var mapping in mappings)
            {
                var entity = MappedEntity(row, source, mapping, position);
                entity.AdditionalFields["priority"] = ClaimPriority(row.Table);
                entity.AdditionalFields["vendor"] = "ccae";
                entity.AdditionalFields["dx1"] = row.Dx1 ?? "";
                entity.AdditionalFields["provid"] = row.Provid ?? "";
                entity.AdditionalFields["stdprov"] = row.Stdprov;
                entity.AdditionalFields["procmod"] = row.Procmod;
                var procedure = new ProcedureOccurrence(entity)
                {
                    Quantity = row.Qty,
                    ModifierConceptId = row.Procmod == "P1" ? 4320556 : 0,
                    ProviderKey = ProviderKey(row.Provid, row.Stdprov)
                };
                if (HasCost(row))
                {
                    procedure.ProcedureCosts = [new ProcedureCost(procedure)
                    {
                        PaidCopay = row.Copay,
                        PaidTowardDeductible = row.Deduct,
                        PaidCoinsurance = row.Coins,
                        PaidByPayer = row.Netpay,
                        PaidByCoordinationBenefits = row.Cob,
                        CurrencyConceptId = 44818668,
                        RevenueCodeConceptId = row.Revcode == "0000" || string.IsNullOrEmpty(row.Revcode) ? 0 : 38003210,
                        RevenueCodeSourceValue = row.Revcode
                    }];
                }
                yield return procedure;

                if (mapping.Domain == "Drug")
                {
                    yield return new DrugExposure(entity)
                    {
                        EndDate = null,
                        Quantity = row.Qty,
                        Ingredients = mapping.Ingredients is null ? [] : [.. mapping.Ingredients]
                    };
                }
            }
        }

        if (HasCost(row) && !Procedures(row).Any())
        {
            var entity = BaseEntity(row, 0, row.Type, row.Revcode, "Procedure");
            entity.AdditionalFields["priority"] = ClaimPriority(row.Table);
            entity.AdditionalFields["vendor"] = "ccae";
            entity.AdditionalFields["dx1"] = "";
            entity.AdditionalFields["provid"] = row.Provid ?? "";
            entity.AdditionalFields["stdprov"] = row.Stdprov;
            entity.AdditionalFields["procmod"] = row.Procmod;
            yield return new ProcedureOccurrence(entity) { Quantity = row.Qty };
        }
    }

    private DrugExposure ProjectDrug(DrugRow row)
    {
        var mappings = _vocabulary.Lookup(row.Ndcnum, "Drug", row.Svcdate);
        var mapping = mappings.FirstOrDefault();
        var concept = mapping?.ConceptId ?? 0;
        var entity = new Entity
        {
            PersonId = row.Enrolid,
            ConceptId = concept,
            SourceConceptId = mapping?.SourceConcepts.FirstOrDefault()?.ConceptId ?? 0,
            SourceValue = row.Ndcnum,
            StartDate = row.Svcdate,
            EndDate = row.Svcdate.AddDays(Math.Max(1, Math.Min(365, row.Daysupp ?? 1)) - 1),
            TypeConceptId = 32869,
            Domain = "Drug",
            SourceRecordGuid = row.Guid,
            IsUnique = true,
            Ingredients = mapping?.Ingredients is null ? [] : [.. mapping.Ingredients],
            SourceConcepts = mapping?.SourceConcepts is null ? [] : [.. mapping.SourceConcepts],
            ValidStartDate = mapping?.ValidStartDate ?? TruvenTestVocabulary.ValidStart,
            ValidEndDate = mapping?.ValidEndDate ?? TruvenTestVocabulary.ValidEnd,
            AdditionalFields = new() { ["hlthplan"] = "1" }
        };
        if (concept == 0 && row.Ndcnum is "13533063670" or "00006032582")
            entity.AdditionalFields["itndc"] = "1";

        var drug = new DrugExposure(entity)
        {
            DaysSupply = Math.Max(1, Math.Min(365, row.Daysupp ?? 1)),
            Quantity = row.Metqty,
            DrugCost = new DrugCost(new DrugExposure(entity))
            {
                PaidCopay = row.Copay,
                IngredientCost = row.Ingcost,
                DispensingFee = row.Dispfee,
                AverageWholesalePrice = row.Awp,
                TotalPaid = row.Awp,
                CurrencyConceptId = 44818668
            }
        };
        return drug;
    }

    private Measurement ProjectLab(LabRow row)
    {
        var mapping = _vocabulary.Lookup(row.Loinccd, "Lab", row.Svcdate).FirstOrDefault();
        var unit = string.IsNullOrWhiteSpace(row.Resunit)
            ? null
            : _vocabulary.Lookup(row.Resunit, "Unit", DateTime.MinValue).FirstOrDefault();
        decimal? number = decimal.TryParse(row.Result, NumberStyles.Any, CultureInfo.InvariantCulture, out var parsed)
            ? parsed
            : null;
        var measurement = new Measurement(new Entity
        {
            PersonId = row.Enrolid,
            ConceptId = mapping?.ConceptId ?? 0,
            SourceConceptId = mapping?.SourceConcepts.FirstOrDefault()?.ConceptId ?? 0,
            SourceValue = row.Loinccd,
            StartDate = row.Svcdate,
            EndDate = null,
            TypeConceptId = 32856,
            Domain = "Measurement",
            SourceRecordGuid = row.Guid,
            AdditionalFields = new() { ["hlthplan"] = "1" }
        })
        {
            ValueAsNumber = number,
            ValueSourceValue = row.Abnormal,
            UnitConceptId = unit?.ConceptId,
            UnitSourceConceptId = unit?.SourceConcepts.FirstOrDefault()?.ConceptId,
            UnitSourceValue = row.Resunit,
            RangeHigh = row.Refhigh,
            RangeLow = row.Reflow,
            ProviderKey = ProviderKey(row.Provid, row.Stdprov)
        };
        return measurement;
    }

    private static IEnumerable<IEntity> ProjectHra(HraRow row)
    {
        if (row.CcBackpain == "1") yield return HraObservation(row, "CC_BACKPAIN", 134736, "Condition");
        if (row.CcAsthma == "1") yield return HraObservation(row, "CC_ASTHMA", 317009, "Condition");
        if (row.Weight is not null) yield return HraMeasurement(row, "WEIGHT", row.Weight, 3025315);
        if (row.Bmi is not null) yield return HraMeasurement(row, "BMI", row.Bmi, 3038553);
        if (row.Exerweek is not null) yield return HraValue(row, "EXERWEEK", row.Exerweek);
        if (row.Cgtpkamt is not null) yield return HraValue(row, "CGTPKAMT", row.Cgtpkamt);
        if (row.FluShot is not null) yield return HraValue(row, "FLU_SHOT", row.FluShot);
    }

    private static Observation HraObservation(HraRow row, string source, long concept, string domain) =>
        new(new Entity
        {
            PersonId = row.Enrolid,
            ConceptId = concept,
            SourceValue = source,
            StartDate = row.Survdate,
            TypeConceptId = 32850,
            Domain = domain,
            SourceRecordGuid = row.Guid,
            AdditionalFields = new() { ["hlthplan"] = "1" }
        });

    private static Measurement HraMeasurement(HraRow row, string source, string value, long concept) =>
        new(new Entity
        {
            PersonId = row.Enrolid,
            ConceptId = concept,
            SourceValue = source,
            StartDate = row.Survdate,
            TypeConceptId = 32850,
            Domain = "Measurement",
            SourceRecordGuid = row.Guid,
            AdditionalFields = new() { ["hlthplan"] = "1" }
        }) { ValueAsNumber = decimal.Parse(value, CultureInfo.InvariantCulture) };

    private static Observation HraValue(HraRow row, string source, string value) =>
        new(new Entity
        {
            PersonId = row.Enrolid,
            ConceptId = 0,
            SourceValue = source,
            StartDate = row.Survdate,
            TypeConceptId = 32850,
            Domain = "Observation",
            SourceRecordGuid = row.Guid,
            AdditionalFields = new() { ["hlthplan"] = "1" }
        }) { ValueAsNumber = decimal.Parse(value, CultureInfo.InvariantCulture) };

    private Entity MappedEntity(ClaimRow row, string source, LookupValue mapping, long type)
    {
        var entity = BaseEntity(row, mapping.ConceptId ?? 0, type, source, mapping.Domain);
        entity.SourceConceptId = mapping.SourceConcepts.FirstOrDefault()?.ConceptId ?? 0;
        entity.SourceConcepts = [.. mapping.SourceConcepts];
        entity.Ingredients = mapping.Ingredients is null ? [] : [.. mapping.Ingredients];
        entity.ValidStartDate = mapping.ValidStartDate;
        entity.ValidEndDate = mapping.ValidEndDate;
        return entity;
    }

    private static Entity BaseEntity(ClaimRow row, long concept, long? type, string source, string domain) => new()
    {
        PersonId = row.Enrolid,
        ConceptId = concept,
        StartDate = row.Start,
        EndDate = row.End,
        TypeConceptId = type,
        SourceValue = source,
        Domain = domain,
        SourceRecordGuid = row.Guid,
        ProviderKey = ProviderKey(row.Provid, row.Stdprov),
        AdditionalFields = new() { ["hlthplan"] = "1" },
        ValidStartDate = TruvenTestVocabulary.ValidStart,
        ValidEndDate = TruvenTestVocabulary.ValidEnd
    };

    private static IEnumerable<(string Source, int Position)> Diagnoses(ClaimRow row)
    {
        if (!string.IsNullOrWhiteSpace(row.Pdx)) yield return (row.Pdx, 0);
        if (!string.IsNullOrWhiteSpace(row.Dx1)) yield return (row.Dx1, 1);
        if (!string.IsNullOrWhiteSpace(row.Dx4)) yield return (row.Dx4, 4);
        if (!string.IsNullOrWhiteSpace(row.Dx9)) yield return (row.Dx9, 9);
    }

    private static IEnumerable<(string Source, int Position)> Procedures(ClaimRow row)
    {
        if (!string.IsNullOrWhiteSpace(row.Pproc)) yield return (row.Pproc, 0);
        if (!string.IsNullOrWhiteSpace(row.Proc1)) yield return (row.Proc1, 1);
        if (!string.IsNullOrWhiteSpace(row.Proc2)) yield return (row.Proc2, 2);
        if (!string.IsNullOrWhiteSpace(row.Proc3)) yield return (row.Proc3, 3);
        if (!string.IsNullOrWhiteSpace(row.Proc4)) yield return (row.Proc4, 4);
        if (!string.IsNullOrWhiteSpace(row.Proc5)) yield return (row.Proc5, 5);
        if (!string.IsNullOrWhiteSpace(row.Proc6)) yield return (row.Proc6, 6);
    }

    private static string DiagnosisKey(string dxver, DateTime date) => dxver switch
    {
        "0" => "Diagnosis10",
        "9" => "Diagnosis9",
        _ => date >= new DateTime(2015, 10, 1) ? "Diagnosis10" : "Diagnosis9"
    };

    private static string ClaimPriority(string table) => table switch
    {
        "outpatient_services" => "1",
        "inpatient_services" => "2",
        _ => "3"
    };

    private static long Specialty(string source) => source switch
    {
        "220" => 38004510,
        "285" => 38004484,
        "540" => 38004497,
        "22" => 38004498,
        _ => 38004514
    };

    private static string ProviderKey(string? provid, string stdprov) => $"{provid};{stdprov}";
    private static bool HasCost(ClaimRow row) =>
        row.Copay.HasValue || row.Deduct.HasValue || row.Coins.HasValue || row.Netpay.HasValue || row.Cob.HasValue;
    private static decimal Sum(params decimal?[] values) => values.Sum(v => v ?? 0m);
    private static int Int(string value) => int.Parse(value, CultureInfo.InvariantCulture);
    private static DateTime Date(string value) => DateTime.ParseExact(value, "yyyy-MM-dd", CultureInfo.InvariantCulture);

    private sealed record EnrollmentRow(long Enrolid, DateTime Start, DateTime End, int Dobyr,
        string Sex, string Egeoloc, string Datatyp, string Plantyp, string Rx);

    private sealed record ClaimRow(string Table, long Type, long Enrolid, DateTime Start, DateTime End,
        long? Encounter, string Dxver, string? Pdx, string? Dx1, string? Dx4, string? Dx9,
        string? Pproc, string? Proc1, string? Proc2, string? Proc3, string? Proc4, string? Proc5,
        string? Proc6, string Stdplac, string Revcode, string Dstatus, string? Provid, string Stdprov,
        string Procmod, int? Qty, decimal? Copay, decimal? Deduct, decimal? Coins, decimal? Netpay,
        decimal? Cob, Guid Guid);

    private sealed record DrugRow(long Enrolid, string Ndcnum, DateTime Svcdate, int? Daysupp,
        decimal? Metqty, decimal? Copay, decimal? Ingcost, decimal? Dispfee, decimal? Awp, Guid Guid);
    private sealed record LabRow(long Enrolid, DateTime Svcdate, string Loinccd, string? Result,
        string? Resunit, string? Abnormal, decimal? Refhigh, decimal? Reflow, string? Provid,
        string Stdprov, Guid Guid);
    private sealed record HraRow(long Enrolid, DateTime Survdate, string? CcBackpain, string? CcAsthma,
        string? Weight, string? Bmi, string? Exerweek, string? Cgtpkamt, string? FluShot, Guid Guid);
    private sealed record GeolocRow(string Code, string Description, string State);
}

internal sealed class TruvenTestVocabulary : IVocabulary
{
    internal static readonly DateTime ValidStart = new(1900, 1, 1);
    internal static readonly DateTime ValidEnd = new(2099, 12, 31);
    private readonly Dictionary<string, List<LookupValue>> _mappings = new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<long, string> _domains = [];
    private readonly Dictionary<long, string> _vocabularies = [];

    internal TruvenTestVocabulary()
    {
        Map("Diagnosis9", "2500", 4008576, "Condition");
        Map("Diagnosis9", "0092", 198337, "Condition");
        Map("Diagnosis9", "1024", 433706, "Condition");
        Map("Diagnosis9", "57411", 195587, "Condition");
        Map("Diagnosis9", "4760", 24970, "Condition");
        Map("Diagnosis9", "V5302", 4047347, "Procedure");
        Map("Diagnosis9", "V5302", 46272569, "Procedure");
        Map("Diagnosis9", "E0152", 4117957, "Observation");
        Map("Diagnosis9", "V726", 4034850, "Measurement");
        Map("Diagnosis9", "V9001", 46270117, "Condition", 44821630, "ICD9CM");
        Map("Diagnosis9", "71978", 0, "Condition");
        Map("Diagnosis9", "37613", 4078387, "Condition");
        Map("Diagnosis10", "S42241S", 438021, "Condition", 45602528, "ICD10CM");
        Map("Diagnosis10", "V9001", 4155106, "Observation", 45591075, "ICD10CM");

        Map("Procedure", "99238", 2514413, "Procedure");
        Map("Procedure", "99221", 2514404, "Procedure");
        Map("Procedure", "65779", 40757105, "Procedure");
        Map("Procedure", "29914", 40757126, "Procedure");
        Map("Procedure", "82985", 2212375, "Measurement");
        Map("Procedure", "S9368", 2721503, "Observation");
        Map("Procedure", "90376", 46234006, "Drug", ingredients: [19135830]);
        Map("Procedure", "50760", 4021253, "Procedure");
        Map("Procedure", "C9727", 4196153, "Procedure");
        Map("Procedure", "54861", 4200063, "Procedure");
        Map("Procedure", "93042", 2313827, "Procedure");
        Map("Procedure", "96900", 4180942, "Procedure");
        Map("Procedure", "97811", 2314322, "Procedure");
        Map("Procedure", "92570", 40757149, "Procedure");
        Map("Procedure", "92568", 4167674, "Measurement");
        Map("Procedure", "97780", 42739018, "Procedure");
        Map("Procedure", "0093U", 709845, "Measurement");
        Map("Procedure", "J9350", 19124326, "Drug", 2718911, "HCPCS", [19124326],
            new DateTime(1900, 1, 1), new DateTime(2014, 11, 10));
        Map("Procedure", "J9350", 0, "Drug", 0, "HCPCS", [],
            new DateTime(2014, 11, 11), new DateTime(2023, 6, 30));
        Map("Procedure", "J9350", 1302318, "Drug", 2100003123, "HCPCS", [1302318],
            new DateTime(2023, 7, 1), ValidEnd);

        Map("Drug", "36987257801", 40161912, "Drug", ingredients: [40161912]);
        Map("Drug", "58864060830", 1545998, "Drug", ingredients: [1545998]);
        Map("Drug", "135330636", 46275250, "Drug", ingredients: [46275250]);
        Map("Drug", "000060325", 45775771, "Drug", ingredients: [45775771],
            validStart: new DateTime(2007, 1, 1), validEnd: ValidEnd);
        Map("Drug", "00069100101", 1545958, "Drug", 45332969, "NDC", [1545958]);
        Map("Drug", "00463303410", 19010482, "Drug", ingredients: [1134439]);
        Map("Drug", "00349835305", 19008123, "Drug", ingredients: [956874]);
        Map("Drug", "00008419001", 19019073, "Drug", ingredients: [1134439, 1112807]);
        Map("Drug", "00378510501", 19024063, "Drug", ingredients: [19024063]);

        Map("Lab", "56773-5", 3019897, "Measurement", vocabularyId: "LOINC");
        Map("Lab", "56784-2", 3025315, "Measurement", vocabularyId: "LOINC");
        Map("Lab", "56789-1", 3038553, "Measurement", vocabularyId: "LOINC");
        Map("Lab", "29463-7", 3025315, "Measurement", vocabularyId: "LOINC");
        Map("ValueAsConcept", "L", 4267416, "Meas Value");
        Map("ValueAsConcept", "H", 4328749, "Meas Value");
        Map("ValueAsConcept", "N", 4069590, "Meas Value");
        Map("ValueAsConcept", "A", 4135493, "Meas Value");
        Map("ValueAsConcept", "+", 9191, "Meas Value");
        Map("Unit", "mg/dl", 8840, "Unit");
        Map("Unit", "lbs.", 8739, "Unit");
        Map("Unit", "LBS", 8739, "Unit");
        Map("Unit", "C", 586323, "Unit");

        Map("CMSPlaceOfService", "9201", 9201, "Visit");
        Map("CMSPlaceOfService", "9202", 9202, "Visit");
        Map("CMSPlaceOfService", "8870", 9203, "Visit");
    }

    internal int MappingCount => _mappings.Values.Sum(v => v.Count);
    public void Fill(bool forLookup) { }

    public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
    {
        if (string.IsNullOrWhiteSpace(sourceValue) || string.IsNullOrWhiteSpace(key)) return [];
        if (!_mappings.TryGetValue(Key(key, sourceValue), out var values)) return [];
        if (eventDate == DateTime.MinValue) return [.. values];
        return values.Where(v => eventDate.Date >= v.ValidStartDate.Date && eventDate.Date <= v.ValidEndDate.Date).ToList();
    }

    public int? LookupGender(string genderSourceValue) => genderSourceValue switch
    {
        "1" => 8507,
        "2" => 8532,
        _ => 8551
    };

    public IEnumerable<PregnancyConcept> LookupPregnancyConcept(long conceptId) => [];
    public string? GetSourceVocabularyId(long conceptId) => _vocabularies.GetValueOrDefault(conceptId);
    public string? GetSourceDomain(long conceptId) => _domains.GetValueOrDefault(conceptId);

    private void Map(string lookup, string source, long concept, string domain,
        long sourceConcept = 0, string? vocabularyId = null, long[]? ingredients = null,
        DateTime? validStart = null, DateTime? validEnd = null)
    {
        var value = new LookupValue
        {
            ConceptId = concept,
            Domain = domain,
            SourceCode = source,
            ValidStartDate = validStart ?? ValidStart,
            ValidEndDate = validEnd ?? ValidEnd,
            Ingredients = ingredients is null ? null : [.. ingredients],
            SourceConcepts = sourceConcept == 0 ? [] : [new SourceConcepts
            {
                ConceptId = sourceConcept,
                ValidStartDate = validStart ?? ValidStart,
                ValidEndDate = validEnd ?? ValidEnd
            }]
        };
        var key = Key(lookup, source);
        if (!_mappings.TryGetValue(key, out var list)) _mappings[key] = list = [];
        list.Add(value);
        if (concept > 0)
        {
            _domains[concept] = domain;
            if (vocabularyId is not null) _vocabularies[concept] = vocabularyId;
        }
    }

    private static string Key(string lookup, string source) => $"{lookup.Trim()}\u001f{source.Trim()}";
}
