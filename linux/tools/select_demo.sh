#!/bin/bash
# my_toolkit.sh
# 功能：顯示常用任務清單，選擇後自動執行對應的腳本或指令

echo "📦 我的工作腳本工具列"
echo "請選擇要執行的項目："
echo "1️⃣ 匯入股市資料"
echo "2️⃣ 重新訓練模型"
echo "3️⃣ 啟動分析容器"
echo "4️⃣ 顯示設定參數"
echo "5️⃣ 離開"
read -p "👉 請輸入選項（1-5）：" choice

case $choice in
  1)
    echo "📥 匯入股市資料中..."
    python3 ~/projects/stock_fetcher.py
    ;;
  2)
    echo "🤖 開始重新訓練模型..."
    bash ~/scripts/train_model.sh
    ;;
  3)
    echo "🚀 啟動分析用 Docker..."
    docker start analysis_container
    ;;
  4)
    echo "⚙️ 設定參數如下："
    cat ~/config/params.json
    ;;
  5)
    echo "👋 已離開。"
    ;;
  *)
    echo "❌ 無效的選項，請重新執行"
    ;;
esac
