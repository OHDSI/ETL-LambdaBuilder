using org.ohdsi.cdm.framework.common.Helpers;
using System;
using System.Collections.Generic;
using System.Data;

namespace org.ohdsi.cdm.presentation.lambdamerge
{
    public class RowGroup
    {
        private Dictionary<int, List<int?>> _intColumns;
        private Dictionary<int, List<long?>> _longColumns;
        private Dictionary<int, List<decimal?>> _decimalColumns;
        private Dictionary<int, List<double?>> _doubleColumns;
        private Dictionary<int, List<float?>> _floatColumns;
        private Dictionary<int, List<string>> _stringColumns;
        private Dictionary<int, List<DateTimeOffset?>> _dateTimeOffsetColumns;

        public int RowCount { get; private set; }

        public long? AddRow(IDataReader reader, string text, int columnCount, long? lastSavedId)
        {
            StringSplitter sp = new(columnCount);
            sp.SafeSplit(text, ",");

            long id = long.Parse(sp.Results[0]);

            for (var i = 0; i < columnCount; i++)
            {
                AddColumnValue(sp.Results[i], i, reader.GetFieldType(i));
            }

            RowCount++;

            return id;
        }

        private void AddColumnValue(string value, int columnIndex, Type t)
        {
            if (t == typeof(int) || t == typeof(int?))
            {
                _intColumns ??= [];

                if (!_intColumns.ContainsKey(columnIndex))
                    _intColumns.Add(columnIndex, []);

                if (int.TryParse(value, out int i))
                    _intColumns[columnIndex].Add(i);
                else
                    _intColumns[columnIndex].Add(null);
            }
            else if (t == typeof(long) || t == typeof(long?))
            {
                _longColumns ??= [];

                if (!_longColumns.ContainsKey(columnIndex))
                    _longColumns.Add(columnIndex, []);

                if (long.TryParse(value, out long i))
                    _longColumns[columnIndex].Add(i);
                else
                    _longColumns[columnIndex].Add(null);
            }
            else if (t == typeof(decimal) || t == typeof(decimal?))
            {
                _decimalColumns ??= [];

                if (!_decimalColumns.ContainsKey(columnIndex))
                    _decimalColumns.Add(columnIndex, []);

                if (decimal.TryParse(value, out decimal i))
                    _decimalColumns[columnIndex].Add(i);
                else
                    _decimalColumns[columnIndex].Add(null);
            }
            else if (t == typeof(double) || t == typeof(double?))
            {
                _doubleColumns ??= [];

                if (!_doubleColumns.ContainsKey(columnIndex))
                    _doubleColumns.Add(columnIndex, []);

                if (double.TryParse(value, out double i))
                    _doubleColumns[columnIndex].Add(i);
                else
                    _doubleColumns[columnIndex].Add(null);
            }
            else if (t == typeof(float) || t == typeof(float?))
            {
                _floatColumns ??= [];

                if (!_floatColumns.ContainsKey(columnIndex))
                    _floatColumns.Add(columnIndex, []);

                if (float.TryParse(value, out float i))
                    _floatColumns[columnIndex].Add(i);
                else
                    _floatColumns[columnIndex].Add(null);
            }
            else if (t == typeof(DateTime) || t == typeof(DateTime?) ||
                     t == typeof(DateTimeOffset) || t == typeof(DateTimeOffset?))
            {

                _dateTimeOffsetColumns ??= [];

                if (!_dateTimeOffsetColumns.ContainsKey(columnIndex))
                    _dateTimeOffsetColumns.Add(columnIndex, []);

                if (DateTimeOffset.TryParse(value, out DateTimeOffset i))
                    _dateTimeOffsetColumns[columnIndex].Add(i);
                else
                    _dateTimeOffsetColumns[columnIndex].Add(null);
            }
            else if (t == typeof(string) || t == typeof(TimeSpan) || t == typeof(TimeSpan?))
            {
                _stringColumns ??= [];

                if (!_stringColumns.ContainsKey(columnIndex))
                    _stringColumns.Add(columnIndex, []);

                if (string.IsNullOrEmpty(value) || value.Trim() == "\0")
                    _stringColumns[columnIndex].Add(null);
                else
                    _stringColumns[columnIndex].Add(value);
            }
            else
            {
                throw new Exception("RowGroup.AddRow unexpected type " + t.Name);
            }
        }

        public Array GetColumn(int index)
        {
            if (_intColumns != null && _intColumns.ContainsKey(index))
                return _intColumns[index].ToArray();

            if (_longColumns != null && _longColumns.ContainsKey(index))
                return _longColumns[index].ToArray();

            if (_stringColumns != null && _stringColumns.ContainsKey(index))
                return _stringColumns[index].ToArray();

            if (_dateTimeOffsetColumns != null && _dateTimeOffsetColumns.ContainsKey(index))
                return _dateTimeOffsetColumns[index].ToArray();

            if (_decimalColumns != null && _decimalColumns.ContainsKey(index))
                return _decimalColumns[index].ToArray();

            if (_doubleColumns != null && _doubleColumns.ContainsKey(index))
                return _doubleColumns[index].ToArray();

            if (_floatColumns != null && _floatColumns.ContainsKey(index))
                return _floatColumns[index].ToArray();

            throw new Exception("RowGroup.GetColumn missed index=" + index);
        }

        public static Array CreateEmtpyArray(Type t)
        {
            if (t == typeof(int) || t == typeof(int?))
            {
                return Array.Empty<int?>();
            }

            if (t == typeof(long) || t == typeof(long?))
            {
                return Array.Empty<long?>();
            }

            if (t == typeof(decimal) || t == typeof(decimal?))
            {
                return Array.Empty<decimal?>();
            }

            if (t == typeof(double) || t == typeof(double?))
            {
                return Array.Empty<double?>();
            }

            if (t == typeof(float) || t == typeof(float?))
            {
                return Array.Empty<float?>();
            }

            if (t == typeof(DateTime) || t == typeof(DateTime?) ||
                t == typeof(DateTimeOffset) || t == typeof(DateTimeOffset?))
            {
                return Array.Empty<DateTimeOffset?>();
            }

            if (t == typeof(string) || t == typeof(TimeSpan) || t == typeof(TimeSpan?))
            {
                return Array.Empty<string>();
            }

            throw new Exception("RowGroup.AddRow unexpected type " + t.Name);
        }
    }
}