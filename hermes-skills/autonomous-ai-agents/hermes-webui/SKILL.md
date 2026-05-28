---
name: hermes-webui
description: Deploy, start, manage, and troubleshoot the Hermes Web UI (nesquena/hermes-webui).
version: 1.0.0
created_by: agent
---

# Hermes Web UI Management

Manage the third-party Hermes Web UI (by nesquena) — a browser-based chat interface that connects to the local Hermes Agent instance.

GitHub: https://github.com/nesquena/hermes-webui

## Triggers

Load this skill when the user asks about:

- Web UI connection issues ("连接断开", "无法访问", "页面打不开")
- Starting or stopping the Web UI server
- Checking if the Web UI is running
- Setting up auto-restart / keepalive for the Web UI
- Web UI port, log, or state management
- Browser-based Hermes interface

## Installation

```bash
git clone https://github.com/nesquena/hermes-webui.git ~/hermes-webui
```

The code lives at `~/hermes-webui/`. The Hermes agent directory auto-detects from `~/.hermes/hermes-agent/`.

## Starting the Server

```bash
cd ~/hermes-webui && python3 bootstrap.py --no-browser
```

The server binds to `127.0.0.1:8787` by default. The `--no-browser` flag prevents it from opening a browser window (recommended for headless / WSL environments).

### Background Mode (Recommended)

Run as a background process so it survives your current terminal session:

```bash
# Via terminal tool with background=True, notify_on_complete=True
terminal(command="cd ~/hermes-webui && python3 bootstrap.py --no-browser", background=true, notify_on_complete=true)
```

The bootstrap launcher prints "Web UI is ready: http://localhost:8787" then exits — the actual server process continues running independently.

## Verifying It's Running

```bash
# Check port
ss -tlnp | grep 8787

# Or check process
ps aux | grep bootstrap | grep -v grep
```

## Logs

| Path | Description |
|------|-------------|
| `~/.hermes/webui/bootstrap-8787.log` | Main access log with JSON-formatted request entries |
| `~/.hermes/webui/settings.json` | UI settings |
| `~/.hermes/webui/sessions/` | Web UI session data |

## Common Issues

### Server Stopped / Not Running

**Symptom:** Page fails to load, "连接断开" message, port 8787 not listening.

**Most likely causes:**
1. WSL went to sleep / terminal was closed — kills the background process
2. No auto-restart mechanism — once stopped, it stays stopped

**Fix:** Restart the server (see Starting above). Consider setting up a cron job for keepalive.

### Auto-Restart with Cron

```bash
# Create a cron job that checks every 30 minutes
cronjob(action="create",
        name="webui-keepalive",
        schedule="every 30m",
        prompt="""Check if Hermes Web UI is running on port 8787.
If not, start it from ~/hermes-webui using python3 bootstrap.py --no-browser.
If it is running, do nothing.""",
        skills=["hermes-webui"])
```

### Port Conflict

If port 8787 is already in use, check with `ss -tlnp | grep 8787` to see what's listening. The Web UI only binds to `127.0.0.1` by default.

### No Outbound Credentials

The Web UI proxies requests through the local Hermes Agent. Ensure `OPENROUTER_API_KEY` (or your provider's key) is set in `~/.hermes/.env` if the Web UI needs to make API calls.

## File Layout

```
~/.hermes/webui/
├── bootstrap-8787.log       # Server access log
├── last_workspace.txt       # Default workspace path
├── sessions/                # Web UI session storage
└── settings.json            # UI configuration
```

## Pitfalls

- **Do NOT assume cron keepalive is set up.** Always ask or add it explicitly when starting the server for the first time.
- **Do NOT check for server process using the old repo root path.** The startup log may reference `/home/pdsda/.hermes/hermes-webui` but the working clone is `~/hermes-webui/`.
- **The bootstrap launcher exits after spawning the real server.** Don't confuse the launcher's exit with a server crash.
