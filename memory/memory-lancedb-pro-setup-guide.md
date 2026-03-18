# memory-lancedb-pro 配置指南

**配置时间**: 2026-03-18 18:42 CST

---

## 📋 配置步骤

### 步骤 1: 选择 Embedding 方案

memory-lancedb-pro 支持多种 Embedding Provider，选择一个：

#### 方案 A: Jina AI (推荐，性价比高)
- **价格**: 免费额度 + 低价
- **模型**: jina-embeddings-v3
- **注册**: https://jina.ai/
- **优点**: 支持多语言、中文效果好

#### 方案 B: OpenAI (质量最好)
- **价格**: $0.02 / 1M tokens
- **模型**: text-embedding-3-small
- **注册**: https://platform.openai.com/
- **优点**: 质量最好、文档完善

#### 方案 C: Ollama (完全免费，本地运行)
- **价格**: 免费
- **模型**: nomic-embed-text / mxbai-embed-large
- **安装**: `brew install ollama`
- **优点**: 完全免费、本地运行、隐私好

#### 方案 D: Gemini (免费额度)
- **价格**: 免费额度
- **模型**: text-embedding-004
- **注册**: https://aistudio.google.com/
- **优点**: 免费额度大

---

### 步骤 2: 获取 API Key

#### 获取 Jina API Key (推荐)
1. 访问：https://jina.ai/
2. 点击 "Get API Key" 或登录
3. 复制 API Key (格式：`jina_...`)

#### 获取 OpenAI API Key
1. 访问：https://platform.openai.com/api-keys
2. 点击 "Create new secret key"
3. 复制 API Key (格式：`sk-...`)

#### 获取 Gemini API Key
1. 访问：https://aistudio.google.com/app/apikey
2. 点击 "Create API Key"
3. 复制 API Key

---

### 步骤 3: 配置 API Key

**方式 A: 添加到 ~/.openclaw/.env 文件**

```bash
# 创建或编辑 .env 文件
cat >> ~/.openclaw/.env << 'EOF'

# memory-lancedb-pro Embedding 配置
# 选择其中一个：

# Jina AI (推荐)
JINA_API_KEY=your_jina_api_key_here

# OpenAI
# OPENAI_API_KEY=your_openai_api_key_here

# Gemini
# GEMINI_API_KEY=your_gemini_api_key_here
EOF
```

**方式 B: 直接设置环境变量**
```bash
export JINA_API_KEY="your_jina_api_key_here"
```

---

### 步骤 4: 配置 openclaw.json

在 `plugins` 部分添加 memory-lancedb-pro 配置：

```json
{
  "plugins": {
    "load": {
      "paths": [
        "/Users/11th/.openclaw/extensions/memory-lancedb-pro"
      ]
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
            "apiKey": "${JINA_API_KEY}",
            "model": "jina-embeddings-v3",
            "baseURL": "https://api.jina.ai/v1",
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
            "rerankApiKey": "${JINA_API_KEY}",
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

### 步骤 5: 验证配置

```bash
# 验证配置文件
npx openclaw-cn config validate

# 查看插件信息
npx openclaw-cn plugins info memory-lancedb-pro

# 重启 Gateway
npx openclaw-cn gateway restart
```

---

### 步骤 6: 测试记忆功能

```bash
# 查看记忆统计
npx openclaw-cn memory-pro stats

# 测试搜索
npx openclaw-cn memory-pro search "测试"

