terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-nsg"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = data.azurerm_network_interface.existing_nic.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "null_resource" "vm_provisioning" {
  triggers = {
    vm_id              = data.azurerm_virtual_machine.existing_vm.id
    index_html_content = filemd5("${path.module}/index.html")
  }

  depends_on = [
    data.azurerm_virtual_machine.existing_vm,
    azurerm_network_interface_security_group_association.main
  ]

  connection {
    type        = "ssh"
    user        = "leoleiden"
    private_key = file("${path.module}/Terra3.pem")
    host        = data.azurerm_public_ip.existing_public_ip.ip_address
    timeout     = "10m"
  }

  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/index.html /var/www/html/index.nginx-debian.html",
      "sudo systemctl restart nginx",
      "sudo systemctl enable nginx"
    ]
  }
}