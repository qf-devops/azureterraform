terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateRG"
    storage_account_name = "tfstatestorageacc091123"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}
