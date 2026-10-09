using System.Globalization;
using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;
using org.ohdsi.cdm.framework.etl.Transformation.Premier;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.PremierTests;

internal sealed record PremierBuildResult(ChunkData Data, Attrition Attrition)
{
    internal VisitOccurrence Visit(string patKey) => Assert.Single(
        Data.VisitOccurrences.Where(v =>
            v.AdditionalFields.TryGetValue("pat_key", out var value) && value == patKey));
}

/// <summary>
/// In-memory Premier source schema used by the original R suite. 
/// </summary>
internal sealed class PremierInMemoryScenario
{
    private readonly PremierTestVocabulary _vocabulary = new();
    private readonly List<PatRow> _pat = [];
    private readonly List<PatbillRow> _patbill = [];
    private readonly List<PatcptRow> _patcpt = [];
    private readonly List<PaticdDiagRow> _paticdDiag = [];
    private readonly List<PaticdProcRow> _paticdProc = [];
    private readonly Dictionary<long, ChgmstrRow> _chgmstr = [];
    private readonly Dictionary<long, string> _hospchg = [];
    private readonly Dictionary<int, string> _payor = [];
    private long _nextEntityId = 1;

    internal PremierTestVocabulary Vocabulary => _vocabulary;

    internal void AddPat(
        long medrecKey,
        string patKey,
        string? admDate = null,
        string? discDate = null,
        int age = 33,
        string gender = "F",
        string race = "W",
        string hispanicInd = "N",
        string iOInd = "O",
        string pointOfOrigin = "1",
        int stdPayor = 360,
        int? msDrg = 0,
        long? admPhy = 999999999,
        long? provId = 1784)
    {
        _pat.Add(new PatRow(
            medrecKey,
            patKey,
            Date(admDate ?? "2020-02-10"),
            Date(discDate ?? "2021-09-30"),
            age,
            gender,
            race,
            hispanicInd,
            iOInd,
            pointOfOrigin,
            stdPayor,
            msDrg,
            admPhy,
            provId,
            Guid.NewGuid()));
    }

    internal void AddPatbill(
        string patKey,
        long stdChgCode = 110229000020000,
        long? hospChgId = 133918884,
        string? servDate = null,
        decimal stdQty = 1m,
        decimal billCharges = 0m,
        decimal billCost = 0m)
    {
        _patbill.Add(new PatbillRow(
            patKey,
            stdChgCode,
            hospChgId,
            servDate is null ? DateTime.MinValue : Date(servDate),
            stdQty,
            billCharges,
            billCost));
    }

    internal void AddPatcpt(string patKey, string cptCode = "36415", string? procDate = null) =>
        _patcpt.Add(new PatcptRow(patKey, cptCode, procDate is null ? DateTime.MinValue : Date(procDate)));

    internal void AddPaticdDiag(
        string patKey,
        string icdCode = "I10",
        int icdVersion = 10,
        string icdPriSec = "S") =>
        _paticdDiag.Add(new PaticdDiagRow(patKey, icdCode, icdVersion, icdPriSec));

    internal void AddPaticdProc(
        string patKey,
        string icdCode = "99.29",
        int icdVersion = 9,
        string icdPriSec = "S",
        string? procDate = null,
        long? procPhy = 999999999) =>
        _paticdProc.Add(new PaticdProcRow(
            patKey,
            icdCode,
            icdVersion,
            icdPriSec,
            procDate is null ? DateTime.MinValue : Date(procDate),
            procPhy));

    internal void AddChgmstr(
        long stdChgCode,
        string stdChgDesc = "",
        string clinSumDesc = "PRO FEE",
        string stdDeptDesc = "SURGERY",
        string sumDeptDesc = "OR") =>
        _chgmstr[stdChgCode] = new ChgmstrRow(
            stdChgCode,
            stdChgDesc,
            clinSumDesc,
            stdDeptDesc,
            sumDeptDesc);

    internal void AddHospchg(long hospChgId, string hospChgDesc) => _hospchg[hospChgId] = hospChgDesc;

