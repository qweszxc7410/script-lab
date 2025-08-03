#!/usr/bin/env bash
# add_docker_networl.sh
# 功能：將多個容器加入指定的 Docker 自訂網路（如 ai_chat 與 ai_report）
# 用途：用於建立 container 間的跨服務溝通橋接，支援內網通訊與整合部署
docker network connect ai_chat funddj_news
docker network connect ai_chat prefect
docker network connect ai_chat taifex_block_trade
docker network connect ai_chat market_data
docker network connect ai_chat finlab
# 將容器加入 ai_report 網路
docker network connect ai_report funddj_news
docker network connect ai_report prefect
docker network connect ai_report taifex_block_trade
docker network connect ai_report market_data
docker network connect ai_report finlab