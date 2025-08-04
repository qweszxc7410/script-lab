#!/bin/bash
# show_manual.sh
# 功能：顯示我的操作說明（純查詢用）

cat <<EOF
📘 我的專案使用手冊（離線版）

🔹 資料前處理
  python3 preprocess.py --input data.csv --output clean.csv

🔹 訓練模型
  bash train_model.sh --epochs 100

🔹 啟動分析服務
  docker run -it --rm analysis:latest

🔹 查詢參數
  cat config.json

EOF