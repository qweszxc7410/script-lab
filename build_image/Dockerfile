FROM python:3.11-slim

# 安裝必要套件
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# 設定工作目錄與複製檔案
WORKDIR /app
COPY . /app

# 設定 Prefect Server API URL（請改成你 Web UI 的 IP）
ENV PREFECT_API_URL=http://192.168.1.106:4200/api

# 啟動 container 時自動執行 Agent（聽 default 工作池）
# CMD ["prefect", "worker", "start", "-p", "default-agent-pool", "--run-once"]

CMD ["bash"]
