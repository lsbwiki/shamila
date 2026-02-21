#!/bin/bash

# 1. 强制声明：把所有输出实时推送到 Flux 日志终端
export PYTHONUNBUFFERED=1
exec > >(tee -a /app/install.log) 2>&1

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! [CRITICAL] 脚本开始在绝对路径执行 !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 2. 定位真正的代码目录
# Flux 会把代码放在 /app/production/current
REAL_PATH="/app/production/current"
cd $REAL_PATH || echo "无法进入 $REAL_PATH"

echo ">>> 当前工作目录: $(pwd)"
echo ">>> 目录下的文件: $(ls)"

# 3. 极简测速 (不依赖外部脚本下载，防止下载失败)
echo ">>> [STEP] 正在尝试下载并运行测速..."
curl -sL https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -o speedtest.py
python3 speedtest.py --single --no-upload

echo ">>> [END] 如果你看到这一行，说明测速跑完了！"

# 4. 强行保活
tail -f /dev/null
