# Kubernetes
"[Kubernetes](https://kubernetes.io/docs/concepts/overview/), also known as K8s, is an open source system for automating deployment, scaling, and management of containerized applications." - [kubernetes.io](https://kubernetes.io/)
## Nodes
### Control Planes

| Name      | IP          | CPU | RAM (GB) |
| --------- | ----------- | --- | -------- |
| k3s-cp-01 | 10.20.40.11 |     | 8        |
| k3s-cp-02 | 10.20.40.12 |     | 8        |
| k3s-cp-03 | 10.20.40.13 |     | 8        |
### Workers
| Name          | IP          | CPU                    | RAM (GB) |
| ------------- | ----------- | ---------------------- | -------- |
| k3s-worker-01 | 10.20.40.21 | AMD Ryzen 5 PRO 2400GE | 48       |
| k3s-worker-02 | 10.20.40.22 | Intel i5 8600          | 16       |
| k3s-worker-03 | 10.20.40.23 | Intel i5 8600          | 16       |