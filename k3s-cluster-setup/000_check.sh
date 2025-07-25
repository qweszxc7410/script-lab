sudo bash -c "echo \$(cat /boot/firmware/cmdline.txt | tr -d '\n') cgroup_memory=1 cgroup_enable=memory cgroup_enable=cpuset > /boot/firmware/cmdline.txt"
sudo reboot

cat /proc/cgroups | grep memory

memory	4	1	1