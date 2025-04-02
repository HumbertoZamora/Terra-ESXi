output "ip" {
  value = esxi_guest.create_vm.ip_address
}

output "vm_hostname" {
  value = esxi_guest.create_vm.guest_name
}

output "Metadatos_VMConfig" {
  value = data.template_file.metadata_config.rendered
}

# output "Metadatos_NetworkConfig" {
#   value = data.template_file.metadata_config.rendered
# }

# output "Packages" {
#   value = [ for i in var.guest_packages : i ]
# }

# output "Packages" {
#   # value = "[ ${join("/ ", [for s in var.guest_packages : format("%q", s)])} ]"
#   # value = join("\\n\\r ", var.guest_packages)
#   value = "[ ${join(",", [for s in var.guest_packages : format("%q", s)])} ]"
# }