    internal void AddPayor(int stdPayor, string stdPayorDesc) => _payor[stdPayor] = stdPayorDesc;

    internal PremierBuildResult Build(long personId)
    {
        var builder = new PremierPersonBuilder(new PremierPersonBuilder.PremierVendor());
        builder.JoinToVocabulary(_vocabulary);

        var pats = _pat.Where(p => p.MedrecKey == personId).ToArray();
        foreach (var row in pats)
        {
            builder.AddData(ToPerson(row));
            builder.AddData(ToVisit(row));

            if (_payor.TryGetValue(row.StdPayor, out var payer))
                builder.AddData(ToPayerPlanPeriod(row, payer));
        }

        foreach (var row in _patbill.Where(r => pats.Any(p => p.PatKey == r.PatKey)))
            foreach (var entity in Project(row, pats.Single(p => p.PatKey == row.PatKey)))
                builder.AddData(entity);

        foreach (var row in _patcpt.Where(r => pats.Any(p => p.PatKey == r.PatKey)))
            foreach (var entity in Project(row, pats.Single(p => p.PatKey == row.PatKey)))
                builder.AddData(entity);

        foreach (var row in _paticdDiag.Where(r => pats.Any(p => p.PatKey == r.PatKey)))
            foreach (var entity in Project(row, pats.Single(p => p.PatKey == row.PatKey)))
                builder.AddData(entity);

        foreach (var row in _paticdProc.Where(r => pats.Any(p => p.PatKey == r.PatKey)))
            foreach (var entity in Project(row, pats.Single(p => p.PatKey == row.PatKey)))
                builder.AddData(entity);

        var data = new ChunkData(chunkId: 0, subChunkId: 0);
        var attrition = builder.Build(data, new KeyMasterOffsetManager(chunkId: 0, prefix: 0, attempt: 0));
        return new PremierBuildResult(data, attrition);
    }

    private Person ToPerson(PatRow row) => new()
    {
        Id = NextId(),
        PersonId = row.MedrecKey,
        PersonSourceValue = row.MedrecKey.ToString(CultureInfo.InvariantCulture),
        StartDate = row.AdmDate,
        EndDate = row.DiscDate,
        GenderConceptId = _vocabulary.LookupGender(row.Gender),
        GenderSourceValue = row.Gender,
        RaceConceptId = RaceConcept(row.Race),
        RaceSourceValue = row.Race,
        EthnicityConceptId = EthnicityConcept(row.HispanicInd, row.Race),
        EthnicitySourceValue = row.HispanicInd,
        YearOfBirth = row.Age,
        ObservationPeriodGap = 31,
        TypeConceptId = 32880,
        SourceRecordGuid = row.Guid,
        AdditionalFields = Fields(row.PatKey)
    };

    private VisitOccurrence ToVisit(PatRow row)
    {
        var visit = new VisitOccurrence(BaseEntity(
            row,
            row.AdmDate,
            row.DiscDate,
            VisitConcept(row),
            32875,
            row.IOInd,
            "Visit"))
        {
            Id = NextId(),
            SourceRecordGuid = row.Guid,
            ProviderId = row.AdmPhy,
            CareSiteId = row.ProvId,
            AdmittingSourceConceptId = AdmittingSourceConcept(row.PointOfOrigin),
            AdmittingSourceValue = row.PointOfOrigin
        };
        return visit;
    }

    private PayerPlanPeriod ToPayerPlanPeriod(PatRow row, string payer) => new()
    {
        PersonId = row.MedrecKey,
        PayerSourceValue = payer,
        StartDate = DateTime.MinValue,
        EndDate = null,
        SourceRecordGuid = row.Guid,
        AdditionalFields = Fields(row.PatKey)
    };

