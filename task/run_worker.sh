#!/bin/bash
sudo apt update
sudo apt install -y python3-venv python3-pip


python3 -m venv ~/.venv-prefect
source ~/.venv-prefect/bin/activate

pip install "prefect==2.10.13" "pydantic<2.0" "anyio==3.6.2" "griffe==0.36.4"


PREFECT_API_URL=http://192.168.1.135:4200/api prefect worker start --pool pi-workers --work-queue default




prefect deployment build flow_run_container.py:main \
  --name run-writer \
  --pool pi-workers \
  --work-queue default \
  --apply
