
resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
}
# module "abc"{
#   source = "./modules/storageaccount"
#   rgname = var.rgname
#   location = var.location
#   storageaccountname = var.storageaccountname
#   queuename = var.queuename
#   tablename = var.tablename
#   container_list = var.container_list
#   fileshare_list = var.fileshare_list
# }
# module "computing1"{
#   source = "./modules/computing"
# }

# module "dev2"{
#   source = "./modules/storageaccount"
#   rgname = var.rgname
#   location = var.location
#   storageaccountname = var.storageaccountnamev1
#   queuename = var.queuename
#   tablename = var.tablename
#   container_list = var.container_list
#   fileshare_list = var.fileshare_list
# }

module "registry1"{
  source = "./modules/container_registry"
  registrylist = var.registrylist
  rgname = var.rgname
  location = var.location
  depends_on=[azurerm_resource_group.rg]
}
# module "container1"{
#   source = "./modules/container_instance"
#   rgname = var.rgname
#   location = var.location
#   image    = var.image
#   username = var.username
#   password = var.password
#   server   = var.server
# }
module "devakscluster"{
  source = "./modules/akscluster"
  rgname = var.rgname
  location = var.location
  password = var.sppassword
  appId  = var.spappId
  depends_on=[azurerm_resource_group.rg]

}

module "azure_cosmos_db" {
  source = "./modules/azure-cosmosdb"
  resource_group_name = var.rgname
  location            = var.location
  cosmos_account_name = var.cosmos_account_name
  cosmos_api          = var.cosmos_api
  cassandra_keyspaces = var.cassandra_keyspaces
  cassandra_tables    = var.cassandra_tables
  depends_on=[azurerm_resource_group.rg]
}