terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2" # АБО "3.x.x" якась інша стабільна версія
    }
  }
}

provider "azurerm" {
  features {}
}