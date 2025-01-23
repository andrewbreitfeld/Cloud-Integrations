provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "linux-vmss-dt-ag-testing"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "ag-testing-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                            = "linux-vmss-dt-ag-testing"
  resource_group_name             = azurerm_resource_group.example.name
  location                        = azurerm_resource_group.example.location
  sku                             = "Standard_B1s"
  instances                       = 2
  admin_username = "testadminuser"
  admin_password = "<passwordhere>"
  disable_password_authentication = false

  custom_data = filebase64("customdata.tpl")


  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "87-gen2"
    version   = "latest"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = 80
  }
}