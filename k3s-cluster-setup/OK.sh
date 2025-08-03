# OK.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
wget https://github.com/k3s-io/k3s/releases/download/v1.32.6%2Bk3s1/k3s-arm64 -O k3s
chmod +x k3s
sudo ./k3s server --disable traefik
cat /proc/cgroups | grep memory  # 應該有輸出


sudo sed -i 's/$/ cgroup_enable=memory cgroup_memory=1/' /boot/cmdline.txt
sudo reboot

ubuntu@pi2w:~ $ cat /proc/cgroups | grep memory
memory  0       45      1  # 最後一個數字要是1表示啟動



curl -sfL https://get.k3s.io | \
K3S_URL=https://192.168.1.106:6443 \
K3S_TOKEN=K108b7c1db5876c294d463352c3cb78cb9c4247f5501de14e98b77d7f8d53eb1c1f::server:5b86b517bd5080189e2b2609d6178dc4 \
sh -s - agent

sudo /usr/local/bin/k3s-agent-uninstall.sh


sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart k3s-agent