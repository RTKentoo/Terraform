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
  description = "Used in resource naming conventions"
}

variable "company_initials" {
  type = string
  description = "Used in resource naming conventions. Needs to be kept to two letters. E.g. hg, hf, rr, etc."
}

variable "environment" {
  type = string
  description = "Used in resource naming convention. Needs to be three letters. E.g. hub, dev, prd, tst, etc."
}

variable "vm_ResourceGroup" {
    type = string
    description = "The resource group in which the vm will reside."
}

variable "vm_Subnet" {
    type = list
    description = "The subnet in which the vm will be assigned."
}

variable "vm_Size" {
    type = string
    description = "The VM SKU"
}

variable "vm_Type" {
    type = string
    description = "Used for naming convention, and should be a very short, succint description of the vm's role. e.g. NAV, DH, etc"
}

variable "vm_nextSequence" {
    type = string
    description = "The next sequence number of this vm. Begins at 00."
}

variable "private_ip_addr" {
    type = string
    description = "The static private ip address to be assigned to the VM NIC"
}

variable "harbor_dns" {
  type    = list(string)
  default = ["10.4.0.84", "10.4.0.86"]
}

variable "remote_peer_vnet_id" {
  type = string
  default = "b7c2dc8c-418d-46a5-a5da-ba751f3b0dd5"
  desctiption = "The remote vnet id of hg-hub for peering"
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