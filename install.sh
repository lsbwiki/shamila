#!/bin/sh

# 1. 立即输出，确保你能看到脚本动了
echo "--- [DEBUG] 正在测试新实例的网络环境 ---"

# 2. 测速组件下载测试
echo "--- [1/3] 测试下载能力 ---"
wget -O speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
if [ $? -eq 0 ]; then
    echo ">>> 下载成功"
else
    echo ">>> 下载失败"
fi

# 3. 运行测速
echo "--- [2/3] 正在测速 (单线程模式) ---"
python3 speedtest.py --single --no-upload

# 4. 测试系统权限
echo "--- [3/3] 测试文件权限与目录 ---"
ls -la
echo "当前用户:" && whoami

echo "--- 测试结束 ---"

# 必须留一个进程，不然 Flux 会觉得你运行结束了直接关掉容器
tail -f /dev/null
