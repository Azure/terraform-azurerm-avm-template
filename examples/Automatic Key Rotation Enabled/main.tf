terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/regions/azurerm"
  version = "~> 0.3"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = module.regions.regions[random_integer.region_index.result].name
  name     = module.naming.resource_group.name_unique
}

module "avm-res-keyvault-vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.7.3"
  name = "test-keyvault"
  location = "West Europe"
  resource_group_name = "test-disk-encryption-set"
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  enabled_for_disk_encryption = true
  purge_protection_enabled = false
}

resource "azurerm_key_vault_key" "example" {
  name         = "des-example-key"
  key_vault_id = module.avm-res-keyvault-vault.key_vault_id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

module "test" {
  source = "../../"
  name = "test"
  resource_group_name = azurerm_resource_group.this.name
  location = azurerm_resource_group.this.location
  key_vault_key_id = azurerm_key_vault_key.example.id
  key_vault_resource_id = module.avm-res-keyvault-vault.key_vault_id
  auto_key_rotation_enabled = true

}


