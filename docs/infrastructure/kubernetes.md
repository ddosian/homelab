# Kubernetes
"[Kubernetes](https://kubernetes.io/docs/concepts/overview/), also known as K8s, is an open source system for automating deployment, scaling, and management of containerized applications." - [kubernetes.io](https://kubernetes.io/)
## Basic Info 
- **Version:** K3s v1.34.3
- **Deployed:** 7th January 2026
## Architecture 
**High Availability Setup:** 
- 3 control plane nodes with embedded etcd 
- Shared VIP (10.20.40.10) via keepalived for automatic failover 
- 3 worker nodes for workload distribution 
**Network:** 
- Cluster VLAN: 40 (10.20.40.0/24) 
- Control plane VIP: 10.20.40.10 
- Control planes: .11, .12, .13 
- Workers: .21, .22, .23
## Nodes
### Control Planes

| Name      | IP          | CPU            | RAM (GB) |
| --------- | ----------- | -------------- | -------- |
| k3s-cp-01 | 10.20.40.11 | ARM Cortex-A76 | 8        |
| k3s-cp-02 | 10.20.40.12 | ARM Cortex-A76 | 8        |
| k3s-cp-03 | 10.20.40.13 | ARM Cortex-A76 | 8        |
### Workers
| Name          | IP          | CPU                    | RAM (GB) |
| ------------- | ----------- | ---------------------- | -------- |
| k3s-worker-01 | 10.20.40.21 | AMD Ryzen 5 PRO 2400GE | 48       |
| k3s-worker-02 | 10.20.40.22 | Intel i5 8600          | 16       |
| k3s-worker-03 | 10.20.40.23 | Intel i5 8600          | 16       |
## Deployment guide
### Shared VIP for the 3 control planes
#### 1. Install keepalived
```bash
sudo apt install keepalived -y
```
#### 2. Create config file
```bash
sudo nano /etc/keepalived/keepalived.conf
```
For the first node, you want the `state` to be "MASTER", for every other node, you want the `state` to be "BACKUP", which decreasing priority for each node.
##### k3s-cp-01
```
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass REPLACE_THIS_WITH_A_PASSWORD
    }
    virtual_ipaddress {
        10.20.40.10/24
    }
}
```
##### k3s-cp-02
```
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 99
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass REPLACE_THIS_WITH_A_PASSWORD
    }
    virtual_ipaddress {
        10.20.40.10/24
    }
}
```
##### k3s-cp-03
```
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 98
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass REPLACE_THIS_WITH_A_PASSWORD
    }
    virtual_ipaddress {
        10.20.40.10/24
    }
}
```
#### 3. Start & enable the service
```bash
sudo systemctl enable --now keepalived
```
### Initialise the first control plane
```bash
curl -sfL https://get.k3s.io | K3S_TOKEN=REPLACE sh -s - server --cluster-init --tls-san=10.20.40.10 --disable=traefik --disable=servicelb
```
### Add the other two control planes
```bash
curl -sfL https://get.k3s.io | K3S_TOKEN=REPLACE sh -s - server --server https://10.20.40.10:6443 --tls-san=10.20.40.10 --disable=traefik --disable=servicelb
```

### Adding worker nodes
#### 1. grab `K3S_TOKEN` from master
```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```
#### 2. Add each worker node
```
curl -sfL https://get.k3s.io | K3S_URL=https://10.20.40.10:6443 K3S_TOKEN=REPLACE sh -
```
