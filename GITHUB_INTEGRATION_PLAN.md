# GitHub 集成方案

**创建时间**: 2026-03-18 17:15  
**目标**: 完整集成 GitHub 到 OpenClaw 工作流  
**优先级**: 高

---

## 📊 当前状态评估

| 项目 | 状态 | 详情 |
|------|------|------|
| **GitHub Skill** | ✅ 已安装 | OpenClaw 内置技能 |
| **GitHub CLI (gh)** | ❌ 未安装 | 需要通过 Homebrew 安装 |
| **Git 配置** | ❌ 未配置 | 缺少 user.name 和 user.email |
| **SSH Key** | ❌ 未生成 | 需要生成并添加到 GitHub |
| **GitHub 认证** | ❌ 未认证 | 需要 gh auth login |
| **Homebrew** | ✅ 已安装 | `/opt/homebrew/bin/brew` |

---

## 🎯 集成目标

### 核心功能
1. **代码管理** - Git 提交、推送、拉取
2. **Issue 管理** - 创建、查看、关闭 issue
3. **PR 管理** - 创建、审查、合并 PR
4. **CI/CD 监控** - 查看 workflow 运行状态
5. **仓库管理** - 创建、克隆、同步仓库

### 自动化场景
1. **自动提交** - 工作区变更自动 commit & push
2. **Issue 响应** - 新 issue 自动分析和回复
3. **PR 审查** - 自动检查 PR 变更并提供反馈
4. **Release 管理** - 自动创建 release 和 changelog
5. **问题追踪** - 自动同步 GitHub issue 到本地任务

---

## 📋 实施步骤

### 阶段 1: 基础环境配置 (预计 10 分钟)

#### 1.1 安装 GitHub CLI
```bash
brew install gh
```

#### 1.2 配置 Git 用户信息
```bash
git config --global user.name "11th"
git config --global user.email "your-email@example.com"
```

#### 1.3 生成 SSH Key
```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
# 或 RSA (兼容性更好)
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
```

#### 1.4 添加 SSH Key 到 GitHub
```bash
# 复制公钥
cat ~/.ssh/id_ed25519.pub | pbcopy
# 然后到 GitHub 设置中添加: https://github.com/settings/keys
```

#### 1.5 GitHub 认证
```bash
gh auth login
# 选择:
# - GitHub.com
# - SSH
# - 使用已有的 SSH key
# - 完成浏览器认证
```

---

### 阶段 2: OpenClaw 集成 (预计 15 分钟)

#### 2.1 验证 GitHub Skill
```bash
# 测试 gh 命令
gh --version

# 测试认证状态
gh auth status
```

#### 2.2 配置工作区 Git
```bash
cd ~/.openclaw/workspace
git init  # 如果还没有初始化
git remote add origin git@github.com:USERNAME/workspace.git
```

#### 2.3 设置自动化脚本
创建 `~/.openclaw/workspace/scripts/github-sync.sh`:
```bash
#!/bin/bash
# GitHub 自动同步脚本

cd ~/.openclaw/workspace

# 检查变更
git status --porcelain

# 如果有变更，自动提交
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M')"
    git push origin main
    echo "✅ 已同步到 GitHub"
else
    echo "✓ 无需同步"
fi
```

---

### 阶段 3: 自动化配置 (预计 20 分钟)

#### 3.1 创建 Cron 任务
```bash
# 每 30 分钟自动同步工作区
*/30 * * * * ~/.openclaw/workspace/scripts/github-sync.sh >/dev/null 2>&1
```

#### 3.2 配置 GitHub 通知 (可选)
使用 GitHub webhook 或轮询:
```bash
# 检查新 issue
gh issue list --state open --limit 10
```

#### 3.3 集成到 OpenClaw 心跳
在 `HEARTBEAT.md` 中添加 GitHub 检查项。

---

## 🔧 常用命令参考

### 仓库操作
```bash
# 克隆仓库
gh repo clone owner/repo

# 创建新仓库
gh repo create my-repo --public --source=. --push

# 查看仓库信息
gh repo view --json name,description,stargazerCount
```

### Issue 管理
```bash
# 列出 issue
gh issue list --state open

# 创建 issue
gh issue create --title "Bug: xxx" --body "Description..."

# 查看 issue 详情
gh issue view 123

# 添加评论
gh issue comment 123 --body "Fixed in latest commit"

# 关闭 issue
gh issue close 123
```

### PR 管理
```bash
# 创建 PR
gh pr create --title "Fix: xxx" --body "Description..."

# 查看 PR 状态
gh pr status

# 检查 CI 运行
gh pr checks

# 合并 PR
gh pr merge --merge --delete-branch

# 审查 PR
gh pr review --approve
gh pr review --comment
gh pr review --request-changes
```

