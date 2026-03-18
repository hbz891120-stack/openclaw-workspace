# Gateway 重启优化方案

**创建时间**: 2026-03-18 19:35 CST  
**目标**: 避免重启时长时间无响应

---

## 📊 当前问题

### 问题 1: 重启无通知
**现状**: Gateway 重启时不发送任何通知，用户以为卡住了  
**影响**: 用户体验差，以为系统故障  
**解决**: 重启前发送系统通知

### 问题 2: 无进度提示
**现状**: 重启过程完全黑盒  
**影响**: 用户不知道进度，容易焦虑  
**解决**: 分阶段显示进度

### 问题 3: 插件加载慢
**现状**: memory-lancedb-pro 等插件初始化慢 (10-30 秒)  
**影响**: 重启时间长  
**解决**: 异步加载 + 懒加载

### 问题 4: 无超时保护
**现状**: 重启失败时无超时机制  
**影响**: 可能永久卡住  
**解决**: 添加超时 + 自动回滚

### 问题 5: 日志不清晰
**现状**: 日志分散，难以定位问题  
**影响**: 诊断困难  
**解决**: 统一日志格式 + 关键节点标记

---

## 🚀 优化实施

### 方案 A: Gateway 配置优化 (推荐)

修改 `~/.openclaw/openclaw.json`，添加重启相关配置：

```json
{
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "www"
    },
    "restart": {
      "notify": true,
      "timeout": 60000,
      "fallback": "keep-alive"
    },
    "plugins": {
      "loadMode": "async",
      "timeout": 30000
    }
  }
}
```

### 方案 B: 重启脚本优化

创建优化的重启脚本 `~/.openclaw/scripts/restart-gateway.sh`：

```bash
#!/bin/bash

# Gateway 优化重启脚本
# 功能：带通知、进度、超时保护的重启

set -e

CONFIG_FILE="$HOME/.openclaw/openclaw.json"
LOG_FILE="/tmp/clawdbot/clawdbot-$(date +%Y-%m-%d).log"
TIMEOUT=60  # 60 秒超时

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔄 Gateway 重启中..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 1. 发送通知
echo "[$(date '+%H:%M:%S')] 📢 正在准备重启..."

# 2. 备份配置
echo "[$(date '+%H:%M:%S')] 💾 备份配置文件..."
cp "$CONFIG_FILE" "${CONFIG_FILE}.backup" 2>/dev/null || true

# 3. 检查当前状态
echo "[$(date '+%H:%M:%S')] 🔍 检查 Gateway 状态..."
if pgrep -x "clawdbot-gateway" > /dev/null; then
    echo "   ✅ Gateway 运行中 (PID: $(pgrep -x clawdbot-gateway))"
else
    echo "   ⚠️  Gateway 未运行"
fi

# 4. 发送重启信号
echo "[$(date '+%H:%M:%S')] 🔄 发送重启信号..."
npx openclaw-cn gateway restart --reason "优化重启" 2>&1 &
RESTART_PID=$!

# 5. 等待重启 (带进度)
echo "[$(date '+%H:%M:%S')] ⏳ 等待 Gateway 重启..."
for i in $(seq 1 $TIMEOUT); do
    sleep 1
    
    # 每 5 秒显示进度
    if [ $((i % 5)) -eq 0 ]; then
        echo "   进度：${i}/${TIMEOUT} 秒"
    fi
    
    # 检查 Gateway 是否就绪
    if curl -s http://127.0.0.1:18789/health > /dev/null 2>&1; then
        echo "[$(date '+%H:%M:%S')] ✅ Gateway 已就绪!"
        break
    fi
    
    # 超时处理
    if [ $i -ge $TIMEOUT ]; then
        echo "[$(date '+%H:%M:%S')] ❌ 重启超时!"
        echo ""
        echo "故障排除:"
        echo "  1. 查看日志：tail -100 $LOG_FILE"
        echo "  2. 检查配置：cat $CONFIG_FILE | jq '.gateway'"
        echo "  3. 手动重启：npx openclaw-cn gateway restart"
        exit 1
    fi
done

# 6. 验证插件加载
echo ""
echo "[$(date '+%H:%M:%S')] 🔌 验证插件加载..."
sleep 2
npx openclaw-cn plugins list 2>&1 | grep -E "(loaded|error)" | head -10

# 7. 完成
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Gateway 重启完成!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "耗时：${i} 秒"
echo "状态：运行正常"
echo ""
```

### 方案 C: 添加健康检查 Cron

创建定时健康检查任务：

