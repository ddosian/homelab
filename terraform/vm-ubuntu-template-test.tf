resource "proxmox_vm_qemu" "ubuntu-template-test" {
  name        = "ubuntu-template-test"
  target_node = "pve-01"
  clone       = "ubuntu-template"
  cores       = 2
  memory      = 2048
  sockets     = 1
  agent       = 1

}