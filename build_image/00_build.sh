#!/bin/bash
# build_image.sh
# 功能：建構 Prefect 專用的 Docker 映像檔
# 用途：將專案與依賴打包為 image，供容器部署使用

docker build -t myprefect/myprefect .
