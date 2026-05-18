using Azure.Identity;
using Azure.Storage.Blobs;
using org.ohdsi.cdm.framework.common.Enums;

namespace org.ohdsi.cdm.presentation.azurebuilder
{
    internal class AzureHelper
    {
        internal static string Path
        {
            get { return $"{Settings.Current.Prefix}/{GetVendorName(Settings.Current.Building.Vendor)}/{Settings.Current.Building.Id}"; }
        }

        private static string GetVendorName(Vendor v)
        {
            if (v.Name.Contains("Truven_"))
                return v.Name.Replace("Truven_", "");

            return v.Name;
        }

        internal static BlobContainerClient GetBlobContainer()
        {
            ClientSecretCredential credential = new(Settings.Current.TenantId, Settings.Current.ClientId, Settings.Current.ClientSecret);
            var client = new BlobServiceClient(new Uri(Settings.Current.ServiceUri), credential, null);
            
            return client.GetBlobContainerClient(Settings.Current.BlobContainerName);
        }

        internal static Stream OpenStream(string fileName)
        {
            return GetBlobContainer().GetBlobClient(fileName).OpenRead();
        }

        internal static void UploadStream(string fileName, Stream stream)
        {
            AzureHelper.GetBlobContainer().UploadBlob(fileName, stream);
        }

        internal static void DeleteFile(string fileName)
        {
            AzureHelper.GetBlobContainer().DeleteBlobIfExists(fileName);
        }
    }
}
