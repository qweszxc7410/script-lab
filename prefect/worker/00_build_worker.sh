# 00_build_worker.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
docker-compose up -d
prefect worker start --pool pi-workers --work-queue default --name pi5-worker-01