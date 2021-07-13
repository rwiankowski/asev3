param location string         = resourceGroup().location

param aseLbMode int           = 3
param aseName string
param aseSubnetName string    = 'AppServiceEnvironmentSubnet'
param aseVnetId string
param aseZoneRedundancy bool  = true

var aseSubnetId  = '${aseVnetId}/Subnets/${aseSubnetName}'
resource ase 'Microsoft.Web/hostingEnvironments@2021-01-01' = {  
  name: aseName
  location: location
  kind: 'ASEV3'
  properties: {
    dnsSuffix: '${aseName}.appserviceenvironment.net'
    internalLoadBalancingMode: aseLbMode
    virtualNetwork: {
      id: aseSubnetId
    }
    zoneRedundant: aseZoneRedundancy
  }
}
