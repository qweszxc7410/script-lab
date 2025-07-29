#!/bin/bash
# === 更改目錄擁有者為 ubuntu ===
# ls -l /opt/AI_Docker/change_owner.sh
sudo chown -R ubuntu:ubuntu /opt/AI_Docker
# 增加執行權限
chmod +x change_owner.sh
