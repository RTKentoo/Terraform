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

provider "azurerm" {
  features {}
  subscription_id = ""
  alias = "hg-hub"
}


#Resource Groups
resource "azurerm_resource_group" "network_rg" {
  name     = "${var.company_initials}-${var.environment}-${var.region_initials}-net-rg"
  location = var.region

   tags = {
    Environment: "${var.environment}",
    Company: "${upper(var.company_initials)}",
    "Deployed By": "${var.deployed_by_email}"
   }
}

resource "azurerm_resource_group" "mgt_rg" {
  name     = "${var.company_initials}-${var.environment}-${var.region_initials}-mgt-rg"
  location = var.region

   tags = {
    Environment: "${var.environment}",
    Company: "${upper(var.company_initials)}",
    "Deployed By": "${var.deployed_by_email}"
   }
}

resource "azurerm_resource_group" "security_rg" {
  name     = "${var.company_initials}-${var.environment}-${var.region_initials}-sec-rg"
  location = var.region

   tags = {
    Environment: "${var.environment}",
    Company: "${upper(var.company_initials)}",
    "Deployed By": "${var.deployed_by_email}"
   }
}

#Virtual Networks and Network Resources
resource "azurerm_virtual_network" "network_vnet" {
  name                = "${var.company_initials}-${var.environment}-${var.region_initials}-vnet"
  location            = var.region
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = var.vnet.address_space
  dns_servers         = var.harbor_dns

  subnet {
    name           = "${var.company_initials}-${var.environment}-${var.region_initials}-app-sn"
    address_prefix = var.subnets.address_prefix[0]
  }

  subnet {
    name           = "${var.company_initials}-${var.environment}-${var.region_initials}-mgt-sn"
    address_prefix = var.subnets.address_prefix[1]
  }

  subnet {
    name           = "${var.company_initials}-${var.environment}-${var.region_initials}-sec-sn"
    address_prefix = var.subnets.address_prefix[2]
  }
  
   tags = {
    Environment: "${var.environment}",
    Company: "${upper(var.company_initials)}",
    "Deployed By": "${var.deployed_by_email}",
    Tier: "Network",
   }
}

resource "azurerm_virtual_network_peering" "toHG" {
  name = "${var.company_initials}-${var.environment}-${var.region_initials}-hg-hub-wus2-peer"
  resource_group_name = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  remote_virtual_network_id = "//resourceGroups/hg-hub-wus2-net-rg/providers/Microsoft.Network/virtualNetworks/hg-hub-wus2-vnet"
  allow_gateway_transit = true
}

resource "azurerm_virtual_network_peering" "fromHG" {
  provider = azurerm.hg-hub
  name = "hg-hub-wus2-${var.company_initials}-${var.environment}-${var.region_initials}-peer"
  resource_group_name = "hg-hub-wus2-net-rg"
  virtual_network_name = "hg-hub-wus2-vnet"
  remote_virtual_network_id = "/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.network_rg.name}/providers/Microsoft.Network/virtualNetworks/${azurerm_virtual_network.network_vnet.name}"
  allow_gateway_transit = true
}
