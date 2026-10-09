using org.ohdsi.cdm.framework.common.Builder;
using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.common.Lookups;
using org.ohdsi.cdm.framework.common.Omop;
using org.ohdsi.cdm.framework.common.PregnancyAlgorithm;
using org.ohdsi.cdm.framework.etl.Transformation.CPRD;

namespace org.ohdsi.cdm.Tests.UnitTests.PersonBuilderTests.CprdTests;

internal enum CprdReadSource
{
    Clinical,
    Immunisation,
    Referral
}

internal sealed record CprdBuildResult(ChunkData Data, Attrition Attrition);
internal sealed record CprdStaticData(
    IReadOnlyList<CareSite> CareSites,
    IReadOnlyList<Location> Locations,
    IReadOnlyList<Provider> Providers);

/// <summary>
/// In-memory projection of the CPRD Gold source rows used by the active R suite.
/// </summary>
internal sealed class CprdInMemoryScenario
{
    private readonly CprdTestVocabulary _vocabulary = new();
    private readonly List<IEntity> _entities = [];
    private readonly List<CareSite> _careSites = [];
    private readonly List<Location> _locations = [];
    private readonly List<Provider> _providers = [];
    private readonly Dictionary<long, long> _practiceByPerson = [];
    private long _nextId = 1;

    internal CprdTestVocabulary Vocabulary => _vocabulary;

    internal void AddPatient(
        long personId,
        int gender = 1,
        int yob = 199,
        int? mob = 1,
        int accept = 1,
        string crd = "2010-01-01",
        long pracid = 311,
        string? tod = null,
        string? deathDate = null,
        int toreason = 0,
        string frd = "1948-07-05")
    {
        var (uts, lcd) = PracticeDates(pracid);
        var start = Max(Date(crd), uts);
        var end = tod is null ? lcd : Min(Date(tod), lcd);
        var year = yob > 1800 ? yob : yob + 1800;
        _practiceByPerson[personId] = pracid;

        _entities.Add(new Person
        {
            Id = NextId(),
            PersonId = personId,
            PersonSourceValue = personId.ToString(),
            StartDate = start,
            EndDate = end,
            TypeConceptId = 32880,
            GenderConceptId = _vocabulary.LookupGender(gender.ToString()),
            GenderSourceValue = gender.ToString(),
            RaceConceptId = 0,
            EthnicityConceptId = 0,
            YearOfBirth = year,
            MonthOfBirth = mob is > 0 ? mob : null,
            CareSiteId = pracid,
            ObservationPeriodGap = 0,
            SourceRecordGuid = Guid.NewGuid(),
            AdditionalFields = new()
            {
                ["accept"] = accept.ToString(),
                ["frd"] = frd
            }
        });

        // Patient.xml emits a Death only when DIED=1. The CPRD R defaults use
        // toreason=0; tests expecting a death therefore correctly expose drift.
        if (deathDate is not null && toreason == 1)
        {
            var deathEntity = BaseEntity(personId, Date(deathDate), 1, 32817, "0", "Death");
            _entities.Add(new Death(deathEntity) { Primary = true });
        }
    }

    internal void AddRead(
        long personId,
        CprdReadSource source,
        string date,
        string readCode,
        long? providerId = 1001,
        int? consultationType = null)
    {
        var eventDate = Date(date);
        var mapping = _vocabulary.Lookup(readCode, "Read_Code", eventDate).FirstOrDefault();
        var defaultDomain = source == CprdReadSource.Clinical ? "Condition" : "Observation";
        var type = source == CprdReadSource.Immunisation ? 32818 : 32817;
        var visitId = AddRawVisit(personId, eventDate, providerId, consultationType);
        var entity = BaseEntity(
            personId,
            eventDate,
            mapping?.ConceptId ?? 0,
            type,
            readCode,
            mapping?.Domain ?? defaultDomain,
            providerId,
            visitId,
            mapping);

        _entities.Add(source == CprdReadSource.Clinical
            ? new ConditionOccurrence(entity)
            : new Observation(entity));
    }

    internal void AddTherapy(
        long personId,
        string date,
        string gemscriptCode,
        int daysSupply,
        decimal quantity = 1,
        int refills = 1,
        long? providerId = 9001,
        int? consultationType = null)
    {
        if (gemscriptCode == "-1") return;

        var eventDate = Date(date);
        var normalizedDays = Math.Max(1, Math.Min(365, daysSupply));
        var mapping = _vocabulary.Lookup(gemscriptCode, "Drug", eventDate).FirstOrDefault();
        var visitId = AddRawVisit(personId, eventDate, providerId, consultationType);
        var entity = BaseEntity(
            personId,
            eventDate,
            mapping?.ConceptId ?? 0,
            32838,
            gemscriptCode,
            mapping?.Domain ?? "Drug",
            providerId,
            visitId,
            mapping);
        entity.EndDate = eventDate.AddDays(normalizedDays - 1);

        _entities.Add(new DrugExposure(entity)
        {
            DaysSupply = normalizedDays,
            Quantity = quantity,
            Refills = refills
        });
    }

