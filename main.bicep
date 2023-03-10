//az deployment sub create --template-file main.bicep --location uksouth

param rgName string = 'biceptest'
param location string = 'uksouth'

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module storageaccounts 'modules/storageaccounts.bicep' = {
  name: 'storageaccounts'
  params: {
    location: rg.location
    name: 'tastoragebicep'
  }
  scope: rg
}

module appservice 'modules/appservice.bicep' = {
  name: 'appservice'
  params: {
    location: rg.location
    webAppName: 'tawebbicep'
    sku: 'B2'
    linuxFxVersion: 'DOTNETCORE|6.0'
  }
  scope: rg
}
