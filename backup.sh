#!/bin/bash
# 青松农场备份脚本 — 一键推送至 GitHub
# 用法: bash backup.sh

set -e

cd "$(dirname "$0")"

echo "=== 青松农场备份 ==="
echo ""

# 检查是否有未提交的修改
if ! git diff --quiet -- 青松农场经营系统/; then
    echo "→ 检测到农场经营系统有改动..."
    git add 青松农场经营系统/
    git commit -m "备份更新：$(date '+%Y-%m-%d %H:%M')"
    echo "  ✅ 已提交"
else
    echo "→ 农场经营系统无变化"
fi

# 检查 skills 是否有变化
if ! git diff --quiet -- hermes-skills/ 2>/dev/null; then
    echo "→ 检测到 skills 有变化..."
    rsync -a --delete \
        --exclude='.hub' --exclude='.usage.json' --exclude='.usage.json.lock' \
        --exclude='.curator_state' --exclude='.bundled_manifest' \
        "$HOME/.hermes/skills/" hermes-skills/
    git add hermes-skills/
    git commit -m "skills 备份更新：$(date '+%Y-%m-%d %H:%M')"
    echo "  ✅ 已提交"
else
    echo "→ skills 无变化"
fi

# 推送到 GitHub
echo ""
echo "→ 推送至 GitHub..."
git push
echo "  ✅ 推送完成"

echo ""
echo "=== 备份完成 ==="
