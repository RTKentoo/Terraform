#Provider Information
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_network_interface" "vm_nic" {
    name = "${company_initials}-${environment}-${region_initials}-${vm_Type}-NIC"
    location = "${region}"
    resource_group_name = "${vm_ResourceGroup}"

#Needs work for Subnet ID
    ip_configuration {
        name = "${azurerm_virtual_machine.vm.name}-ipconfig"
        subnet_id = "${ERP_subnet}"
        private_ip_address_allocation = "Static"
        private_ip_address = "${private_ip_addr}"
    }
}

resource "azurerm_virtual_machine" "vm" {
    name = "${company_initials}-${environment}-${region_initials}-${vm_Type}-vm${vm_nextSequence}"
    location = "${region}"
    resource_group_name = "${vm_ResourceGroup}"
    network_interface_ids = [azurerm_network_interface.vm_nic.id]
    vm_size = "${vm_Size}"

    # Uncomment this line to delete the OS disk automatically when deleting the vm
    # delete_os_disk_on_termination = true

    # Uncomment this line to delete the data disks automatically when deleting the vm
    # delete_data_disks_on_termination = true

    storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2022-datacenter-g2"
        verison = "latest"
    }

    #Update as Object Variable
    storage_os_disk {
        name = "${company_initials}-${environment}-${region_initials}-${azurerm_virtual_machine.vm.name}-osd"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "Premium_ZRS"
    }

    #Update as Object Variable
    os_profile {
        computer_name = ${vm_Name}
        admin_username = "vmadmin"
        admin_password = 
    }

    tags {
        Environment: "${var.environment}",
        Company: "${upper(var.company_initials)}",
        "Deployed By": "${var.deployed_by_email}"
    }
}