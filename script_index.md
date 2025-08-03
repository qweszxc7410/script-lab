# 📜 腳本總覽（自動產生）

## trigger_flow.py
**路徑:** `script-lab\prefect\trigger_flow.py`

**說明:**
- trigger_container_script.py
- 功能：透過 Prefect flow 執行 container 中的 bash 腳本
- 用途：用於觸發容器內 `/app/run.sh` 的自動化任務流程

**語言:** `python`

---

## 00_build.sh
**路徑:** `script-lab\build_image\00_build.sh`

**說明:**
- build_image.sh
- 功能：建構 Prefect 專用的 Docker 映像檔
- 用途：將專案與依賴打包為 image，供容器部署使用

**語言:** `bash`

---

## backup_container.sh
**路徑:** `script-lab\container\backup_container.sh`

**說明:**
- === 備份 Docker Container 成 Image 並導出為 .tar 檔案 ===
- 使用方式：
- ./backup_container.sh <container_id或container_name> <備份image名稱>

**語言:** `bash`

---

## start_all_containers.sh
**路徑:** `script-lab\container\start_all_containers.sh`

**說明:**
- start_all_containers.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## reset_and_force_push.sh
**路徑:** `script-lab\git\reset_and_force_push.sh`

**說明:**
- reset_and_force_push.sh
- 功能：將專案重設為指定 commit 並強制推送至 GitHub（清除歷史）
- 用途：回復特定狀態並同步 GitHub 倉庫

**語言:** `bash`

---

## apply_git_identity.sh
**路徑:** `script-lab\git_scripts\apply_git_identity.sh`

**說明:**
- apply_git_identity.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## init_project.sh
**路徑:** `script-lab\git_scripts\init_project.sh`

**說明:**
- init_project.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## rename_backups.sh
**路徑:** `script-lab\git_scripts\rename_backups.sh`

**說明:**
- rename_backups.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## reset_and_force_push.sh
**路徑:** `script-lab\git_scripts\reset_and_force_push.sh`

**說明:**
- reset_and_force_push.sh
- 功能：將專案重設為指定 commit 並強制推送至 GitHub（清除歷史）
- 用途：回復特定狀態並同步 GitHub 倉庫

**語言:** `bash`

---

## 000_check.sh
**路徑:** `script-lab\k3s-cluster-setup\000_check.sh`

**說明:**
- 000_check.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## 01_install_k3s_server.sh
**路徑:** `script-lab\k3s-cluster-setup\01_install_k3s_server.sh`

**說明:**
- 01_install_k3s_server.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## 02_install_k3s_agents.sh
**路徑:** `script-lab\k3s-cluster-setup\02_install_k3s_agents.sh`

**說明:**
- 02_install_k3s_agents.sh
- 功能：在所有工作節點安裝 K3s Agent 並加入叢集
- pdsh -w 192.168.1.134,192.168.1.118 "sudo /usr/local/bin/k3s-agent-uninstall.sh || true" # 刪除先前的安裝

**語言:** `bash`

---

## OK.sh
**路徑:** `script-lab\k3s-cluster-setup\OK.sh`

**說明:**
- OK.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## reset_to_agent.sh
**路徑:** `script-lab\k3s-cluster-setup\reset_to_agent.sh`

**說明:**
- reset_to_agent.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## 01.buil.sh
**路徑:** `k3s-cluster-setup\test\01.buil.sh`

**說明:**
- 01.buil.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## 02_rtun.sh
**路徑:** `k3s-cluster-setup\test\02_rtun.sh`

**說明:**
- 02_rtun.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## 04.sh
**路徑:** `k3s-cluster-setup\test\04.sh`

**說明:**
- 04.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## uninstall.sh
**路徑:** `script-lab\k3s-cluster-setup\uninstall.sh`

**說明:**
- uninstall.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## changer_owner.sh
**路徑:** `linux\common\changer_owner.sh`

**說明:**
- changer_owner.sh
- 功能：將指定資料夾的擁有者變更為 ubuntu 使用者
- 用途：修復 /opt/AI_Docker/market_data_feather 權限問題，讓 ubuntu 可正常讀寫

**語言:** `bash`

---

## find.sh
**路徑:** `linux\common\find.sh`

**說明:**
- find_env_and_0050.sh
- 功能：搜尋 /opt/AI_Docker 目錄下的 .env 檔與以 0050_ 開頭的檔案
- 用途：快速定位設定檔與特定命名的資料檔案

