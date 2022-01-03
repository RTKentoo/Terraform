variable "deployed_by_email" {
  type = string
}

variable "subscription_id" {
  type        = string
}

variable "region" {
  type    = string
  default = "westus2"
}

variable "region_initials" {
  type = string
  default = "wus2"
}

variable "company_initials" {
  type = string
}

variable "environment" {
  type = string
}

variable "harbor_dns" {
  type    = list(string)
  default = ["10.4.0.84", "10.4.0.86"]
}

variable "remote_peer_vnet_id" {
  type = string
}

variable "vnet" {
  type = object({
    address_space = list(string)
  })
}

variable "subnets" {
  type = object({
    address_prefix = list(string)
  })
}