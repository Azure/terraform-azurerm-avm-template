# required AVM resources interfaces
resource "azurerm_management_lock" "this" {
  count = var.lock != null ? 1 : 0

  lock_level = var.lock.kind
  name       = coalesce(var.lock.name, "lock-${var.lock.kind}")
  scope      = azurerm_MY_RESOURCE.this.id
  notes      = var.lock.kind == "CanNotDelete" ? "Cannot delete the resource or its child resources." : "Cannot delete or modify the resource or its child resources."
}

resource "azurerm_disk_encryption_set" "this" {
  name = var.name
  resource_group_name = var.resource_group_name
  location = var.location
  key_vault_key_id = var.key_vault_key_id
  managed_hsm_key_id = var.managed_hsm_key_id
  auto_key_rotation_enabled = var.auto_key_rotation_enabled
  encryption_type = var.encryption_type
  federated_client_id = var.federated_client_id 
  identity {
    type = var.identity_type
    identity_ids = var.identity_ids
  }
}
resource "azurerm_role_assignment" "this" {

  principal_id                           = azurerm_disk_encryption_set.this.identity[0].principal_id
  scope                                  = var.key_vault_resource_id #keyvault id
  role_definition_name                   = "Key Vault Crypto Service Encryption User"
}