resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = "westus2"
}

resource "azurerm_storage_account" "tf" {
  name                     = var.storageaccountname
  resource_group_name      = azurerm_resource_group.tf.name
  location                 = azurerm_resource_group.tf.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "nonprod"
  }
}

resource "azurerm_storage_container" "tf" {
  name                  = var.containername
  storage_account_name  = azurerm_storage_account.tf.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "tf" {
  name                 = var.queuename
  storage_account_name = azurerm_storage_account.tf.name
}

resource "azurerm_storage_table" "tf" {
  name                 = var.tablename
  storage_account_name = azurerm_storage_account.tf.name
}

resource "azurerm_storage_share" "example" {
  name                 = var.filesharename
  storage_account_name = azurerm_storage_account.tf.name
  quota                = 50
  }
}