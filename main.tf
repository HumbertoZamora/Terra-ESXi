# https://github.com/josenk/terraform-provider-esxi
# https://cloudinit.readthedocs.io/en/latest/reference/examples.html
# Debe estar instalado en la maquina desde la cual se corra terraform el comando: ovftool.
# Este Terrafom tiene la ultima version funcional del OVF.
# cloud-init schema --system: Para ver los erroes del sintaxis.
# Comando para crear la contraseña:
# mkpasswd --method=SHA-512 --rounds=4096
# Validar la correcta sintaxis del userdata.tpl
# cloud-init schema --system --annotate
# cloud-init schema -c <PATH_FILE_NETWORK-CONFIG>  --schema-type network-config
# /usr/sbin/vmtoolsd --cmd info-get guestinfo.ovfEnv


provider "esxi" {
  esxi_hostname      = var.esxi_server["hostname"]
  esxi_hostssl       = var.esxi_server["https_port"]
  esxi_username      = var.esxi_server["username"]
  esxi_password      = var.esxi_server["password"]
}

data "template_file" "metadata_config" {
  template = file("userdata.tpl")
  vars = {
    vm_username      = "${var.vm_guest["guest_username"]}"
    vm_ip            = "${var.vm_guest["guest_ip"]}"
    vm_ethernet      = "${var.vm_guest["guest_ethernet"]}"
    guest_gateway    = "${var.vm_guest["guest_gateway"]}"
    guest_dns        = "${var.vm_guest["guest_dns"]}"
    guest_hostname   = "${var.vm_guest["guest_hostname"]}"
  }
}

resource "esxi_guest" "create_vm" {
  guest_name     = "${var.vm_guest["guest_name"]}"
  disk_store     = "${var.vm_guest["guest_hdd_store"]}"
  boot_disk_size = "${var.vm_guest["guest_hdd_size"]}"
  ovf_source     = "${var.vm_guest["ovf_file_path"]}"
  boot_firmware  = "${var.guest_bios[0]}"
  memsize        = "${var.vm_guest["guest_ram_size"]}"
  numvcpus       = "${var.vm_guest["guest_num_vcpu"]}"
  power          = "${var.guest_power[0]}"
  guestos        = "rhel8-64"
  notes          = "${var.vm_guest["guest_notes"]}"

  network_interfaces {
     virtual_network = "${var.vm_guest["guest_network"]}"
     nic_type        = "e1000"
  }

  guestinfo = {
    base64_encode = false
    gzip = false
    "userdata.encoding" = "gzip+base64"
    "userdata"          = base64gzip(data.template_file.metadata_config.rendered)
  }

  ovf_properties {
    key = "user-data"
    value = base64encode(data.template_file.metadata_config.rendered)
  }
}