# CosmosDB_AzureStorage_Emulator
A docker setup for running CosmosDB and Azure Storage to make local development easier.


Improve README



How to setup.

1. docker pull joshuadeanhall/cosmosdb_storage_emulator
2. md %LOCALAPPDATA%\CosmosDBEmulatorCert 2>nul
3. docker run -v %LOCALAPPDATA%\CosmosDBEmulatorCert:c:\CosmosDBEmulator\CosmosDBEmulatorCert -P -t -i joshuadeanhall/cosmosdb_storage_emulator
4. Copy ip from output
5. cd %LOCALAPPDATA%\CosmosDBEmulatorCert
6. powershell .\importcert.ps1
7. Setup CosmosDb Client with Key and endpoint.  In C# : var client = new DocumentClient(new Uri($"https://{ip}:8081/"), "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==");
8. Setup Storage Account with IP and Dev Key. In C# : var storageAccount = CloudStorageAccount.Parse($"DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://{ip}:10000/devstoreaccount1;TableEndpoint=http://{ip}:10002/devstoreaccount1;QueueEndpoint=http://{ip}:10001/devstoreaccount1;");
