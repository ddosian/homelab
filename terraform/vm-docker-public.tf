resource "proxmox_vm_qemu" "docker-public" {
  name        = "docker-public"
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
    bridge = "vmbr1"
    tag    = 20
  }

  ipconfig0 = "ip=10.20.20.105/16,gw=10.20.20.1"
}

# NetBox
resource "netbox_virtual_machine" "docker-public" {
  name         = proxmox_vm_qemu.docker-public.name
  cluster_id   = 1
  device_id    = 1
  vcpus        = 4
  memory_mb    = 16000
  disk_size_mb = 64000
  status       = "active"
}

resource "netbox_interface" "docker-public-eth0" {
  name               = "eth0"
  virtual_machine_id = netbox_virtual_machine.docker-public.id
}

resource "netbox_ip_address" "docker-public-ip" {
  ip_address            = "10.20.20.105/16"
  status                = "active"
  virtual_machine_interface_id = netbox_interface.docker-public-eth0.id
}

resource "netbox_primary_ip" "docker-public-primary-ip" {
  ip_address_id      = netbox_ip_address.docker-public-ip.id
  virtual_machine_id = netbox_virtual_machine.docker-public.id
}

resource "netbox_virtual_disk" "docker-public-scsi0" {
  name               = "scsi0"
  size_mb            = 64000
  virtual_machine_id = netbox_virtual_machine.docker-public.id
}