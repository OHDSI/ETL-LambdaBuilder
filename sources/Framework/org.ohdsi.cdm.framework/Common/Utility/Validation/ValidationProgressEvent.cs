

namespace org.ohdsi.cdm.framework.Common.Utility.Validation
{
    public enum ValidationProgressEventKind
    {
        Log,
        StartTask,
        UpdateTask,
        IncrementTask,
        CompleteTask,
        KeepTaskWithMessage
    }

    public enum ValidationLogLevel
    {
        Info,
        Success,
        Warning,
        Error
    }

    public record ValidationProgressEvent(
        ValidationProgressEventKind Kind,
        string TaskId,
        string Message,
        double MaxValue,
        double? Value,
        double Increment,
        bool IsIndeterminate,
        ValidationLogLevel Level)
    {
        public static ValidationProgressEvent Log(string message, ValidationLogLevel level = ValidationLogLevel.Info)
        {
            return new ValidationProgressEvent(
                ValidationProgressEventKind.Log,
                string.Empty,
                message,
                0,
                null,
                0,
                false,
                level);
        }

        public static ValidationProgressEvent StartTask(
            string taskId,
            string message,
            double maxValue,
            bool isIndeterminate = false)
        {
            return new ValidationProgressEvent(
                ValidationProgressEventKind.StartTask,
                taskId,
                message,
                maxValue,
                null,
                0,
                isIndeterminate,
                ValidationLogLevel.Info);
        }

        public static ValidationProgressEvent UpdateTask(
            string taskId,
            string message,
            double? value = null)
        {
            return new ValidationProgressEvent(
                ValidationProgressEventKind.UpdateTask,
                taskId,
                message,
                0,
                value,
                0,
                false,
                ValidationLogLevel.Info);
        }

        public static ValidationProgressEvent IncrementTask(
            string taskId,
            double increment,
            string message)
        {
            return new ValidationProgressEvent(
                ValidationProgressEventKind.IncrementTask,
                taskId,
                message,
                0,
                null,
                increment,
                false,
                ValidationLogLevel.Info);
        }

        public static ValidationProgressEvent CompleteTask(string taskId, string message)
        {
            return new ValidationProgressEvent(
                ValidationProgressEventKind.CompleteTask,
                taskId,
                message,
                0,
                null,
                0,
                false,
                ValidationLogLevel.Success);
        }

        public static ValidationProgressEvent KeepTaskWithMessage(string taskId, string message, ValidationLogLevel validationLogLevel)
        {

            return new ValidationProgressEvent(
                ValidationProgressEventKind.KeepTaskWithMessage,
                taskId,
                message,
                0,
                null,
                0,
                false,
                validationLogLevel);
        }
    }

    public interface IValidationReporter
    {
        void Report(ValidationProgressEvent progressEvent);
    }

    public class NullValidationReporter : IValidationReporter
    {
        public static readonly NullValidationReporter Instance = new NullValidationReporter();

        private NullValidationReporter()
        {
        }

        public void Report(ValidationProgressEvent progressEvent)
        {
        }
    }
}