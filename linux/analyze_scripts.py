#!/usr/bin/env python3
# analyze_scripts.py
# 功能：掃描所有 .py 與 .sh 檔案，補上缺失註解並輸出 Markdown 與 JSON 清單
# 用途：集中管理腳本描述與用途，輔助維護與查閱

import os
import json
from pathlib import Path

def normalize_comments(lines: list[str], total=3):
    """補齊註解行數至 total"""
    while len(lines) < total:
        lines.append("")
    return lines[:total]

def extract_header(file_path: Path):
    try:
        lines = file_path.read_text(encoding="utf-8").splitlines()

    except Exception as e:
        print(f"⚠️ 無法讀取 {file_path}: {e}")
        return None

    suffix = file_path.suffix
    filename = file_path.name

    comment_lines = []
    updated = False

    if suffix == ".py":
        # 取前3行中有 # 的部分
        for line in lines[:3]:
            if line.strip().startswith("#"):
                comment_lines.append(line.strip("# ").strip())
        comment_lines = normalize_comments(comment_lines)
        lang = "python"

    elif suffix == ".sh":
        lang = "bash"
        header_region = lines[1:5] if lines and lines[0].startswith("#!") else lines[:4]
        for line in header_region:
            if line.strip().startswith("#"):
                comment_lines.append(line.strip("# ").strip())
        if len(comment_lines) < 3:
            print(f"🛠️  補上註解：{filename}")
            shebang = lines[0] if lines and lines[0].startswith("#!") else "#!/bin/bash"
            new_header = [
                f"# {filename}",
                "# 功能：請補上腳本的功能說明",
                "# 用途：請補上腳本的實際用途"
            ]
            if len(lines) ==0:
                lines = [shebang] + new_header
            else:
                lines = [shebang] + new_header + lines[1:] if shebang == lines[0] else new_header + lines
            file_path.write_text("\n".join(lines), encoding="utf-8")
            comment_lines = [l.strip("# ").strip() for l in new_header]
            updated = True
        comment_lines = normalize_comments(comment_lines)

    else:
        return None
    start_folder = file_path.parent.parent.name
    parts = file_path.parts
    index = parts.index(start_folder)
    relative_path = Path(*parts[index:])
    return {
        "filename": filename,
        "filepath": str(relative_path),
        "comment1": comment_lines[0],
        "comment2": comment_lines[1],
        "comment3": comment_lines[2],
        "language": lang
    }

def scan_and_generate(base_dir: Path):
    results = []
    markdown_lines = ["# 📜 腳本總覽（自動產生）\n"]

    for ext in ("*.py", "*.sh"):
        for file in sorted(base_dir.rglob(ext)):
            if file.name == "analyze_scripts.py":
                continue
            info = extract_header(file)
            if info:
                results.append(info)
                markdown_lines.append(f"## {info['filename']}")
                markdown_lines.append(f"> {info['filepath']}")
                markdown_lines.append(f"> {info['comment1']}")
                markdown_lines.append(f"> {info['comment2']}")
                markdown_lines.append(f"> {info['comment3']}")
                markdown_lines.append(f"> {info['language']}")
                markdown_lines.append("")

    return results, markdown_lines

if __name__ == "__main__":
    # BASE_DIR = Path(".")
    BASE_DIR = Path(__file__).parent if __file__ else Path.cwd()
    JSON_PATH = BASE_DIR / "script_headers.json"
    MD_PATH = BASE_DIR / "script_index.md"

    header_data, md_lines = scan_and_generate(BASE_DIR)

    with open(JSON_PATH, "w", encoding="utf-8") as jf:
        json.dump(header_data, jf, ensure_ascii=False, indent=2)

    with open(MD_PATH, "w", encoding="utf-8") as mf:
        mf.write("\n".join(md_lines))

    print(f"✅ JSON 已儲存：{JSON_PATH}")
    print(f"✅ Markdown 已儲存：{MD_PATH}")
