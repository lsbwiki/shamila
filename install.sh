#!/bin/sh

# 进入代码所在的真实目录
cd /app/production/current || cd /app

# 简单暴力：直接用 python 运行测速命令，不搞复杂的变量
echo "--- START TEST ---"

# 用 curl 直接下载并立即用 python 执行，不保存中间文件
curl -sL https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 - --single --no-upload

echo "--- END TEST ---"

# 绝对保活，防止 exit status 2
while true; do
    sleep 300
done
