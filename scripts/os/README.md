## 開機自動啟動
```
sudo nano /etc/systemd/system/docker-container-start.service
head -n 1 /opt/AI_Docker/scripts/os/start_all_containers.sh
sudo chmod +x /opt/AI_Docker/scripts/os/start_all_containers.sh
sudo dos2unix /opt/AI_Docker/scripts/os/start_all_containers.sh
sudo systemctl daemon-reload
sudo systemctl restart docker-container-start.service
sudo systemctl status docker-container-start.service
sudo reboot
```

## container加入特定網路 -> add_docker_networl.sh