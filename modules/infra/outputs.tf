output "aad_pod_identity_namespace" {
  description = "Namespace used for AAD Pod Identity"
  value       = kubernetes_namespace.add_pod_identity.metadata.0.name
}

output "aad_pod_identity_azure_identity" {
  description = "Identity object for AAD Pod Identity"
  value       = azurerm_user_assigned_identity.aad_pod_identity
}

output "aad_pod_identity_id" {
  value = azurerm_user_assigned_identity.aad_pod_identity.id
}

output "aad_pod_identity_client_id" {
  value = azurerm_user_assigned_identity.aad_pod_identity.client_id
}

output "add_pod_identity_principal_id" {
  value = azurerm_user_assigned_identity.aad_pod_identity.principal_id
}
