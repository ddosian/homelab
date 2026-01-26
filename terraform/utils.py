def generate_file(name, target_node, template, cpu_cores, cpu_sockets, cpu_type, ram_size, disk_storage, disk_size, cloudinit_storage, network_bridge, vlan_tag, ip_address, cidr, gateway):
  if disk_size < 32:
    print("WARNING: Disk size cannot be smaller than 32, setting to 32.")
    disk_size = 32
  file = f'''resource "proxmox_vm_qemu" "{name}" {{
  name        = "{name}"
  target_node = "{target_node}"
  clone       = "{template}"

  agent = 1
  start_at_node_boot = true

  startup_shutdown {{
    order            = -1
    startup_delay    = -1
    shutdown_timeout = -1
  }}

  cpu {{
    cores   = {cpu_cores}
    sockets = {cpu_sockets}
    type    = "{cpu_type}"
  }}

  memory = {ram_size * 1024}
  balloon = {ram_size * 1024}
  bios = "seabios"
  scsihw = "virtio-scsi-single"

  serial {{
    id   = 0
    type = "socket"
  }}

  vga {{
    type = "serial0"
  }}

  disks {{
    scsi {{
      scsi0 {{
        disk {{
          storage  = "{disk_storage}"
          size     = "{disk_size}G"
          iothread = true
        }}
      }}
    }}
    ide {{
      ide0 {{
        cloudinit {{
          storage = "{cloudinit_storage}"
        }}
      }}
    }}
  }}

  network {{
    id     = 0
    model  = "virtio"
    bridge = "{network_bridge}"
    tag    = {vlan_tag}
  }}

  ipconfig0 = "ip={ip_address}/{cidr},gw={gateway}"
}}

# NetBox
resource "netbox_virtual_machine" "{name}" {{
  name         = proxmox_vm_qemu.{name}.name
  cluster_id   = 1
  device_id    = 1
  vcpus        = {cpu_cores}
  memory_mb    = {ram_size * 1000}
  disk_size_mb = {disk_size * 1000}
  status       = "active"
}}

resource "netbox_interface" "{name}-eth0" {{
  name               = "eth0"
  virtual_machine_id = netbox_virtual_machine.{name}.id
}}

resource "netbox_ip_address" "{name}-ip" {{
  ip_address            = "{ip_address}/{cidr}"
  status                = "active"
  virtual_machine_interface_id = netbox_interface.{name}-eth0.id
}}

resource "netbox_primary_ip" "{name}-primary-ip" {{
  ip_address_id      = netbox_ip_address.{name}-ip.id
  virtual_machine_id = netbox_virtual_machine.{name}.id
}}

resource "netbox_virtual_disk" "{name}-scsi0" {{
  name               = "scsi0"
  size_mb            = {disk_size * 1000}
  virtual_machine_id = netbox_virtual_machine.{name}.id
}}'''

  return file
