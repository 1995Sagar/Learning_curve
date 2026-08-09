module "rg" {
  source = "../Child_Module/azurerm_resource_group"
  rg     = var.rg

}

module "vm" {
  depends_on = [module.pip, module.sub]
  source     = "../Child_Module/azurerm_vm"
  myvm       = var.vm

}

module "vnet" {
  depends_on = [module.rg]
  source     = "../Child_Module/azurerm_vnet"
  vnet1      = var.vnet

}

module "sub" {
  depends_on = [module.vnet]
  source     = "../Child_Module/azurerm_subnet"
  subnet     = var.subnet

}

module "pip" {
  depends_on = [module.rg]
  source     = "../Child_Module/azurerm_pip"
  pip        = var.pip

}
