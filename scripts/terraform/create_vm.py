import random
import os
import sys

def prompt(message, default):
    users_input = input(f"{message} [{default}]: ")
    if users_input == "":
        return default
    else:
        return users_input

name = prompt("VM Name", str(random.randint(800, 899)))
target_node = prompt("Target Node", "pve-01")
template = prompt("Template", "ubuntu-24.04-template")
cpu_cores = prompt("CPU Cores", "4")
cpu_sockets = prompt("CPU Sockets", "1")
cpu_type = prompt("CPU Type", "host")
ram_size = int(prompt("RAM Size in GB", "4"))
disk_storage = prompt("Disk Storage", "disk-02")
disk_size = int(prompt("Disk Storage in GB", "32"))
if disk_size < 32:
    print("WARNING: Disk size cannot be smaller than 32, setting to 32.")
    disk_size = 32
cloudinit_storage = prompt("Cloud Init Storage", "local-lvm")
network_bridge = prompt("Network Bridge", "vmbr1")
vlan_tag = prompt("VLAN Tag", "1")
ip_address = prompt("IP Address", "10.77.x.x")
cidr = prompt("CIDR Prefix", "16")
gateway = prompt("Gateway", "10.77.0.1")

path = prompt("Path to File", f"/Users/ddos/homelab/terraform/vm-{name}.tf")

file = f'''
resource "proxmox_vm_qemu" "{name}" {{
  name        = "{name}"
  target_node = "{target_node}"
  clone       = "{template}"

  agent = 1
  start_at_node_boot = true

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
  cluster_id   = data.netbox_cluster.pve-01.id
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
}}
'''

path = os.path.expanduser(path)
parent_dir = os.path.dirname(path)
if parent_dir:
    os.makedirs(parent_dir, exist_ok=True)

if os.path.exists(path):
    overwrite = prompt(f"File {path} exists. Overwrite?", "no")
    if overwrite.lower() not in ("y", "yes"):
        print("Aborted: file not overwritten.")
        sys.exit(0)

with open(path, "w", encoding="utf-8") as f:
    f.write(file)

print(f"Saved file to {path}")
print("FINISHED")