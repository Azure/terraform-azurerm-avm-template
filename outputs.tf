output "name" {
  description = "The name of the resource group."
  value       = azapi_resource.this.name
}

output "resource_id" {
  description = "The resource ID of the resource group."
  value       = azapi_resource.this.id
}
