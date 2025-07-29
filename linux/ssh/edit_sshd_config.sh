#!/bin/bash
# edit_sshd_config.sh
# 功能：手動編輯 SSH 伺服器設定檔後重新啟動 sshd 服務
# 用途：用於修改 SSH 設定（例如 Port、PermitRootLogin），並立即套用變更
sudo nano /etc/ssh/sshd_config
sudo systemctl restart ssh
