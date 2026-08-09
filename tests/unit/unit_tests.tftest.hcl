mock_provider "azapi" {}

variables {
  location = "westus3"
  name     = "rg-avm-template-test"
  tags = {
    environment = "test"
  }
}

run "resource_group" {
  command = apply

  assert {
    condition     = azapi_resource.this.type == "Microsoft.Resources/resourceGroups@2024-11-01"
    error_message = "The module must deploy the expected resource group API version."
  }

  assert {
    condition     = azapi_resource.this.name == var.name
    error_message = "The resource group name must match the module input."
  }

  assert {
    condition     = azapi_resource.this.tags == var.tags
    error_message = "The resource group tags must match the module input."
  }

  assert {
    condition     = output.name == var.name
    error_message = "The name output must match the resource group name."
  }

  assert {
    condition     = output.resource_id == azapi_resource.this.id
    error_message = "The resource ID output must match the resource group ID."
  }
}

run "invalid_trailing_period" {
  command = plan

  variables {
    name = "rg-avm-template-test."
  }

  expect_failures = [var.name]
}
