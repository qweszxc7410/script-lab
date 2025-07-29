#!/bin/bash
# trust_all_hosts.sh
# 功能：從 hostlist.txt 建立 SSH 信任（避免 Host key verification failed）
# 用途：從 hostlist.txt 建立 SSH 信任（避免 Host key verification failed）

mapfile -t ips < <(grep -v '^\s*$' "$HOME/hostlist.txt")
for ip in "${ips[@]}"; do
  echo "🔐 正在信任 $ip..."
  ssh -o StrictHostKeyChecking=no ubuntu@"$ip" "echo 🟢 $ip 信任完成"
done
