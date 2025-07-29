#!/bin/bash
# ssh.sh
# 功能：初始化 pdsh 的 SSH 設定環境，並建立主機清單
# 用途：用於設定 cluster 環境下的 pdsh，使其能透過 SSH 控制多台主機（包含自己）

# 建立 pdsh 主機清單（hostlist.txt），包含所有節點 IP（可自行修改順序）
echo -e "192.168.1.106\n192.168.1.104\n" > ~/hostlist.txt
echo "✅ 已建立 ~/hostlist.txt"

# 加入 pdsh 設定到 ~/.bashrc（避免重複寫入）
if ! grep -q 'PDSH_RCMD_TYPE=ssh' ~/.bashrc; then
  echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc
  echo "✅ 已加入 PDSH_RCMD_TYPE 設定到 ~/.bashrc"
fi

# 立即套用設定
source ~/.bashrc
echo "✅ 已套用 .bashrc，pdsh 將使用 ssh 模式連線"

# 提示後續操作
echo "💡 建議接著執行 distribute_pubkey.sh 以建立免密登入"
echo "✅ SSH 環境設定完成，現在可以用 pdsh 控制主機"