    private IEnumerable<IEntity> Project(PatbillRow row, PatRow pat)
    {
        _chgmstr.TryGetValue(row.StdChgCode, out var charge);
        var hospitalDescription = row.HospChgId.HasValue && _hospchg.TryGetValue(row.HospChgId.Value, out var hd)
            ? hd
            : string.Empty;
        var source = $"{charge?.StdChgDesc ?? string.Empty} / {hospitalDescription}";
        var revenueSource = charge is null ? " / " : $"{charge.SumDeptDesc} / {charge.StdDeptDesc}";
        var date = row.ServDate;

        var mappings = _vocabulary.Lookup(row.StdChgCode.ToString(CultureInfo.InvariantCulture), "PremierCharge", date);
        if (mappings.Count == 0 && pat.MsDrg.GetValueOrDefault() > 0)
        {
            var fallback = new ProcedureOccurrence(BaseEntity(pat, date, null, 0, 0, source, "Procedure"))
            {
                Id = NextId()
            };
            AttachCost(fallback, row, pat, revenueSource);
            yield return fallback;
        }

        foreach (var mapping in mappings)
        {
            var entity = MappedEntity(pat, date, null, source, mapping);
            entity.AdditionalFields["source"] = "patbill";
            entity.AdditionalFields["source_value"] = source.ToLowerInvariant();
            entity.AdditionalFields["quantity"] = row.StdQty.ToString(CultureInfo.InvariantCulture);

            switch (mapping.Domain)
            {
                case "Drug":
                    var drug = new DrugExposure(entity) { Id = NextId(), Quantity = row.StdQty };
                    AttachCost(drug, row, pat, revenueSource);
                    yield return drug;
                    break;
                case "Procedure":
                    var procedure = new ProcedureOccurrence(entity) { Id = NextId(), Quantity = Decimal.ToInt32(row.StdQty) };
                    AttachCost(procedure, row, pat, revenueSource);
                    yield return procedure;
                    break;
                case "Device":
                    var device = new DeviceExposure(entity) { Id = NextId(), Quantity = Decimal.ToInt32(row.StdQty) };
                    AttachCost(device, row, pat, revenueSource);
                    yield return device;
                    break;
                case "Measurement":
                    var measurement = new Measurement(entity) { Id = NextId() };
                    AttachCost(measurement, row, pat, revenueSource);
                    yield return measurement;
                    break;
                case "Condition":
                    var condition = new ConditionOccurrence(entity)
                    {
                        Id = NextId(),
                        StatusConceptId = 32908,
                        StatusSourceValue = "From PATBILL - No information provided"
                    };
                    yield return condition;
                    break;
                default:
                    var observation = new Observation(entity) { Id = NextId() };
                    AttachCost(observation, row, pat, revenueSource);
                    yield return observation;
                    break;
            }
        }

        if (charge is not null &&
            charge.ClinSumDesc.Equals("SURGERY TIME", StringComparison.OrdinalIgnoreCase) &&
            row.StdChgCode != 360360000530008)
        {
            var surgery = new Observation(BaseEntity(pat, date, null, 3016562, 45754907, " ", "Observation"))
            {
                Id = NextId()
            };
            surgery.AdditionalFields["source"] = "patbill";
            surgery.AdditionalFields["quantity"] = row.StdQty.ToString(CultureInfo.InvariantCulture);
            surgery.AdditionalFields["std_chg_desc"] = charge.StdChgDesc;
            yield return surgery;
        }
    }

    private IEnumerable<IEntity> Project(PatcptRow row, PatRow pat)
    {
        foreach (var lookup in new[] { "Procedure", "DrugCpt", "Observation", "Measurement", "Device" })
        {
            foreach (var mapping in _vocabulary.Lookup(row.CptCode, lookup, row.ProcDate))
            {
                var entity = MappedEntity(pat, row.ProcDate, null, row.CptCode, mapping);
                yield return mapping.Domain switch
                {
                    "Drug" => new DrugExposure(entity) { Id = NextId() },
                    "Device" => new DeviceExposure(entity) { Id = NextId() },
                    "Measurement" => new Measurement(entity) { Id = NextId() },
                    "Observation" => new Observation(entity) { Id = NextId() },
                    _ => new ProcedureOccurrence(entity) { Id = NextId() }
                };
            }
        }
    }

