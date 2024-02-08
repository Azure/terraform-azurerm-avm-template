# TODO remove this code & var.private_endpoints if private link is not support.  Note it must be included in this module if it is supported.
resource "azurerm_private_endpoint" "this" {
  for_each                      = var.private_endpoints
  name                          = each.value.name != null ? each.value.name : "pe-${var.name}"
  location                      = coalesce(each.value.location, var.location, local.resource_group_location)
  resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
  subnet_id                     = each.value.subnet_resource_id
  custom_network_interface_name = each.value.network_interface_name
  tags                          = each.value.tags

  private_service_connection {
    name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "pse-${var.name}"
    private_connection_resource_id = azurerm_resource_group.TODO.id # TODO: Replace this dummy resource azurerm_resource_group.TODO with your module resource
    is_manual_connection           = false
    subresource_names              = ["TODO subresource name, see https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource"]
  }

  dynamic "private_dns_zone_group" {
    for_each = length(each.value.private_dns_zone_resource_ids) > 0 ? ["this"] : []

    content {
      name                 = each.value.private_dns_zone_group_name
      private_dns_zone_ids = each.value.private_dns_zone_resource_ids
    }
  }

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name               = ip_configuration.value.name
      subresource_name   = "TODO subresource name"
      member_name        = "TODO subresource name"
      private_ip_address = ip_configuration.value.private_ip_address
    }
  }
}

resource "azurerm_private_endpoint_application_security_group_association" "this" {
  for_each                      = local.private_endpoint_application_security_group_associations
  private_endpoint_id           = azurerm_private_endpoint.this[each.value.pe_key].id
  application_security_group_id = each.value.asg_resource_id
}
