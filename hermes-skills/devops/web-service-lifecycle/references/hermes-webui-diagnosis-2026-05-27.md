# Session Reference: Hermes WebUI 断连诊断与恢复

**日期:** 2026-05-27
**环境:** WSL (Windows Subsystem for Linux)
**服务:** Hermes WebUI (nesquena/hermes-webui)
**情景:** 用户报告 "web ui连接已断开"

## 诊断步骤记录

### 1. 初始检查

```
$ ps aux | grep -i 'python\|node\|http\|web\|flask\|fastapi' | grep -v grep
```
结果：只有 Hermes Agent 自己的进程 (PID 48)，无 WebUI 进程。

```
$ ss -tlnp
```
结果：只有 10.255.255.254:53 (DNS)，无 8787。

### 2. 确认服务存在

```
$ ls ~/hermes-webui/
```
确认服务源码已安装，目录结构完整（server.py, bootstrap.py, static/ 等）。

### 3. 日志分析

```
$ head -30 ~/.hermes/webui/bootstrap-8787.log
```

启动头显示：
```
repo root   : /home/pdsda/.hermes/hermes-webui
agent dir   : /home/pdsda/.hermes/hermes-agent  [ok]
host:port   : 127.0.0.1:8787
```

```
$ tail -60 ~/.hermes/webui/bootstrap-8787.log
```

日志尾部显示正常请求记录，最后一条是：
```
[webui] {"ts": "2026-05-27T00:13:46Z", "method": "GET", "path": "/static/favicon.svg", "status": 200, "ms": 5.9}
```

之后无任何内容 — 无错误、无异常、无退出记录。

```
$ grep -i 'error\|traceback\|exception' ~/.hermes/webui/bootstrap-8787.log | tail -10
```

仅发现 API rate limit 错误：
```
⚠️  API call failed (attempt 3/3): RateLimitError [HTTP 429]
```
但这些是 API 调用失败（不影响服务器进程本身）。

### 4. 原因判断

**结论：进程正常退出或被终止（无 crash 痕迹）。** 无 cron 自动保活任务。

### 5. 解决方案

后台重启服务：

```bash
cd ~/hermes-webui && python3 bootstrap.py --no-browser
```
使用 terminal(background=True, notify_on_complete=True) 启动。

验证：
```bash
$ ss -tlnp | grep 8787
LISTEN 0  64  127.0.0.1:8787  0.0.0.0:*  users:(("python",pid=295,fd=3))
```

### 6. 建议后续

未执行的自动保活方案：
- 设置 cron job 每 5 分钟检查端口 8787 是否存活
- 挂掉则自动重启并记录
