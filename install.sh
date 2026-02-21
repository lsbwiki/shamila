#!/bin/sh

# 1. 环境变量优化，防止日志卡住
export PYTHONUNBUFFERED=1

echo "================================================="
echo ">>> [START] 正在启动去中心化节点性能测试..."
echo "================================================="

# 2. 检查系统环境
echo ">>> [INFO] 系统信息:"
uname -a
python3 --version || echo "Warning: python3 not found"

# 3. 获取测速工具
echo ">>> [STEP 1] 正在下载测速脚本..."
# 使用 -O 确保文件名固定
wget -O speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py

# 4. 执行多维度测速
echo ">>> [STEP 2] 正在进行带宽压力测试 (单线程模式)..."
echo "-------------------------------------------------"
# --single 模式最适合这种虚拟化环境，不容易被节点限流
python3 speedtest.py --single --no-upload
echo "-------------------------------------------------"

# 5. 延迟测试
echo ">>> [STEP 3] 正在测试 Google 连通性..."
ping -c 4 8.8.8.8

echo "================================================="
echo ">>> [FINISH] 测试任务完成，容器进入休眠模式"
echo ">>> 如果你看到了速度数值，说明此节点网络极佳！"
echo "================================================="

# 保持容器运行，否则 Flux 会因为进程退出而报错重启
tail -f /dev/null
