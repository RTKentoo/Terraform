terraform {
  backend "azurerm" {
    storage_account_name = "hghubwus2infratfstatesa"
    container_name       = "hw-tf"
    key                  = "hw-test/landingZone/landingZone.tfstate"
    sas_token            = ""
  }
}

module "spoke" {
  source            = "../../../Modules/LandingZones/spoke"
  subscription_id   = ""
  deployed_by_email = "kent.taylor@harborfoods.com"
  company_initials  = "hw"
  environment       = "tst"
  vnet = {
    address_space = ["10.4.64.0/21"]
  }
  subnets = {
    address_prefix = ["10.4.64.0/24", "10.4.65.0/24", "10.4.66.0/24"]
  }
}