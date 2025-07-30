data "azurerm_resource_group" "existing_rg" {
  name = "tfvmex-manual-rg"
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = "tfvmex-network"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_public_ip" "existing_public_ip" {
  name                = "tfvmex-public-ip"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_network_security_group" "existing_nsg" {
  name                = "tfvmex-nsg"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_network_interface" "existing_nic" {
  name                = "tfvmex-nic"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_virtual_machine" "existing_vm" {
  name                = "tfvmex-vm"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}