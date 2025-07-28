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


prefect deployment build flow_trigger.py:main \
  --name run-inside-container \
  --pool my-process-pool \
  --work-queue default \
  --apply


from prefect import flow, task
import subprocess

@task(log_prints=True)
def call_container_script():
    result = subprocess.run(
        ["bash", "/mnt/share/my_container/run.sh"],  # Host 看到的掛載路徑
        capture_output=True,
        text=True
    )
    print("STDOUT:", result.stdout)
    print("STDERR:", result.stderr)
    if result.returncode != 0:
        raise RuntimeError("Script failed!")

@flow(name="trigger_container_script")
def main():
    call_container_script()

if __name__ == "__main__":
    main()
