# Proxmox VE
"Proxmox Virtual Environment is a complete, open-source server management platform for enterprise virtualization. It tightly integrates the KVM hypervisor and Linux Containers (LXC), software-defined storage and networking functionality, on a single platform. With the integrated web-based user interface you can manage VMs and containers, high availability for clusters, or the integrated disaster recovery tools with ease." - [proxmox.com](https://www.proxmox.com/en/products/proxmox-virtual-environment/overview)
## VMs

| ID  | Name       | IP           | VLAN | Cores | RAM (GB) | Storage (GB) | Host   |
| --- | ---------- | ------------ | ---- | ----- | -------- | ------------ | ------ |
| 100 | pfsense    | 10.77.0.11   | all  | 2     | 4        | 32           | pve-01 |
| 101 | docker-01  | 10.77.1.101  | 1    | 4     | 24       | 64           | pve-01 |
| 102 | docker-02  | 10.20.20.102 | 20   | 4     | 16       | 64           | pve-01 |
| 104 | mgmt-proxy | 10.20.10.2   | 10   | 1     | 2        | 24           | pve-01 |
| 105 | wings-01   | 10.20.30.105 | 30   | 6     | 16       | 128          | pve-01 |
| 106 | wazuh      | 10.77.1.106  | 1    | 2     | 4        | 32           | pve-01 |
### LXCs

| ID  | Name         | IP   | VLAN | Cores | RAM (GB) | Storage (GB) | Host   |
| --- | ------------ | ---- | ---- | ----- | -------- | ------------ | ------ |
| 103 | tailscale-01 | DHCP | 1    | 1     | 0.5      | 8            | pve-01 |
