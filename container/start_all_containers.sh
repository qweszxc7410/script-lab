#!/bin/bash
# start_all_containers.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
# 啟動所有指定的 container
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