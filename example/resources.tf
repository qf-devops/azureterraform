resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = "westus2"
}