    private IEnumerable<IEntity> Project(PaticdDiagRow row, PatRow pat)
    {
        var lookups = new[]
        {
            "ConditionIcd",
            "Measurement",
            row.IcdVersion == 9 ? "ObservationICD9" : "ObservationICD10",
            "Device"
        };
        foreach (var lookup in lookups)
        {
            foreach (var mapping in _vocabulary.Lookup(row.IcdCode, lookup, DateTime.MinValue))
            {
                var entity = MappedEntity(pat, DateTime.MinValue, null, row.IcdCode, mapping);
                if (mapping.Domain == "Condition")
                {
                    yield return new ConditionOccurrence(entity)
                    {
                        Id = NextId(),
                        StatusConceptId = ConditionStatus(row.IcdPriSec),
                        StatusSourceValue = row.IcdPriSec
                    };
                }
                else if (mapping.Domain == "Measurement")
                {
                    yield return new Measurement(entity) { Id = NextId() };
                }
                else if (mapping.Domain == "Device")
                {
                    yield return new DeviceExposure(entity) { Id = NextId() };
                }
                else
                {
                    yield return new Observation(entity) { Id = NextId() };
                }
            }
        }
    }

    private IEnumerable<IEntity> Project(PaticdProcRow row, PatRow pat)
    {
        foreach (var mapping in _vocabulary.Lookup(row.IcdCode, "Procedure", row.ProcDate))
        {
            var entity = MappedEntity(pat, row.ProcDate, null, row.IcdCode, mapping);
            entity.AdditionalFields["proc_phy"] = row.ProcPhy?.ToString(CultureInfo.InvariantCulture) ?? string.Empty;
            yield return new ProcedureOccurrence(entity)
            {
                Id = NextId(),
                TypeConceptId = ProcedureType(row.IcdPriSec)
            };
        }

        var observationLookup = row.IcdVersion == 9 ? "ObservationICD9" : "ObservationICD10";
        foreach (var mapping in _vocabulary.Lookup(row.IcdCode, observationLookup, row.ProcDate))
            yield return new Observation(MappedEntity(pat, row.ProcDate, null, row.IcdCode, mapping)) { Id = NextId() };

        foreach (var mapping in _vocabulary.Lookup(row.IcdCode, "Device", row.ProcDate))
            yield return new DeviceExposure(MappedEntity(pat, row.ProcDate, null, row.IcdCode, mapping)) { Id = NextId() };

        var operation = new Observation(BaseEntity(pat, row.ProcDate, null, 3016562, 45754907, " ", "Observation"))
        {
            Id = NextId()
        };
        operation.AdditionalFields["source"] = "paticd_proc";
        operation.AdditionalFields["icd_code"] = row.IcdCode;
        operation.AdditionalFields["proc_phy"] = row.ProcPhy?.ToString(CultureInfo.InvariantCulture) ?? string.Empty;
        yield return operation;
    }

    private Entity MappedEntity(
        PatRow pat,
        DateTime start,
        DateTime? end,
        string source,
        LookupValue mapping)
    {
        var entity = BaseEntity(pat, start, end, mapping.ConceptId ?? 0, DefaultType(mapping.Domain), source, mapping.Domain);
        entity.SourceConceptId = mapping.SourceConcepts?.FirstOrDefault()?.ConceptId ?? 0;
        entity.ValidStartDate = mapping.ValidStartDate;
        entity.ValidEndDate = mapping.ValidEndDate;
        entity.SourceConcepts = mapping.SourceConcepts is null ? [] : [.. mapping.SourceConcepts];
        entity.Ingredients = mapping.Ingredients is null ? [] : [.. mapping.Ingredients];
        return entity;
    }

    private static Entity BaseEntity(
        PatRow pat,
        DateTime start,
        DateTime? end,
        long conceptId,
        long? typeConceptId,
        string source,
        string domain) => new()
    {
        PersonId = pat.MedrecKey,
        ConceptId = conceptId,
        StartDate = start,
        EndDate = end,
        TypeConceptId = typeConceptId,
        SourceValue = source,
        Domain = domain,
        SourceRecordGuid = Guid.NewGuid(),
        AdditionalFields = Fields(pat.PatKey),
        ValidStartDate = PremierTestVocabulary.ValidStart,
        ValidEndDate = PremierTestVocabulary.ValidEnd
    };

