
resource "azurerm_resource_group" "tf" {
  name     = var.rgname
  location = var.location
}
module "abc"{
  source = "./modules/storageaccount"
  rgname = var.rgname
  location = var.location
  storageaccountname = var.storageaccountname
  queuename = var.queuename
  tablename = var.tablename
  container_list = var.container_list
  fileshare_list = var.fileshare_list
}
module "computing1"{
  source = "./modules/computing"
}

module "dev2"{
  source = "./modules/storageaccount"
  rgname = var.rgname
  location = var.location
  storageaccountname = var.storageaccountnamev1
  queuename = var.queuename
  tablename = var.tablename
  container_list = var.container_list
  fileshare_list = var.fileshare_list
}