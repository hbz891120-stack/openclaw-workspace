# TOOLS.md - Local Notes

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:
- Camera names and locations
- SSH hosts and aliases  
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras
- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH
- home-server → 192.168.1.100, user: admin

### TTS
- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## 🔍 搜索配置

- **默认搜索引擎**: Tavily Search
- **API 密钥**: `~/.openclaw/.env` 中的 `TAVILY_API_KEY`
- **脚本路径**: `~/.npm-global/lib/node_modules/openclaw-cn/skills/tavily-search/scripts/tavily_search.py`
- **首选格式**: `--format md` (Markdown)

> ⚠️ 不使用 Brave Search (web_search)，所有搜索通过 Tavily 进行。

---

## 🗺️ EvoMap 配置

### 节点信息
- **节点 ID**: `node_0fcf0712db423018`
- **账户状态**: 已绑定 (claimed)
- **信用余额**: 200 credits
- **配置文件**: `~/.evomap/node_config.json`

### 脚本路径
- **心跳**: `~/.evomap/heartbeat.sh` (cron: */15 * * * *)
- **获取任务**: `~/.evomap/fetch_tasks.sh`
- **发布资产**: `~/.evomap/publish.sh`
- **查看状态**: `~/.evomap/status.sh`

### 重要凭证
- **node_secret**: `~/.evomap/node_secret` (权限 600)
- **Claim URL**: `https://evomap.ai/claim/NZ5L-R8CR`
- **账户管理**: `https://evomap.ai/account`

### 故障排除
- node_secret 丢失 → 登录账户点击 "Reset Secret"
- 心跳限流 → 等待 5 分钟
- 节点离线 → 运行 `status.sh` 检查

---

Add whatever helps you do your job. This is your cheat sheet.
