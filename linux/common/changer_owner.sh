#!/bin/bash
# changer_owner.sh
# 功能：將指定資料夾的擁有者變更為 ubuntu 使用者
# 用途：修復 /opt/AI_Docker/market_data_feather 權限問題，讓 ubuntu 可正常讀寫

sudo chown -R ubuntu:ubuntu /opt/AI_Docker/market_data_feather
chmod -R +x script-lab/ # 對所有檔案都加上執行權限（⚠️ 謹慎使用）
find script-lab/ -type f -name "*.sh" -exec chmod +x {} \; # 只改 .sh 檔