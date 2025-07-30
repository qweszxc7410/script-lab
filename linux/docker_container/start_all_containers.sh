#!/usr/bin/env bash
# start_all_containers.sh
# 功能：啟動指定清單中的所有 Docker container
# 用途：用於系統開機或部署後一鍵啟動所有服務容器

# cat /etc/systemd/system/docker-container-start.service

containers=(
  "funddj_news"
  "taifex_block_trade"
  "market_data"
  "finlab"
  "market_monitor_and_warning"
  "web_crawler"
  "api-data-server"
  "market_data_feather"
  "data_publisher"
  "data_collector"
)

echo "🚀 啟動 containers..."
for name in "${containers[@]}"; do
  echo "👉 正在啟動 $name"
  docker start "$name"
done

echo "✅ 所有容器已嘗試啟動完成。"