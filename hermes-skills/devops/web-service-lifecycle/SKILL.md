---
name: web-service-lifecycle
description: 在本地/WSL 环境中诊断、重启和自动保活 Web 服务的系统化方法。涵盖进程检查、端口验证、日志分析、异常排除、后台启动和 cron 自动恢复。
version: 1.0.0
author: session-learning
created_by: agent
platforms: [linux, wsl]
metadata:
  hermes:
    tags: [devops, web-service, lifecycle, process-management, wsl]
---

# Web Service Lifecycle — 诊断、重启与自动保活

当用户报告 "web UI 打不开"、"连接断开"、"服务挂了" 时，遵循这个系统化诊断流程。避免无头绪地猜测原因。

## 信号与触发条件

用户说出以下任意一句时，自动加载此 skill：
- "web UI 连不上了" / "连接断开"
- "xxx 服务停了" / "打不开了"
- "服务挂了" / "端口访问不了"
- "之前还能用，现在不行了"
- 任何关于本地 Web 服务不可用的报告

## 诊断流程

按顺序执行，每一步都有明确结论后进入下一步。

### 第 1 步：进程检查

```bash
ps aux | grep -i '<服务名>\|python.*server\|node\|flask\|fastapi\|gunicorn\|httpd' | grep -v grep
```

**结论：**
- 有进程 → 服务可能还在，转第 2 步检查端口
- 无进程 → 服务已退出，转第 2 步确认端口然后分析日志

### 第 2 步：端口检查

```bash
ss -tlnp | grep <端口号>
```

或全量查看：

```bash
ss -tlnp
```

**结论：**
- 端口在监听且有进程 PID → 服务正常运行，检查是否是网络/防火墙问题
- 端口在监听但无关联进程 → 可能是之前残留的套接字
- 端口无监听 → 服务确实不在运行

### 第 3 步：日志分析

先看日志最后几行：

```bash
tail -30 <日志路径>
```

再搜索错误：

```bash
grep -i 'error\|traceback\|exception' <日志路径> | tail -10
```

**典型模式：**
| 日志特征 | 可能原因 | 解决方案 |
|-----------|---------|---------|
| 日志正常但突然停止、无错误 | 进程被终止（终端关闭、OOM、WSL 休眠） | 重启 + 设后台保活 |
| HTTP 429 / Rate limit | API 配额耗尽 | 检查 API 密钥或充值 |
| ModuleNotFoundError / ImportError | 依赖缺失或虚拟环境未激活 | 安装依赖或用正确 Python |
| OSError / BindError / Address in use | 端口被占用 | 杀掉旧进程或用不同端口 |
| Traceback 加异常退出 | 代码或环境错误 | 修复代码或环境后重启 |

### 第 4 步：确定原因

常见根本原因：

1. **Terminal 关闭导致进程退出**（最常见）
   - 通过 `terminal(command='...', background=True)` 启动时，如果 original terminal 关闭且未设 notify_on_complete，进程会收到 SIGHUP
   - 解决方案：使用 cron 自动保活（见下文）

2. **WSL 休眠/重启**
   - WSL 进入睡眠或重启后，所有用户进程终止
   - 解决方案：设 cron 定时检查

3. **进程正常退出**
   - 看日志最后一行是否有正常退出日志
   - 解决方案：直接重启

4. **OOM（内存不足）**
   - 检查 `dmesg | grep -i oom` 或系统日志
   - 解决方案：增加内存或限制进程内存使用

5. **API/模型调用失败**
   - 日志中出现 429/4xx/5xx 但服务器进程未退出
   - 解决方案：修复 API 配置后重试

### 第 5 步：重启服务

```bash
cd <服务目录> && python3 bootstrap.py --no-browser
```

**后台启动（推荐，防止终端关闭影响）：**

使用 terminal 背景进程：

```bash
terminal(
  command='cd <服务目录> && python3 bootstrap.py --no-browser',
  background=True,
  notify_on_complete=True
)
```

**验证重启成功：**

```bash
ss -tlnp | grep <端口号>
```

确认端口在 LISTEN 状态且有对应的 PID。

## 自动保活（cron 看门狗）

为防止进程再次意外停止，可设置 cron 定期检查并自动重启：

```yaml
# cron job 配置思路
# 每 5 分钟检查端口是否存活，挂掉就重启
# 使用 script 模式：运行检测脚本，无输出 = 正常，有输出 = 问题
```

创建一个看门狗脚本 `<服务名>-watchdog.sh`：

```bash
#!/bin/bash
# 检查端口是否存活，挂掉则重启
PORT=<端口号>
SERVICE_DIR=<服务目录>
if ! ss -tlnp | grep -q ":$PORT "; then
  cd "$SERVICE_DIR" && python3 bootstrap.py --no-browser
  echo "[$(date)] WebUI restarted" >> ~/.hermes/webui/restart.log
fi
```

然后通过 cron job 定时执行此脚本。

## Hermes WebUI 特有信息

此技能创建时的上下文参考（通用模式，具体路径可能变化）：

| 属性 | 典型值 |
|------|--------|
| 源码位置 | `~/hermes-webui/` 或 `~/.hermes/hermes-webui/` |
| 端口 | 8787 |
| 启动命令 | `python3 bootstrap.py --no-browser` |
| 状态目录 | `~/.hermes/webui/` |
| 日志文件 | `~/.hermes/webui/bootstrap-<端口>.log` |
| 访问地址 | `http://127.0.0.1:<端口>` |

## Pitfalls

1. **不要只看 ps 不看端口** — 可能有孤儿进程残留在 process table 上但端口已释放
2. **日志尾部没有错误不等于正常退出** — 进程可能被 SIGKILL / SIGHUP 直接终止，来不及写日志
3. **WSL 中的后台进程** — 通过 `terminal(background=True)` 启动的进程在 WSL 中可能随终端关闭而退出。设置 notify_on_complete=True 或使用 cron 保活
4. **端口被占用时不要盲目加端口** — 先 `kill` 旧进程或用 `fuser -k <端口>/tcp` 清理
5. **不要仅依赖 grep -v grep** — 进程名可能包含 grep 本身的关键字，用 `pgrep` 或 `ps aux | grep [...]` 更可靠
