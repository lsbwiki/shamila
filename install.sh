#!/bin/sh

# 1. 测速并把结果写入文件
echo "Speedtesting..." > speed.txt
curl -sL https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 - --single --no-upload >> speed.txt 2>&1

# 2. 写入一个极其简单的 Node.js 服务器代码 (server.js)
cat <<EOF > server.js
const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
    // 读取测速结果并显示
    const data = fs.readFileSync(path.join(__dirname, 'speed.txt'));
    res.end(data);
});

// Flux 默认通常监听 8080 或 3000，这里用 8080，如果不行你可以换
server.listen(3000, () => {
    console.log('Server running at http://0.0.0.0:3000/');
});
EOF

# 3. 启动服务器
node server.js
