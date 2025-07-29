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
