"""
trigger_container_script.py

功能：透過 Prefect flow 執行 container 中的 bash 腳本  
用途：用於觸發容器內 `/app/run.sh` 的自動化任務流程
"""

from prefect import flow, task
import subprocess
# pip install prefect==2.20.18

@task(log_prints=True)
def call_container_script():
    result = subprocess.run(
        ["bash", "/app/run.sh"],
        capture_output=True,
        text=True
    )
    print("STDOUT:", result.stdout)
    print("STDERR:", result.stderr)
    if result.returncode != 0:
        raise RuntimeError(f"Script failed with exit code {result.returncode}")

@flow(name="trigger_container_script")
def main():
    call_container_script()

if __name__ == "__main__":
    main()
