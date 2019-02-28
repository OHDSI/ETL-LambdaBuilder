using NUnit.Framework;
using org.ohdsi.cdm.framework.common2.Core.Transformation.Premier;

namespace org.ohdsi.cdm.tests
{
   public class TParseSurgeryTime
   {
      [Test]
      public void Test()
      {
         Assert.AreEqual(15, PremierPersonBuilder.GetMinutes("OR MINOR ADDL 15 MIN"));
         Assert.AreEqual(60, PremierPersonBuilder.GetMinutes("OR MINOR EMERGENCY 1ST HR"));
         Assert.AreEqual(255, PremierPersonBuilder.GetMinutes("OR OPEN HEART 4 HR 15 MIN"));
         Assert.AreEqual(6 * 60, PremierPersonBuilder.GetMinutes("OR MAJOR 6 HR"));
         Assert.AreEqual(30, PremierPersonBuilder.GetMinutes("OR MINOR 1ST 30 MIN"));
      }
   }
}