**語言:** `bash`

---

## grep_python.sh
**路徑:** `linux\common\grep_python.sh`

**說明:**
- grep_python.sh
- 功能：列出目前所有與 python 相關的執行程序
- 用途：快速檢查是否有正在執行的 Python 程式或背景任務

**語言:** `bash`

---

## setup_ufw.sh
**路徑:** `linux\firewall\setup_ufw.sh`

**說明:**
- ufw_setup.sh
- 功能：安裝並設定 UFW 防火牆規則，預設拒絕進入，只開放 SSH 與選擇性 Webmin
- 用途：用於基礎伺服器防護，快速啟用安全防火牆設定

**語言:** `bash`

---

## edit_sshd_config.sh
**路徑:** `linux\ssh\edit_sshd_config.sh`

**說明:**
- edit_sshd_config.sh
- 功能：手動編輯 SSH 伺服器設定檔後重新啟動 sshd 服務
- 用途：用於修改 SSH 設定（例如 Port、PermitRootLogin），並立即套用變更

**語言:** `bash`

---

## remove_repeat_ssh_key.sh
**路徑:** `linux\ssh\remove_repeat_ssh_key.sh`

**說明:**
- dedup_ssh_keys.sh
- 功能：移除 ~/.ssh/authorized_keys 中的重複公鑰
- 用途：保持 SSH 授權清單乾淨，避免重複登入金鑰造成混亂

**語言:** `bash`

---

## ssh-keygen.sh
**路徑:** `linux\ssh\ssh-keygen.sh`

**說明:**
- ssh.sh
- 功能：清除舊的 SSH 指紋並重新嘗試連線至指定主機
- 用途：用於排除 SSH 指紋衝突，方便初次或重連接測試

**語言:** `bash`

---

## backup.sh
**路徑:** `linux\system\backup.sh`

**說明:**
- backup.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## mount.sh
**路徑:** `linux\system\mount.sh`

**說明:**
- fetch_from_usb_remote.sh
- 功能：掛載 USB、複製金鑰、透過 SCP 抓取遠端資料，最後卸載 USB
- 用途：從 USB 取得私鑰，下載遠端目錄並儲存至 USB 裝置中

**語言:** `bash`

---

## setup_swap.sh
**路徑:** `linux\system\setup_swap.sh`

**說明:**
- swap_setup.sh
- 功能：移除舊的 swap，建立指定大小的新 swap 檔案並啟用
- 用途：用於記憶體不足時擴充虛擬記憶體（適合在 Raspberry Pi、低記憶體系統）

**語言:** `bash`

---

## truncate_logs.sh
**路徑:** `linux\system\truncate_logs.sh`

**說明:**
- truncate_logs.sh
- 功能：保留指定 log 的最後 100 行並修正權限
- 用途：避免 log 過大並維持檔案安全權限設定

**語言:** `bash`

---

## install_webmin.sh
**路徑:** `linux\tools\install_webmin.sh`

**說明:**
- install_webmin.sh
- 功能：自動安裝 Webmin 並新增對應套件源與 GPG 金鑰
- 用途：快速部署 Webmin 管理介面並自動開啟 port 10000（若啟用 UFW）

**語言:** `bash`

---

## 00_install_git.sh
**路徑:** `linux-cluster\00_hands\00_install_git.sh`

**說明:**
- install_git.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## 01_install_pdsh.sh
**路徑:** `linux-cluster\00_hands\01_install_pdsh.sh`

**說明:**
- 01_install_pdsh.sh
- 功能：安裝 pdsh 並設定預設使用 ssh 模式與自動接受 host key
- 用途：用於在 cluster 環境中快速部署平行指令工具 pdsh，可透過 SSH 對多台主機下達指令

**語言:** `bash`

---

## 02_setup_ntp_taipei.sh
**路徑:** `linux-cluster\00_hands\02_setup_ntp_taipei.sh`

**說明:**
- setup_ntp_taipei.sh
- 功能：設定系統時區為台北並啟用 NTP 自動校時
- 用途：讓系統維持準確時間，適用於伺服器或樹莓派等設備

**語言:** `bash`

---

## 03_add_swap.sh
**路徑:** `linux-cluster\00_hands\03_add_swap.sh`

**說明:**
- add_swap.sh
- 功能：加開額外 2GB 的 swap 空間
- 用途：用於記憶體不足時，減緩系統壓力，特別是在 K3s 等重載環境

**語言:** `bash`

---

