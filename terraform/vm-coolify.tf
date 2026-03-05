resource "proxmox_vm_qemu" "coolify" {
  name        = "coolify"
  target_node = "pve-02"
  clone       = "ubuntu-24.04-template"

  agent = 1
  start_at_node_boot = true

  startup_shutdown {
    order            = -1
    startup_delay    = -1
    shutdown_timeout = -1
  }

  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
  }

  memory = 8192
  balloon = 8192
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
          storage  = "local-lvm"
          size     = "64G"
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
    bridge = "vmbr0"
    tag    = 1
  }

  ipconfig0 = "ip=10.77.0.109/16,gw=10.77.0.3"
}