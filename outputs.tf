output "resource" {
  description = "This is the full output for the resource."
  value       = azurerm_disk_encryption_set.this
}

output "id" {
  description = "The ID of the disk encryption set."
  value       = azurerm_disk_encryption_set.this.id
}

output "key_vault_key_url" {
  description = "The ID of the disk encryption set."
  value       = azurerm_disk_encryption_set.this.key_vault_key_url
}