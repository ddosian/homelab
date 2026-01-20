# Homelab

If you are viewing on GitHub, you can view this repo on my self-hosted instance of Gitea <a href="https://gitea.dontddos.me/dontddos/homelab">here</a>.

## 📋 Table of Contents
- [Overview](#-overview)
- [Physical Setup](#-physical-setup)
- [Status / Uptime](#-status--uptime)
- [Hardware](#-hardware)
- [Services, Applications & Deployments](#-services-applications--deployments)
- [Links](#-links)
## 👁️ Overview

**About Me:**
- **Age:** 16
- **Location:** London, England
- **Experience:** 2+ years of homelab
- **Career Goal:** Datacenter/Network Engineer
- **Current Focus:** GCSEs & CCNA certification

**About This Lab:**
- **Current Lab Started**: 4th January 2026
- **First Lab**: mid 2024 - late 2025 (estimate)
- **Purpose**: to learn more about networking, infrastructure management, git, CI/CD and other IT related topics
- **Contents**: this git repo contains most, if not all, of my homelab infrastructure
- **Scale**: I still consider this lab to be a relatively small one

## 📸 Physical Setup

![Lab](imgs/lab.png)

<details>
<summary>Show More</summary>

### Pi cluster
![Pis](imgs/pis.png)

</details>

## ✅ Status / Uptime
Full Status page: https://status.dontddos.me

| Service       | Status                                                                                           | Uptime (365d)                                                                                                                       |
| ------------- | ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| dontddos.me   | [![](https://status.dontddos.me/api/badge/30/status)](https://status.dontddos.me) | [![](https://status.dontddos.me/api/badge/30/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me) |
| PVE-01        | [![](https://status.dontddos.me/api/badge/1/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/1/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |
| K3s-CP-01     | [![](https://status.dontddos.me/api/badge/2/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/2/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |
| K3s-CP-02     | [![](https://status.dontddos.me/api/badge/3/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/3/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |
| K3s-CP-03     | [![](https://status.dontddos.me/api/badge/4/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/4/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |
| K3s-Worker-01 | [![](https://status.dontddos.me/api/badge/5/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/5/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |
| K3s-Worker-02 | [![](https://status.dontddos.me/api/badge/6/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/6/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |
| K3s-Worker-03 | [![](https://status.dontddos.me/api/badge/7/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/7/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |
| pfSense       | [![](https://status.dontddos.me/api/badge/9/status)](https://status.dontddos.me)  | [![](https://status.dontddos.me/api/badge/9/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)  |


## 🖥️ Hardware

| Component     | Model / Specs                                                     | Role                     |
| ------------- | ----------------------------------------------------------------- | ------------------------ |
| Firewall      | pfsense on pve-01                                                 | Edge firewall, DHCP      |
| Switch        | Arista DCS-7010T                                                  | Core / L3 switch         |
| PVE-01        | HPE ProLiant DL360 Gen 9<br>2x Intel Xeon E5-2673 v3<br>128GB RAM | Virtualisation server    |
| K3s-CP-01     | Raspberry Pi 5<br>ARM Cortex-A76<br>8GB RAM                       | Kubernetes control plane |
| K3s-CP-02     | Raspberry Pi 5<br>ARM Cortex-A76<br>8GB RAM                       | Kubernetes control plane |
| K3s-CP-03     | Raspberry Pi 5<br>ARM Cortex-A76<br>8GB RAM                       | Kubernetes control plane |
| K3s-Worker-01 | HP EliteDesk G4 800<br>Intel i5 8600<br>16GB RAM                  | Kubernetes worker        |
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
- **Pangolin** - Reverse proxy for external HTTP traffic (internet-facing)
- [**Traefik**](kubernetes/traefik/traefik) - Proxy for internal HTTP traffic to Kubernetes
- [**Nginx**](docker/multi-host/proxy/) - Proxy for internal HTTP traffic
- **Tailscale** - Remote access via VPN

### Monitoring
- [**Uptime Kuma**](kubernetes/monitoring/uptime-kuma/) - Uptime monitoring
- [**Grafana**](kubernetes/monitoring/grafana/)
- [**Prometheus**](kubernetes/monitoring/prometheus/)
- [**LibreNMS**](kubernetes/monitoring/librenms/) - SNMP based network monitoring
- [**OpenSpeedTest**](docker/docker-01/openspeedtest/)


### Security
- [**Vaultwarden**](docker/docker-01/vaultwarden/) - Password manager
- [**Authentik**](docker/docker-02/authentik/) - SSO and OIDC
- **CrowdSec** - IPS monitoring for all incoming traffic
- [**Wazuh**](docker/wazuh/wazuh/) - Security monitoring and SIEM
- [**Cert Manager**](kubernetes/cert-manager/cert-manager/) - Automated SSL/TLS certificate management

### Git & CI/CD
- [**Gitea**](docker/docker-02/gitea/) - Self-hosted Git service
- **ArgoCD** - Continuous delivery tool for Kubernetes deployments

### Storage
- [**Longhorn**](/kubernetes/longhorn-system/longhorn/) - Distributed block storage system for Kubernetes persistent volumes
- [**CloudNative PG**](/kubernetes/cnpg-system/cnpg/)
- **TrueNAS** - NAS solution
- [**Nextcloud**](kubernetes/nextcloud/nextcloud/)

### Dashboards
- [**Homarr**](kubernetes/homarr/homarr/)

### Media Stack
- [**Jellyfin**](docker/docker-02/jellyfin/) - Streaming
- [**Jellyseerr**](docker/docker-02/jellyseerr) - Requests
- **Radarr** - Movie index manager
- **Sonarr** - Show index manager
- **Prowlarr** - Torrent manager
- **qBittorrent** - 😉

### Communication
- **Mailcow** - Mail

### Automation
- [**Ansible**](ansible/)
- [**Semaphore**](kubernetes/semaphore/semaphore/)
- [**n8n**](kubernetes/n8n/n8n/)

### Games
- [**Pelican**](docker/docker-02/pelican/) - Game panel
- **Wings** - Game servers

### Remote management
- [**Rustdesk**](docker/docker-01/rustdesk/)
- [**Guacamole**](docker/docker-01/guacamole/)

## 🔗 Links 
- **Status Page:** https://status.dontddos.me
- **Personal Website:** https://dontddos.me 
- **GitHub:** https://github.com/ddosian 
- **Self-hosted Gitea:** https://gitea.dontddos.me