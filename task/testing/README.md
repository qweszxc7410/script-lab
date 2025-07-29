cd /opt/AI_Docker
docker compose up -d  # 啟動 worker（和 server，如果你要）
docker exec -it prefect_worker bash
export PREFECT_API_URL="http://192.168.1.135:4200/api"
bash /app/deploy_trigger.sh
