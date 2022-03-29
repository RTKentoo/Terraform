#Provider Information
terraform {
  required_providers {
    azuread = {
      source  = "azuread"
      version = ">= 2.18.0"
    }

    azurerm = {
      source  = "azurerm"
      version = ">= 2.98.0"
    }

    random = {
      source  = "random"
      version = ">= 3.1.0"
    }

    time = {
      source  = "time"
      version = ">= 0.7.2"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "bd1d2c11-78e5-4a4b-9ebb-9fc0d81c2209"
}


## Module Deployements ##
module "host" {
  source              = "./module/host"
  environment_initial = "i"
  region_initial      = "w"
  host_users          = ["alex.cohen@genesis-fs.com", "kent.taylor@genesis-fs.com"]
  vm_count            = "2"
  domain_user         = "ktaylor-a@genesis-fs.com"
  domain_password     = "*****"
  hostpool_id         = module.hostpool.hostpool_id
}

module "hostpool" {
  source = "./module/hostpool"
}

