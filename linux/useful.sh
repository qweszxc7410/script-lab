chmod -R +x script-lab/ # 對所有檔案都加上執行權限（⚠️ 謹慎使用）
find script-lab/ -type f -name "*.sh" -exec chmod +x {} \; # 只改 .sh 檔