## 00_ssh.sh
**路徑:** `linux-cluster\01_main\00_ssh.sh`

**說明:**
- ssh.sh
- 功能：初始化 pdsh 的 SSH 設定環境，並建立主機清單
- 用途：用於設定 cluster 環境下的 pdsh，使其能透過 SSH 控制多台主機（包含自己）

**語言:** `bash`

---

## 01_distribute_pubkey_clean.sh
**路徑:** `linux-cluster\01_main\01_distribute_pubkey_clean.sh`

**說明:**
- 01_distribute_pubkey_clean.sh（全新主機強制部署版）
- 功能：將 SSH 公鑰分發至 hostlist.txt 所列主機，允許每台輸入密碼，不會跳過未設免密的主機
- ./01_distribute_pubkey_clean.sh

**語言:** `bash`

---

## 02_trust_all_hosts.sh
**路徑:** `linux-cluster\01_main\02_trust_all_hosts.sh`

**說明:**
- trust_all_hosts.sh
- 功能：從 hostlist.txt 建立 SSH 信任（避免 Host key verification failed）
- 用途：從 hostlist.txt 建立 SSH 信任（避免 Host key verification failed）

**語言:** `bash`

---

## 03_sync_ssh_to_all.sh
**路徑:** `linux-cluster\01_main\03_sync_ssh_to_all.sh`

**說明:**
- 03_sync_ssh_to_all.sh（強化版）
- 功能：將 main 主機的 SSH 金鑰與 hostlist.txt 同步到所有節點，並建立雙向免密登入
- 用途：用於初次部署或重設多台主機的 SSH 信任設定，確保所有節點可互相登入以利 Cluster 或批次管理

**語言:** `bash`

---

## 00_install_cockpit.sh
**路徑:** `linux-cluster\02_pdsh\00_install_cockpit.sh`

**說明:**
- 03_install_cockpit.sh
- 功能：安裝 Cockpit 系統管理介面並啟用服務
- 用途：提供 Web UI 介面，用於遠端瀏覽與管理本機資源（CPU、記憶體、磁碟、服務等），可做為 Cluster 主控節點或被控節點使用

**語言:** `bash`

---

## 01_test_pdsh.sh
**路徑:** `linux-cluster\02_pdsh\01_test_pdsh.sh`

**說明:**
- 03_install_cockpit.sh
- 功能：測試PDSH是否安裝成功
- 用途：用於在 cluster 環境中快速部署平行指令

**語言:** `bash`

---

## 01_setup_ftp_server.sh
**路徑:** `03_storage\ftp\01_setup_ftp_server.sh`

**說明:**
- 01_setup_ftp_server.sh
- 功能：安裝與設定 vsftpd，支援本機帳號登入、可上傳，並可選擇是否啟用 TLS
- 用途：建立 FTP 檔案伺服器，支援本機帳號登入與資料上傳

**語言:** `bash`

---

## 01_setup_nfs_client.sh
**路徑:** `nfs\client\01_setup_nfs_client.sh`

**說明:**
- 01_setup_nfs_client.sh
- 功能：自動安裝與掛載 NFS 共享資料夾
- 用途：將 NFS Server 的目錄掛載到本機指定目錄，並加入 /etc/fstab 實現開機自動掛載

**語言:** `bash`

---

## 01_nfs_server_setup.sh
**路徑:** `nfs\server\01_nfs_server_setup.sh`

**說明:**
- 01_setup_nfs_server.sh
- 功能：自動安裝與設定 NFS Server
- 用途：快速佈署 Ubuntu 上的 NFS 分享目錄給區網使用

**語言:** `bash`

---

## 01_samba_server_setup.sh
**路徑:** `03_storage\smb\01_samba_server_setup.sh`

**說明:**
- 01_samba_server_setup.sh
- 功能：自動安裝與設定 Samba Server，將共享資料夾開放給 Windows 存取
- 用途：快速設定 /opt/AI_Docker/shared 為匿名可寫的 Windows 分享路徑

**語言:** `bash`

---

## sync_to_all.sh
**路徑:** `linux-cluster\script\sync_to_all.sh`

**說明:**
- sync_to_all.sh
- 功能：將指定檔案 scp 到 hostlist.txt 中所有機器（自動略過本機 IP）
- 用途：快速同步檔案到 cluster 節點（含免密登入）

**語言:** `bash`

---

## 00_install_docker.sh
**路徑:** `script-lab\prefect\00_install_docker.sh`

