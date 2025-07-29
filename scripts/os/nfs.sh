sudo apt update
sudo apt install nfs-kernel-server -y
sudo chown nobody:nogroup /opt/AI_Docker
/opt/AI_Docker 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)
sudo systemctl enable nfs-server

sudo nano /etc/exports
# 在文件中加入以下行：
/opt/AI_Docker 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)