terraform {
  required_version = ">= 1.6.0"
  required_providers {

    esxi = {
      source = "josenk/esxi"
      version = "1.10.3"
    }

    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.6"
    }

    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}