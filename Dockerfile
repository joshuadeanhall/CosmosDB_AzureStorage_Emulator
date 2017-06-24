# CosmosDB Emulator Dockerfile

# Indicates that the windowsservercore image will be used as the base image.
FROM microsoft/windowsservercore

# Metadata indicating an image maintainer.
MAINTAINER joshuadeanhall@gmail.com

# Add the CosmosDB installer msi into the package
ADD https://aka.ms/cosmosdb-emulator c:\\CosmosDBEmulator\\AzureCosmosDB.Emulator.msi

# Add the Storage Emulator installer msi into the package
ADD https://go.microsoft.com/fwlink/?linkid=717179&clcid=0x409 c:\\StorageEmulator\\MicrosoftAzureStorageEmulator.msi
ADD https://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SqlLocalDB.MSI c:\\LocalDB\\SqlLocalDB.msi



# Copy misc scripts into the package
COPY package_scripts\\startemu.cmd c:\\StorageEmulator\\startemu.cmd
COPY package_scripts\\getaddr.ps1 c:\\CosmosDBEmulator\\getaddr.ps1
COPY package_scripts\\changeconfig.ps1 c:\\CosmosDBEmulator\\changeconfig.ps1
COPY package_scripts\\exportcert.ps1 c:\\CosmosDBEmulator\\exportcert.ps1
COPY package_scripts\\importcert.ps1 c:\\CosmosDBEmulator\\importcert.ps1


# Install the MSI for Cosmos
RUN echo "Starting Installer For CosmosDB"
RUN powershell.exe -Command $ErrorActionPreference = 'Stop'; \
   Start-Process 'msiexec.exe' -ArgumentList '/i','c:\CosmosDBEmulator\AzureCosmosDB.Emulator.msi','/qn' -Wait
RUN echo "Installer Done"

# Install the MSI
RUN echo "Starting Installer For Azure Storage"
RUN powershell.exe -Command $ErrorActionPreference = 'Stop'; \
   Start-Process 'msiexec.exe' -ArgumentList '/i','c:\StorageEmulator\MicrosoftAzureStorageEmulator.msi','/qn' -Wait
RUN echo "Installer Done"

RUN echo "Starting Installer for SQL"
	RUN ["cmd", "/S", "/C", "c:\\windows\\syswow64\\msiexec", "/i", "c:\\LocalDB\\SqlLocalDB.msi", "IACCEPTSQLLOCALDBLICENSETERMS=YES", "/qn"]  
RUN echo "Installer Done"
# Expose the required network ports
EXPOSE 8081
EXPOSE 10250
EXPOSE 10251
EXPOSE 10252
EXPOSE 10253
EXPOSE 10254
EXPOSE 10000
EXPOSE 10001
EXPOSE 10002

# Start the interactive shell
CMD [ "c:\\StorageEmulator\\startemu.cmd" ]


