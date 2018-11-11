variable "password" {}

resource "azurerm_azuread_application" "aks_application" {
  name                       = "example"
  homepage                   = "https://homepage"
  identifier_uris            = ["https://uri"]
  reply_urls                 = ["https://replyurl"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

resource "azurerm_azuread_service_principal" "aks_service_principal" {
  application_id = "${azurerm_azuread_application.aks_application.application_id}"
}

resource "azurerm_azuread_service_principal_password" "aks_service_principal" {
  service_principal_id = "${azurerm_azuread_service_principal.aks_service_principal.id}"
  value                = "${var.password}"
  end_date             = "2020-01-01T01:02:03Z"
}