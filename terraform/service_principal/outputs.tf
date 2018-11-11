output "application_id" {
  value = "${azurerm_azuread_application.aks_application.application_id}"
}

output "password" {
  value = "${var.password}"
}