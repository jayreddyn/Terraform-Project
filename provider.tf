terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
 
}

provider "azurerm" {
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  subscription_id = ""
 features {}
}