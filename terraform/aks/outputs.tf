output "resource_group" {
  value = "${azurerm_resource_group.kubernetes_cluster_group.name}"
}

output "cluster_name" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.name}"
}

output "registry_login_server" {
  value = "${azurerm_container_registry.container_registry.login_server}"
}

output "registry_admin_username" {
  value = "${azurerm_container_registry.container_registry.admin_username}"
}

output "registry_admin_password" {
  value = "${azurerm_container_registry.container_registry.admin_password}"
}