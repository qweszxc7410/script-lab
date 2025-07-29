#!/bin/bash
# build_deployment.sh
# 要在任務的container裡面執行 都是呼叫trigger_flow.py
export PREFECT_API_URL="http://192.168.1.135:4200/api"
prefect deployment build trigger_flow.py:main \
  --name run-writer2 \
  --pool pi-workers \
  --work-queue default \
  --apply
