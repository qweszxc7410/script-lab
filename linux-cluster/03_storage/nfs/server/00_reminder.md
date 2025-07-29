# 00_reminder.md
## ⚠️ 前置提醒事項

在執行 `01_setup_nfs_server.sh` 前，請確認：

1️⃣ **本機 IP 為內網，例如：192.168.1.x**

2️⃣ **你希望哪些機器可以存取此 NFS Server？**
   - 預設是開放給 `192.168.1.0/24` 整個區段
   - 如果要限制為特定主機，請修改 `01_setup_nfs_server.sh` 裡的 `/etc/exports` 那一行

3️⃣ **如果 `/opt/AI_Docker/shared` 已存在，請確認內容是否會被共用**

---

### 📌 進階選項

如需變更共用資料夾位置，請修改腳本內：
```bash
SHARE_DIR="/opt/AI_Docker/shared"


chmod +x 01_setup_nfs_server.sh
./01_setup_nfs_server.sh