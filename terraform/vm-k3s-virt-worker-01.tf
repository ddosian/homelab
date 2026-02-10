resource "proxmox_vm_qemu" "k3s-virt-worker-01" {
  name        = "k3s-virt-worker-01"
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
    cores   = 6
    sockets = 1
    type    = "host"
  }

  memory = 16384
  balloon = 16384
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
    tag    = 40
  }

  ipconfig0 = "ip=10.20.40.31/24,gw=10.20.40.31"
}

# NetBox
resource "netbox_virtual_machine" "k3s-virt-worker-01" {
  name         = proxmox_vm_qemu.k3s-virt-worker-01.name
  cluster_id   = 1
  device_id    = 1
  vcpus        = 6
  memory_mb    = 16000
  disk_size_mb = 128000
  status       = "active"
}

resource "netbox_interface" "k3s-virt-worker-01-eth0" {
  name               = "eth0"
  virtual_machine_id = netbox_virtual_machine.k3s-virt-worker-01.id
}

resource "netbox_ip_address" "k3s-virt-worker-01-ip" {
  ip_address            = "10.20.40.31/24"
  status                = "active"
  virtual_machine_interface_id = netbox_interface.k3s-virt-worker-01-eth0.id
}

resource "netbox_primary_ip" "k3s-virt-worker-01-primary-ip" {
  ip_address_id      = netbox_ip_address.k3s-virt-worker-01-ip.id
  virtual_machine_id = netbox_virtual_machine.k3s-virt-worker-01.id
}

resource "netbox_virtual_disk" "k3s-virt-worker-01-scsi0" {
  name               = "scsi0"
  size_mb            = 128000
  virtual_machine_id = netbox_virtual_machine.k3s-virt-worker-01.id
}