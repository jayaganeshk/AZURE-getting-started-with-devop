param resourcePrefix string
param currentDate string = utcNow('yyyy-MM-dd')

var tagValues = {
  CreatedBy: 'BICEPDeployment'
  deploymentDate: currentDate
}

module sta 'Modules/storageAccount.bicep' = {
  name: 'sta'
  params: {
    storageAccountPrefix: resourcePrefix
    tagValues: tagValues
  }
}
