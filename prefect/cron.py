# flows/funddj_news_flow.py
from prefect import flow, task
import subprocess

@task
def run_funddj_news():
    cmd = "docker exec funddj_news bash /app/run.sh"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"❌ 執行失敗：{result.stderr}")
    print(f"✅ 執行成功：{result.stdout}")

@flow(name="funddj_news_flow")
def funddj_news_flow():
    run_funddj_news()
# prefect deployment build flows/funddj_news_flow.py:funddj_news_flow \
#   --name funddj-news-deploy \
#   --cron "0 6 * * *" \
#   --work-queue default \
#   --apply
# export LANG=zh_TW.UTF-8
# export LC_ALL=zh_TW.UTF-8