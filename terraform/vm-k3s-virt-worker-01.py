import utils

# General Settings
name = "k3s-virt-worker-01"
target_node = "pve-01"
template = "ubuntu-24.04-template"

# CPU Settings
cpu_cores = 6
cpu_sockets = 1
cpu_type = "host"

# RAM Settings
ram_size = 16

# Storage Settings
disk_storage = "disk-02"
disk_size = 256
cloudinit_storage = "local-lvm"

# Network Settings
network_bridge = "vmbr1"
vlan_tag = 40
ip_address = "10.20.40.31"
cidr = "24"
gateway = "10.20.40.1"

with open("vm-k3s-virt-worker-01.tf", "w") as f:
    f.write(utils.generate_file(name, target_node, template, cpu_cores, cpu_sockets, cpu_type, ram_size, disk_storage, disk_size, cloudinit_storage, network_bridge, vlan_tag, ip_address, cidr, gateway))