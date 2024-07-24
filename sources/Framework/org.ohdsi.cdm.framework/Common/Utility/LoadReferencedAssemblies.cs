using System.Reflection;

namespace org.ohdsi.cdm.framework.common.Utility
{
    public static class LoadReferencedAssemblies
    {
        #region Fields

        private static bool _assemblyLoaded = false;

        #endregion

        #region Methods

        /// <summary>
        /// If a class goes to a different assembly than its ancestor 
        /// then this method is required to make this class visible for Assembly.GetTypes()
        /// </summary>
        public static void DoIfNotLoadedAlready()
        {
            if (_assemblyLoaded)
                return;

            var loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies().ToList();
            var loadedPaths = new HashSet<string>(loadedAssemblies.Select(a => a.Location), StringComparer.InvariantCultureIgnoreCase);

            var baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
            var allAssemblies = Directory.GetFiles(baseDirectory, "*.dll", SearchOption.AllDirectories)
                                         .Where(filePath => !loadedPaths.Contains(filePath))
                                         .ToList();

            foreach (var assemblyPath in allAssemblies)
            {
                try
                {
                    if (!assemblyPath.Contains("org.ohdsi.cdm.framework.etl"))
                        continue;

                    var assembly = Assembly.LoadFrom(assemblyPath);
                    loadedAssemblies.Add(assembly);
                    loadedPaths.Add(assembly.Location);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Failed to load assembly from {assemblyPath}: {ex.Message}");
                }
            }

            _assemblyLoaded = true;
        }

        #endregion
    }
}
