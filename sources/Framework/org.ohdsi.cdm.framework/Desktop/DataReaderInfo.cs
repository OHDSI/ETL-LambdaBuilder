using System.Data;
using System.Data.Odbc;

namespace org.ohdsi.cdm.framework.desktop
{
    public class DataReaderInfo(OdbcConnection connection, OdbcCommand command, IDataReader reader, string name) : IDisposable
    {
        public OdbcConnection Connection { get; private set; } = connection;
        public OdbcCommand Command { get; private set; } = command;
        public IDataReader DataReader { get; private set; } = reader;
        public string Name { get; private set; } = name;

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                DataReader?.Dispose();
                Command?.Dispose();
                Connection?.Dispose();

                DataReader = null;
                Command = null;
                Connection = null;
            }
        }
    }
}