    internal void AddTestResult(
        long personId,
        string date,
        string readCode,
        string entityKey,
        long? providerId = 1001,
        decimal? value = null,
        string? valueSource = null,
        decimal? rangeLow = null,
        decimal? rangeHigh = null,
        long qualifierConceptId = 0,
        string? qualifierSource = null,
        long? unitConceptId = null,
        string? unitSource = null,
        int? consultationType = null)
    {
        var eventDate = Date(date);
        var mapping = _vocabulary.Lookup(entityKey, "Test_Ent", eventDate).FirstOrDefault();
        var visitId = AddRawVisit(personId, eventDate, providerId, consultationType);
        var entity = BaseEntity(
            personId,
            eventDate,
            mapping?.ConceptId ?? 0,
            32856,
            readCode,
            mapping?.Domain ?? "Observation",
            providerId,
            visitId,
            mapping);

        var observation = new Observation(entity)
        {
            ValueAsNumber = value,
            ValueSourceValue = valueSource,
            ValueAsString = valueSource,
            RangeLow = rangeLow,
            RangeHigh = rangeHigh,
            QualifierConceptId = qualifierConceptId,
            QualifierSourceValue = qualifierSource,
            UnitsConceptId = unitConceptId,
            UnitsSourceValue = unitSource,
            ValueAsConceptId = valueSource is null
                ? null
                : _vocabulary.Lookup(valueSource, "ValueAsConceptId", DateTime.MinValue)
                    .FirstOrDefault()?.ConceptId
        };
        _entities.Add(observation);
    }

    internal void AddObservation(
        long personId,
        string date,
        long conceptId,
        string sourceValue,
        long typeConceptId = 32817,
        long sourceConceptId = 0,
        string? valueAsString = null,
        decimal? valueAsNumber = null,
        long? valueAsConceptId = null,
        long qualifierConceptId = 0,
        string? unitSourceValue = null,
        long? unitConceptId = null,
        string domain = "Observation")
    {
        var observation = new Observation(BaseEntity(
            personId, Date(date), conceptId, typeConceptId, sourceValue, domain))
        {
            SourceConceptId = sourceConceptId,
            ValueAsString = valueAsString,
            ValueAsNumber = valueAsNumber,
            ValueAsConceptId = valueAsConceptId,
            QualifierConceptId = qualifierConceptId,
            UnitsSourceValue = unitSourceValue,
            UnitsConceptId = unitConceptId
        };
        _entities.Add(observation);
    }

    internal void AddMeasurement(
        long personId,
        string date,
        long conceptId,
        string sourceValue,
        long typeConceptId = 32817,
        long sourceConceptId = 0,
        decimal? valueAsNumber = null,
        string? valueSourceValue = null,
        long? valueAsConceptId = null,
        decimal? rangeLow = null,
        decimal? rangeHigh = null,
        long? operatorConceptId = null,
        string? unitSourceValue = null,
        long? unitConceptId = null)
    {
        var measurement = new Measurement(BaseEntity(
            personId, Date(date), conceptId, typeConceptId, sourceValue, "Measurement"))
        {
            SourceConceptId = sourceConceptId,
            ValueAsNumber = valueAsNumber,
            ValueSourceValue = valueSourceValue,
            ValueAsConceptId = valueAsConceptId,
            RangeLow = rangeLow,
            RangeHigh = rangeHigh,
            OperatorConceptId = operatorConceptId,
            UnitSourceValue = unitSourceValue,
            UnitConceptId = unitConceptId
        };
        _entities.Add(measurement);
    }

    internal void AddCareSite(long careSiteId, long locationId) => _careSites.Add(new CareSite
    {
        Id = careSiteId,
        LocationId = locationId,
        SourceValue = careSiteId.ToString(),
        AdditionalFields = []
    });

    internal void AddLocation(long locationId) => _locations.Add(new Location
    {
        Id = locationId,
        SourceValue = locationId.ToString(),
        Country = "United Kingdom",
        CountryConceptId = 42046186,
        AdditionalFields = []
    });

