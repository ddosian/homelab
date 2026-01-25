resource "proxmox_vm_qemu" "mgmt-proxy" {
  name        = "mgmt-proxy"
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
    tag    = 10
  }

  ipconfig0 = "ip=10.20.10.2/24,gw=10.20.10.1"
}

# NetBox
resource "netbox_virtual_machine" "mgmt-proxy" {
  name         = proxmox_vm_qemu.mgmt-proxy.name
  cluster_id   = 1
  device_id    = 1
  vcpus        = 1
  memory_mb    = 2000
  disk_size_mb = 32000
  status       = "active"
}

resource "netbox_interface" "mgmt-proxy-eth0" {
  name               = "eth0"
  virtual_machine_id = netbox_virtual_machine.mgmt-proxy.id
}

resource "netbox_ip_address" "mgmt-proxy-ip" {
  ip_address            = "10.20.10.2/24"
  status                = "active"
  virtual_machine_interface_id = netbox_interface.mgmt-proxy-eth0.id
}

resource "netbox_primary_ip" "mgmt-proxy-primary-ip" {
  ip_address_id      = netbox_ip_address.mgmt-proxy-ip.id
  virtual_machine_id = netbox_virtual_machine.mgmt-proxy.id
}

resource "netbox_virtual_disk" "mgmt-proxy-scsi0" {
  name               = "scsi0"
  size_mb            = 32000
  virtual_machine_id = netbox_virtual_machine.mgmt-proxy.id
}