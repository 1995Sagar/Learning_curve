resource "azurerm_network_interface" "net" {
  for_each            = var.vm
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnwtt[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.pipp[each.key].id
    private_ip_address_allocation = "Static"
  }
}

resource "azurerm_linux_virtual_machine" "virtualmachine" {
  for_each              = var.vm
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = [azurerm_network_interface.net[each.key].id] 
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}