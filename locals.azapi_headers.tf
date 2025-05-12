locals {
  valid_module_source_regex = [
    "registry.terraform.io/[A|a]zure/.+",
    "registry.opentofu.io/[A|a]zure/.+",
    "git::https://github\\.com/[A|a]zure/.+",
    "git::ssh:://git@github\\.com/[A|a]zure/.+",
  ]
  apply_headers = var.enable_telemetry && anytrue([for r in local.valid_module_source_regex : can(regex(r, one(data.modtm_module_source.telemetry).module_source))])
  # tflint-ignore: terraform_unused_declarations
  azapi_headers = local.apply_headers ? {
    avm = "true"
    avm_module_source   = one(data.modtm_module_source.telemetry).module_source
    avm_module_version  = one(data.modtm_module_source.telemetry).module_version
  } : {}
}
