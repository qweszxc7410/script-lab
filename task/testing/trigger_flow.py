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
# export PREFECT_API_URL="http://192.168.1.135:4200/api"

# prefect deployment build /app/trigger_flow.py:main \
#   --name trigger-script \
#   --pool default-agent-pool \
#   --work-queue default \
#   --path /app \
#   --apply


# docker run -d \
#   --name prefect_worker \
#   -v /opt/AI_Docker/testing:/app \
#   -e PREFECT_API_URL=http://192.168.1.135:4200/api \
#   prefecthq/prefect:2.20-python3.11 \
#   prefect worker start --pool default-agent-pool --name pi5-main
