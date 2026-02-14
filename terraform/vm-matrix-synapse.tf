resource "proxmox_vm_qemu" "matrix-synapse" {
  name        = "matrix-synapse"
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
    bridge = "vmbr0"
    tag    = 20
  }

  ipconfig0 = "ip=10.20.20.102/24,gw=10.20.20.1"
}

# NetBox
resource "netbox_virtual_machine" "matrix-synapse" {
  name         = proxmox_vm_qemu.matrix-synapse.name
  cluster_id   = 1
  device_id    = 1
  vcpus        = 2
  memory_mb    = 8000
  disk_size_mb = 128000
  status       = "active"
}

resource "netbox_interface" "matrix-synapse-eth0" {
  name               = "eth0"
  virtual_machine_id = netbox_virtual_machine.matrix-synapse.id
}

resource "netbox_ip_address" "matrix-synapse-ip" {
  ip_address            = "10.20.20.102/24"
  status                = "active"
  virtual_machine_interface_id = netbox_interface.matrix-synapse-eth0.id
}

resource "netbox_primary_ip" "matrix-synapse-primary-ip" {
  ip_address_id      = netbox_ip_address.matrix-synapse-ip.id
  virtual_machine_id = netbox_virtual_machine.matrix-synapse.id
}

resource "netbox_virtual_disk" "matrix-synapse-scsi0" {
  name               = "scsi0"
  size_mb            = 128000
  virtual_machine_id = netbox_virtual_machine.matrix-synapse.id
}