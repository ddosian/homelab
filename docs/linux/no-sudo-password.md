```bash
echo "ddos ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ddos
sudo chmod 440 /etc/sudoers.d/ddos
sudo whoami
```