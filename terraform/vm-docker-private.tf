resource "proxmox_vm_qemu" "docker-private" {
  name        = "docker-private"
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
    cores   = 4
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
    tag    = 1
  }

  ipconfig0 = "ip=10.77.1.104/16,gw=10.77.0.1"
}

# NetBox
resource "netbox_virtual_machine" "docker-private" {
  name         = proxmox_vm_qemu.docker-private.name
  cluster_id   = 1
  device_id    = 1
  vcpus        = 4
  memory_mb    = 24000
  disk_size_mb = 32000
  status       = "active"
}

resource "netbox_interface" "docker-private-eth0" {
  name               = "eth0"
  virtual_machine_id = netbox_virtual_machine.docker-private.id
}

resource "netbox_ip_address" "docker-private-ip" {
  ip_address            = "10.77.1.104/16"
  status                = "active"
  virtual_machine_interface_id = netbox_interface.docker-private-eth0.id
}

resource "netbox_primary_ip" "docker-private-primary-ip" {
  ip_address_id      = netbox_ip_address.docker-private-ip.id
  virtual_machine_id = netbox_virtual_machine.docker-private.id
}

resource "netbox_virtual_disk" "docker-private-scsi0" {
  name               = "scsi0"
  size_mb            = 32000
  virtual_machine_id = netbox_virtual_machine.docker-private.id
}