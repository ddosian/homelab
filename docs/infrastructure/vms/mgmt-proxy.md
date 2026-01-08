# mgmt-proxy
**Purpose**: Hosts the instance of Nginx that proxies all http traffic for iLO & other management interfaces.
## Networking
- **VLAN**: 10 (Management/mgmt)
- **Firewall Rules**: can be accessed by LAN, only on ports 22, 80 & 443
