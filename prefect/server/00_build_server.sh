#!/bin/bash
# 00_run_prefect_server.sh
# 功能：啟動 Prefect 2.20 Server，避開 docker-compose 相容性問題(避免升級 docker-compose)
# 用途：取代 docker-compose.yml 無法啟動 server 的狀況

docker run -d \
  --name prefect_server3 \
  -p 4500:4200 \
  -e TZ=Asia/Taipei \
  -e PREFECT_DISABLE_TELEMETRY=true \
  -v /opt/AI_Docker/prefect:/app \
  -v /opt/AI_Docker:/mnt/share \
  -v /etc/localtime:/etc/localtime:ro \
  --restart unless-stopped \
  --network bridge \
  prefecthq/prefect:2.20-python3.11 \
  bash -c "prefect config set PREFECT_API_URL=http://192.168.1.135:4500/api && \
           prefect config set PREFECT_UI_URL=http://192.168.1.135:4500 && \
           prefect server start --host 0.0.0.0 --port 4200"


sudo ufw allow 4500/tcp
docker ps -a | grep prefect_server3
# docker logs -f prefect_server3
