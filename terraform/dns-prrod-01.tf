resource "proxmox_vm_qemu" "dns-prod-01" {
  name        = "dns-prod-01"
  target_node = "pve-prod-01"
  clone       = "ubuntu-24.04"

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

  memory = 2048
  balloon = 1024
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
          size     = "16G"
          iothread = true
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "disk-02"
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr1"
    tag    = 1
  }
  ssh_user = "ddos"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINew6VSTlJ2ZEEC8OgqZCc1zSSL6tMSUUybpXH4ADAAf ddos@macbook
EOF
  ipconfig0 = "ip=10.0.1.103/24,gw=10.0.1.1"
  nameserver = "10.0.1.103"
  searchdomain = "local.dontddos.me"
}