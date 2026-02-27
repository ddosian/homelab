resource "proxmox_vm_qemu" "watermelonhost-panel" {
  name        = "watermelonhost-panel"
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
    bridge = "vmbr0"
    tag    = 20
  }

  ipconfig0 = "ip=10.20.20.109/24,gw=10.20.20.1"
  }
  