    private void AttachCost(IEntity entity, PatbillRow bill, PatRow pat, string revenueSource)
    {
        var revenue = _vocabulary.Lookup(revenueSource, "RevenueCode", bill.ServDate).FirstOrDefault();
        var drgSource = pat.MsDrg.GetValueOrDefault() <= 0
            ? null
            : pat.MsDrg.Value.ToString("000", CultureInfo.InvariantCulture);
        var drg = drgSource is null
            ? null
            : _vocabulary.Lookup(drgSource, "Drg", bill.ServDate).FirstOrDefault();

        void Fill(ICostV5 cost)
        {
            cost.TotalPaid = bill.BillCharges;
            cost.PaidByPayer = bill.BillCost;
            cost.CurrencyConceptId = 44818668;
            cost.RevenueCodeConceptId = revenue?.ConceptId;
            cost.RevenueCodeSourceValue = revenueSource;
            cost.DrgConceptId = drg?.ConceptId;
            cost.DrgSourceValue = drgSource;
        }

        switch (entity)
        {
            case DrugExposure drug:
                drug.DrugCost = new DrugCost(drug);
                Fill(drug.DrugCost);
                break;
            case ProcedureOccurrence procedure:
                procedure.ProcedureCosts = [new ProcedureCost(procedure)];
                Fill(procedure.ProcedureCosts[0]);
                break;
            case DeviceExposure device:
                device.DeviceCosts = [new DeviceCost(device)];
                Fill(device.DeviceCosts[0]);
                break;
            case Measurement measurement:
                measurement.MeasurementCost = [new MeasurementCost(measurement)];
                Fill(measurement.MeasurementCost[0]);
                break;
            case Observation observation:
                observation.ObservationCost = [new ObservationCost(observation)];
                Fill(observation.ObservationCost[0]);
                break;
        }
    }

    private long NextId() => _nextEntityId++;

    private static DateTime Date(string value) => DateTime.ParseExact(
        value,
        "yyyy-MM-dd",
        CultureInfo.InvariantCulture,
        DateTimeStyles.None);

    private static Dictionary<string, string> Fields(string patKey) => new()
    {
        ["pat_key"] = patKey
    };

    private static long RaceConcept(string race) => race.Trim().ToUpperInvariant() switch
    {
        "W" => 8527,
        "B" => 8516,
        "A" => 8515,
        _ => 0
    };

    private static long EthnicityConcept(string hispanic, string race)
    {
        if (hispanic.Equals("Y", StringComparison.OrdinalIgnoreCase) ||
            race.Equals("H", StringComparison.OrdinalIgnoreCase))
            return 38003563;
        return hispanic.Equals("N", StringComparison.OrdinalIgnoreCase) ? 38003564 : 0;
    }

    private static long VisitConcept(PatRow row)
    {
        if (row.PointOfOrigin == "7" && row.IOInd.Equals("O", StringComparison.OrdinalIgnoreCase)) return 9203;
        if (row.PointOfOrigin == "7" && row.IOInd.Equals("I", StringComparison.OrdinalIgnoreCase)) return 262;
        if (row.IOInd.Equals("I", StringComparison.OrdinalIgnoreCase)) return 9201;
        if (row.IOInd.Equals("O", StringComparison.OrdinalIgnoreCase)) return 9202;
        return 0;
    }

    // Deliberately follows the current production pat.xml.  Several R expectations
    // disagree with these values; those tests are intentionally allowed to fail.
    private static long AdmittingSourceConcept(string source) => source.Trim().ToUpperInvariant() switch
    {
        "0" => 8976,
        "1" => 0,
        "2" => 8716,
        "3" => 38004298,
        "4" => 8717,
        "5" => 8863,
        "6" => 0,
        "7" => 8870,
        "8" => 0,
        "9" => 0,
        "45" => 581384,
        "46" => 0,
        "A" => 8761,
        "B" => 0,
        "C" => 0,
        "D" => 8717,
        "E" => 8883,
        "F" => 8546,
        _ => 0
    };

