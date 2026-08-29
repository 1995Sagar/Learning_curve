terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }

  } 
}


provider "azurerm" {
  features {

  }
}

variable "rg_count" {
  type    = number
  default = 4
}

resource "azurerm_resource_group" "rg_count" {
  count    = var.rg_count

  name     = "my-app-rg-${count.index}"
  location = "East US"
}