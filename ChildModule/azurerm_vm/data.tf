data "azurerm_subnet" "subnet" {
  for_each             = var.myvm
  name                 = each.value.subnet
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}