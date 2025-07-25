sudo /usr/local/bin/k3s-uninstall.sh


curl -sfL https://get.k3s.io | K3S_URL=https://192.168.1.105:6443 K3S_TOKEN=你的token sh -s - agent
