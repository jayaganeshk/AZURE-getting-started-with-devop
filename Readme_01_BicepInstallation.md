# Azure Installation

1. [Setting Up](#setting-up)
    1. Installing Azure CLI
    2. Installing Azure Bicep
    3. Logging in to Azure CLI

2. [Further Reading](#further-reading)


## Setting up
Installing Azure CLI:

Powershell Command
```# Create the install folder
$installPath = "$env:USERPROFILE\.bicep"
$installDir = New-Item -ItemType Directory -Path $installPath -Force
$installDir.Attributes += 'Hidden'
# Fetch the latest Bicep CLI binary
(New-Object Net.WebClient).DownloadFile("https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe", "$installPath\bicep.exe")
# Add bicep to your PATH
$currentPath = (Get-Item -path "HKCU:\Environment" ).GetValue('Path', '', 'DoNotExpandEnvironmentNames')
if (-not $currentPath.Contains("%USERPROFILE%\.bicep")) { setx PATH ($currentPath + ";%USERPROFILE%\.bicep") }
if (-not $env:path.Contains($installPath)) { $env:path += ";$installPath" }
# Verify you can now access the 'bicep' command.
bicep --help
# Done!
```

[https://github.com/Azure/bicep/blob/main/docs/installing.md#windows-installer](https://github.com/Azure/bicep/blob/main/docs/installing.md#windows-installer)


## Installing Bicep

Install Azure Bicep Using Azure CLI
```
az bicep install
```
<br>

> Other Installation: [refer this link](https://github.com/Azure/bicep/blob/main/docs/installing.md)


<h1>


## AZ Login
```
az login
```
>[Refer here](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli)


# Further Reading

* https://4bes.nl/2021/04/18/step-by-step-deploy-bicep-with-azure-devops-pipelines/

* https://github.com/Azure/bicep/tree/main/docs/tutorial

* https://docs.microsoft.com/en-us/learn/modules/deploy-azure-resources-by-using-bicep-templates/?WT.mc_id=AZ-MVP-5003674