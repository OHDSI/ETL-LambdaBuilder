# ETL-LambdaBuilder
CDM Builder leveraging AWS Lambda 

Getting Started
===============

The ETL-LambdaBuilder consist of 2 AWS Lambda fuctions and the ETL command line tool:
 - the ETL command line tool - split source dataset (Redshift) to chunks, move data to S3 bucket and triggers AWS Lambda functions
 - CDM Builder function - convert native data from S3 bucket to CDM 5.4 format and store result to S3 result bucket as .csv files
 - Merge function - used for aggregation of the following tables: fact_relationship, metadata. 

Prerequisites:
- Visual Studio 2022
- AWS Toolkit for Visual Studio [Toolkit](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.AWSToolkitforVisualStudio2022)
- .NET 8.0 [.net](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)

## Publish to Lambda

1. Open org.ohdsi.cdm.sln with Visual Studio
2. In AWS Explorer setup your AWS Profile, Menu: View -> AWS Explorer. (see, if not installed [Toolkit](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.AWSToolkitforVisualStudio2022))
   
  ![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/8b27f941-74f3-4f25-9a65-aea0d7655b04) 
  
3. Right mouse click and click Publish to AWS lambda... on org.ohdsi.cdm.presentation.lambdabuilder project in the Solution Explorer
   
  ![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/be6ccbd8-490e-4964-9a5d-920f488114ad)
  
4. Use following settings:
- Runtime: .NET8
- Architecture: ARM
- Function name: CDMBuilder
- Handler: org.ohdsi.cdm.presentation.lambdabuilder::org.ohdsi.cdm.presentation.lambdabuilder.Function::FunctionHandler
   
![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/f61c27da-c63f-43c6-ac28-cf9443c35326)

And in a similar way for the Merge function, org.ohdsi.cdm.presentation.lambdamerge project
- Runtime: .NET8
- Architecture: ARM
- Function name: Merge
- Handler: org.ohdsi.cdm.presentation.lambdamerge::org.ohdsi.cdm.presentation.lambdamerge.Function::FunctionHandler

5. Upload functions to AWS
 
## Configuring CDMBuilder Lambda function

1. Open AWS Console, Lambda functions page
2. Open CDMBuilder function
3. Add s3 trigger
- Bucket: <b>!!! Use separate bucket for trigger, all PUT events in this bucket will invoke your function</b>
- Event types: s3:ObjectCreated:Put

![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/6606536b-9935-4105-9458-615deb63916c)

4. Setup environment variables 

- Bucket:	bucket for result
- CDMFolder:	cdmCSV
- S3AwsAccessKeyId:	AccessKeyId for result bucket
- S3AwsSecretAccessKey:	SecretAccessKey for result bucket

 ![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/c7030433-1894-4019-8687-bbe2d39e66ce)

5. Setup general configuration, setting depends on source data set, below recommended settings:

- Memory 3000MB
- Ephemeral storage 2048MB
- Timeout 15min

![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/20eb37c2-3af5-448c-a162-a8c3028d338a)

## Configuring Merge Lambda function

1. Open Merge function

2. Add s3 trigger
- Bucket: Use CDMBuilder trigger bucket <b>!!! Use separate bucket for trigger, all PUT events in this bucket will invoke your function</b>
- Event types: s3:ObjectCreated:Put
- Prefix: merge/

3. Setup environment variables 
- Bucket:	bucket for result
- CDMFolder:	cdmCSV
- ResultFolder:	cdmCSV
- S3AwsAccessKeyId:	AccessKeyId for result bucket
- S3AwsSecretAccessKey:	SecretAccessKey for result bucket

4. Setup general configuration, setting depends on source data set, below recommended settings:

- Memory 3000MB
- Ephemeral storage 512MB
- Timeout 15min
  
## Publish command line tool
1. Right mouse click on org.ohdsi.cdm.presentation.etl project in Solution Explorer, Publish..

![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/3a797013-d9e6-4084-a9ec-8fa5af2cebcc)

2. Publish settings, my version of the settings below, different may be used

