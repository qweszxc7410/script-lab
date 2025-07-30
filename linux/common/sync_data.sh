#!/usr/bin/env bash
# sync_data.sh
# 功能：將 USB 裝置中的指定資料夾同步(copy)至 AI_Docker 專案資料夾
# 用途：用於跨裝置搬移或每日手動資料同步，確保資料夾內容保持一致

sudo rsync -avh --progress /media/ubuntu/0DE4-FCD0/market_data/ /opt/AI_Docker/market_data/

sudo rsync -avh --progress /media/ubuntu/0DE4-FCD0/taifex_block_trade/ /opt/AI_Docker/taifex_block_trade/

sudo rsync -avh --progress /media/ubuntu/0DE4-FCD0/EconomicAnalysis/ /opt/AI_Docker/economic_analysis/
