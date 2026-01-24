resource "proxmox_vm_qemu" "ubuntu-template-test" {
  name        = "ubuntu-template-test"
  target_node = "pve-01"
  clone       = "ubuntu-template"

  cores   = 2
  memory  = 2048
  sockets = 1
  agent   = 1

  disk {
    storage = "disk-02"
    size    = "20G"
    type    = "scsi"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=dhcp"
}