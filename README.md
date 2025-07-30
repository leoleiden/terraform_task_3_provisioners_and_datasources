# Creating an Azure Virtual Machine with Nginx web server

This task involves defining additional resources, using provisioners to install software and configure the VM, and utilizing Terraform datasources.

## Prerequisites

- Basic understanding of Terraform and Azure.
- Terraform installed on your machine.
- Azure CLI installed and configured.

## Hands-on Task
1. Fork this repository.
2. Create a resource group manually in the Azure portal.
3. Retrieve the information from the resource group using a datasource for `azurerm_virtual_network`, `azurerm_network_interface`, `azurerm_subnet`, and `azurerm_virtual_machine`.
4. Create a default page for Nginx.
5. Use the `remote-exec` provisioner to install Nginx.
6. Use the `file` provisioner to pass the default page for Nginx.
7. Plan and apply Terraform changes using the `tfplan` file.
8. Separate the code between `provider.tf`, `variables.tf`, and `datasources.tf`.
