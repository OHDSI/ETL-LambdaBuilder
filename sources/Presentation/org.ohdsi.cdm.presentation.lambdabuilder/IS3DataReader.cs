using System;
using System.Data;

namespace org.ohdsi.cdm.presentation.lambdabuilder
{
    public interface IS3DataReader : IDataReader
    {
        public TimeSpan IdleTime { get; }
        public long RowIndex { get; }

        public void Restart();

        public bool Paused { get; }

        public void Pause();

        public void Resume();
    }
}
