param environment string
param location string = 'eastus'
param sqlAdmin string
param sqlPassword string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'quickshop-${environment}-plan'
  location: location
  sku: {
    name: environment == 'prod' ? 'P1v2' : 'B1'
    tier: environment == 'prod' ? 'PremiumV2' : 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'quickshop-web-${environment}'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource apiApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'quickshop-api-${environment}'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource sqlServer 'Microsoft.Sql/servers@2021-02-01' = {
  name: 'quickshop-sql-${environment}'
  location: location
  properties: {
    administratorLogin: sqlAdmin
    administratorLoginPassword: sqlPassword
  }
}

resource sqlDb 'Microsoft.Sql/servers/databases@2021-02-01' = {
  parent: sqlServer
  name: 'quickshopdb'
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
  }
}
