resource "azapi_resource" "this" {
  type     = "Microsoft.Resources/resourceGroups@2024-11-01"
  location = var.location
  name     = var.name
  tags     = var.tags
}
