#!/bin/bash
# truncate_logs.sh
# 功能：保留指定 log 的最後 100 行並修正權限
# 用途：避免 log 過大並維持檔案安全權限設定

# 手動列出要保留的 log 清單
LOG_FILES=(
  "/var/log/taifex_block_trade.log"
  "/var/log/finlab_run.log"
  "/var/log/market_data.log"
  "/var/log/run_and_push.log"
  "/var/log/funddj_news.log"
  "/var/log/market_monitor_and_warning.log"
  "/var/log/web_crawler.log"
  "/var/log/market_data_feather.log"
  "/var/log/data_collector.log"
  "/backup/backup.log"
  "/mnt/sdcard/backup.log"
)

# 自動搜尋 /opt/AI_Docker 底下的 .log 檔案
AI_DOCKER_LOGS=$(find /opt/AI_Docker -type f -name "*.log")

# 合併到 LOG_FILES 陣列中（去重）
for log_file in $AI_DOCKER_LOGS; do
  if [[ ! " ${LOG_FILES[@]} " =~ " ${log_file} " ]]; then
    LOG_FILES+=("$log_file")
  fi
done

# 修剪並處理每個 log 檔案
for file in "${LOG_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "✂️ 保留 $file 的最後 100 行"
    sudo sh -c "tail -n 100 '$file' > '${file}.tmp' && mv '${file}.tmp' '$file'"
  fi
done

# 修正檔案擁有者與權限
for file in "${LOG_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "🔧 修正 $file 權限為 ubuntu:ubuntu 644"
    sudo chown ubuntu:ubuntu "$file"
    sudo chmod 644 "$file"
  fi
done
