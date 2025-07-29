# 03_storage
本資料夾整合了多種 Linux 環境下的檔案分享方式，包括 NFS、SMB、FTP，分別用於不同平台或用途的檔案共享。

---

## 📂 結構總覽

ftp/
  - 建立 FTP 伺服器，提供檔案上傳／下載
  - 支援匿名或本機帳號登入
  - 適合外部系統擷取檔案或對外公開報表

nfs/
  - 架設 NFS Server 與 Client
  - 適合 Linux ↔ Linux 間共享（如叢集架構）
  - 通常搭配 UID/GID 權限共享，不需登入帳號

smb/
  - 架設 Samba Server
  - 提供 Windows ↔ Linux 的資料夾共享
  - 可設定 guest 存取或使用者登入

---

## 🔍 使用情境建議

| 目的             | 建議協定 |
|------------------|-----------|
| Linux 內網共享     | NFS       |
| Windows 要掛載資料夾 | SMB       |
| 提供報表、模型下載 | FTP       |
| 給外部用戶下載資料 | FTP       |
| 多機協作共用大資料 | NFS / SMB |

---

## 🚧 注意事項

- 所有分享方式預設在區網內使用，未考慮加密傳輸（如需 FTPS / VPN 請自行補強）
- FTP / SMB 支援匿名存取者，請留意權限設置與目錄資料內容
- NFS 沒有帳號密碼保護，建議搭配 IP 白名單 + no_root_squash 控制

---

## ✅ 後續規劃

- 可加入 WebDAV 或 SFTP 模組
- 可整合成 Docker 版儲存分享服務

- [NFS 設定教學](./nfs/server/00_reminder.md)
- [SMB 設定教學](./smb/00_reminder.md)
- [FTP 設定教學](./ftp/00_reminder.md)
