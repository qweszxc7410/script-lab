#!/bin/bash

output="/opt/AI_Docker/scripts/cron_summary.csv"
temp="/opt/AI_Docker/scripts/cron_temp.csv"

# 清空暫存
> "$temp"

# 抓取排程資訊
crontab -l | grep -v '^#' | grep -v '^\s*$' | while read -r line; do
    min=$(echo "$line" | awk '{print $1}')
    hour=$(echo "$line" | awk '{print $2}')
    cmd=$(echo "$line" | awk '{for(i=6;i<=NF;++i) printf $i " "; print ""}' | sed 's/ *$//')

    docker_name=$(echo "$cmd" | grep -oP 'docker exec \K[^ ]+')
    if [ -n "$docker_name" ]; then
        source_name="$docker_name"
    else
        sh_name=$(echo "$cmd" | grep -oE '[^/ ]+\.sh' | tail -n 1)
        source_name=${sh_name:-未知}
    fi

    # 將多個時數用 & 串接
    hour_clean=$(echo "$hour" | sed 's/,/ \& /g')
    echo "$source_name,$hour_clean,$min" >> "$temp"
done

# 表頭 + 排序（按照最小的 hour 排序）
echo "來源名稱,時,分" > "$output"
sort -t, -k2n -k3n "$temp" >> "$output"
rm "$temp"
