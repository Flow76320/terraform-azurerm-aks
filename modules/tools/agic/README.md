# Azure Kubernetes Service - Application Gateway Ingress Controller tool submodule
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/aks/azurerm)

This module allows you to create an application gateway ingress controller with its associated Application Gateway v2 on an existing AKS cluster.

## Version compatibility

| Module version    | Terraform version | AzureRM version | Helm version | Kubernetes version |
|-------------------|-------------------|-----------------|--------------|--------------------|
| >= 3.x.x          | 0.12.x            | >= 2.0          | = 1.1.1      | ~> 1.11.1          |
| >= 2.x.x, < 3.x.x | 0.12.x            | <  2.0          | N/A          | N/A                |
| <  2.x.x          | 0.11.x            | <  2.0          | N/A          | N/A                |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "rg" {
  source  = "claranet/rg/azurerm"
  version = "3.0.0"

  location    = module.azure-region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  custom_rg_name = local.support_bastion_rg_name
}

module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "3.0.0"

  azure_region = var.azure_region
}

module "agic" {
  source = "claranet/aks/azurerm//modules/tools/agic"
  
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  resource_group_name = module.rg.resource_group_name
  location            = module.azure-region.location
  location_short      = module.azure-region.location_short

  appgw_subnet_id = '/subscriptions/xxxxxxx/xxxxx/xxxxxxx'
  appgw_ingress_contoller_values = { "verbosityLevel" = "5" }
  app_gateway_tags = {"tag1" = "value1"}

  aks_aad_pod_identity_id           = "/subscription/xxx/xxx/xxx"
  aks_aad_pod_identity_client_id    = "xxx-xxxxx-xxxx-xxxx"
  aks_aad_pod_identity_principal_id = "xxxx-xxxx-xxxx-xxxx"
  aks_name = "MyClusterName"

