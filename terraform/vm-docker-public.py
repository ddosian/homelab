import utils

# General Settings
name = "docker-public"
target_node = "pve-01"
template = "ubuntu-24.04-template"

# CPU Settings
cpu_cores = 4
cpu_sockets = 1
cpu_type = "host"

# RAM Settings
ram_size = 16

# Storage Settings
disk_storage = "disk-02"
disk_size = 64
cloudinit_storage = "local-lvm"

# Network Settings
network_bridge = "vmbr1"
vlan_tag = 20
ip_address = "10.20.20.109"
cidr = "16"
gateway = "10.20.20.1"

with open("vm-docker-public.tf", "w") as f:
    f.write(utils.generate_file(name, target_node, template, cpu_cores, cpu_sockets, cpu_type, ram_size, disk_storage, disk_size, cloudinit_storage, network_bridge, vlan_tag, ip_address, cidr, gateway))