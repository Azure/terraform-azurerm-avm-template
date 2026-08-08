# The template intentionally excludes the standard telemetry providers to remain AzAPI-only.
data "variable" "all" {}

transform "reorder_attributes" "variables" {
  for_each                 = data.variable.all.result
  target_block_address     = "variable.${each.key}"
  head_attributes          = ["type", "default", "description", "nullable"]
  sort_body_alphabetically = false
}
