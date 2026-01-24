
resource "proxmox_vm_qemu" "mgmt-proxy" {
  name        = "mgmt-proxy"
  target_node = "pve-01"
  clone       = "ubuntu-24.04-template"
  agent = 1
  cpu {
    cores   = 1
    sockets = 1
    type    = "host"
  }
  memory = 2048
  balloon = 2048
  bios = "seabios"
  scsihw = "virtio-scsi-single"
  serial {
    id   = 0
    type = "socket"
  }
  vga {
    type = "serial0"
  }
  disks {
    scsi {
      scsi0 {
        disk {
          storage  = "disk-02"
          size     = "24G"
          iothread = true
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr1"
    tag    = 10
  }
  ipconfig0 = "ip=dhcp"
}
