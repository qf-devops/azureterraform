rgname = "devRG"
location = "westus2"
storageaccountname = "devwebappstgaccnt101023"
storageaccountnamev1 = "devwebappstgaccnt111023"

queuename = "webqueue"
tablename = "webtable"
container_list = {
 container1 = {
         "name" = "webapp01"
         "accesstype" = "private"
         },
 container2 = {
         "name" = "webapp02"
         "accesstype" = "blob"
         },
container3 = {
         "name" = "webapp03"
         "accesstype" = "private"
         },
container4 = {
         "name" = "webapp04"
         "accesstype" = "private"
         },
container5 = {
         "name" = "webapp05"
         "accesstype" = "blob"
         }
}
fileshare_list = {
  "fileshare1" = {
                  "name" = "webfileshare1"
                  "quota" = "10"
                 },
  "fileshare2" = {
                   "name" = "webfileshare2"
                   "quota" = "20"
                 },
  "fileshare3" = {
                   "name" = "webfileshare3"
                   "quota" = "30"
                 },
  "fileshare4" = {
                    "name" = "webfileshare4"
                    "quota" = "40"
                 }
}
registrylist = ["devabcdcoreregistry"]
image = "devabcdcoreregistry.azurecr.io/nginx:1.0"
username = "devabcdcoreregistry"
password = "ximbWSABRLuNiFSjaTJUdC3VvjOv15iC8V+AF/z/hU+ACRCENqMJ"
server   = "devabcdcoreregistry.azurecr.io"

spappId    = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
sppassword = "********-****-****-****-************"


cosmos_account_name = "samplecosmosacct103"
cosmos_api          = "cassandra"
cassandra_keyspaces = {
  one = {
    keyspace_name           = "keyspacenoautoscale"
    keyspace_throughput     = 400
    keyspace_max_throughput = null
  },
  two = {
    keyspace_name           = "keyspaceautoscale"
    keyspace_throughput     = null
    keyspace_max_throughput = 1000
  }
}
cassandra_tables = {
  one = {
    keyspace_name        = "keyspaceautoscale"
    table_name           = "table1"
    default_ttl_seconds  = "86400"
    analytical_storage_ttl = null
    table_throughout     = 400
    table_max_throughput = null
    cassandra_schema_settings = {
      column  = {
        columnone = {
          column_key_name      = "loadid"
          column_key_type      = "uuid"  
        },
        columntwo = {
          column_key_name      = "machine"
          column_key_type      = "uuid"  
        },
        columnthree = {
          column_key_name      = "mtime"
          column_key_type      = "int"  
        }      
      }
      partition_key = {
        partition_key_one = {
          partition_key_name   = "loadid"
        }  
      }
      cluster_key = null
    }
  },
two = {
     keyspace_name        = "keyspacenoautoscale"
     table_name           = "table2"
     default_ttl_seconds  = "86400"
     analytical_storage_ttl = null
     table_throughout     = 400
     table_max_throughput = null
     cassandra_schema_settings = {
       column  = {
         columntwo = {
           column_key_name      = "loadid"
           column_key_type      = "uuid"  
         }
       }
       partition_key = {
         partition_key_two = {
           partition_key_name   = "loadid"
         }  
       }
       cluster_key = null
     }
    }
}
