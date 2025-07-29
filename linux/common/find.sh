#!/bin/bash
# find_env_and_0050.sh
# 功能：搜尋 /opt/AI_Docker 目錄下的 .env 檔與以 0050_ 開頭的檔案
# 用途：快速定位設定檔與特定命名的資料檔案
find /opt/AI_Docker -type f -name ".env"
find /opt/AI_Docker -type f -name "0050_"
