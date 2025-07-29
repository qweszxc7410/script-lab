from prefect import flow, task
import subprocess

@task(log_prints=True)
def call_container_script():
    result = subprocess.run(
        ["bash", "/mnt/share/my_container/run.sh"],
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
