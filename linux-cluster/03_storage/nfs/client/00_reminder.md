# 00_reminder.md
## ⚠️ NFS Client 設定前提醒

在執行 `01_setup_nfs_client.sh` 前，請先確認以下事項：

---

### 1️⃣ **確認 NFS Server 已啟用並設定完成**
- 建議先在 server 執行完 `server/01_setup_nfs_server.sh`
- 確認 Server 上的 `/etc/exports` 有分享對應路徑
- Server IP 預設為：`192.168.1.106`

---

### 2️⃣ **請根據實際狀況修改以下變數**
可在 `01_setup_nfs_client.sh` 最上方調整：

```bash
SERVER_IP="192.168.1.106"              # ← 你的 NFS Server IP
REMOTE_DIR="/opt/AI_Docker/shared"     # ← Server 端共用目錄
LOCAL_MOUNT="/mnt/shared_nfs"          # ← Client 掛載目錄