    private static long ConditionStatus(string value) => value.Trim().ToUpperInvariant() switch
    {
        "A" => 32890,
        "P" => 32902,
        "S" => 32908,
        _ => 0
    };

    private static long ProcedureType(string value) => value.Trim().ToUpperInvariant() switch
    {
        "P" => 44786630,
        "S" => 44786631,
        _ => 0
    };

    private static long DefaultType(string domain) => domain switch
    {
        "Drug" => 38000180,
        "Device" => 44818705,
        "Measurement" => 44818701,
        "Observation" => 38000281,
        "Condition" => 32818,
        _ => 32875
    };

    private sealed record PatRow(
        long MedrecKey,
        string PatKey,
        DateTime AdmDate,
        DateTime DiscDate,
        int Age,
        string Gender,
        string Race,
        string HispanicInd,
        string IOInd,
        string PointOfOrigin,
        int StdPayor,
        int? MsDrg,
        long? AdmPhy,
        long? ProvId,
        Guid Guid);

    private sealed record PatbillRow(
        string PatKey,
        long StdChgCode,
        long? HospChgId,
        DateTime ServDate,
        decimal StdQty,
        decimal BillCharges,
        decimal BillCost);

    private sealed record PatcptRow(string PatKey, string CptCode, DateTime ProcDate);
    private sealed record PaticdDiagRow(string PatKey, string IcdCode, int IcdVersion, string IcdPriSec);
    private sealed record PaticdProcRow(
        string PatKey,
        string IcdCode,
        int IcdVersion,
        string IcdPriSec,
        DateTime ProcDate,
        long? ProcPhy);
    private sealed record ChgmstrRow(
        long StdChgCode,
        string StdChgDesc,
        string ClinSumDesc,
        string StdDeptDesc,
        string SumDeptDesc);
}

internal sealed class PremierTestVocabulary : IVocabulary
{
    internal static readonly DateTime ValidStart = new(1900, 1, 1);
    internal static readonly DateTime ValidEnd = new(2099, 12, 31);
    private readonly Dictionary<string, List<LookupValue>> _mappings = new(StringComparer.Ordinal);
    private readonly Dictionary<long, string> _domains = [];
    private readonly Dictionary<long, string> _vocabularies = [];

