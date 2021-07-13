param location string                  = resourceGroup().location

param appServicePlanName string
param appServicePlanKind string        = 'linux'
param appServicePlanSku object         = {
  Name: 'I1v2'
  tier: 'IsolatedV2'
}
param appServicePlanWorkerCount string = '3'
param appServicePlanWorkerSize string  = '6'
param hostingEnvironmentId string      = ''

var hostingEnvironmentProfile = {
  id: hostingEnvironmentId
}

resource appServicePlanName_resource 'Microsoft.Web/serverfarms@2019-08-01' = {
  kind: appServicePlanKind
  name: appServicePlanName
  location: location
  properties: {
    hostingEnvironmentProfile: empty(hostingEnvironmentId) ? json('null') : hostingEnvironmentProfile
    perSiteScaling: false
    reserved: false
    targetWorkerCount: appServicePlanWorkerCount
    targetWorkerSizeId: appServicePlanWorkerSize
  }
  sku: appServicePlanSku
}
