using System;
using System.Windows;
using org.ohdsi.cdm.framework.desktop;

namespace org.ohdsi.cdm.presentation.buildingmanager2
{
   /// <summary>
   /// Interaction logic for App.xaml
   /// </summary>
   public partial class App : Application
   {
      public App()
      {
         AppDomain.CurrentDomain.UnhandledException += CurrentDomain_UnhandledException;
      }

      private void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
      {
          var ex = e.ExceptionObject as Exception;

         MessageBox.Show(Logger.CreateExceptionString(ex));
      }
   }
}
