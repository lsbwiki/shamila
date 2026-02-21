#!/bin/bash
# 强制实时刷新日志
export PYTHONUNBUFFERED=1

echo "--- [1] 脚本启动成功 ---"
date

echo "--- [2] 正在清理旧进程 ---"
pkill node || true

echo "--- [3] 开始下载测速脚本 ---"
wget -O speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py

echo "--- [4] 准备进行测速，请等待约 60 秒... ---"
# 这里是关键：我们把结果直接重定向到标准输出
python3 speedtest.py --single --no-upload

echo "--- [5] 测速任务收尾 ---"
# 打印一下当前目录，确认文件都在
ls -lh

# 防止容器退出
echo "--- [6] 进入守护模式，日志输出完毕 ---"
tail -f /dev/null
