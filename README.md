# Homelab

If you are viewing on GitHub, you can view this repo on my self-hosted instance of Gitea <a href="https://gitea.dontddos.me/dontddos/homelab">here</a>.
## 🖥️ Hardware

| Component | Model / Specs                                                     | Role                  |
| --------- | ----------------------------------------------------------------- | --------------------- |
| Firewall  | pfsense on pve-01                                                 | Edge firewall, DHCP   |
| Switch    | Arista DCS-7010T                                                  | Core / L3 switch      |
| PVE-01    | HPE ProLiant DL360 Gen 9<br>2x Intel Xeon E5-2673 v3<br>128GB RAM | Virtualisation server |
| TrueNAS   | AMD FX-6100<br>24GB RAM<br>8TB Storage                            | Storage               |

##  🚀 Services, Applications & Deployments
### Infrastructure
- [**Proxmox VE**](docs/infrastructure/proxmox-ve.md) - Type 1 hypervisor
- **Docker** - Containerisation 

### Networking
- **pfSense** - Edge firewall, DHCP
- **AdGuard Home** - DNS
- **Pangolin** - Proxy for external HTTP traffic
- **Nginx** - Proxy for internal HTTP traffic
- **Tailscale** - Remote access via VPN

### Security
- **Vaultwarden** - Password manager
- Authentik - SSO and OIDC
- **CrowdSec** - Intrusion prevention
- **Wazuh** - Security monitoring and SIEM

### Storage
- **TrueNAS** - NAS solution

### Media Stack
- **Jellyfin** - Streaming
- **Jellyseer** - Requests
- **Radarr** - Movie index manager
- **Sonarr** - Show index manager
- **Prowlarr** - Torrent manager
- **qBittorrent** - 😉

### Communication
- **Mailcow** - mail
- **Synapse** - Self-hosted, decentralised communication

### Games
- **Pelican** - Game servers

## 🌐 Network Architecture 
**Key Features:**
- Segmented VLANs for security and organization
- Arista DCS-7010T providing L3 switching
- pfSense handling firewall rules and DHCP
- AdGuard Home for DNS filtering across all VLANs

**Detailed network documentation:** [docs/networking.md](docs/networking.md)