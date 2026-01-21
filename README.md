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
- [**Proxmox VE**](docs/infrastructure/proxmox-ve.md) - Type 1 hypervisor used to run and manage virtual machines and containers on the homelab server.
- [**Portainer**](kubernetes/portainer/portainer) - Lightweight web UI for managing Docker and Kubernetes resources across hosts and clusters.
- [**Kubernetes**](docs/infrastructure/kubernetes.md) - k3s-based container orchestration platform for running most services in the cluster.
 - **OpenStack** - Private cloud platform for managing VMs, networks and block/object storage
- **Docker** - Container runtime used for lightweight services and quick deployments outside Kubernetes.

### Networking
- **pfSense** - Edge firewall, VLAN routing and DHCP provider for the lab network.
- [**AdGuard Home**](docker/docker-01/adguard-home/) - DNS-level ad and tracker blocking for the entire network.
- **Pangolin** - Public-facing reverse proxy securing and routing external HTTP/S traffic to internal services.
- [**Traefik**](kubernetes/traefik/traefik) - In-cluster ingress controller routing HTTP/S traffic to Kubernetes services.
- [**Nginx**](docker/multi-host/proxy/) - Reverse proxy and TLS termination for Docker-based services not in Kubernetes.
- **Tailscale** - WireGuard-based mesh VPN for secure remote access to the lab.

### Monitoring
- [**Uptime Kuma**](kubernetes/monitoring/uptime-kuma/) - Simple uptime and alerting dashboard for HTTP/ICMP checks.
- [**Grafana**](kubernetes/monitoring/grafana/) - Dashboarding and visualization for metrics and logs.
- [**Prometheus**](kubernetes/monitoring/prometheus/) - Metrics collection and alerting for cluster and service monitoring.
- [**OpenSpeedTest**](docker/docker-01/openspeedtest/) - Browser-based network speed testing hosted on the lab.

### Security
- [**Vaultwarden**](docker/docker-01/vaultwarden/) - Self-hosted password manager compatible with Bitwarden clients.
- [**Authentik**](docker/docker-02/authentik/) - Identity provider offering SSO, LDAP/SSO integration and OIDC authentication.
- **CrowdSec** - Collaborative IPS that analyzes logs and blocks abusive IPs across services.
- **Fail2Ban** - Simple intrusion prevention that bans IPs showing malicious behaviour on exposed services.
- [**Wazuh**](docker/wazuh/wazuh/) - Host and security monitoring, SIEM-style alerting and log analysis.
- [**Cert Manager**](kubernetes/cert-manager/cert-manager/) - Automates issuance and renewal of TLS certificates inside Kubernetes.

### Git & CI/CD
- [**Gitea**](docker/docker-02/gitea/) - Lightweight self-hosted Git hosting for repositories and basic CI integrations.
- **ArgoCD** - GitOps continuous deployment tool that reconciles Kubernetes manifests stored in Git to the cluster.

### Storage
- [**Longhorn**](/kubernetes/longhorn-system/longhorn/) - Distributed block storage solution for persistent volumes in Kubernetes.
- [**CloudNative PG**](/kubernetes/cnpg-system/cnpg/) - PostgreSQL operator for running clustered/managed Postgres in Kubernetes.
- **TrueNAS** - Central NAS for bulk storage, backups and ISO/media hosting.
- [**Nextcloud**](kubernetes/nextcloud/nextcloud/) - Self-hosted file sync, calendar, contacts and collaboration platform.

### Dashboards
- [**Homarr**](kubernetes/homarr/homarr/) - User-facing application dashboard to quickly access and visualise services and links.

### Media Stack
- [**Jellyfin**](docker/docker-02/jellyfin/) - Media server for streaming personal video and audio collections.
- [**Jellyseerr**](docker/docker-02/jellyseerr) - Requests manager for Jellyfin (requesting and approval workflow).
- **Radarr** - Movie collection manager and automatic downloader for new releases.
- **Sonarr** - TV show collection manager and automatic episode downloader.
- **Prowlarr** - Indexer manager that integrates with Sonarr/Radarr to manage torrent/usenet indexers.
- **qBittorrent** - Torrent client used by download automation tools.

### Communication
- **Mailcow** - Full mail server suite providing mailboxes, webmail and spam/virus filtering for personal domains.

### Automation
- [**Ansible**](ansible/) - Configuration management and orchestration used for provisioning hosts and services.
- [**Semaphore**](kubernetes/semaphore/semaphore/) - Self-hosted job runner for automation tasks and playbook execution.
- [**n8n**](kubernetes/n8n/n8n/) - Workflow automation/orchestration for integrating APIs and automating repetitive tasks.

### Games
- [**Pelican**](docker/docker-02/pelican/) - Game panel for hosting and managing game servers.
- **Wings** - Game server management stack (backend for some game servers).

### Remote management
- [**Rustdesk**](docker/docker-01/rustdesk/) - Remote desktop solution for ad-hoc support and remote access.
- [**Guacamole**](docker/docker-01/guacamole/) - Browser-based remote desktop gateway (RDP/VNC/SSH) for managing systems.

## 🔗 Links 
- **Status Page:** https://status.dontddos.me
- **Personal Website:** https://dontddos.me 
- **GitHub:** https://github.com/ddosian 
- **Self-hosted Gitea:** https://gitea.dontddos.me