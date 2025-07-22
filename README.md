# 🚀 組織專案初始化模板

本專案為 noneresearchlab 組織的起始模板，提供一鍵初始化流程，讓每位成員快速開始開發。
[注意] : 需要先在github上面建立專案
---

## ✅ 使用方式

### 1️⃣ Clone 專案

```bash
git clone git@github.com:noneresearchlab/org-project-template.git 你的專案名稱
cd 你的專案名稱
```

### 2️⃣ 修改 `.gitidentity`

```
[identity]
user_name = 你的名稱
user_email = 你的 email
ssh_key = id_rsa_你的金鑰檔名
remote = git@github-org:noneresearchlab/你的專案名稱.git
```

---

### 3️⃣ 初始化專案
## 注意 要先在github上面建立專案然後開放權限(Settings -> Collaborators and teams)

```bash
bash git_scripts/init_project.sh
```

這會自動完成：
- 初始化 Git 倉庫（如需要）
- 套用 Git 身份與 SSH 金鑰
- 把 `.env(backup)` → `.env`
- 把 `.gitignore(backup)` → `.gitignore`

---

## 📂 初始檔案說明

| 檔案 | 說明 |
|------|------|
| `.env(backup)` | 範例環境變數，會被轉成 `.env` |
| `.gitignore(backup)` | 範例忽略檔，會被轉成 `.gitignore` |
| `.gitidentity` | Git 使用者與 remote 設定 |
| `scripts/init_project.sh` | 一鍵初始化主腳本 |

---

## 🛑 注意

- 請勿將私密金鑰放入專案中
- `.env` 不應上傳，會被 `.gitignore` 忽略
- clone 後請先修改 `.gitidentity` 再執行初始化腳本


