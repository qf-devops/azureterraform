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
