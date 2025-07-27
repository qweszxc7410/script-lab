import socket
from prefect import flow, task, get_run_logger
from datetime import datetime

@task
def fetch_news():
    logger = get_run_logger()
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # ✅ 抓取實體 IP（非 localhost）
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)

    message = f"{now} - ✅ 抓取新聞成功 from {ip_address}"

    # 寫入檔案
    with open("/tmp/fund_news_log.txt", "a") as f:
        f.write(message + "\n")

    # 顯示在 UI
    logger.info(message)

@flow(name="fund_news_flow2")
def fund_news_main2():
    fetch_news()

if __name__ == "__main__":
    fund_news_main2()
