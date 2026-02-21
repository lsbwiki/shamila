#!/bin/sh
echo "--- 测速任务开始 ---"
wget -O speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
python3 speedtest.py --single --no-upload
echo "--- 测速结束 ---"
tail -f /dev/null
