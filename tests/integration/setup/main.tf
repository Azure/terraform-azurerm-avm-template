resource "random_id" "suffix" {
  byte_length = 4
}

output "resource_group_name" {
  value = "rg-avm-template-${random_id.suffix.hex}"
}
