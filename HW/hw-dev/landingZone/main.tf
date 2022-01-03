terraform {
  backend "azurerm" {
    storage_account_name = "hghubwus2infratfstatesa"
    container_name       = "hw-tf"
    key                  = "hw-dev/landingZone/landingZone.tfstate"
    sas_token            = ""
  }
}

module "spoke" {
  source            = "../../../Modules/LandingZones/spoke"
  subscription_id   = ""
  deployed_by_email = "kent.taylor@harborfoods.com"
  company_initials  = "hw"
  environment       = "dev"
  vnet = {
    address_space = ["10.4.72.0/21"]
  }
  subnets = {
    address_prefix = ["10.4.72.0/24", "10.4.73.0/24", "10.4.74.0/24"]
  }
}