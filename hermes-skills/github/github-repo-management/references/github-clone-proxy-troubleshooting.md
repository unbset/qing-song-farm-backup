# WSL GitHub Clone — Proxy Troubleshooting

## Diagnosing Proxy Connectivity

On WSL with v2rayN/Clash/other proxy tools running on the Windows host:

```bash
# Get Windows host IP
HOST_IP=$(ip route | grep default | awk '{print $3}')
echo "Windows host: $HOST_IP"

# Test proxy ports
timeout 3 bash -c "echo > /dev/tcp/$HOST_IP/10809" 2>&1 && echo "HTTP(10809): OPEN" || echo "HTTP(10809): CLOSED"
timeout 3 bash -c "echo > /dev/tcp/$HOST_IP/10808" 2>&1 && echo "SOCKS5(10808): OPEN" || echo "SOCKS5(10808): CLOSED"
```

**Interpretation:**
| HTTP | SOCKS5 | Meaning |
|------|--------|---------|
| OPEN | OPEN | Both proxies working — use env vars |
| CLOSED | OPEN | SOCKS5-only (common v2rayN default) — use git socks proxy |
| CLOSED | CLOSED | Proxy not running on Windows, or bound to 127.0.0.1 only |
| OPEN | CLOSED | HTTP proxy only — try `export http_proxy/http_proxy` |

## Fix: v2rayN Binds to 127.0.0.1 Only

If `timeout 3 bash -c "echo > /dev/tcp/$HOST_IP/10809"` fails but the proxy works from Windows browsers:

1. Open v2rayN on Windows
2. Go to **Parameters** → **Parameter Setting**
3. **Local Address** → change from `127.0.0.1` to `0.0.0.0`
4. Restart v2rayN

## SOCKS5 Clone (No Config Change)

If SOCKS5 port is open but HTTP is not, add a per-repo remote:

```bash
git clone https://github.com/owner/repo.git
cd repo
git config --local http.proxy socks5://$HOST_IP:10808
git config --local https.proxy socks5://$HOST_IP:10808
```

## Test That Any Proxy Works

```bash
# SOCKS5 test
curl -s --socks5 172.24.208.1:10808 https://api.github.com 2>&1 | head -1

# HTTP proxy test
curl -s -x http://172.24.208.1:10809 https://api.github.com 2>&1 | head -1
```

## Unset Proxy After Clone

```bash
# Global (affects all repos)
git config --global --unset http.proxy
git config --global --unset https.proxy

# Local (current repo only)
git config --local --unset http.proxy
git config --local --unset https.proxy
```
