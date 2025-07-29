# write_time.py
from datetime import datetime
from pathlib import Path

output_path = Path("/app/output/timestamp.txt")  # 或 "./output/timestamp.txt"
output_path.parent.mkdir(parents=True, exist_ok=True)

with output_path.open("a", encoding="utf-8") as f:
    f.write(datetime.now().isoformat() + "\n")


print("✅ 寫入完成，檔案內容如下：")
import subprocess
subprocess.run(["cat", "/data/timestamp.txt"])
