#!/bin/sh
# 强制杀掉多余的 Node 进程（如果有）
pkill node || true

echo "--- 测速任务开始 (跳过 Node 编译) ---"
# 直接执行你的 python 测速逻辑
wget -O speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
python3 speedtest.py --single --no-upload 2>&1 | tee /app/speed.log
cat /app/speed.log
tail -f /dev/null