    internal void AddProvider(long providerId, string specialtySourceValue, long specialtyConceptId) =>
        _providers.Add(new Provider
        {
            Id = providerId,
            ProviderSourceValue = providerId.ToString(),
            SourceValue = specialtySourceValue,
            ConceptId = specialtyConceptId,
            SpecialtySourceConceptId = 0,
            GenderConceptId = 0,
            GenderSourceConceptId = 0,
            AdditionalFields = []
        });

    internal CprdBuildResult Build(long personId)
    {
        var builder = new CprdPersonBuilder(new CprdPersonBuilder.CprdVendor());
        builder.JoinToVocabulary(_vocabulary);
        foreach (var entity in _entities.Where(e => e.PersonId == personId)) builder.AddData(entity);

        var data = new ChunkData(chunkId: 0, subChunkId: 0);
        var attrition = builder.Build(data, new KeyMasterOffsetManager(chunkId: 0, prefix: 0, attempt: 0));
        return new CprdBuildResult(data, attrition);
    }

    internal CprdStaticData BuildStaticData() => new(_careSites, _locations, _providers);

    private long AddRawVisit(long personId, DateTime date, long? providerId, int? consultationType)
    {
        var type = consultationType ?? 99;
        var id = checked(personId * 100_000L + date.DayOfYear * 100L + type);
        _entities.Add(new VisitOccurrence(BaseEntity(
            personId, date, 9202, 32817, ConsultationDescription(consultationType), "Visit",
            providerId))
        {
            Id = id,
            EndDate = date,
            CareSiteId = _practiceByPerson.GetValueOrDefault(personId, TrailingPracticeId(personId)),
            AdditionalFields = new() { ["constype"] = consultationType?.ToString() ?? string.Empty }
        });
        return id;
    }

    private Entity BaseEntity(
        long personId,
        DateTime date,
        long? conceptId,
        long? typeConceptId,
        string sourceValue,
        string domain,
        long? providerId = null,
        long? visitDetailId = null,
        LookupValue? mapping = null) => new()
    {
        Id = NextId(),
        PersonId = personId,
        ConceptId = conceptId ?? 0,
        SourceConceptId = mapping?.SourceConcepts.FirstOrDefault()?.ConceptId ?? 0,
        SourceConcepts = mapping?.SourceConcepts is null ? [] : [.. mapping.SourceConcepts],
        Ingredients = mapping?.Ingredients is null ? [] : [.. mapping.Ingredients],
        StartDate = date,
        EndDate = null,
        TypeConceptId = typeConceptId,
        SourceValue = sourceValue,
        Domain = domain,
        ProviderId = providerId,
        VisitDetailId = visitDetailId,
        SourceRecordGuid = Guid.NewGuid(),
        ValidStartDate = mapping?.ValidStartDate ?? CprdTestVocabulary.ValidStart,
        ValidEndDate = mapping?.ValidEndDate ?? CprdTestVocabulary.ValidEnd,
        AdditionalFields = []
    };

    private long NextId() => _nextId++;

    private static DateTime Date(string value) => DateTime.Parse(value, System.Globalization.CultureInfo.InvariantCulture);
    private static DateTime Max(DateTime left, DateTime right) => left >= right ? left : right;
    private static DateTime Min(DateTime left, DateTime right) => left <= right ? left : right;

    private static (DateTime Uts, DateTime Lcd) PracticeDates(long practiceId) => practiceId switch
    {
        111 => (Date("2010-01-01"), Date("2013-01-01")),
        113 => (Date("2014-01-01"), Date("2012-12-01")),
        222 => (Date("2001-02-12"), Date("2011-11-11")),
        311 => (Date("2000-01-01"), Date("2016-12-31")),
        555 => (Date("2013-01-01"), Date("2013-12-31")),
        888 => (Date("2009-01-01"), Date("2014-01-01")),
        _ => (Date("2000-01-01"), Date("2023-06-07"))
    };

    private static long TrailingPracticeId(long personId)
    {
        var text = personId.ToString();
        return long.Parse(text.Length <= 5 ? text : text[^5..]);
    }

    private static string ConsultationDescription(int? type) => type switch
    {
        9 => "Surgery consultation",
        6 => "Night visit , practice",
        null => string.Empty,
        _ => type?.ToString() ?? string.Empty
    };
}

internal sealed class CprdTestVocabulary : IVocabulary
{
    internal static readonly DateTime ValidStart = new(1900, 1, 1);
    internal static readonly DateTime ValidEnd = new(2099, 12, 31);

    private readonly Dictionary<string, List<LookupValue>> _mappings = new(StringComparer.Ordinal);
    private readonly Dictionary<long, string> _domains = [];
    private readonly Dictionary<long, string> _vocabularies = [];

