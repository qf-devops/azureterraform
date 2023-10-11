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

variable "fileshare_list" {
  type = map(object({
    name           = string
    quota          = number
  }))
  description = "List of azure fileshares to create."
  default     = {}
}