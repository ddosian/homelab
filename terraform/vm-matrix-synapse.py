import utils

# General Settings
name = "matrix-synapse"
target_node = "pve-02"
template = "ubuntu-24.04-template"

# CPU Settings
cpu_cores = 2
cpu_sockets = 1
cpu_type = "host"

# RAM Settings
ram_size = 8

# Storage Settings
disk_storage = "local-lvm"
disk_size = 128
cloudinit_storage = "local-lvm"

# Network Settings
network_bridge = "vmbr0"
vlan_tag = 20
ip_address = "10.20.20.102"
cidr = "24"
gateway = "10.20.20.1"

with open("vm-matrix-synapse.tf", "w") as f:
    f.write(utils.generate_file(name, target_node, template, cpu_cores, cpu_sockets, cpu_type, ram_size, disk_storage, disk_size, cloudinit_storage, network_bridge, vlan_tag, ip_address, cidr, gateway))