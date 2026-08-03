module "rsource_group" {
  source = "../Child_module/azure_resource_group"
  rg     = var.rgs
}

module "virtual_network" {
  depends_on = [module.rsource_group]
  source     = "../Child_module/azure_virtual_network"
  vnet       = var.vnet

}

module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../child_module/azure_subnet"
  subnet     = var.sub1
}

module "publicip" {
  depends_on = [module.rsource_group]
  source     = "../child_module/azure_public_ip"
  pip        = var.pip1

}

module "virtualmachine" {

  depends_on = [module.rsource_group, module.publicip, module.subnet]
  source     = "../child_module/azure_virtual_machine"
  vm         = var.vm1
}



