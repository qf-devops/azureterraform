resource "azurerm_storage_account" "tf" {
  name                     = var.storageaccountname
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "nonprod"
  }
}

resource "azurerm_storage_container" "tf" {
  for_each = var.container_list
  name     = each.value.name
  storage_account_name  = azurerm_storage_account.tf.name
  container_access_type = each.value.accesstype
}

resource "azurerm_storage_queue" "tf" {
  count = 5
  name                 = "webqueue${count.index}"
  storage_account_name = azurerm_storage_account.tf.name
}

resource "azurerm_storage_table" "tf" {
  name                 = var.tablename
  storage_account_name = azurerm_storage_account.tf.name
}

resource "azurerm_storage_share" "example" {
  for_each = var.fileshare_list
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.tf.name
  quota                = each.value.quota
  }