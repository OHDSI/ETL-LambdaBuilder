using System;
using static org.ohdsi.cdm.framework.common.Enums.Vendor;

namespace org.ohdsi.cdm.framework.common.Omop
{
    public class CdmSource
    {
        public long CdmVersionConceptId { get; set; }

        public string CdmSourceName { get; set; }
        public string CdmSourceAbbreviation { get; set; }
        public string CdmHolder { get; set; }
        public string SourceDescription { get; set; }
        public string SourceDocumentationReference { get; set; }
        public string CdmEtlReference { get; set; }
        public DateTime SourceReleaseDate { get; set; }
        public DateTime CdmReleaseDate { get; set; }
        public string CdmVersion { get; set; }
        public string VocabularyVersion { get; set; }

        public CdmSource(Vendors vendor)
        {
            switch (vendor)
            {
                case Vendors.Truven_CCAE:
                    CdmSourceName = "IBM Health MarketScan® Commercial Claims and Encounters Database";
                    CdmSourceAbbreviation = "IBM CCAE";
                    SourceDescription =
                        "The IBM(R) MarketScan(R) Commercial Database (CCAE) includes health insurance claims across the continuum of care (e.g. inpatient, outpatient, outpatient pharmacy, carve-out behavioral healthcare) as well as enrollment data from large employers and health plans across the United States who provide private healthcare coverage for more than 155 million employees, their spouses, and dependents. This administrative claims database includes a variety of fee- for-service, preferred provider organizations, and capitated health plans.";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2Ff2f27aca-60f6-491d-8ed8-fff1858d178e.xml";
                    //CdmEtlReference = "http://www.ohdsi.org/web/wiki/doku.php?id=documentation:example_etls";
                    break;
                case Vendors.Truven_MDCR:
                    CdmSourceName = "IBM Health MarketScan® Medicare Supplemental and Coordination of Benefits Database";
                    CdmSourceAbbreviation = "IBM MDCR";
                    SourceDescription = "The IBM(R) MarketScan(R) Medicare Supplemental Database (MDCR) represents the health services of approximately 10 million retirees in the United States with Medicare supplemental coverage through employer-sponsored plans. This database contains primarily fee-for-service plans and includes health insurance claims across the continuum of care (e.g. inpatient, outpatient and outpatient pharmacy).";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F4d653f44-36f7-4ccb-a81d-a1dce3be1c62.xml";
                    //CdmEtlReference = "http://www.ohdsi.org/web/wiki/doku.php?id=documentation:example_etls";
                    break;
                case Vendors.Truven_MDCD:
                    CdmSourceName = "IBM Health MarketScan® Multi-State Medicaid Database";
                    CdmSourceAbbreviation = "IBM MDCD";
                    SourceDescription = "The IBM(R) MarketScan(R) Multi-State Medicaid Database (MDCD) reflects the healthcare service use of individuals covered by Medicaid programs in numerous geographically dispersed states. The database contains the pooled healthcare experience of Medicaid enrollees, covered under fee-for-service and managed care plans. It includes records of inpatient services, inpatient admissions, outpatient services, and prescription drug claims, as well as information on long-term care. Data on eligibility and service and provider type are also included. In addition to standard demographic variables such as age and gender, the database includes variables such as federal aid category (income based, disability, Temporary Assistance for Needy Families) and race.";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F4136471c-0662-4ca7-b091-4d6120358f74.xml";
                    //CdmEtlReference = "http://www.ohdsi.org/web/wiki/doku.php?id=documentation:example_etls";
                    break;
                case Vendors.CprdAurum:
                    CdmSourceName = "CPRD Aurum";
                    CdmSourceAbbreviation = "CPRD Aurum";
                    SourceDocumentationReference = "https://cprd.com/sites/default/files/CPRD%20Aurum%20Data%20Specification%20v2.5.pdf";
                    CdmHolder = "Erasmus MC";
                    SourceDescription = "CPRD Aurum is a UK general practioner database containing diagnosis, lab, procedure, and precriptions written data from contributing practices. This data is a sample containing 12 practices and has been converted to the OMOP Common Data Model and has been edited based on quality control measures.";
                    break;
                case Vendors.CprdV5:
                    CdmSourceName = "Clinical Practice Research Datalink (CPRD)";
                    CdmSourceAbbreviation = "CPRD";
                    SourceDescription =
                        "The Clinical Practice Research Datalink (CPRD) is a governmental, not-for-profit research service, jointly funded by the NHS National Institute for Health Research (NIHR) and the Medicines and Healthcare products Regulatory Agency (MHRA), a part of the Department of Health, United Kingdom (UK).  CPRD GOLD consists of data collected from UK primary care offices using Vision(R) software.  This includes conditions, observations, measurements, and procedures that the general practitioner is made aware of in addition to any prescriptions as prescribed by the general practitioner.";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2Fe3d6a6b5-a712-456f-9418-31b9c4f4c4fb.xml  ";
                    //CdmEtlReference = "http://www.ohdsi.org/web/wiki/doku.php?id=documentation:example_etls";
                    break;
                case Vendors.CprdCovid:
                    CdmSourceName = "Clinical Practice Research Datalink (CPRD)";
                    CdmSourceAbbreviation = "CPRD";
                    SourceDescription =
                        "CPRD GOLD primary care patients with a COVID-19 test, diagnosis, or related code from January 1, 2020 forward.  The Clinical Practice Research Datalink (CPRD) is a governmental, not-for-profit research service, jointly funded by the NHS National Institute for Health Research (NIHR) and the Medicines and Healthcare products Regulatory Agency (MHRA), a part of the Department of Health, United Kingdom (UK).  CPRD consists of data collected from UK primary care for all ages.  This includes conditions, observations, measurements, and procedures that the general practitioner is made aware of in additional to any prescriptions as prescribed by the general practitioner.  In addition to primary care, there are also linked secondary care records for a small number of people. JNJ also licenses CPRD HES APC data, available directly from CPRD based on specific patient ids.  If requiring CPRD HES OP data, an additional cost/license will be required. The rHEALTH CPRD data is updated twice per year.  There is a secondary version of this data available that is updated monthly but it is only accessible via web portal and by two JNJ users (nominated users - Amy Matcho and Chantal Holy) whom have undergone special training.  Additional access to the web-based version would be an additional fee.";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2Fe3d6a6b5-a712-456f-9418-31b9c4f4c4fb.xml  ";
                    //CdmEtlReference = "http://www.ohdsi.org/web/wiki/doku.php?id=documentation:example_etls";
                    break;
                case Vendors.PremierV5:
                case Vendors.PremierFull:
                    CdmSourceName = "Premier Healthcare Database (PHD)";
                    CdmSourceAbbreviation = "PREMIER";
                    SourceDescription = "Premier Healthcare Database (PHD) is a nationally representative all-payer US hospital database that houses data on the inpatient and outpatient visits from non-profit, non-governmental and community and teaching hospitals and health systems. The data represent 1 in 5 inpatient hospital stays in the US. It is a visit-centric, billing database where each visit is linked with a unique billing record. The database contains information on medications, laboratory procedures, diagnostic procedures, and diagnoses with day of service for medications and procedures. ";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F27adc862-0a6d-48cd-abe9-6aec4c303b29.xml";
                    //CdmEtlReference = "http://www.ohdsi.org/web/wiki/doku.php?id=documentation:example_etls";
                    break;
                case Vendors.PremierCovid:
                    CdmSourceName = "Premier Covid Healthcare Database";
                    CdmSourceAbbreviation = "PREMIER COVID";
                    SourceDescription = "Premier Healthcare Database (PHD) is a nationally representative all-payer US hospital database that houses data on the inpatient and outpatient visits from non-profit, non-governmental and community and teaching hospitals and health systems. The data represent 1 in 5 inpatient hospital stays in the US. It is a visit-centric, billing database where each visit is linked with a unique billing record. The database contains information on medications, laboratory procedures, diagnostic procedures, and diagnoses with day of service for medications and procedures. ";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F27adc862-0a6d-48cd-abe9-6aec4c303b29.xml";
                    //CdmEtlReference = "http://www.ohdsi.org/web/wiki/doku.php?id=documentation:example_etls";
                    break;
                case Vendors.JMDCv5:
                    CdmSourceName = "Japan Medical Data Center (JMDC)";
                    CdmSourceAbbreviation = "JMDC";
                    SourceDescription = "JMDC database is a payer based database that has collected claims, ledger of the insured people and health checkup results from more than 250 payers. It covers workers and their dependents aged under 74. It is longitudinal and the largest one as commercially available database in Japan with more than 13 million enrollments. All medical history of the insured people are available and patient reported outcome research can be done through payers on-demand basis. Those aged 66 or older are less representative as compared with whole population in the nation. When estimated among the people who are younger than 66 years old, the proportion of children younger than 18 years old in JMDC is approximately the same as the proportion in the whole nation. Claims data are derived from monthly claims issued by clinics, hospitals and community pharmacies. The number of claims issued and added to JMDC database is about 6,000,000 per month. The size of JMDC population is about 6% of the whole nation.";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F06d7e4d1-6000-4779-bdc9-16ace880912a.xml";
                    //CdmEtlReference = "https://github.com/OHDSI/ETL-CDMBuilder";
                    break;
                case Vendors.OptumExtendedSES:
                    CdmSourceName = "Optum’s  Clinformatics® Extended Data Mart – Socio-Economic Status (SES)";
                    CdmSourceAbbreviation = "OPTUM Extended SES";
                    SourceDescription = "Optum‘s Clinformatics(R) Data Mart is derived from a database of administrative health claims for members of large commercial and Medicare Advantage health plans.The database includes approximately 17-19 million annual covered lives, for a total of over 65 million unique lives over a 12 year period (1/2007 through 12/2019). Clinformatics(R) Data Mart is statistically de-identified under the Expert Determination method consistent with HIPAA and managed according to Optum(R) customer data use agreements. CDM administrative claims submitted for payment by providers and pharmacies are verified, adjudicated and de-identified prior to inclusion. This data, including patient-level enrollment information, is derived from claims submitted for all medical and pharmacy health care services with information related to healthcare costs and resource utilization. The population is geographically diverse, spanning all 50 states.  Optum Clinformatics(R) Data Mart Socio-Economic Status (Optum SES) provides socio-economic status for members with both medical and pharmacy coverage and location information for patients at the US Census Division level. ";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2Fd27742b7-6a17-4a6c-96f4-a4c5a486155a.xml";
                    //CdmEtlReference = "https://github.com/OHDSI/ETL-CDMBuilder/tree/master/man";
                    break;
                case Vendors.OptumExtendedDOD:
                    CdmSourceName = "Optum’s  Clinformatics® Extended Data Mart – Date of Death (DOD)";
                    CdmSourceAbbreviation = "OPTUM Extended DOD";
                    SourceDescription = "Optum‘s Clinformatics(R) Data Mart is derived from a database of administrative health claims for members of large commercial and Medicare Advantage health plans.The database includes approximately 17-19 million annual covered lives, for a total of over 65 million unique lives over a 12 year period (1/2007 through 12/2019). Clinformatics(R) Data Mart is statistically de-identified under the Expert Determination method consistent with HIPAA and managed according to Optum(R) customer data use agreements. CDM administrative claims submitted for payment by providers and pharmacies are verified, adjudicated and de-identified prior to inclusion. This data, including patient-level enrollment information, is derived from claims submitted for all medical and pharmacy health care services with information related to healthcare costs and resource utilization. The population is geographically diverse, spanning all 50 states.  Optum Clinformatics(R) Data Mart Data of Death (Optum DOD) also provides date of death (month and year only) for members with both medical and pharmacy coverage from the Social Security Death Master File (however after 2011 reporting frequency changed due to changes in reporting requirements) and location information for patients is at the US state level. ";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F5115ce8f-54d7-46f8-bef5-7fba67943b75.xml";
                    //CdmEtlReference = "https://github.com/OHDSI/ETL-CDMBuilder/tree/master/man";
                    break;
                case Vendors.OptumPantherFull:
                    CdmSourceName = "Optum EHR";
                    CdmSourceAbbreviation = "Optum EHR";
                    SourceDescription =
                        "Optum‘s longitudinal EHR repository is derived from dozens of healthcare provider organizations in the United States, that include more than 700 Hospitals and 7000 Clinics; treating more than 102 million patients receiving care in the United States. The data is certified as de-identified by an independent statistical expert following HIPAA statistical de-identification rules, and managed according to Optum(R) customer data use agreements. Clinical, claims and other medical administrative data is obtained from both Inpatient and Ambulatory electronic health records (EHRs), practice management systems and numerous other internal systems. Information is processed, normalized, and standardized across the continuum of care from both acute inpatient stays and outpatient visits. Optum(R) data elements include: demographics, medications prescribed and administered, immunizations, allergies, lab results (including microbiology), vital signs and other observable measurements, clinical and inpatient stay administrative data and coded diagnoses and procedures. In addition, Optum(R) uses natural language processing (NLP) computing technology to transform critical facts from physician notes into usable datasets. The NLP data provides detailed information regarding signs and symptoms, family history, disease related scores (i.e. RAPID3 for RA, or CHADS2 for stroke risk), genetic testing, medication changes, and physician rationale behind prescribing decisions that might never be recorded in the EHR.";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F0863f562-32bb-45cb-bd91-4210bd5b1e11.xml";
                    //CdmEtlReference = "https://github.com/OHDSI/ETL-CDMBuilder/tree/master/man/OPTUM_PANTHER/v5.3.1/ETL";
                    break;
                case Vendors.OptumPantherCovid:
                    CdmSourceName = "Optum EHR Covid Cut";
                    CdmSourceAbbreviation = "Optum EHR Covid";
                    SourceDescription =
                        "Optum‘s longitudinal, low-latency COVID-19 EHR data is derived from a network of healthcare provider organizations across the United States. The data is certified as de-identified by an independent statistical expert following HIPAA statistical de-identification rules and managed according to Optum(R) customer data use agreements. The COVID-19 data assetincorporates clinical and medical administrative data from both Inpatient and Ambulatory electronic medical records (EMRs), practice management systems and numerous other internal systems. Information is processed from across the continuum of care, including acute inpatient stays and outpatient visits. The COVID-19 data captures point of care diagnostics specific to the COVID-19 patient during initial presentation, acute illness and convalescence with over 500 mapped labs and bedside observations, including COVID -19 specific testing." +
"The Optum COVID - 19 data elements include patient level information: demographics, mortality, as well as clinical interventions such as medications prescribed and administered.The Data is comprised of multiple tables that can be linked by a common patient identifier(anonymous, randomized string of characters).The COVID - 19 patient base includes all patients in the Electronic Health Record Database from January 2007 through to the most current data period available";
                    SourceDocumentationReference = "https://catalog.rwe.jnj.com/index#jnjsearches?dataSetUri=%2Fdataset%2F0863f562-32bb-45cb-bd91-4210bd5b1e11.xml";
                    //CdmEtlReference = "https://github.com/OHDSI/ETL-CDMBuilder/tree/master/man/OPTUM_PANTHER/v5.3.1/ETL";
                    break;
                case Vendors.HealthVerity:
                case Vendors.HealthVerityCovid:
                    CdmSourceName = "Health Verity Comprehensive Claims and EHR Closed Claims Enrollment";
                    CdmSourceAbbreviation = "Health Verity CC EHR CCE";
                    SourceDescription = "The HealthVerityCC EHR CCE derived data set contains de-identified linked patient information from select private data providers participating in the HealthVerity marketplace. This data extract includes 2 data sources across medical and pharmacy closed claims data, 3 sources providing open medical claims, 6 sources providing open pharmacy claims, 3 sources providing electronic medical record data from primary and specialty care, COVID vaccination records from commercial pharmacies, state COVID immunization records from California and Louisiana, as well as hospital chargemaster transactional records for inpatient and outpatient hospital encounters, and 2 sources providing laboratory data. During the transformation to the OMOP CDM, only patients with enrollment in one of the two closed claims sources are included.";
                    SourceDocumentationReference = "https://sourcecode.jnj.com/projects/ITX-ASJ/repos/healthverity_etl/browseNone";
                    //CdmEtlReference = "https://sourcecode.jnj.com/projects/ITX-ASJ/repos/healthverity_etl/browse";
                    CdmHolder = "Janssen R&D";
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(vendor), vendor, null);
            }

            CdmHolder = "Janssen R&D";
            CdmReleaseDate = DateTime.Now;
            CdmVersion = "v5.4";
        }
    }
}
