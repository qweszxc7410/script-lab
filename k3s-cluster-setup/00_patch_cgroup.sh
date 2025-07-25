#!/bin/bash
# 00_patch_cgroup.sh
# 功能：修正 /boot/cmdline.txt 加入 cgroup 支援
# 用途：讓 K3s 能正常啟動，解決 "failed to find memory cgroup (v2)" 問題


# /boot/cmdline.txt 一般可能用這個

echo "🔧 檢查並修補 /boot/cmdline.txt..."

if ! grep -q "cgroup_memory=1" /boot/cmdline.txt; then
  sudo sed -i 's/cgroup_disable=memory//; s|$| cgroup_memory=1 cgroup_enable=memory cgroup_enable=cpuset|' /boot/firmware/cmdline.txt
  echo "✅ 已加入 cgroup 支援參數，請重新啟動系統"
else
  echo "✅ 已包含所需參數，無需修改"
fi
