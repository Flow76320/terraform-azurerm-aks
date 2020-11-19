output "aks_id" {
  description = "AKS resource id"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_name" {
  description = "Name of the AKS cluster"
  value       = split("/", azurerm_kubernetes_cluster.aks.id)[8]
}

output "aks_nodes_rg" {
  description = "Name of the resource group in which AKS nodes are deployed"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "aks_nodes_pools_ids" {
  description = "Ids of AKS nodes pools"
  value       = azurerm_kubernetes_cluster_node_pool.node_pools.*.id
}

output "aks_nodes_pools_names" {
  description = "Names of AKS nodes pools"
  value       = azurerm_kubernetes_cluster_node_pool.node_pools.*.name
}

output "aks_kube_config_raw" {
  description = "Raw kube config to be used by kubectl command"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "aks_kube_config" {
  description = "Kube configuration of AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config
  sensitive   = true
}

output "aks_user_managed_identity" {
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity
  description = "The User Managed Identity used by AKS Agents"
}

##########################
# AGIC outputs
##########################
output "agic_namespace" {
  description = "Namespace used for AGIC"
  value       = module.appgw.namespace
}

output "application_gateway_id" {
  description = "Id of the application gateway used by AKS"
  value       = module.appgw.application_gateway_id
}

output "application_gateway_name" {
  description = "Name of the application gateway used by AKS"
  value       = module.appgw.application_gateway_name
}

output "public_ip_id" {
  description = "Id of the public ip used by AKS application gateway"
  value       = module.appgw.public_ip_id
}

output "public_ip_name" {
  value       = module.appgw.public_ip_name
  description = "Name of the public ip used by AKS application gateway"
}

##########################
# AAD Pod Identity outputs
##########################
output "aad_pod_identity_namespace" {
  description = "Namespace used for AAD Pod Identity"
  value       = module.infra.aad_pod_identity_namespace
}

output "aad_pod_identity_azure_identity" {
  description = "Identity object for AAD Pod Identity"
  value       = module.infra.aad_pod_identity_azure_identity
}

##########################
# Cert Manager outputs
##########################
output "cert_manager_namespace" {
  description = "Namespace used for Cert Manager"
  value       = module.certmanager.namespace
}

##########################
# Velero outputs
##########################
output "kured_namespace" {
  description = "Namespace used for Kured"
  value       = module.kured.namespace
}

##########################
# Velero outputs
##########################
output "velero_namespace" {
  description = "Namespace used for Velero"
  value       = module.velero.namespace
}

output "velero_storage_account" {
  description = "Storage Account on which Velero data is stored."
  value       = module.velero.storage_account
}

output "velero_storage_account_container" {
  description = "Container in Storage Account on which Velero data is stored."
  value       = module.velero.storage_account_container
}

output "velero_identity" {
  description = "Azure Identity used for Velero pods"
  value       = module.velero.velero_identity
}
