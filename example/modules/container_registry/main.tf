

resource "azurerm_container_registry" "acr" {
  for_each = toset(var.registrylist)
  name     = each.value
  resource_group_name      = var.rgname
  location                 = var.location
  sku                 = "Basic"
  admin_enabled       = true
  # georeplications {
  #   location                = "East US"
  #   zone_redundancy_enabled = true
  #   tags                    = {}
  # }

}