![image](https://github.com/OHDSI/ETL-LambdaBuilder/assets/13117785/2fc8c1da-fe59-4a22-8536-1187daead5e4)

## Add a layer to the CDMBuilder & Merge functions
1. Compress the "org.ohdsi.cdm.framework.etl.dll" file to zip archive (exists in publish folder).
2. Add new layer, #3 upload created zip file.   
![AddLayer1](https://github.com/user-attachments/assets/5e84f05a-ca9d-4eaf-a54f-7bd9fb960862)
3. Add created layer to the CDM Builder Function
![AddLayer2](https://github.com/user-attachments/assets/ef889553-fd71-4dfa-b53d-04e972420c17)
![AddLayer3](https://github.com/user-attachments/assets/015d018c-b40d-4591-9c15-228d8b735c4e)
4. Repeat previous steps for the Merge function.

## Run ETL conversion
1. Open command line tool folder
2. Update appsettings.json file with yours setting

```
{
  "AppSettings": {
    "s3_aws_access_key_id": "your result bucket access_key_id",
    "s3_aws_secret_access_key": "your result bucket secret_access_key",
    "bucket": "your result bucket",

    "s3_messages_access_key_id": "your trigger bucket access_key_id",
    "s3_messages_secret_access_key": "your trigger bucket secret_access_key",
    "messages_bucket": "your trigger bucket",
    "messages_bucket_merge": "your trigger bucket/merge",

    "raw_folder": "raw",
    "cdm_folder_csv": "cdmCSV",
    "cdm_folder": "cdmCSV",
    "vendor_settings": "",

    "spectrum_cluster": "",
    "spectrum_db": "",

    "iam_role": "",

    "parallel_queries": "1",
    "parallel_chunks": "5",

    "local_path": ""
  },
  "ConnectionStrings": {
    "Builder": "Data Source=builder.db",
    "Vocabulary": "Connection string to database that contains OHDSI Vocabulary tables (concept, concept_ancestor, source_to_concept_map...)",
    "Source": "Connection string to source database"
  }
}
```

Connection string example: 
```
Driver={Amazon Redshift (x64)};Server=your server name;Database={db};Sc={sc};UID=your user;PWD=your pswd;Port=5439;SSL=true;Sslmode=Require;UseDeclareFetch=1;Fetch=10000000;UseMultipleStatements=1
```

Following parameters {db} and {sc} will be replaced to command line parameters, during tool startup

3. Run org.ohdsi.cdm.presentation.etl with below parameters:

- vendor - name of the ETL converter (available converters: ccae, mdcr, mdcd, jmdc, cprd, premier, jmdc, dod, ses, panther)
- rawdb - name of the source database   
- rawschema - name of the source schema
- batch - size of the chunk in person numbers, tool will split native data to equivalent chunk, details below 
- new - true/false, default true, create new folder for conversion result
- skip_chunk - true/false, default false, true used in resume mode, skip or not chunk creation step
- resume - true/false, default false, in resume mode tool will convert not completed chunks
- skip_lookup - true/false, default false, lookup step creates follwoing tables: Provider, Location, Care_site
- skip_build false - true/false, default false, true - for testing purpose 
- skip_etl false - true/false, default false, true - for testing purpose 
- versionid - CDM version number, optional parameter
- skip_vocabulary - true/false, default true, false - will copy vocabulary tables to result bucket in .csv format 
- skip_cdmsource - true/false, default false, true - creates cdmsource data in s3 result bucket with vendor details
- skip_merge - true/false, default false, aggregates fact_relationship and metadata tables
- skip_validation - use true, obsolete parameter

Example: 

```
org.ohdsi.cdm.presentation.etl.exe --vendor ccae --rawdb ccae  --rawschema native --batch 500000 --new true --skip_chunk false --resume false --skip_lookup false  --skip_build false --skip_etl false --versionid 1 --skip_vocabulary true --skip_cdmsource false --skip_merge false --skip_validation true
```

### Batch size or Size of the chunk

Lambda function are limited in [memory](https://docs.aws.amazon.com/lambda/latest/operatorguide/computing-power.html)
for this reason ETL tool splitting source data to chunks, additionally chunks are divided into smaller part by number of source Redshift cluster slices.

To check number of slices use below query:

```
select node, slice from stv_slices;
```

Chunk size depended on source dataset and slice number. 
Larger size of chunk provides better performance, but can cause Out of memory error in lambda function, so to process chunk you will need to reduce chunk size or increase lambda memory.

The approximate chunk size (for 3000MB CDMBuilder function) can be calculated using this formula: 
```
batch=number of slice * 100k
```
A couple of examples of conversion time depending on cluster type for IBM CCAE:
- ra3.16xlarge, 12 nodes, 24 slices - chunk size = 250000, conversion time approximately 30h
- ra3.4xlarge, 6 nodes, 192 slices  - chunk size = 2000000, conversion time approximately 4h

ETL tool parameters example:
```
org.ohdsi.cdm.presentation.etl.exe --vendor ccae --rawdb ibm_ccae --rawschema native --batch 500000 --new true --skip_chunk false --resume false --skip_lookup false  --skip_build false --skip_etl false --versionid 1 --skip_vocabulary true --skip_cdmsource false --skip_merge false --skip_validation true
```

### Lambda function log output

When chunk data will be available on s3, etl tool will trigger function by creating N files in s3 trigger bucket, number of functions/files equivalent number of slices, etl output shouw messages like below:
```
...
[Moving raw data] Lambda functions for cuhnkId=21 were triggered | 24 functions
...
```

You can check log of each lambda function with Amazon CloudWatch, CDMBuilder and Merge function will have own log group.
File that triggered lambda will be automatically dropped if conversion was successful.

Etl tool output provide information about total number of chunks, like below:

```
...
***** Chunk ids were generated and saved, total count=36 *****
...
```

and current progress, for example:
```
*** 6:17 AM | Running: lambda 7 local 0; Validating 0; Valid 16; Timeout 0; Invalid 0; Error 0; Total 23
```

### Export CDM from s3 to Redshift

1. Create CDM database [dll](https://github.com/OHDSI/CommonDataModel/blob/main/inst/ddl/5.4/redshift/OMOPCDM_redshift_5.4_ddl.sql)
2. Use following template to move data from s3 to Redshift table

```
copy "schema_name"."cdm_table" 
from 's3://your_result_bucket/vendor_name/conversionId/cdmCSV/cdm_table/cdm_table.' 
credentials 'aws_access_key_id=your_result_bucket_access_key_id;aws_secret_access_key=your_result_bucket_secret_access_key' DELIMITER ',' CSV QUOTE AS '"' GZIP
```

## Important

- Be careful with trigger bucket <b>all PUT events in this bucket will invoke lambda function</b>
- For current implementation, all native tables that are involved in the transformation must have distribution key on person id columns (ENROLID for ibms, medrec_key for premier, patid for CPRD and etc.) 
