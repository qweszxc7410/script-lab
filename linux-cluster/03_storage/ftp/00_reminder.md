# 00_reminder.md
## FTP Server 設定前提醒（vsftpd）

1️⃣ 預設使用 vsftpd，資料放置於：
    /srv/ftp

2️⃣ 匿名訪問已啟用，適合以下情境：
    - 內網使用（不建議直接暴露在公網）
    - 提供無帳號下載連結給使用者
    - 上傳功能預設關閉（可自行啟用）

3️⃣ 若要允許匿名上傳：
    請打開腳本中的設定：
        ALLOW_UPLOAD=true

4️⃣ 測試連線方式（在 Windows 或 Linux 檔案總管中輸入）：
    ftp://<你的IP>
    例如：
    ftp://192.168.1.106

5️⃣ 注意事項：
    - FTP 為明文傳輸，請勿用於敏感資料
    - 建議改用 FTPS 或 SFTP 如需加密傳輸
    - 若網路不通，請確認防火牆未封鎖 port 21

6️⃣ 可用場景範例：
    - 對外提供資料下載（如模型、log、CSV）
    - 自動產出報表並存入 /srv/ftp，供其他設備擷取

7️⃣ 執行方式：
    chmod +x 01_setup_ftp_server.sh
    ./01_setup_ftp_server.sh
