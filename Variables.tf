
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}

variable "vnetname" {
    type = string
    description = "used for vnet name" 
}
variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = string
}

variable "subnetname" {
    type = string
    description = "used for subnetname"
  
}
variable "subnet_address_prefix" {
  description = "The address prefix of the subnet"
  type        = string
}

