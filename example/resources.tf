resource "azurerm_resource_group" "tf" {
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
  for_each = toset(var.container_list) 
  name     = each.value
  storage_account_name  = azurerm_storage_account.tf.name
  container_access_type = "private"
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
  for_each = tomap(var.fileshare_list)
  name                 = var.fileshare_list["name"]
  storage_account_name = azurerm_storage_account.tf.name
  quota                = var.fileshare_list["quota"]
  }