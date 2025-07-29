#!/bin/bash
# fetch_from_usb_remote.sh
# 功能：掛載 USB、複製金鑰、透過 SCP 抓取遠端資料，最後卸載 USB
# 用途：從 USB 取得私鑰，下載遠端目錄並儲存至 USB 裝置中

# 顯示磁碟與掛載資訊
lsblk -f

# 掛載 USB 裝置（請確保 /dev/sda1 是正確的裝置）
sudo mount /dev/sda1 /mnt/usb

# 複製金鑰到家目錄並設定權限
cp /mnt/usb/A10_2.pem ~/
chmod 400 ~/A10_2.pem

# 從遠端伺服器下載資料到 USB（請確認遠端主機與路徑正確）
rsync -av -e "ssh -i ~/A10_2.pem" ubuntu@132.145.137.151:/home/ubuntu/A10/ /media/ubuntu/USB_Drive/Xtal_v6/A10/

# 卸載 USB 裝置
sudo umount /media/ubuntu/USB_Drive
