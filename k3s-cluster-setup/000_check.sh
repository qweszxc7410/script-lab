

#!/bin/bash
# 00_patch_cgroup.sh
# 功能：修正 /boot/cmdline.txt 加入 cgroup 支援
# 用途：讓 K3s 能正常啟動，解決 "failed to find memory cgroup (v2)" 問題


# 是建立在os lite legacy 64 bit
pdsh -w ^$HOME/hostlist.txt "cat /proc/cgroups | grep memory"

CMDLINE='$(cat /boot/cmdline.txt | tr -d "\n") cgroup_memory=1 cgroup_enable=memory cgroup_enable=cpuset'
pdsh -w ^$HOME/hostlist.txt "echo $CMDLINE | sudo tee /boot/cmdline.txt"
# 一定要重開生效
pdsh -w ^$HOME/hostlist.txt "sudo reboot"
# 結果
#memory	4	1	1# 最後一個數字一定要是1表示生效