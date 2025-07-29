# 00_reminder.md
## ⚠️ Samba Server 設定前提醒

請確認以下事項：

1️⃣ 你希望讓哪一個資料夾被 Windows 讀寫共享？  
   - 預設為 `/opt/AI_Docker/shared`  
   - 可以透過 `01_samba_server_setup.sh` 修改變數 `SHARE_DIR`

2️⃣ Windows 端連線方式：
   - 直接在檔案總管輸入：
     ```
     \\伺服器IP\shared
     ```
     例如：`\\192.168.1.106\shared`
   - 預設為無密碼匿名訪問

3️⃣ 權限與安全性提醒：
   - 預設開放所有人讀寫（`chmod 777`）
   - 若希望限制存取，請在 `/etc/samba/smb.conf` 中設定使用者登入與權限

4️⃣ 若未成功連線，請確認：
   - 防火牆未封鎖 TCP 445 / 139
   - Windows 已啟用「SMB 1.0/CIFS 支援」（部分舊版需要）
