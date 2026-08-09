run "setup" {
  command = apply

  module {
    source = "./tests/integration/setup"
  }
}

run "resource_group" {
  command = apply

  variables {
    location = "westus3"
    name     = run.setup.resource_group_name
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
