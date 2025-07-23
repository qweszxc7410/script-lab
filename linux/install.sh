# install.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
echo "🔑 生成 SSH 金鑰對..."
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
# ~/.ssh/id_rsa        ← 私鑰（不要外洩）
# ~/.ssh/id_rsa.pub    ← 公鑰（可發送給別人）