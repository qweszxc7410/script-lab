"""
analyze_scripts.py

功能：掃描所有 .py 與 .sh 檔案，補上缺失註解並輸出 Markdown 與 JSON 清單  
用途：集中管理腳本描述與用途，輔助維護與查閱
"""

import os
import json
import re
from pathlib import Path

def normalize_comments(lines: list[str], total=3):
    """補齊註解行數至 total"""
    while len(lines) < total:
        lines.append("")
    return lines[:total]

def extract_header(file_path: Path):
    try:
        content = file_path.read_text(encoding="utf-8")
        lines = content.splitlines()

    except Exception as e:
        print(f"⚠️ 無法讀取 {file_path}: {e}")
        return None

    suffix = file_path.suffix
    filename = file_path.name

    comment_lines = []
    updated = False

    if suffix == ".py":
        # 檢查是否有 docstring 格式的註解 (PEP257)
        docstring_match = re.search(r'"""(.*?)"""', content, re.DOTALL)
        if docstring_match:
            # 從 docstring 提取註解
            docstring_content = docstring_match.group(1).strip()
            docstring_lines = [line.strip() for line in docstring_content.splitlines()]
            # 移除空行
            docstring_lines = [line for line in docstring_lines if line]
            comment_lines = docstring_lines
        else:
            # 舊的方式：尋找 # 開頭的註解
            for line in lines[:5]:
                if line.strip().startswith("#"):
                    comment_lines.append(line.strip("# ").strip())
        
        comment_lines = normalize_comments(comment_lines)
        lang = "python"

    elif suffix == ".sh":
        lang = "bash"
        # 首先處理 shebang 行
        start_index = 0
        if lines and lines[0].startswith("#!"):
            start_index = 1  # 跳過 shebang 行
            
        # 從 shebang 行之後開始尋找註解
        for line in lines[start_index:start_index+10]:  # 增加搜索範圍到10行
            if line.strip().startswith("#") and not line.strip().startswith("#!"):
                comment_content = line.strip("# ").strip()
                if comment_content:  # 確保註解行不是空的
                    comment_lines.append(comment_content)
                    
        if len(comment_lines) < 3:
            print(f"🛠️  補上註解：{filename}")
            shebang = "#!/usr/bin/env bash"  # 使用更可移植的 shebang
            if lines and lines[0].startswith("#!"):
                shebang = lines[0]
                
            new_header = [
                f"# {filename}",
                "# 功能：請補上腳本的功能說明",
                "# 用途：請補上腳本的實際用途"
            ]
            
            if len(lines) == 0:
                lines = [shebang] + new_header
            else:
                if lines[0].startswith("#!"):
                    lines = [shebang] + new_header + lines[1:]
                else:
                    lines = [shebang] + new_header + lines
                    
            file_path.write_text("\n".join(lines), encoding="utf-8")
            comment_lines = [l.strip("# ").strip() for l in new_header]
            updated = True
            
        comment_lines = normalize_comments(comment_lines)

    else:
        return None
        
    # 嘗試獲取目錄結構
    try:
        start_folder = file_path.parent.parent.name
        parts = file_path.parts
        index = parts.index(start_folder)
        relative_path = Path(*parts[index:])
    except (ValueError, IndexError):
        # 如果無法找到預期的父目錄結構，就使用相對於當前目錄的路徑
        relative_path = file_path
        
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
                # 改进 Markdown 格式
                markdown_lines.append(f"## {info['filename']}")
                markdown_lines.append(f"**路徑:** `{info['filepath']}`")
                markdown_lines.append("")
                markdown_lines.append("**說明:**")
                if info['comment1']:
                    markdown_lines.append(f"- {info['comment1']}")
                if info['comment2']:
                    markdown_lines.append(f"- {info['comment2']}")
                if info['comment3'] and info['comment3'].strip():
                    markdown_lines.append(f"- {info['comment3']}")
                markdown_lines.append("")
                markdown_lines.append(f"**語言:** `{info['language']}`")
                markdown_lines.append("")
                markdown_lines.append("---")
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