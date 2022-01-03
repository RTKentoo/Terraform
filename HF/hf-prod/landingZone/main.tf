terraform {
  backend "azurerm" {
    storage_account_name = "hghubwus2infratfstatesa"
    container_name       = "hf-tf"
    key                  = "hf-prod/landingZone/landingZone.tfstate"
    sas_token            = ""
  }
}

module "spoke" {
  source            = "../../../Modules/LandingZones/spoke"
  subscription_id   = ""
  deployed_by_email = "kent.taylor@harborfoods.com"
  company_initials  = "hf"
  environment       = "prd"
  vnet = {
    address_space = ["10.4.80.0/21"]
  }
  subnets = {
    address_prefix = ["10.4.80.0/24", "10.4.81.0/24", "10.4.82.0/24"]
  }
}