    internal CprdTestVocabulary()
    {
        Map("Read_Code", "F563500", 75555, "Condition", 45436713, "Read");
        Map("Read_Code", "K17y000", 195862, "Condition", 45453481, "Read");
        Map("Read_Code", "J040.14", 4123595, "Condition", 45463565, "Read");
        Map("Read_Code", "P00..00", 377368, "Condition", 45420722, "Read");
        Map("Read_Code", "PB2z.00", 198550, "Condition", 45430565, "Read");
        Map("Read_Code", "9b20.00", 4192787, "Device", vocabularyId: "Read");
        Map("Read_Code", "65M4.00", 44792015, "Procedure", 45498792, "Read");
        Map("Read_Code", "65F5.00", 0, "Drug", vocabularyId: "Read");
        Map("Read_Code", "65A..00", 40213170, "Drug", 45445397, "Read", [40213170]);
        Map("Read_Code", "424Z.00", 4132152, "Measurement", 45508441, "Read");
        Map("Read_Code", "7J46z00", 4074106, "Procedure", 45419444, "Read");
        Map("Read_Code", "7414200", 4336549, "Procedure", 45425628, "Read");
        Map("Read_Code", "744C.00", 4192131, "Procedure", 45425639, "Read");
        Map("Read_Code", "65PT.11", 40479404, "Observation", 45425506, "Read");
        Map("Read_Code", "R100.00", 4044812, "Observation", 45474099, "Read");
        Map("Read_Code", "66Ya.00", 0, "Observation", vocabularyId: "Read");
        Map("Read_Code", "339A.00", 0, "Observation", 45455049, "Read");
        Map("Read_Code", "339a.00", 0, "Observation", 45421972, "Read");

        Map("Drug", "58976020", 19073982, "Drug", ingredients: [1316354]);
        Map("Drug", "72487020", 1539463, "Drug", ingredients: [1539463]);
        Map("Drug", "93680020", 0, "Drug");
        Map("Drug", "99978020", 21380480, "Device");
        Map("Drug", "90473020", 19019073, "Drug", ingredients: [1177480]);

        Map("Test_Ent", "215-Clotting Tests", 4199172, "Measurement");
        Map("Test_Ent", "220-Full blood count", 4132152, "Measurement");
        Map("Test_Ent", "173-Haemoglobin", 4015178, "Measurement");
        Map("Test_Ent", "284-Maternity ultra sound scan", 3031455, "Measurement");
        Map("Test_Ent", "311-PF current", 0, "Observation");
        Map("Test_Ent", "154-Alpha fetoprotein", 4197249, "Measurement");
        Map("Test_Ent", "412-Airway ...", 0, "Observation");
        Map("Test_Ent", "380-Pulmonary function tests", 0, "Observation");

        Map("ValueAsConceptId", "Normal", 4069590, "Meas Value");
        Map("ValueAsConceptId", "High", 4328749, "Meas Value");
        Map("Units", "g/dL", 8713, "Unit");
        Map("Units", "%", 8554, "Unit");

        Map("Specialty", "Partner", 32577, "Provider");
        Map("Specialty", "Radiographer", 45756825, "Provider");
        Map("Specialty", "Data Not Entered", 38004514, "Provider");
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

    public int? LookupGender(string genderSourceValue) => genderSourceValue switch
    {
        "1" => 8507,
        "2" => 8532,
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
        if (!_mappings.TryGetValue(key, out var values)) _mappings[key] = values = [];
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
            if (vocabularyId is not null) _vocabularies[conceptId] = vocabularyId;
        }
    }

    private static string Key(string lookup, string source) =>
        $"{lookup.Trim()}\u001f{source.Trim()}";
}

internal static class CprdRAssert
{
    internal static DateTime Date(string value) => DateTime.Parse(value, System.Globalization.CultureInfo.InvariantCulture);

    internal static T Single<T>(IEnumerable<T> values, Func<T, bool> predicate) => Assert.Single(values.Where(predicate));

    internal static void Common(
        IEntity entity,
        long personId,
        long conceptId,
        string date,
        string sourceValue,
        long sourceConceptId,
        long typeConceptId)
    {
        Assert.Equal(personId, entity.PersonId);
        Assert.Equal(conceptId, entity.ConceptId);
        Assert.Equal(Date(date), entity.StartDate);
        Assert.Equal(sourceValue, entity.SourceValue);
        Assert.Equal(sourceConceptId, entity.SourceConceptId);
        Assert.Equal(typeConceptId, entity.TypeConceptId);
    }
}
