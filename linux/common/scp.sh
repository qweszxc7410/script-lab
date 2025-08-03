#!/bin/bash
# scp_r_to_windows.sh
# 功能：從遠端主機複製整個 /home/ubuntu 目錄內容到本機 Windows 的桌面
# 用途：備份或同步樹莓派使用者主目錄資料至 Windows 系統

scp -r ubuntu@192.168.1.106:/home/ubuntu/* C:\Users\user\Desktop\pi