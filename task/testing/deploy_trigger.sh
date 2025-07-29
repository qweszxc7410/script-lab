#!/bin/bash
# 功能：重新部署 trigger_flow.py 為 Prefect deployment
export PREFECT_API_URL="http://localhost:4200/api"

prefect deployment build /app/trigger_flow.py:main \
  --name trigger-script \
  --pool default-agent-pool \
  --work-queue default \
  --path /app \
  --apply