**說明:**
- 00_install_docker.sh
- 功能：安裝 Docker 並啟動服務
- 用途：提供 Prefect Server 或其他容器應用程式的前置環境

**語言:** `bash`

---

## 00_build.sh
**路徑:** `prefect\deploy\00_build.sh`

**說明:**
- 00_build.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## 00_build_server.sh
**路徑:** `prefect\server\00_build_server.sh`

**說明:**
- 00_run_prefect_server.sh
- 功能：啟動 Prefect 2.20 Server，避開 docker-compose 相容性問題(避免升級 docker-compose)
- 用途：取代 docker-compose.yml 無法啟動 server 的狀況

**語言:** `bash`

---

## 00_build_worker.sh
**路徑:** `prefect\worker\00_build_worker.sh`

**說明:**
- 00_build_worker.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## auto_git_push_market-sentinel.sh
**路徑:** `script-lab\scripts\auto_git_push_market-sentinel.sh`

**說明:**
- auto_git_push_market-sentinel.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## backup_container.sh
**路徑:** `script-lab\scripts\backup_container.sh`

**說明:**
- === 備份 Docker Container 成 Image 並導出為 .tar 檔案 ===
- 使用方式：
- ./backup_container.sh <container_id或container_name> <備份image名稱>

**語言:** `bash`

---

## change_owner.sh
**路徑:** `script-lab\scripts\change_owner.sh`

**說明:**
- === 更改目錄擁有者為 ubuntu ===
- ls -l /opt/AI_Docker/change_owner.sh
- 增加執行權限

**語言:** `bash`

---

## copy_file.sh
**路徑:** `script-lab\scripts\copy_file.sh`

**說明:**
- copy_file.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## create_docker_networks.sh
**路徑:** `script-lab\scripts\create_docker_networks.sh`

**說明:**
- 建立外部 Docker 網路用的腳本
- 使用前：sudo 權限執行 or 使用者有 docker 權限
- chmod +x create_docker_networks.sh

**語言:** `bash`

---

## dump_crontab.sh
**路徑:** `script-lab\scripts\dump_crontab.sh`

**說明:**
- dump_crontab.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## install_prefect.sh
**路徑:** `script-lab\scripts\install_prefect.sh`

**說明:**
- install_prefect.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## install_webmin.sh
**路徑:** `script-lab\scripts\install_webmin.sh`

**說明:**
- install_webmin.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## move_files.sh
**路徑:** `script-lab\scripts\move_files.sh`

**說明:**
- move_files.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## add_docker_networl.sh
**路徑:** `scripts\os\add_docker_networl.sh`

**說明:**
- add_docker_networl.sh
- 功能：將多個容器加入指定的 Docker 自訂網路（如 ai_chat 與 ai_report）
- 用途：用於建立 container 間的跨服務溝通橋接，支援內網通訊與整合部署

**語言:** `bash`

---

## backup.sh
**路徑:** `scripts\os\backup.sh`

**說明:**
- backup.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## build_log.sh
**路徑:** `scripts\os\build_log.sh`

**說明:**
- build_log.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## changer_owner.sh
**路徑:** `scripts\os\changer_owner.sh`

**說明:**
- changer_owner.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## find.sh
**路徑:** `scripts\os\find.sh`

**說明:**
- find.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## mount.sh
**路徑:** `scripts\os\mount.sh`

**說明:**
- mount.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## nfs.sh
**路徑:** `scripts\os\nfs.sh`

**說明:**
- nfs.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## setup_swap.sh
**路徑:** `scripts\os\setup_swap.sh`

**說明:**
- setup_swap.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## setup_ufw.sh
**路徑:** `scripts\os\setup_ufw.sh`

**說明:**
- setup_ufw.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## start_all_containers.sh
**路徑:** `scripts\os\start_all_containers.sh`

**說明:**
- start_all_containers.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## truncate_logs.sh
**路徑:** `scripts\os\truncate_logs.sh`

**說明:**
- truncate_logs.sh
- 功能：保留指定 log 的最後 100 行並修正權限
- 用途：避免 log 過大並維持檔案安全權限設定

**語言:** `bash`

---

## push.sh
**路徑:** `script-lab\scripts\push.sh`

**說明:**
- push.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---

## run_and_push.sh
**路徑:** `script-lab\scripts\run_and_push.sh`

**說明:**
- run_and_push.sh
- 功能：請補上腳本的功能說明
- 用途：請補上腳本的實際用途

**語言:** `bash`

---