# 查看日志
npx openclaw-cn logs --follow --plain | grep "memory-lancedb-pro"
```

---

## 🔧 完整配置示例

### ~/.openclaw/openclaw.json (完整配置)

```json
{
  "wizard": {
    "lastRunAt": "2026-03-18T02:08:55.177Z",
    "lastRunVersion": "0.1.8-fix.3",
    "lastRunCommand": "onboard",
    "lastRunMode": "local"
  },
  "auth": {
    "profiles": {
      "dashscope-coding-plan:default": {
        "provider": "dashscope-coding-plan",
        "mode": "api_key"
      }
    },
    "order": {
      "dashscope-coding-plan": [
        "dashscope-coding-plan:default"
      ]
    }
  },
  "models": {
    "mode": "merge",
    "providers": {
      "dashscope-coding-plan": {
        "baseUrl": "https://coding.dashscope.aliyuncs.com/v1",
        "api": "openai-completions",
        "models": [
          {
            "id": "qwen3.5-plus",
            "name": "qwen3.5-plus",
            "reasoning": false,
            "input": [
              "text"
            ],
            "cost": {
              "input": 0,
              "output": 0,
              "cacheRead": 0,
              "cacheWrite": 0
            },
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "dashscope-coding-plan/qwen3.5-plus"
      },
      "models": {
        "dashscope-coding-plan/qwen3.5-plus": {
          "alias": "qwen3.5-plus"
        }
      },
      "workspace": "/Users/11th/.openclaw/workspace",
      "compaction": {
        "mode": "safeguard"
      },
      "maxConcurrent": 4,
      "subagents": {
        "maxConcurrent": 8
      }
    }
  },
  "messages": {
    "ackReactionScope": "group-mentions"
  },
  "commands": {
    "native": "auto",
    "nativeSkills": "auto",
    "restart": true
  },
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "www"
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
      ]
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
            "apiKey": "${JINA_API_KEY}",
            "model": "jina-embeddings-v3",
            "baseURL": "https://api.jina.ai/v1",
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
            "rerankApiKey": "${JINA_API_KEY}",
            "candidatePoolSize": 12,
            "hardMinScore": 0.62
          }
        }
      }
    }
  },
  "meta": {
    "lastTouchedVersion": "0.1.8-fix.3",
    "lastTouchedAt": "2026-03-18T02:08:55.190Z"
  }
}
```

---

## 🎯 配置说明

### 核心配置项

| 配置项 | 说明 | 推荐值 |
|--------|------|--------|
| `embedding.provider` | Embedding 提供商 | `openai-compatible` |
| `embedding.apiKey` | API Key | `${JINA_API_KEY}` |
| `embedding.model` | Embedding 模型 | `jina-embeddings-v3` |
| `embedding.baseURL` | API 地址 | `https://api.jina.ai/v1` |
| `autoCapture` | 自动捕捉记忆 | `true` |
| `autoRecall` | 自动回忆 | `true` |
| `smartExtraction` | 智能提取 | `true` |
| `retrieval.mode` | 检索模式 | `hybrid` (混合检索) |
| `retrieval.rerank` | 重排序 | `cross-encoder` |

### 可选配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `extractMinMessages` | 触发提取的最小消息数 | `2` |
| `extractMaxChars` | 提取最大字符数 | `8000` |
| `sessionMemory.enabled` | 会话记忆 | `false` |
| `retrieval.vectorWeight` | 向量检索权重 | `0.7` |
| `retrieval.bm25Weight` | BM25 权重 | `0.3` |

---

## 🚀 快速配置脚本

复制以下脚本并运行：

```bash
#!/bin/bash

# 1. 提示输入 API Key
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔑 配置 memory-lancedb-pro"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "请选择 Embedding 方案:"
echo "1. Jina AI (推荐，免费额度 + 低价)"
echo "2. OpenAI (质量最好)"
echo "3. Ollama (完全免费，本地)"
echo "4. Gemini (免费额度)"
echo ""
read -p "选择 [1-4]: " choice

case $choice in
  1)
    read -p "输入 Jina API Key: " api_key
    echo "JINA_API_KEY=$api_key" >> ~/.openclaw/.env
    provider="openai-compatible"
    model="jina-embeddings-v3"
    base_url="https://api.jina.ai/v1"
    ;;
  2)
    read -p "输入 OpenAI API Key: " api_key
    echo "OPENAI_API_KEY=$api_key" >> ~/.openclaw/.env
    provider="openai"
    model="text-embedding-3-small"
    base_url="https://api.openai.com/v1"
    ;;
  3)
    echo "OLLAMA_API_KEY=ollama" >> ~/.openclaw/.env
    provider="openai-compatible"
    model="nomic-embed-text"
    base_url="http://localhost:11434/v1"
    ;;
  4)
    read -p "输入 Gemini API Key: " api_key
    echo "GEMINI_API_KEY=$api_key" >> ~/.openclaw/.env
    provider="openai-compatible"
    model="text-embedding-004"
    base_url="https://generativelanguage.googleapis.com/v1beta/openai"
    ;;
  *)
    echo "无效选择"
    exit 1
    ;;
esac

echo ""
echo "✅ API Key 已保存到 ~/.openclaw/.env"
echo ""
echo "下一步:"
echo "1. 手动编辑 ~/.openclaw/openclaw.json 添加插件配置"
echo "2. 运行：npx openclaw-cn config validate"
echo "3. 运行：npx openclaw-cn gateway restart"
```

---

## 📝 下一步

**请告诉我你选择的 Embedding 方案，我会帮你自动完成配置！**

选项：
1. **Jina AI** - 推荐，免费额度 + 低价，中文效果好
2. **OpenAI** - 质量最好，需要科学上网
3. **Ollama** - 完全免费，本地运行，需要安装 Ollama
4. **Gemini** - 免费额度大，Google 出品

选择后我会帮你：
- ✅ 配置 API Key
- ✅ 更新 openclaw.json
- ✅ 验证配置
- ✅ 重启 Gateway
- ✅ 测试功能

---

*配置指南版本：1.0*  
*最后更新：2026-03-18 18:42*
