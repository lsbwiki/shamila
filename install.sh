#!/bin/sh

# 1. 创建初始文件，防止 Node 读取时报错
echo "Speedtest task has been submitted. Please refresh this page in 30 seconds..." > speed.txt
echo "Timestamp: $(date)" >> speed.txt

# 2. 在后台静默执行测速，结果追加到 speed.txt
(
  curl -sL https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 - --single --no-upload >> speed.txt 2>&1
  echo "\n--- Test Completed at $(date) ---" >> speed.txt
) &

# 3. 动态创建 Node.js 服务器脚本
cat <<EOF > server.js
const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
    // 强制返回文本格式，防止浏览器乱码
    res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
    
    const filePath = path.join(__dirname, 'speed.txt');
    
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            res.end("Error reading results: " + err.message);
            return;
        }
        res.end(data);
    });
});

// 监听 Flux 核心的 3000 端口
const PORT = 3000;
server.listen(PORT, '0.0.0.0', () => {
    console.log('Server is running on port ' + PORT);
});
EOF

# 4. 启动服务器
node server.js
