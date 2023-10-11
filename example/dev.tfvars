rgname = "devRG"
storageaccountname = "devwebappstgaccnt101023"
queuename = "webqueue"
tablename = "webtable"
filesharename = "webfileshare"
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