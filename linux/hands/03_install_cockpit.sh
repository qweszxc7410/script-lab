#!/bin/bash
# 03_install_cockpit.sh
# 功能：安裝 Cockpit 系統管理介面並啟用服務
# 用途：提供 Web UI 介面，用於遠端瀏覽與管理本機資源（CPU、記憶體、磁碟、服務等），可做為 Cluster 主控節點或被控節點使用
sudo apt install -y cockpit
sudo systemctl enable --now cockpit
