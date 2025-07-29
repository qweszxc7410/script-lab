#!/bin/bash
# ssh.sh
# 功能：清除舊的 SSH 指紋並重新嘗試連線至指定主機
# 用途：用於排除 SSH 指紋衝突，方便初次或重連接測試

ssh-keygen -R 192.168.1.104 && ssh ubuntu@192.168.1.104
ssh-keygen -R 192.168.1.106 && ssh ubuntu@192.168.1.106