terraform {
    required_providers {
        proxmox = {
            source = "Telmate/proxmox"
            version = "3.0.2-rc07"
        }
        adguard = {
            source = "gmichels/adguard"
            version = "1.6.2"
        }
    }
}

variable "proxmox_api_url" {
    type        = string
}

variable "proxmox_api_token_id" {
    type        = string
    sensitive   = true
}

variable "proxmox_api_token_secret" {
    type        = string
    sensitive   = true
}

provider "proxmox" {
    pm_api_url = var.proxmox_api_url
    pm_api_token_id = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret

    pm_tls_insecure = true
}


variable "adguard_username" {
    type        = string
    sensitive   = true
}

variable "adguard_password" {
    type        = string
    sensitive   = true
}

provider "adguard" {
  host     = "adguard-home-prod-01.local.dontddos.me"
  username = var.adguard_username
  password = var.adguard_password
}