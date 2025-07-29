# 📜 腳本總覽（自動產生）

## changer_owner.sh
> linux\common\changer_owner.sh
> changer_owner.sh
> 功能：將指定資料夾的擁有者變更為 ubuntu 使用者
> 用途：修復 /opt/AI_Docker/market_data_feather 權限問題，讓 ubuntu 可正常讀寫
> bash

## find.sh
> linux\common\find.sh
> find_env_and_0050.sh
> 功能：搜尋 /opt/AI_Docker 目錄下的 .env 檔與以 0050_ 開頭的檔案
> 用途：快速定位設定檔與特定命名的資料檔案
> bash

## grep_python.sh
> linux\common\grep_python.sh
> grep_python.sh
> 功能：列出目前所有與 python 相關的執行程序
> 用途：快速檢查是否有正在執行的 Python 程式或背景任務
> bash

## setup_ufw.sh
> linux\firewall\setup_ufw.sh
> ufw_setup.sh
> 功能：安裝並設定 UFW 防火牆規則，預設拒絕進入，只開放 SSH 與選擇性 Webmin
> 用途：用於基礎伺服器防護，快速啟用安全防火牆設定
> bash

## edit_sshd_config.sh
> linux\ssh\edit_sshd_config.sh
> edit_sshd_config.sh
> 功能：手動編輯 SSH 伺服器設定檔後重新啟動 sshd 服務
> 用途：用於修改 SSH 設定（例如 Port、PermitRootLogin），並立即套用變更
> bash

## remove_repeat_ssh_key.sh
> linux\ssh\remove_repeat_ssh_key.sh
> dedup_ssh_keys.sh
> 功能：移除 ~/.ssh/authorized_keys 中的重複公鑰
> 用途：保持 SSH 授權清單乾淨，避免重複登入金鑰造成混亂
> bash

## ssh-keygen.sh
> linux\ssh\ssh-keygen.sh
> ssh.sh
> 功能：清除舊的 SSH 指紋並重新嘗試連線至指定主機
> 用途：用於排除 SSH 指紋衝突，方便初次或重連接測試
> bash

## backup.sh
> linux\system\backup.sh
> backup.sh
> 功能：請補上腳本的功能說明
> 用途：請補上腳本的實際用途
> bash

## mount.sh
> linux\system\mount.sh
> fetch_from_usb_remote.sh
> 功能：掛載 USB、複製金鑰、透過 SCP 抓取遠端資料，最後卸載 USB
> 用途：從 USB 取得私鑰，下載遠端目錄並儲存至 USB 裝置中
> bash

## setup_swap.sh
> linux\system\setup_swap.sh
> swap_setup.sh
> 功能：移除舊的 swap，建立指定大小的新 swap 檔案並啟用
> 用途：用於記憶體不足時擴充虛擬記憶體（適合在 Raspberry Pi、低記憶體系統）
> bash

## truncate_logs.sh
> linux\system\truncate_logs.sh
> truncate_logs.sh
> 功能：保留指定 log 的最後 100 行並修正權限
> 用途：避免 log 過大並維持檔案安全權限設定
> bash

## install_webmin.sh
> linux\tools\install_webmin.sh
> install_webmin.sh
> 功能：自動安裝 Webmin 並新增對應套件源與 GPG 金鑰
> 用途：快速部署 Webmin 管理介面並自動開啟 port 10000（若啟用 UFW）
> bash
