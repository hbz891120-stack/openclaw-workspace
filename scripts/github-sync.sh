#!/bin/bash
# GitHub 自动同步脚本

cd ~/.openclaw/workspace

# 检查变更
CHANGES=$(git status --porcelain)

if [ -n "$CHANGES" ]; then
    echo "📝 发现变更:"
    echo "$CHANGES"
    echo ""
    
    # 添加并提交
    git add .
    git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M')"
    
    # 推送到 GitHub
    git push origin master 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ 已同步到 GitHub"
    else
        echo "❌ 推送失败"
    fi
else
    echo "✓ 无需同步 (无变更)"
fi
