terraform {
  backend "azurerm" {
    storage_account_name = "hghubwus2infratfstatesa"
    container_name       = "hw-tf"
    key                  = "hw-prod/landingZone/landingZone.tfstate"
    sas_token            = ""
  }
}

module "spoke" {
  source            = "../../../Modules/LandingZones/spoke"
  subscription_id   = ""
  deployed_by_email = "kent.taylor@harborfoods.com"
  company_initials  = "hw"
  environment       = "prd"
  vnet = {
    address_space = ["10.4.56.0/21"]
  }
  subnets = {
    address_prefix = ["10.4.56.0/24", "10.4.57.0/24", "10.4.58.0/24"]
  }
}