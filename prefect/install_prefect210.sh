#!/bin/bash
# install_prefect210.sh
# 功能：建立乾淨的 prefect 2.10.0 環境（適用於 Raspberry Pi）
# 用途：自動建立虛擬環境、安裝指定版本套件並啟用

set -e

echo "🚧 建立虛擬環境 ~/.venv-prefect210..."
python3 -m venv ~/.venv-prefect210

echo "✅ 啟用虛擬環境..."
source ~/.venv-prefect210/bin/activate

echo "📦 安裝 Prefect 2.10.0 及相容的 Pydantic..."
pip install --upgrade pip
pip install "prefect==2.10.0" "pydantic==1.10.12"

echo "🔧 設定 PREFECT_API_URL..."
prefect config set PREFECT_API_URL="http://localhost:4200/api"

echo "🎉 Prefect 2.10.0 安裝完成！已啟用虛擬環境"
echo "👉 你現在可以執行：prefect version / prefect server start / prefect agent start"

# 保持在虛擬環境中
$SHELL
