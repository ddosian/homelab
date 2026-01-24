resource "proxmox_vm_qemu" "test1" {
  name        = "test1"
  target_node = "pve-01"
  clone       = "ubuntu-24.04-template"

  agent = 1

  cpu {
    cores   = 4
    sockets = 1
    type    = "host"
  }

  memory = 4096
  balloon = 4096

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
          size     = "32G"
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
  }

  ipconfig0 = "ip=dhcp"
}