output "service_principal_id" {
  value = "${azurerm_azuread_service_principal.aks_service_principal.id}"
}

output "service_principal_password" {
  value = "${var.service_principal_password}"
}