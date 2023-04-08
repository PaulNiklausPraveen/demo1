# Terraform Block
terraform {
  required_version = ">= 0.15"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.92.0"
      
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.0"
    }

}
}

# Provider Block
provider "azurerm" {
 features {}          
}



# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "terraformresourcegroup" {
  name = "terraform-rg1"
  location = "west US"
}

# Resource-2: Random String 
resource "random_string" "storageaccountrandomname" {
  length = 16
  upper = false 
  special = false
}

# Resource-3: Azure Storage Account 
resource "azurerm_storage_account" "terraformsa" {
  name                     = "tfsa${random_string.myrandom.id}"
  resource_group_name      = azurerm_resource_group.terraformresourcegroup.name
  location                 = azurerm_resource_group.terraformresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
 

  tags = {
   Lab = "terraformlab"
  }
}
