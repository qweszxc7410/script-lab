# pwd_login.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
sudo nano /etc/ssh/sshd_config
# PasswordAuthentication yes 修改 (原始是NO)
sudo systemctl restart ssh
