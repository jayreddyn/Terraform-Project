# Define the resource group
resource "azurerm_resource_group" "RG-02" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Define the virtual network
resource "azurerm_virtual_network" "VNET" {
  name                = Var.vnetname
  resource_group_name = azurerm_resource_group.RG-02.name
  location            = azurerm_resource_group.RG-02.location
  address_space       = [var.vnet_address_space]
}

# Define the subnet
resource "azurerm_subnet" "SUBNET" {
  name                 = Var.subnetname
  resource_group_name  = azurerm_resource_group.RG-02.name
  virtual_network_name = azurerm_virtual_network.VNET.name
  address_prefixes     = [var.subnet_address_prefix]
}

# Define the network security group
resource "azurerm_network_security_group" "NSG" {
  name                = "NSG-02"
  location            = azurerm_resource_group.RG-02.location
  resource_group_name = azurerm_resource_group.RG-02.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the network security group with the subnet
resource "azurerm_subnet_network_security_group_association" "NSG-SUBNET-Associate" {
  subnet_id                 = azurerm_subnet.SUBNET.id
  network_security_group_id = azurerm_network_security_group.NSG.id
}

# Define the NAT gateway
resource "azurerm_nat_gateway" "NAT" {
  name                    = "nat-Gateway"
  location                = azurerm_resource_group.RG-02.location
  resource_group_name     = azurerm_resource_group.RG-02.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

# Associate the NAT gateway with the subnet
resource "azurerm_subnet_nat_gateway_association" "NATASSOCIATE" {
  subnet_id      = azurerm_subnet.SUBNET.id
  nat_gateway_id = azurerm_nat_gateway.NAT.id
}
