echo -e "192.168.1.106\n192.168.1.104" > ~/hostlist.txt
echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc # 設定 pdsh 使用 ssh
source ~/.bashrc
# 使用 pdsh 連線到多台主機並執行命令
chmod +x trust_all_hosts.sh
./trust_all_hosts.sh