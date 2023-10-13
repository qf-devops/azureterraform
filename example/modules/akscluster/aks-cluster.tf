# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_pet" "prefix" {}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = var.location
  resource_group_name = var.rgname
  dns_prefix          = "${random_pet.prefix.id}-k8s"
  kubernetes_version  = "1.26.3"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }
  identity {
    type = "SystemAssigned"
  }
  # service_principal {
  #   client_id     = var.appId
  #   client_secret = var.password
  # }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "dev"
  }
}
