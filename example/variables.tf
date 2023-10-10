variable "rgname"{
    type = string
    default = "devRG"
}
variable  "storageaccountname"{
    type = string
}
variable "container_list"{
    type = list(string)
    
}
variable "queuename"{
  type = string
}
variable "tablename"{
  type = string
}
variable "filesharename"{
  type = string
}