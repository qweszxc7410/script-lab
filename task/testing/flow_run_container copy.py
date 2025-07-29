from prefect import flow, task
import subprocess

@task
def run_time_writer_container():
    result = subprocess.run([
        "docker", "run", "--rm",
        "-v", "/opt/AI_Docker/test/data:/data",
        "time-writer"
    ], capture_output=True, text=True)

    print("✅ STDOUT:\n", result.stdout)
    if result.stderr:
        print("⚠️ STDERR:\n", result.stderr)

@flow(name="run_time_writer_flow")
def main():
    run_time_writer_container()

if __name__ == "__main__":
    main()
