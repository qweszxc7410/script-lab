# 📦 pdsh 安裝與使用說明

## ✅ 安裝腳本使用方式

為了讓環境變數（如 `PDSH_RCMD_TYPE=ssh`）能立即在當前 shell 生效，請使用 `source` 而不是直接執行腳本，否則變數只會在子 shell 中有效。

### ⛔ 錯誤用法（變數不會留在目前 shell）

```
./01_install_pdsh.sh
```

### ✅ 正確用法（建議）

```
source ./01_install_pdsh.sh
```

或簡寫：

```
. ./01_install_pdsh.sh
```

這樣設定的環境變數（如 `export PDSH_RCMD_TYPE=ssh`）才會在你目前的 shell 立即生效，不需要重開終端機。

---

## 🧠 為什麼要這樣？

Bash 腳本中使用 `export` 設定的環境變數，**只會在該腳本的子 shell 中生效**。  
如果你用 `./xxx.sh` 執行腳本，變數不會回傳到你目前的 shell。  
只有使用 `source` 才能讓變數在你目前的 session 中立刻有效。

---

## 📌 推薦步驟

1. 建立 `hostlist.txt`，每行寫一台節點 IP  
2. 使用 `source ./01_install_pdsh.sh` 安裝 pdsh 並自動設定 ssh 模式  
3. 使用 `pdsh -w ^hostlist.txt "hostname"` 測試連線

---
