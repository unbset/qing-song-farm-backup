# Vault Git Setup — Version Control for Obsidian Vaults

Adding git version control to a knowledge vault provides backup, change tracking, rollback capability, and SOP version history.

## When to Set Up

As soon as a vault structure is created — before significant knowledge accumulation. Every edit is tracked from day one.

## Steps

### 1. Initialize the repo

```bash
cd /path/to/vault
git init
git branch -m main                         # rename default branch
git config user.email "system@vault.local"
git config user.name "Vault System"
```

### 2. Create `.gitignore`

Essential ignores to avoid committing tool-generated runtime files:

```
# Obsidian runtime (auto-generated)
.obsidian/workspace.json
.obsidian/workspaces.json
.obsidian/graph.json
.obsidian/cache/
.obsidian/plugins/obsidian-git/data.json

# Claude / AI tool config (not vault content)
.claude/
.claudian/

# OS
.DS_Store
Thumbs.db

# Temp
*.tmp
*.swp
*.bak
~$*
```

Note about `.claude/` vs vault content: if the vault is used by Claude Code via `.claude/` skills, those are the tool's own config cache. They should be gitignored — only the vault's actual knowledge content should be tracked.

### 3. Install obsidian-git plugin

Plugin already downloaded: simply enable it in `community-plugins.json` and configure `data.json`.

**Plugin config structure** (`.obsidian/plugins/obsidian-git/data.json`):

| Key | Recommended Value | Reason |
|-----|------------------|--------|
| `autoSaveInterval` | 15 | Auto-commit every 15 minutes |
| `autoPushInterval` | 60 | Push every hour (if remote configured) |
| `autoPullInterval` | 30 | Pull every 30 min to stay in sync |
| `autoPullOnBoot` | true | Get latest on vault open |
| `commitMessage` | `"📝 vault backup: {{date}}"` | Emoji prefix = visually scannable |
| `listChangedFilesInMessageBody` | true | See what changed without opening history |
| `changedFilesInStatusBar` | true | Visible indicator of uncommitted changes |
| `pullBeforePush` | true | Avoid push rejection |
| `differentIntervalCommitAndPush` | true | Commit more often than push |

### 4. First commit strategy

Stage vault content (not `.claude/` or `.claudian/`) and make an initial commit:

```bash
git add -A
git commit -m "🎉 Initial commit: [vault description]
- Core directory structure
- Principles, rules, templates"
```

The first commit will be large (all existing files). Subsequent commits are incremental.

### 5. Remote setup (optional)

```bash
git remote add origin <remote-url>
git push -u origin main
```

If using GitHub with WSL and a SOCKS5 proxy:
```bash
git config --global http.proxy socks5://<host>:10808
git config --global https.proxy socks5://<host>:10808
```

### 6. GitHub Token 配置与问题排查

准备将 vault 推送到 GitHub 时，会用到 `GITHUB_TOKEN`。以下是最常见的踩坑点。

#### 6a. Token 类型：Classic PAT vs Fine-grained PAT

GitHub 有两种 Personal Access Token：

| 类型 | 认证头 | 权限方式 | 仓库创建 |
|------|--------|---------|---------|
| **Classic PAT** | `Bearer` | 全局 scope（`repo` / `public_repo`） | 需要 `public_repo` 或 `repo` scope |
| **Fine-grained PAT** | `Bearer` | 按仓库细粒度授权 | 需要额外开启 **Administration: Write** 权限 |

**Fine-grained PAT 常见坑：**
- 默认只能访问你勾选的那几个仓库，无法创建新仓库
- 即使有 `Contents: Write`，也不足以创建仓库——需要 **Administration: Write**
- 已有的仓库只要有 `Contents: Write` 就可以推送代码

**诊断方法** — 先测试认证是否通过：

```bash
# 测试 token 能否认证
curl -s -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com/user
# ✅ 返回用户信息 → 认证成功
# ❌ "Bad credentials" (401) → token 无效或过期
```

如果认证通过但创建仓库失败（403）：

```bash
# 403 时 GitHub 会告诉你缺少什么
curl -s -X POST \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d '{"name":"test-repo","private":false}'
# ❌ "Resource not accessible by personal access token"
#     → 这是 fine-grained PAT 权限不够，不是 token 本身的问题
```

**解决方案：**

1. 对于 **fine-grained PAT**：
   - 打开 https://github.com/settings/tokens → Fine-grained tokens
   - 点击当前 token
   - **Repository access** → 改为 **All repositories**
   - **Permissions** → **Repository permissions** → **Administration: Write**
   - 保存

2. 或者换用 **Classic PAT**（更简单）：
   - 打开 https://github.com/settings/tokens → Tokens (classic)
   - 点 **Generate new token (classic)**
   - 勾选 **`public_repo`**（公开仓库）或 **`repo`**（私有仓库）
   - 生成后将值替换到 `~/.hermes/.env` 的 `GITHUB_TOKEN=` 后面

#### 6b. 完整推送流程（vault + 附属内容）

如果想把 vault 连同 Hermes skills 等附属内容一起备份到 GitHub：

```bash
# 1. 创建 GitHub 仓库（确保 token 有权限）
curl -s -X POST \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d '{"name":"仓库名","description":"描述","private":false}'

# 2. 进入 vault 目录
cd /mnt/d/我的农场

# 3. 设置远程仓库并推送
git remote add origin https://github.com/<用户名>/<仓库名>.git
git push -u origin main

# 4. （可选）将附属内容（如 skills）复制到 vault 目录后再提交
cp -r ~/.hermes/skills ./hermes-skills
git add hermes-skills
git commit -m "添加 Hermes skills 备份"
git push
```

#### 6c. 常见错误速查

| HTTP 错误 | 响应信息 | 原因 | 解决 |
|-----------|---------|------|------|
| 401 | `Bad credentials` | Token 无效或过期 | 重新生成 token |
| 403 | `Resource not accessible by personal access token` | Fine-grained PAT 缺少仓库创建权限 | 加 **Administration: Write** |
| 403 | `Must have push access to view repository` | 已有仓库但没有该仓库的访问权 | 在 token 设置中添加该仓库 |
| 422 | `Repository creation failed` | 仓库名已存在或格式不合法 | 换个名字或用 `gh repo create` |

## Pitfalls

- **Large first commit**: A vault with `.claude/` dirs can be hundreds of files. Gitignore those first.
- **obsidian-git plugin and large repos**: The plugin can slow down Obsidian on very large vaults (10K+ files). Keep the vault lean.
- **.gitignore obsidian-git data.json**: The plugin's own `data.json` contains local settings — don't commit it.
- **Chinese filenames**: Git handles them fine on Linux/WSL. On Windows, ensure `core.unicodeRendering` is set properly.
- **Auto-commit + auto-sync during editing**: The auto-commit fires on save. If a user is actively editing, git may commit a half-written file. The vault's structure (SOP versioning) handles this — intermediate commits are fine as long as releases are tagged.
- **Fine-grained PAT 无法创建仓库**: 即使认证成功（`/user` 返回 200），创建仓库仍可能 403。先检查 token 类型，再检查权限。
- **不要用 `token` 前缀 + fine-grained PAT**: GitHub 推荐 fine-grained PAT 用 `Bearer` 前缀。`Authorization: token xxx` 可能对某些 fine-grained PAT 不生效。