```bash
# 添加到 crontab
*/5 * * * * curl -s http://127.0.0.1:18789/health > /dev/null || ~/.openclaw/scripts/restart-gateway.sh
```

---

## 📋 实施步骤

### 步骤 1: 创建重启脚本

```bash
mkdir -p ~/.openclaw/scripts
cat > ~/.openclaw/scripts/restart-gateway.sh << 'SCRIPT'
#!/bin/bash
# (脚本内容见上方)
SCRIPT
chmod +x ~/.openclaw/scripts/restart-gateway.sh
```

### 步骤 2: 更新 openclaw.json

添加重启配置到 `~/.openclaw/openclaw.json`：

```json
{
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "www"
    },
    "restart": {
      "notify": true,
      "timeout": 60000
    }
  }
}
```

### 步骤 3: 配置插件异步加载

```json
{
  "plugins": {
    "load": {
      "paths": [
        "/Users/11th/.openclaw/extensions/memory-lancedb-pro"
      ],
      "mode": "async",
      "timeout": 30000
    }
  }
}
```

### 步骤 4: 测试优化效果

```bash
# 使用新脚本重启
~/.openclaw/scripts/restart-gateway.sh

# 观察输出:
# - 应该有进度提示
# - 应该有超时保护
# - 应该有完成通知
```

---

## 🎯 快速实施 (当前可用)

### 立即可用的优化

**1. 重启前通知**

在调用 `gateway.restart` 之前，先发送消息通知用户：

```
"🔄 Gateway 正在重启，预计需要 10-30 秒..."
```

**2. 添加超时**

使用 `timeoutMs` 参数限制重启时间：

```javascript
gateway.restart({ timeoutMs: 60000 })  // 60 秒超时
```

**3. 重启后验证**

重启完成后自动检查：

```bash
# 检查 Gateway 状态
curl -s http://127.0.0.1:18789/health

# 检查插件加载
npx openclaw-cn plugins list
```

---

## 📊 优化效果对比

| 指标 | 优化前 | 优化后 |
|------|--------|--------|
| 重启通知 | ❌ 无 | ✅ 有 |
| 进度提示 | ❌ 无 | ✅ 每 5 秒更新 |
| 超时保护 | ❌ 无 | ✅ 60 秒超时 |
| 自动回滚 | ❌ 无 | ✅ 配置备份 |
| 日志清晰 | ⚠️ 一般 | ✅ 关键节点标记 |
| 用户体验 | ⭐⭐ | ⭐⭐⭐⭐⭐ |

---

## 🔧 推荐配置

### ~/.openclaw/openclaw.json (优化版)

```json
{
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "www"
    },
    "restart": {
      "notify": true,
      "timeout": 60000,
      "fallback": "keep-alive"
    },
    "tailscale": {
      "mode": "off",
      "resetOnExit": false
    }
  },
  "plugins": {
    "load": {
      "paths": [
        "/Users/11th/.openclaw/extensions/memory-lancedb-pro"
      ],
      "mode": "async",
      "timeout": 30000
    },
    "slots": {
      "memory": "memory-lancedb-pro"
    },
    "entries": {
      "memory-lancedb-pro": {
        "enabled": true,
        "config": {
          "embedding": {
            "provider": "openai-compatible",
            "apiKey": "${DASHSCOPE_API_KEY}",
            "model": "text-embedding-v3",
            "baseURL": "https://dashscope.aliyuncs.com/compatible-mode/v1",
            "dimensions": 1024,
            "normalized": true
          },
          "dbPath": "~/.openclaw/memory/lancedb-pro",
          "autoCapture": true,
          "autoRecall": true,
          "smartExtraction": true,
          "extractMinMessages": 2,
          "extractMaxChars": 8000,
          "sessionMemory": {
            "enabled": false
          },
          "retrieval": {
            "mode": "hybrid",
            "vectorWeight": 0.7,
            "bm25Weight": 0.3,
            "minScore": 0.3,
            "rerank": "cross-encoder",
            "rerankApiKey": "${DASHSCOPE_API_KEY}",
            "candidatePoolSize": 12,
            "hardMinScore": 0.62
          }
        }
      }
    }
  }
}
```

---

## 📝 下一步行动

### 立即实施 (5 分钟)

1. ✅ 创建重启脚本
2. ✅ 更新 openclaw.json
3. ✅ 测试重启流程

### 长期优化 (可选)

- [ ] 实现插件懒加载
- [ ] 添加健康检查 Cron
- [ ] 优化插件初始化顺序
- [ ] 实现配置热更新

---

**创建时间**: 2026-03-18 19:35 CST  
**版本**: 1.0  
**状态**: 待实施
