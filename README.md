# Homelab

If you are viewing on GitHub, you can view this repo on my self-hosted instance of Gitea <a href="https://gitea.dontddos.me/dontddos/homelab">here</a>.

## 📋 Table of Contents
- [Overview](#-overview)
- [Skills Demonstrated](#-skills-demonstrated)
- [Hardware](#-hardware)
- [Services, Applications & Deployments](#-services-applications--deployments)
- [Network Architecture](#-network-architecture)
- [Goals for the Future](#-goals-for-the-future)
- [Links](#-links)
## 👁️ Overview
- **Lab Started**: 4th January 2026
- **Purpose**: to learn more about networking, infrastructure management, git, CI/CD and other IT related topics
- **Contents**: this git repo contains most, if not all, of my homelab infrastructure
- **Scale**: I still consider this lab to be a relatively small one

## 📚 Skills Demonstrated

**Networking:**
- Enterprise switching (Arista DCS-7010T)
- VLAN configuration and inter-VLAN routing
- Firewall management and security policies (pfSense)
- Network segmentation (DMZ, management, isolated workload VLANs)
- DNS management (AdGuard Home)
- VPN configuration (Tailscale)

**Infrastructure & Virtualisation:**
- Virtualisation platforms (Proxmox VE)
- Container orchestration (Kubernetes/K3s)
- High availability design (3-node control plane with keepalived VIP)
- Hybrid ARM/x86 architecture
- Distributed storage (Longhorn)

**DevOps & Automation:**
- GitOps continuous delivery (ArgoCD)
- Infrastructure as Code (Kubernetes manifests in Git)
- Configuration management
- Automated certificate management (Cert Manager)
- CI/CD concepts

**Security:**
- SIEM implementation (Wazuh)
- Intrusion detection/prevention (CrowdSec)
- Single sign-on (Authentik)
- Network security architecture
- Automated SSL/TLS management

**Operations:**
- Service monitoring (Prometheus + Grafana)
- Container management (Portainer)
## 🖥️ Hardware

| Component     | Model / Specs                                                     | Role                     |
| ------------- | ----------------------------------------------------------------- | ------------------------ |
| Firewall      | pfsense on pve-01                                                 | Edge firewall, DHCP      |
| Switch        | Arista DCS-7010T                                                  | Core / L3 switch         |
| PVE-01        | HPE ProLiant DL360 Gen 9<br>2x Intel Xeon E5-2673 v3<br>128GB RAM | Virtualisation server    |
| K3s-CP-01     | Raspberry Pi 5<br>ARM Cortex-A76<br>8GB RAM                       | Kubernetes control plane |
| K3s-CP-02     | Raspberry Pi 5<br>ARM Cortex-A76<br>8GB RAM                       | Kubernetes control plane |
| K3s-CP-03     | Raspberry Pi 5<br>ARM Cortex-A76<br>8GB RAM                       | Kubernetes control plane |
| K3s-Worker-01 | HP EliteDesk G4 705<br>AMD Ryzen 5 PRO 2400GE<br>48GB RAM         | Kubernetes worker        |
| K3s-Worker-02 | HP EliteDesk G4 800<br>Intel i5 8600<br>16GB RAM                  | Kubernetes worker        |
| K3s-Worker-03 | HP EliteDesk G4 800<br>Intel i5 8600<br>16GB RAM                  | Kubernetes worker        |
| TrueNAS       | AMD FX-6100<br>24GB RAM<br>8TB Storage                            | Storage                  |

##  🚀 Services, Applications & Deployments
### Infrastructure
- [**Proxmox VE**](docs/infrastructure/proxmox-ve.md) - Type 1 hypervisor
- [**Portainer**](kubernetes/portainer/portainer) - Kubernetes & Docker management GUI
- [**Kubernetes**](docs/infrastructure/kubernetes.md) - Container orchestration
- **Docker** - Containerisation 

### Networking
- **pfSense** - Edge firewall, DHCP
- [**AdGuard Home**](docker/docker-01/adguard-home/) - DNS
- **Pangolin** - Proxy for external HTTP traffic
- [**Traefik**](kubernetes/traefik/traefik) - Proxy for internal HTTP traffic to Kubernetes
- [**Nginx**](docker/multi-host/proxy/) - Proxy for internal HTTP traffic
- **Tailscale** - Remote access via VPN
### Monitoring
- [**Grafana**](kubernetes/monitoring/grafana/)
- [**Prometheus**](kubernetes/monitoring/prometheus/)
### Security
- [**Vaultwarden**](docker/dcker-01/vaultwarden/) - Password manager
- [**Authentik**](docker/docker-02/authentik/) - SSO and OIDC
- **CrowdSec** - IPS monitoring for all incoming traffic
- **Wazuh** - Security monitoring and SIEM
- [**Cert Manager**](kubernetes/cert-manager/cert-manager/) - Automated SSL/TLS certificate management

### Git & CI/CD
- [**Gitea**](docker/docker-02/gitea/) - Self-hosted Git service
- **ArgoCD** - Continuous delivery tool for Kubernetes deployments

### Storage
- [**Longhorn**](/kubernetes/longhorn-system/longhorn/) - Distributed block storage system for Kubernetes persistent volumes
- [**CloudNative PG**](/kubernetes/cnpg-system/cnpg/)
- **TrueNAS** - NAS solution

### Media Stack
- [**Jellyfin**](docker/docker-02/jellyfin/) - Streaming
- [**Jellyseer**](docker/docker-02/jellyseerr) - Requests
- **Radarr** - Movie index manager
- **Sonarr** - Show index manager
- **Prowlarr** - Torrent manager
- **qBittorrent** - 😉

### Communication
- **Mailcow** - mail
- **Synapse** - Self-hosted, decentralised communication

### Games
- [**Pelican**](docker/docker-02/pelican/) - Game panel
- **Wings** - Game servers

## 🌐 Network Architecture 
**Network Topology:** 
``` 
Internet
	↓
pfSense (10.77.0.1) - Edge Firewall/Router
	↓
Arista DCS-7010T - Core L3 Switch
	↓
	├─ VLAN 1 (10.77.0.0/16) - Default/LAN
	├─ VLAN 10 (10.20.10.0/24) - Management
	├─ VLAN 20 (10.20.20.0/24) - DMZ (Public Services)
	├─ VLAN 30 (10.20.30.0/24) - Games/Wings
	└─ VLAN 40 (10.20.40.0/24) - Kubernetes Cluster
```
**Key Features:**
- Segmented VLANs for security and organisation
- Arista DCS-7010T providing L3 switching
- pfSense handling firewall rules and DHCP
- AdGuard Home for DNS filtering across all VLANs
**Security Measures:** 
- DMZ isolation for internet-facing services 
- Kubernetes workloads on isolated VLAN 
- Firewall rules controlling inter-VLAN traffic 
- CrowdSec IPS monitoring all incoming traffic
- Wazuh SIEM for security event analysis

**Detailed network documentation:** [docs/networking.md](docs/networking.md)

## 🎯 Goals for the Future

**Infrastructure Improvements:**
- [x] Automated backups for all critical components (VMs, configurations, databases)
- [x] Off-site backups with Backblaze B2
- [ ] Implement Ansible for configuration management automation
- [ ] Deploy LibreNMS for SNMP-based network monitoring
- [ ] Add Netbox for network documentation and IPAM

**Learning & Certification:**
- [ ] Complete CCNA certification
- [ ] Expand monitoring with custom Grafana dashboards
- [ ] Learn Terraform for infrastructure provisioning
- [ ] Implement full GitOps workflow for all services


## 🔗 Links 
- **Personal Website:** https://dontddos.me 
- **GitHub:** https://github.com/ddosian 
- **Self-hosted Gitea:** https://gitea.dontddos.me