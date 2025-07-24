#!/bin/bash
# 01_install_pdsh.sh
# 功能：安裝 pdsh 並設定預設使用 ssh 模式與自動接受 host key
# 用途：用於在 cluster 環境中快速部署平行指令工具 pdsh，可透過 SSH 對多台主機下達指令

echo "📦 安裝 pdsh..."
sudo apt update
sudo apt install -y pdsh

echo "🔧 設定 PDSH 預設使用 ssh 模式與自動接受 SSH host key（寫入 ~/.bashrc）..."
if ! grep -q "PDSH_RCMD_TYPE=ssh" ~/.bashrc; then
  echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc
  echo "✅ 已加入 ~/.bashrc：PDSH_RCMD_TYPE=ssh"
else
  echo "⚠️ ~/.bashrc 中已存在 PDSH_RCMD_TYPE 設定，略過"
fi

if ! grep -q "PDSH_SSH_ARGS_APPEND=" ~/.bashrc; then
  echo 'export PDSH_SSH_ARGS_APPEND="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"' >> ~/.bashrc
  echo "✅ 已加入 ~/.bashrc：PDSH_SSH_ARGS_APPEND"
else
  echo "⚠️ ~/.bashrc 中已存在 PDSH_SSH_ARGS_APPEND 設定，略過"
fi

# 立即生效
export PDSH_RCMD_TYPE=ssh
export PDSH_SSH_ARGS_APPEND="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

echo "🎯 當前 shell 中 pdsh 模式：$PDSH_RCMD_TYPE"
echo "🛡️ SSH 附加參數：$PDSH_SSH_ARGS_APPEND"

echo "💡 如要永久生效，請重新登入或執行：source ~/.bashrc"
echo "✅ pdsh 安裝與設定完成！你現在可以使用 pdsh -w ^hostlist.txt \"指令\" 了。"
