##### VARIABLES ESXi #####
variable "esxi_server" {
  type    = map(string)
    default = {
      hostname   = "x.x.x.x"
      https_port = "443"
      username   = "root"
      password   = "passwd_root"
    }
}

variable "guest_bios" {
  type    = list(string)
  default = [
    "efi",
    "bios"
  ]
}

variable "guest_power" {
  type    = list(string)
  default = [
    "on",
    "off"
  ]
}

variable "vm_guest" {
  type    = map(string)
    default = {
      guest_hdd_store  = "datastore1"
      guest_network    = "VM Network"
      ovf_file_path    = "RedHat-9/Template-RH9.ovf"
      guest_name       = "ansible-platform"
      guest_ip         = "x.x.x.x"
      guest_gateway    = "x.x.x.x"
      guest_dns        = "x.x.x.x"
      guest_username   = "ansible"
      guest_ethernet   = "ens192"
      guest_hostname   = "guest-hostname"
      guest_hdd_size   = "40"
      guest_ram_size   = "8192"
      guest_num_vcpu   = "2"
      guest_notes      = "VM Notes"
   }
}
