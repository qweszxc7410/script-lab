# ssh.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
echo -e "192.168.1.106\n192.168.1.104" > ~/hostlist.txt
echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc # 設定 pdsh 使用 ssh
source ~/.bashrc
# 使用 pdsh 連線到多台主機並執行命令
