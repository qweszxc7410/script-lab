# install_git.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
sudo apt update
sudo apt install -y git
rm ~/.ssh/authorized_keys # 清空公鑰

git clone https://github.com/qweszxc7410/script-lab.git
chmod -R +x script-lab/
cd script-lab/linux/hands/ # 然後執行01_install_pdsh_ntp.sh
