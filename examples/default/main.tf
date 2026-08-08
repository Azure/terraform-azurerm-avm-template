terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.4"
    }
  }
}

provider "azapi" {}

module "resource_group" {
  source = "../../"

  location = "westus3"
  name     = "rg-avm-template-example"
}
