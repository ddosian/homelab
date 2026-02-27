resource "proxmox_vm_qemu" "wings-eu-en-lon-01" {
  name        = "wings-eu-en-lon-01"
  target_node = "pve-01"
  clone       = "ubuntu-24.04-template"

  agent = 1
  start_at_node_boot = true

  startup_shutdown {
    order            = -1
    startup_delay    = -1
    shutdown_timeout = -1
  }

  cpu {
    cores   = 8
    sockets = 1
    type    = "host"
  }

  memory = 24576
  balloon = 24576
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
          size     = "128G"
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
    tag    = 20
  }

  ipconfig0 = "ip=10.20.20.110/24,gw=10.20.20.1"
}