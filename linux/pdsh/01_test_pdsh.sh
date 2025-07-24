#!/bin/bash
# 03_install_cockpit.sh
# 功能：測試PDSH是否安裝成功
# 用途：用於在 cluster 環境中快速部署平行指令

pdsh -w ^$HOME/hostlist.txt "hostname"
