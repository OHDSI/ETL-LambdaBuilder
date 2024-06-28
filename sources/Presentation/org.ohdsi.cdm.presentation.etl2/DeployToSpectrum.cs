using org.ohdsi.cdm.framework.common.Enums;
using org.ohdsi.cdm.framework.desktop.Settings;
using System;
using System.Data.Odbc;
using System.IO;

namespace org.ohdsi.cdm.presentation.etl
{
    class DeployToSpectrum
    {
        public static void Start(string spectrumConnectionString, string iamRole, string db, string schema)
        {
            var createDestinationSql = Helper.S3ReadAllText(Path.Combine(Settings.Current.Vendorettings, "Common",
                "Spectrum", "CreateDestination.sql"));

            createDestinationSql = createDestinationSql.Replace("{sc}", schema);
            createDestinationSql = createDestinationSql.Replace("{db}", schema);
            createDestinationSql = createDestinationSql.Replace("{role}", iamRole);

            var createTables = Helper.S3ReadAllText(Path.Combine(Settings.Current.Vendorettings, "Common", "Spectrum",
                "CreateTables.sql"));

            if (Settings.Current.Building.Cdm == CdmVersions.V6)
                createTables = Helper.S3ReadAllText(Path.Combine(Settings.Current.Vendorettings, "Common", "Spectrum", "v6.0",
                    "CreateTables.sql"));

            createTables = createTables.Replace("{sc}", schema);
            createTables = createTables.Replace("{bucket}", Settings.Current.Bucket);

            var folder =
                $"{Settings.Current.Building.Vendor}/{Settings.Current.Building.Id.Value}/{Settings.Current.CDMFolder}";
            createTables = createTables.Replace("{folder}", folder);

            Console.WriteLine($"s3://{Settings.Current.Bucket}/{folder}/");
            Console.WriteLine("spectrumConnectionString=" + spectrumConnectionString);
            Console.WriteLine();

            using (var connection = new OdbcConnection(spectrumConnectionString))
            {
                connection.Open();
                using var c = new OdbcCommand(createDestinationSql, connection);
                c.ExecuteNonQuery();
            }

            using (var connection = new OdbcConnection(spectrumConnectionString))
            {
                connection.Open();

                foreach (var subQuery in createTables.Split(';', StringSplitOptions.RemoveEmptyEntries))
                {
                    using var command = new OdbcCommand(subQuery, connection);
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
