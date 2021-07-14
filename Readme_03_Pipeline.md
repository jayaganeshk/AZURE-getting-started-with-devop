# Azure DevOps

Getting started with Azure Devops by deploying a bicep file with pipeline

# Index

1. [Azure DevOps Connection](#azure-devops-connection)
2. [Create a repository](#create-a-repository)
3. [Create an environment](#create-an-environment)
4. [Create a new pipeline](#create-a-new-pipeline)

<br>

# Azure DevOps Connection

### **Create the service principal**

In CloudShell execute the following command to create a Service Principal
```
New-AzADServicePrincipal -DisplayName Gtaa-DevOp-Connection
```

### **Create a secret for the Service pricipal**

Click App registrations. Here you will find your new service principal. Open the service principal and select Certificates and secrets in the menu.
<br>

### **Set permissions**
* The service principal needs permissions to work. It needs Reader rights on the subscription level. After that, you can provide it with the RBAC role of your choice
* And Contributor on a specific Resource group to which we will be deploying out resource to.

### **Creating the connection in Azure DevOps**
Open your Azure DevOps organization in a different tab. Open the project that gets the connection and click Project settings at the bottom left. In the menu that pops up, click Service Connections.
* Click New service connection in the top corner
* After that, click Azure Resource Manager.
* Enter the connection name and paste the Secret in the field Service principal key
*  Use below code to get the other field details

```
$SPName = "gtaa-test"
$AzSubscriptionName = "gtaa-test"

$Subscription = (Get-AzSubscription -SubscriptionName $AzSubscriptionName)

$SubscriptionID = $Subscription.Id
$spId = (Get-AzADServicePrincipal -DisplayName $SPName).ApplicationId
$TenantId = $Subscription.TenantId


Write-Output "  SubscriptionID: $SubscriptionID 
Subscription Name: $AzSubscriptionName
Service Principal Client ID: $spId
Tenant ID: $TenantId "
```
* click “verify connection” to make sure it worked.


# Create a repository

Push all the Bicep Files to an azure repo

<br>

# Create an environment
*  Open your Azure DevOps project and in the menu select Pipelines > Environments.
* Click Create environment
* Now give the environment a descriptive name and Leave Resource at None. Click Create to activate the environment.

<br>

# Create a new pipeline
* In the menu on the left, open Pipelines and then again pipelines click Create Pipeline to get started.
* Source:
    * Click **Azure Repos Git**
    * select the repository where your code is stored
* Configure Your Pipeline
    * select **Starter pipeline**
    * Use azure-pipelines.yml file
* To Manually add tasks ref below and this [link](https://4bes.nl/2020/06/14/step-by-step-setup-a-cicd-pipeline-in-azure-devops-for-arm-templates/)

| Deployment scope 	| ResourceGroup 	|  	|  	|  	|
|---	|---	|---	|---	|---	|
| Azure Resource Manager Connection 	| Select the name of the connection you created before 	|  	|  	|  	|
| Subscription 	| Select the subscription you want to use from the drop down menu. Don’t see that subscription? Check the permissions of your Service Principal. 	|  	|  	|  	|
| Action 	| Create or update resource group 	|  	|  	|  	|
| Resourcegroup 	| Select one from the drop down menu or type a name for a new one. For this example I use “ARMDeploymentTest“ 	|  	|  	|  	|
| Location 	| Select the location for your resourcegroup 	|  	|  	|  	|
| Template 	| The Path to the Template. To refer to the root folder, use $(Build.SourcesDirectory). After that enter the path in your repository. For our example, you use $(Build.SourcesDirectory)/StorageAccount/azuredeploy.json 	|  	|  	|  	|
| Template Parameters 	| As with the template, you use $(Build.SourcesDirectory)/StorageAccount/azuredeploy.parameters.json 	|  	|  	|  	|
| Override template parameters 	| Here you are able to create new parameters for the deployment. For example, you could paste -StorageAccounPrefix “examp” here to use that as your storage account prefix. This can make your deployment a lot more flexible. For this example we will leave it empty 	|  	|  	|  	|
| Deployment Mode 	| Validation only 	|  	|  	|  	|

# Reference
https://4bes.nl/2019/07/11/step-by-step-manually-create-an-azure-devops-service-connection-to-azure/