### Workflow/CI
```bash
# 查看运行列表
gh run list --limit 10

# 查看运行详情
gh run view <run-id>

# 查看失败日志
gh run view <run-id> --log-failed

# 重新运行
gh run rerun <run-id>

# 取消运行
gh run cancel <run-id>
```

### 高级查询
```bash
# API 查询
gh api /user --jq '.login, .name, .public_repos'

# 搜索仓库
gh search repos "topic:machine-learning" --json name,description,stargazersCount

# 查看贡献
gh api /repos/owner/repo/contributors --jq '.[].login'
```

---

## 🤖 自动化场景实现

### 场景 1: 工作区自动备份
```bash
# 脚本：github-backup.sh
#!/bin/bash
cd ~/.openclaw/workspace
git add .
git diff --cached --quiet || git commit -m "Backup: $(date '+%Y-%m-%d %H:%M')"
git push origin main 2>/dev/null
```

### 场景 2: GitHub Issue 监控
```bash
# 脚本：github-issues-check.sh
#!/bin/bash
NEW_ISSUES=$(gh issue list --state open --json number,title,createdAt | \
  jq -r '.[] | select(.createdAt > "24h ago") | "\(.number): \(.title)"')

if [ -n "$NEW_ISSUES" ]; then
    echo "📋 新 Issue 提醒:"
    echo "$NEW_ISSUES"
    # 可以集成到 OpenClaw 消息通知
fi
```

### 场景 3: PR 自动审查
```bash
# 脚本：github-pr-review.sh
#!/bin/bash
PR_NUMBER=$1
gh pr view $PR_NUMBER --json files,author,title | \
  jq -r '.files[].path' | while read file; do
    echo "检查文件：$file"
    # 可以添加自定义审查逻辑
done
```

---

## 📅 实施时间表

| 阶段 | 任务 | 预计时间 | 状态 |
|------|------|----------|------|
| **阶段 1** | 安装 gh CLI | 5 分钟 | ⏳ 待执行 |
| **阶段 1** | 配置 Git 用户 | 2 分钟 | ⏳ 待执行 |
| **阶段 1** | 生成 SSH Key | 3 分钟 | ⏳ 待执行 |
| **阶段 1** | GitHub 认证 | 5 分钟 | ⏳ 待执行 |
| **阶段 2** | 验证集成 | 5 分钟 | ⏳ 待执行 |
| **阶段 2** | 配置工作区 Git | 5 分钟 | ⏳ 待执行 |
| **阶段 3** | 创建自动化脚本 | 10 分钟 | ⏳ 待执行 |
| **阶段 3** | 配置 Cron 任务 | 5 分钟 | ⏳ 待执行 |
| **总计** | - | **40 分钟** | - |

---

## 🔐 安全注意事项

### SSH Key 管理
- ✅ 使用强密码保护私钥
- ✅ 不要将私钥上传到任何地方
- ✅ 定期轮换 SSH key
- ✅ 使用 `ssh-add` 管理多个 key

### GitHub Token
- ✅ 最小权限原则
- ✅ 定期更新 token
- ✅ 不在代码中硬编码 token
- ✅ 使用 `gh auth` 管理认证

### 自动化安全
- ✅ 审查所有自动提交的代码
- ✅ 限制自动化脚本的权限
- ✅ 记录所有自动化操作
- ✅ 设置回滚机制

---

## 📊 成功指标

| 指标 | 目标值 | 测量方式 |
|------|--------|----------|
| **认证成功率** | 100% | `gh auth status` |
| **自动备份频率** | 每 30 分钟 | Cron 日志 |
| **Issue 响应时间** | < 1 小时 | GitHub 统计 |
| **PR 审查覆盖率** | > 80% | GitHub Insights |
| **CI 监控及时性** | < 5 分钟 | Webhook 延迟 |

---

## 🚀 快速启动命令

**一键执行所有配置** (需要用户确认):
```bash
# 1. 安装 gh
brew install gh

# 2. 配置 Git
git config --global user.name "11th"
git config --global user.email "your-email@example.com"

# 3. 生成 SSH Key
ssh-keygen -t ed25519 -C "your-email@example.com" -N ""

# 4. 复制公钥到剪贴板
cat ~/.ssh/id_ed25519.pub | pbcopy

# 5. GitHub 认证
gh auth login
```

**完成后验证**:
```bash
gh auth status
git --version
gh --version
```

---

## 📝 下一步行动

1. **确认用户信息** - 获取用户的 GitHub 用户名和邮箱
2. **执行安装** - 安装 gh CLI 并完成认证
3. **配置自动化** - 设置自动备份和监控脚本
4. **测试集成** - 验证所有功能正常工作
5. **文档更新** - 将配置记录到 TOOLS.md

---

*方案版本：1.0*  
*最后更新：2026-03-18 17:15*
