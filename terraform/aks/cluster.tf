resource "random_integer" "unique_number" {
  min     = 1
  max     = 999
}

resource "azurerm_resource_group" "kubernetes_cluster_group" {
  name     = "Kubernetes_Cluster"
  location = "West Europe"
}

resource "azurerm_container_registry" "container_registry" {
  name                = "cygniacr${random_integer.unique_number.result}"
  resource_group_name = "${azurerm_resource_group.kubernetes_cluster_group.name}"
  location            = "${azurerm_resource_group.kubernetes_cluster_group.location}"
  admin_enabled       = true
  sku                 = "Standard"
}

resource "azurerm_role_assignment" "acr_reader" {
  scope                = "${azurerm_container_registry.container_registry.id}"
  role_definition_name = "Reader"
  principal_id         = "${azurerm_azuread_service_principal.aks_sp.id}"
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = "cygniaks${random_integer.unique_number.result}"
  location            = "${azurerm_resource_group.kubernetes_cluster_group.location}"
  resource_group_name = "${azurerm_resource_group.kubernetes_cluster_group.name}"
  dns_prefix          = "cygniaks${random_integer.unique_number.result}"

  agent_pool_profile {
    name            = "default"
    count           = 3
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     =  "${azurerm_azuread_service_principal.aks_sp.application_id}"
    client_secret = "${random_string.aks_sp_password.result}"
  }
}