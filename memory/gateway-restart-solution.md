# Gateway 重启优化方案

**问题**: Gateway 重启会导致 WebSocket 连接断开，前端对话卡住无法继续

**根本原因**: 
- Gateway 重启时关闭 WebSocket 服务器
- 前端 (webchat) 没有自动重连机制
- 会话状态在重启过程中丢失

---

## ✅ 解决方案

### 方案 1: 使用优化重启脚本 (推荐)

脚本位置：`~/.openclaw/scripts/restart-gateway.sh`

**特性**:
- ✓ 自动备份配置
- ✓ 尝试热重载 (SIGUSR1) - 不中断连接
- ✓ 60 秒超时保护
- ✓ 详细日志记录
- ✓ 失败自动回滚

**使用方法**:
```bash
# 执行重启
~/.openclaw/scripts/restart-gateway.sh

# 查看日志
tail -f /tmp/clawdbot/gateway-restart-*.log
```

**工作流程**:
1. 备份 `openclaw.json` → `openclaw.json.bak`
2. 尝试发送 `SIGUSR1` 信号 (热重载，不中断连接)
3. 如果热重载失败，执行完全重启
4. 等待 Gateway 就绪 (最多 30 秒)
5. 报告结果

---

### 方案 2: 配置 `fallback: keep-alive` (已启用)

在 `openclaw.json` 中添加:

```json
{
  "gateway": {
    "restart": {
      "notify": true,
      "timeout": 60000,
      "fallback": "keep-alive"
    }
  }
}
```

**作用**: 
- 重启时保持会话状态
- 减少连接中断时间
- 自动恢复连接 (如果前端支持)

---

### 方案 3: 使用原生重启命令

```bash
# 启用原生重启命令 (已配置)
"commands": {
  "restart": true
}

# 使用方式
npx openclaw-cn gateway restart
```

---

## 📋 重启检查清单

### 重启前
- [ ] 确认配置已保存 (`openclaw.json`)
- [ ] 确认没有正在进行的任务
- [ ] 记录当前 Gateway PID (可选)

### 重启后
- [ ] 检查 Gateway 状态：`ps aux | grep clawdbot-gateway`
- [ ] 检查健康状态：`curl http://127.0.0.1:18789/health`
- [ ] 检查插件加载：`npx openclaw-cn plugins list`
- [ ] 测试基本功能

---

## 🔧 故障排除

### Gateway 无法启动

```bash
# 查看日志
tail -100 /tmp/clawdbot/clawdbot-$(date +%Y-%m-%d).log

# 检查端口占用
lsof -i :18789

# 检查配置
npx openclaw-cn gateway config.get

# 恢复备份配置
cp ~/.openclaw/openclaw.json.bak ~/.openclaw/openclaw.json
```

### 对话仍然卡住

**原因**: 前端 WebSocket 客户端没有重连逻辑

**解决方案**:
1. 刷新浏览器页面
2. 重新打开聊天窗口
3. 等待 30 秒后重试

**长期方案**: 需要 OpenClaw 前端实现自动重连机制

---

## 📊 重启时间对比

| 方法 | 耗时 | 连接中断 | 推荐度 |
|------|------|----------|--------|
| 热重载 (SIGUSR1) | 2-5 秒 | ❌ 否 | ⭐⭐⭐⭐⭐ |
| 优化脚本 | 10-30 秒 | ⚠️ 短暂 | ⭐⭐⭐⭐ |
| 原生重启 | 10-30 秒 | ⚠️ 短暂 | ⭐⭐⭐⭐ |
| 手动重启 | 30-60 秒 | ✅ 是 | ⭐⭐ |

---

## 🎯 最佳实践

1. **优先使用热重载**: `kill -USR1 <gateway_pid>`
2. **配置变更时使用脚本**: 自动备份 + 回滚
3. **避免频繁重启**: 插件配置变更才需要重启
4. **监控日志**: 定期检查 `/tmp/clawdbot/` 日志
5. **定期备份**: 重要配置手动备份

---

## 📝 相关配置

### openclaw.json 完整配置

```json
{
  "commands": {
    "native": "auto",
    "nativeSkills": "auto",
    "restart": true
  },
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "restart": {
      "notify": true,
      "timeout": 60000,
      "fallback": "keep-alive"
    }
  }
}
```

---

**最后更新**: 2026-03-18  
**状态**: ✅ 已实施
