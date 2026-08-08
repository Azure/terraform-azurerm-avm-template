output "resource" {
  description = "The resource group resource."
  value       = azapi_resource.this
}

output "resource_id" {
  description = "The resource ID of the resource group."
  value       = azapi_resource.this.id
}