  diagnostics = {
    enabled       = true
    destination   = "/subscription/xxx/xxx/workspace/id"
    eventhub_name = null
    logs          = ["all"]
    metrics       = ["all"]
  }

}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| agic\_chart\_repository | Helm chart repository URL | `string` | `"https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/"` | no |
| agic\_chart\_version | Version of the Helm chart | `string` | `"1.2.0"` | no |
| agic\_helm\_version | [DEPRECATED] Version of Helm chart to deploy | `string` | `null` | no |
| aks\_aad\_pod\_identity\_client\_id | AAD Identity client\_id used by AKS | `string` | n/a | yes |
| aks\_aad\_pod\_identity\_id | AAD Identity id used by AKS | `string` | n/a | yes |
| aks\_aad\_pod\_identity\_principal\_id | AAD Identity principal\_id used by AKS | `string` | n/a | yes |
| aks\_name | Name of the AKS Cluster attached to this APPGW | `string` | n/a | yes |
| app\_gateway\_subnet\_id | ID of the subnet to use with the application gateway | `string` | n/a | yes |
| app\_gateway\_tags | Tags to apply on the Application gateway | `map(string)` | n/a | yes |
| appgw\_backend\_http\_settings | List of maps including backend http settings configurations | `any` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| appgw\_backend\_pools | List of maps including backend pool configurations | `any` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| appgw\_http\_listeners | List of maps including http listeners configurations | `list(map(string))` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| appgw\_ingress\_values | Application Gateway Ingress Controller settings | `map(string)` | `{}` | no |
| appgw\_probes | List of maps including request probes configurations | `any` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| appgw\_redirect\_configuration | List of maps including redirect configurations | `list(map(string))` | `[]` | no |
| appgw\_rewrite\_rule\_set | Application gateway's rewrite rules | `any` | `[]` | no |
| appgw\_routings | List of maps including request routing rules configurations | `list(map(string))` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| appgw\_url\_path\_map | List of maps including url path map configurations | `any` | `[]` | no |
| authentication\_certificate\_configs | List of maps including authentication certificate configurations | `list(map(string))` | `[]` | no |
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| diag\_custom\_name | Custom name for Azure Diagnostics for AKS. | `string` | `null` | no |
| diagnostics | Enable diagnostics logs on AKS | <pre>object({<br>    enabled       = bool,<br>    destination   = string,<br>    eventhub_name = string,<br>    logs          = list(string),<br>    metrics       = list(string)<br>  })</pre> | n/a | yes |
| disabled\_rule\_group\_settings | Appgw WAF rules group to disable. | <pre>list(object({<br>    rule_group_name = string<br>    rules           = list(string)<br>  }))</pre> | `[]` | no |
| enable\_agic | Enable application gateway ingress controller | `bool` | `true` | no |
| enabled\_waf | Enable WAF or not | `bool` | `false` | no |
| environment | Project's environment | `string` | n/a | yes |
| file\_upload\_limit\_mb | WAF configuration of the file upload limit in MB | `number` | `100` | no |
| firewall\_mode | Appgw WAF mode | `string` | `"Detection"` | no |
| frontend\_ip\_configuration\_name | Name of the appgw frontend ip configuration | `string` | n/a | yes |
| frontend\_port\_settings | Appgw frontent port settings | `list(map(string))` | <pre>[<br>  {<br>    "fake": "fake"<br>  }<br>]</pre> | no |
| gateway\_ip\_configuration\_name | Name of the appgw gateway ip configuration | `string` | n/a | yes |
| ip\_allocation\_method | Allocation method of the IP address | `string` | `"Static"` | no |
| ip\_label | Domain name for the public ip address | `string` | n/a | yes |
| ip\_name | Name of the applications gateway's public ip address | `string` | n/a | yes |
| ip\_sku | SKU of the public ip address | `string` | `"Standard"` | no |
| ip\_tags | Specific tags for the public ip address | `map(string)` | n/a | yes |
| location | Location of application gateway | `string` | n/a | yes |
| location\_short | Short name of Azure regions to use | `any` | n/a | yes |
| max\_request\_body\_size\_kb | WAF configuration of the max request body size in KB | `number` | `128` | no |
| name | Name of the application gateway | `string` | n/a | yes |
| name\_prefix | prefix used in naming | `string` | `""` | no |
| policy\_name | Name of the SSLPolicy to use with Appgw | `string` | `"AppGwSslPolicy20170401S"` | no |
| request\_body\_check | WAF should check the request body | `bool` | `true` | no |
| resource\_group\_name | Name of the resource group in which to deploy the application gateway | `string` | n/a | yes |
| rule\_set\_type | WAF rules set type | `string` | `"OWASP"` | no |
| rule\_set\_version | WAF rules set version | `string` | `"3.0"` | no |
| sku\_capacity | Application gateway's SKU capacity | `string` | `2` | no |
| sku\_name | Application gateway's SKU name | `string` | `"Standard_v2"` | no |
| sku\_tier | Application gateway's SKU tier | `string` | `"Standard_v2"` | no |
| ssl\_certificates\_configs | List of maps including ssl certificates configurations | `list(map(string))` | `[]` | no |
| stack | Project's stack | `string` | n/a | yes |
| trusted\_root\_certificate\_configs | Trusted root certificate configurations | `list(map(string))` | `[]` | no |
| waf\_exclusion\_settings | Appgw WAF exclusion settings | `list(map(string))` | `[]` | no |
| zones | Application gateway's Zones to use | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_gateway\_id | Application gateway Id |
| application\_gateway\_name | Application gateway name |
| namespace | Namespace used for AGIC |
| public\_ip\_id | Application gateway public ip Id |
| public\_ip\_name | Application gateway public ip name |

## Related documentation

- Terraform Azure Application gateway documentation: [terraform.io/docs/providers/azurerm/r/application_gateway.html](https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html)
- Azure application gateway documentation : [docs.microsoft.com/en-us/azure/application-gateway/overview](https://docs.microsoft.com/en-us/azure/application-gateway/overview)
- Helm AGIC documentation : [azure.github.io/application-gateway-kubernetes-ingress/](https://azure.github.io/application-gateway-kubernetes-ingress/)
