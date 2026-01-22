# MicroCloud

- **Deployment Date:** 22nd January 2026

## Instilation Commands
```bash
sudo ip link set ens19 up

sudo snap install lxd microceph microovn microcloud --cohort="+"
sudo snap refresh lxd microceph microovn microcloud --hold

sudo microcloud init
sudo microcloud join
```