
# Azure provider version 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
}

resource "azurerm_cosmosdb_account" "this" {
  name                          = local.cosmos_account_name
  location                      = local.location
  resource_group_name           = data.azurerm_resource_group.this.name
  offer_type                    = "Standard"
  kind                          = var.cosmos_api == "mongo" ? "MongoDB" : "GlobalDocumentDB"
  public_network_access_enabled = var.public_network_access_enabled
  ip_range_filter               = var.ip_firewall_enabled == true ? local.firewall_ips : null

  enable_automatic_failover       = var.auto_failover
  enable_free_tier                = var.free_tier
  enable_multiple_write_locations = var.multi_region_write
  key_vault_key_id                = var.key_vault_name != "" ? data.azurerm_key_vault_key.this[0].versionless_id : null

  tags = local.tags

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  dynamic "capabilities" {
    for_each = var.cosmos_api == "sql" ? [] : [1]
    content {
      name = var.capabilities[var.cosmos_api]
    }
  }

  dynamic "capabilities" {
    for_each = var.additional_capabilities != null ? var.additional_capabilities : []
    content {
      name = capabilities.value
    }
  }

  dynamic "geo_location" {
    for_each = var.geo_locations
    content {
      location          = geo_location.value["geo_location"]
      failover_priority = geo_location.value["failover_priority"]
      zone_redundant    = geo_location.value["zone_redundant"]
    }
  }

  dynamic "backup" {
    for_each = var.backup_enabled == true ? [1] : []
    content {
      type                = title(var.backup_type)
      interval_in_minutes = lower(var.backup_type) == "periodic" ? var.backup_interval : ""
      retention_in_hours  = lower(var.backup_type) == "periodic" ? var.backup_retention : ""
    }
  }

  dynamic "analytical_storage" {
    for_each = var.analytical_storage.enabled ? [1] : []
    content {
      schema_type = var.analytical_storage.schema_type
    }
  }

  dynamic "identity" {
    for_each = var.enable_systemassigned_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  lifecycle {
    ignore_changes = [
      default_identity_type
    ]
  }
}

resource "azurerm_cosmosdb_cassandra_keyspace" "this" {
  for_each            = var.cassandra_keyspaces
  name                = each.value.keyspace_name
  resource_group_name = data.azurerm_resource_group.this.name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = each.value.keyspace_max_throughput != null ? null : each.value.keyspace_throughput

  dynamic "autoscale_settings" {
    for_each = each.value.keyspace_max_throughput != null ? [1] : []
    content {
      max_throughput = each.value.keyspace_max_throughput
    }
  }
}

resource "azurerm_cosmosdb_cassandra_table" "this" {
  for_each               = var.cassandra_tables
  name                   = each.value.table_name
  cassandra_keyspace_id  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_resource_group.this.name}/providers/Microsoft.DocumentDB/databaseAccounts/${azurerm_cosmosdb_account.this.name}/cassandraKeyspaces/${each.value.keyspace_name}"
  throughput             = each.value.table_max_throughput != null ? null : each.value.table_throughout
  default_ttl            = each.value.default_ttl_seconds != null ? each.value.default_ttl_seconds : null
  analytical_storage_ttl = each.value.analytical_storage_ttl != null ? each.value.analytical_storage_ttl : null

  dynamic "autoscale_settings" {
    for_each = each.value.table_max_throughput != null ? [1] : []
    content {
      max_throughput = each.value.table_max_throughput
    }
  }

  # Schema is required. 
  dynamic "schema" {
    for_each = length(each.value.cassandra_schema_settings) > 0 ? [1] : []
    content {
      # column is required. 
      dynamic "column" {
        for_each = each.value.cassandra_schema_settings.column
        content {
          name = column.value.column_key_name
          type = column.value.column_key_type
        }
      }

      # partition_key is required. 
      dynamic "partition_key" {
        for_each = each.value.cassandra_schema_settings.partition_key
        content {
          name = partition_key.value.partition_key_name
        }
      }

      # cluster_key is otional. 
      dynamic "cluster_key" {
        for_each = each.value.cassandra_schema_settings.cluster_key != null ? each.value.cassandra_schema_settings.cluster_key : {}
        content {
          name     = each.value.cassandra_schema_settings.cluster_key != null ? cluster_key.value.cluster_key_name : null
          order_by = each.value.cassandra_schema_settings.cluster_key != null ? cluster_key.value.cluster_key_order_by : null
        }
      }
    }
  }
  # Depends on existence of Cosmos DB Cassandra API Keyspace managed by module
  depends_on = [
    azurerm_cosmosdb_cassandra_keyspace.this
  ]
}