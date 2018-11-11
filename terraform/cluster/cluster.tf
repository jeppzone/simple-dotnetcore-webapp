variable "service_principal_client_id" {}

variable "service_principal_password" {}

resource "random_integer" "unique_number" {
  min     = 1
  max     = 999
}

resource "azurerm_resource_group" "kubernetes_cluster_group" {
  name     = "Kubernetes_Cluster"
  location = "West Europe"
}

resource "azurerm_container_registry" "container_registry" {
  name                = "klasacr${random_integer.unique_number.result}"
  resource_group_name = "${azurerm_resource_group.kubernetes_cluster_group.name}"
  location            = "${azurerm_resource_group.kubernetes_cluster_group.location}"
  admin_enabled       = true
  sku                 = "Classic"
  storage_account_id  = "${azurerm_storage_account.storage_account.id}"
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = "klasaks${random_integer.unique_number.result}"
  location            = "${azurerm_resource_group.kubernetes_cluster_group.location}"
  resource_group_name = "${azurerm_resource_group.kubernetes_cluster_group.name}"
  dns_prefix          = "klasaks${random_integer.unique_number.result}"

  agent_pool_profile {
    name            = "default"
    count           = 3
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     =  "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_password}"
  }

  tags {
    Environment = "Development"
  }
}