    internal PremierTestVocabulary()
    {
        Map("ConditionIcd", "112.89", 433968, "Condition", 44828825, "ICD9CM");
        Map("ConditionIcd", "M05.421", 4116440, "Condition", 45591075, "ICD10CM");
        Map("ConditionIcd", "M05.421", 4107913, "Condition", 45591075, "ICD10CM");
        Map("ConditionIcd", "I10", 320128, "Condition", 45591075, "ICD10CM");

        Map("PremierCharge", "250250038820000", 19042590, "Drug", ingredients: [19042590]);
        Map("PremierCharge", "33840", 4105220, "Procedure");
        Map("PremierCharge", "270275000120000", 4236068, "Device");
        Map("PremierCharge", "110214000620000", 4227255, "Observation");
        Map("PremierCharge", "85013", 4016241, "Measurement");
        Map("PremierCharge", "270270056010000", 4063122, "Device");
        Map("PremierCharge", "250250015090000", 1100333, "Drug", ingredients: [1100333]);
        Map("PremierCharge", "300305856520000", 4016246, "Measurement");
        Map("PremierCharge", "300301800060000", 4148655, "Observation");
        Map("PremierCharge", "999999040442008", 2108550, "Observation");
        Map("PremierCharge", "360360206110000", 46257707, "Procedure");
        Map("PremierCharge", "270270019860000", 0, "Observation");

        Map("DrugCpt", "J9310", 46275081, "Drug", 2718907, "HCPCS", [46275081]);
        Map("DrugCpt", "90687", 40213145, "Drug", 44818309, "CPT4", [40213145]);
        Map("Device", "V5245", 2721945, "Device", vocabularyId: "HCPCS");
        Map("Measurement", "81003", 2212168, "Measurement", vocabularyId: "CPT4");
        Map("Measurement", "G0432", 40664440, "Measurement", vocabularyId: "HCPCS");
        Map("Observation", "0581F", 44816517, "Observation", vocabularyId: "CPT4");
        Map("Observation", "G8997", 43533318, "Observation", vocabularyId: "HCPCS");
        Map("Procedure", "S2325", 40489502, "Procedure", vocabularyId: "HCPCS");
        Map("Procedure", "01210", 2101632, "Procedure", vocabularyId: "CPT4");

        Map("Measurement", "796.0", 4195512, "Measurement", vocabularyId: "ICD9CM");
        Map("Measurement", "Z01.83", 4258677, "Measurement", vocabularyId: "ICD10CM");
        Map("Measurement", "V85.42", 0, "Measurement", vocabularyId: "ICD9CM");
        Map("Measurement", "Z68.3", 0, "Measurement", vocabularyId: "ICD10CM");
        Map("ObservationICD9", "E872.9", 439633, "Observation", vocabularyId: "ICD9CM");
        Map("ObservationICD10", "T71.131", 439470, "Observation", vocabularyId: "ICD10CM");
        Map("ObservationICD9", "E826", 443423, "Observation", vocabularyId: "ICD9CM");
        Map("ObservationICD10", "V80.02", 4067275, "Observation", vocabularyId: "ICD10CM");

        Map("Procedure", "V55.1", 4125153, "Procedure", vocabularyId: "ICD9CM");
        Map("Procedure", "26.31", 4239779, "Procedure", vocabularyId: "ICD9Proc");
        Map("Procedure", "Z05.1", 44789514, "Procedure", vocabularyId: "ICD10CM");
        Map("Procedure", "0SG33KJ", 2771840, "Procedure", vocabularyId: "ICD10PCS");
        Map("Procedure", "86.28", 4026179, "Procedure", vocabularyId: "ICD9Proc");
        Map("Procedure", "33.51", 4337611, "Procedure", vocabularyId: "ICD9Proc");
        Map("Procedure", "99.29", 4337186, "Procedure", vocabularyId: "ICD9Proc");

        Map("RevenueCode", "PHARMACY / PHARMACY", 38003147, "Revenue Code");
        Map("RevenueCode", "OR / SURGERY", 38003208, "Revenue Code");
        Map("RevenueCode", "SUPPLY / CENTRAL SUPPLY", 38003163, "Revenue Code");
        Map("RevenueCode", "OTHER / DIALYSIS", 38003458, "Revenue Code");
        Map("RevenueCode", "LAB / LABORATORY", 38003172, "Revenue Code");
        Map("Drg", "001", 38000887, "DRG");
    }

    internal int MappingCount => _mappings.Values.Sum(values => values.Count);

    public void Fill(bool forLookup) { }

    public List<LookupValue> Lookup(string sourceValue, string key, DateTime eventDate)
    {
        if (string.IsNullOrWhiteSpace(sourceValue) || string.IsNullOrWhiteSpace(key)) return [];
        if (!_mappings.TryGetValue(Key(key, sourceValue), out var values)) return [];
        if (eventDate == DateTime.MinValue) return [.. values];
        return values.Where(v => eventDate.Date >= v.ValidStartDate.Date && eventDate.Date <= v.ValidEndDate.Date).ToList();
    }

    public int? LookupGender(string genderSourceValue) => genderSourceValue?.Trim().ToLowerInvariant() switch
    {
        "m" or "male" => 8507,
        "f" or "female" => 8532,
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
        long[]? ingredients = null)
    {
        var key = Key(lookup, source);
        if (!_mappings.TryGetValue(key, out var values))
        {
            values = [];
            _mappings.Add(key, values);
        }

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
            if (!string.IsNullOrWhiteSpace(vocabularyId)) _vocabularies[conceptId] = vocabularyId;
        }
    }

    private static string Key(string lookup, string source) =>
        $"{lookup.Trim().ToUpperInvariant()}\u001f{source.Trim().ToUpperInvariant()}";
}
