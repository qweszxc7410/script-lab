#!/usr/bin/env bash
# build_log.sh
# 功能：建立各容器與備份相關服務所需的 log 檔案，並設定通用寫入權限
# 用途：避免 log 檔案缺失導致服務寫入失敗，適用於初始化或容器部署前執行

sudo touch /var/log/taifex_block_trade.log
sudo chmod 666 /var/log/taifex_block_trade.log

sudo touch /var/log/finlab_run.log
sudo chmod 666 /var/log/finlab_run.log

sudo touch /var/log/market_data.log
sudo chmod 666 /var/log/market_data.log

sudo touch /var/log/run_and_push.log
sudo chmod 666 /var/log/run_and_push.log

sudo touch /var/log/funddj_news.log
sudo chmod 666 /var/log/funddj_news.log

sudo touch /var/log/market_monitor_and_warning.log
sudo chmod 666 /var/log/market_monitor_and_warning.log

sudo touch /var/log/web_crawler.log
sudo chmod 666 /var/log/web_crawler.log

sudo touch /backup/backup.log
sudo chmod 666 /backup/backup.log

sudo touch /backup/backup.log
sudo chmod 666 /backup/backup.log

sudo touch /mnt/sdcard/backup.log
sudo chmod 666 /mnt/sdcard/backup.log

sudo touch /var/log/market_data_feather.log
sudo chmod 666 /var/log/market_data_feather.log

sudo touch /var/log/data_collector.log
sudo chmod 666 /var/log/data_collector.log