# 將容器加入 ai_chat 網路
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