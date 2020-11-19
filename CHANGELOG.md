# Unreleased

Added
 * AZ-377: Core tools as documented sub-module

Updated
 * AZ-381: Harmonize variables and add outputs
 * AZ-380: AKS module: pin velero azure image
 * AZ-379: Fix kured chart repository
 * AZ-382: Update of Kured chart version
 
# v3.2.0 - 2020-10-20

Fixed
  * AZ-251: Update velero helm chart to 2.12.13
  * AZ-251: Align velero 1.4.0 to main branch of velero-plugin-for-microsoft-azure to work with managed identities
  * AZ-251: Remove hack for velero pod labels since it's now supported in chart v2.12.13
  * AZ-252: Update AGIC helm chart to 1.2.0 final
  * AZ-254: Application gateway creation fail with default parameters.
  
Added
  * AZ-253: Update to last stable version of AKS by default.
  
# v3.1.0 - 2020-07-31

Breaking
  * AZ-229: Replace deprecated Services Principals by Managed Identity

Fixed
  * AZ-237: `appgw_subnet_id` variable must not be mandatory
  
# v3.0.0 - 2020-07-03

Added
  * AZ-123: First version of the AKS module.

