## 系統環境說明

本專案部署於多台 Raspberry Pi 主機，並使用以下作業系統與硬體規格：

### 🧠 作業系統

- **Raspberry Pi OS (Legacy, 64-bit) Lite**
  - 基於 Debian Bullseye
  - 無桌面環境（headless）
  - 官方發布日期：2025-05-06
  - 提供安全更新，適用於輕量級伺服器與容器環境

### 🖥️ 主機硬體

- Raspberry Pi Zero 2 W（armv7 架構）
- Raspberry Pi 3 Model B（armv8 架構）

兩者均透過有線或無線網路連線組成分散式叢集，適用於 IoT、自動化排程、分散資料處理等應用場景。

---

✅ 本環境已驗證可正常執行如 Docker、Prefect、Dask、Python 3.11 等關鍵組件。
