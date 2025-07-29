#!/bin/bash
# dedup_ssh_keys.sh
# 功能：移除 ~/.ssh/authorized_keys 中的重複公鑰
# 用途：保持 SSH 授權清單乾淨，避免重複登入金鑰造成混亂

sort ~/.ssh/authorized_keys | uniq > ~/.ssh/authorized_keys.tmp && mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys
