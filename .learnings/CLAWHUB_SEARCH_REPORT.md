# ClawHub 技能搜索报告

**搜索时间**: 2026-03-18 14:51  
**搜索主题**: 多 agent 协作、金融股市、token 消耗减少  
**搜索来源**: Tavily Search + GitHub + ClawHub 生态

---

## 📊 搜索结果摘要

| 主题 | 相关技能数 | 推荐技能 |
|------|-----------|---------|
| 多 agent 协作 | 4+ | agent-team-orchestration, orchestrator |
| 金融股市 | 2+ | agenthc-market-intelligence |
| Token 优化 | 3+ | token-optimizer, llm-token-optimization |

---

## 🤝 1. 多 Agent 协作技能

### 1.1 agent-team-orchestration
**来源**: VoltAgent/awesome-openclaw-skills  
**功能**: 
- 编排多 agent 团队
- 定义明确的角色分工
- 任务生命周期管理
- 交接协议和审查工作流

**适用场景**:
- 大型项目分解
- 多专家协作
- 代码审查流程
- 任务分发和汇总

**安装方式**: 
```bash
# 通过 clawdhub 安装
clawdhub install agent-team-orchestration
```

---

### 1.2 orchestrator (Orchestrator Agent Coordinator)
**来源**: mcpmarket.com  
**功能**:
- Claude 作为项目经理
- 监督并行工作 agent 集群
- 处理大规模软件功能开发
- 智能路由和 agent 交接

**适用场景**:
- 大型软件开发
- 多模块并行处理
- 复杂任务分解
- 项目管理和协调

**链接**: https://mcpmarket.com/tools/skills/orchestrator-agent-coordinator

---

### 1.3 Multi-Agent Systems (Tessl Registry)
**来源**: tessl.io  
**功能**:
- 使用 AI SDK v5 编排多 agent 系统
- agent 交接 (handoffs)
- 智能路由
- 协调工作流

**适用场景**:
- AI agent 集群管理
- 任务路由优化
- 多 agent 协作流程

**链接**: https://tessl.io/registry/skills/github/jeremylongshore/claude-code-plugins-plus-skills/Orchestrating%20Multi-Agent%20Systems

---

### 1.4 ontology (知识图谱)
**来源**: ClawHub  
**功能**:
- 结构化 agent 记忆的知识图谱
- 可组合的技能系统
- 106⭐ | 43k 下载

**适用场景**:
- 多 agent 共享知识
- 结构化记忆存储
- 技能组合和复用

**统计**: ⭐ 106 · 43k 下载

---

## 📈 2. 金融股市技能

### 2.1 agenthc-market-intelligence
**来源**: VoltAgent/awesome-openclaw-skills  
**功能**:
- 实时股票市场数据
- 交易情报 API
- 85 个情报模块
- 40 个编码情报技能

**适用场景**:
- 股票市场数据分析
- 实时金融信息获取
- 交易决策支持
- 市场趋势监控

**安装方式**:
```bash
clawdhub install agenthc-market-intelligence
```

---

### 2.2 Dappier API Integration (Stock Market Data)
**来源**: docs.dappier.com  
**功能**:
- 实时金融洞察
- 股票价格查询
- 市场新闻获取
- 上市公司数据

**适用场景**:
- 个股查询
- 市场新闻监控
- 金融数据分析

**链接**: https://docs.dappier.com/integrations/clawhub-integration

**注意**: 查询必须包含股票代码

---

### ⚠️ 安全警告

搜索发现恶意技能：
- **ClawHavoc 活动**: 约 341 个恶意技能
- **伪装类型**: 加密货币交易自动化工具
- **风险**: 信息窃取恶意软件 (macOS/Windows)

**建议**:
- 仅从可信来源安装技能
- 使用 Skill Vetter 审查
- 避免不明加密货币交易技能

---

## 💰 3. Token 消耗减少技能

### 3.1 token-optimizer (LobeHub)
**来源**: lobehub.com  
**功能**:
- 减少 LLM token 使用量
- 降低 OpenClaw API 成本
- 提供 lazy skill 加载
- 综合优化工具包

**适用场景**:
- 降低 API 调用成本
- 优化 token 使用效率
- 大规模部署优化

**链接**: https://lobehub.com/vi-VN/skills/openclaw-skills-openclaw-token-optimizer

---

### 3.2 llm-token-optimization
**来源**: LobeHub  
**功能**:
- 后端优化的开发者技能
- 减少输入/处理/输出的 token 消耗
- 提供可操作的优化模式
- 技术应用和最佳实践

**适用场景**:
- LLM 应用成本优化
- token 使用分析
- 输入输出优化

**链接**: https://lobehub.com/fr/skills/amnadtaowsoam-cerebraskills-llm-token-optimization

---

### 3.3 LLM Prompt Caching Specialist
**来源**: mcpmarket.com  
**功能**:
- 提示词缓存优化
- **降低成本高达 90%**
- MCP 服务器集成
- Claude/Cursor 连接

**适用场景**:
- 重复查询优化
- 提示词缓存利用
- 大幅降低 LLM 成本

**链接**: https://mcpmarket.com/tools/skills/llm-prompt-caching-specialist

---

### 3.4 OpenClaw 内置优化

**记忆格式压缩** (RFC #17364):
- **减少 37%** 文件大小
- 结构化查询更易处理
- 语义保持完整

**智能上下文管理** (Issue #14384):
- 动态加载相关上下文
- 语义上下文管理
- 减少上下文丢失

**来源**: 
- https://github.com/openclaw/openclaw/discussions/17364
- https://github.com/openclaw/openclaw/issues/14384

---

## 📁 技能资源汇总

### 官方资源
| 资源 | 链接 | 技能数 |
|------|------|--------|
| ClawHub | https://clawhub.ai/ | 500+ |
| Awesome OpenClaw Skills | https://github.com/VoltAgent/awesome-openclaw-skills | 5400+ |
| AI Agent Store | https://aiagentstore.ai/ai-agent/awesome-openclaw-skills | 2999+ |

### 技能市场
| 市场 | 链接 |
|------|------|
| LobeHub | https://lobehub.com/skills |
| MCP Market | https://mcpmarket.com/tools/skills |
| Tessl Registry | https://tessl.io/registry/skills |

---

## 🎯 推荐安装清单

### 高优先级 (建议立即安装)
```bash
# 1. Token 优化 (降低成本)
clawdhub install token-optimizer

# 2. 多 agent 编排
clawdhub install agent-team-orchestration

# 3. 金融数据 (如需)
clawdhub install agenthc-market-intelligence
```

### 中优先级 (按需安装)
```bash
# 4. 提示词缓存专家
clawdhub install llm-prompt-caching-specialist

# 5. 知识图谱记忆
clawdhub install ontology
```

---

## ⚠️ 安装前检查清单

1. **Skill Vetter 审查** - 必须通过安全审查
2. **来源验证** - 仅从官方/可信市场安装
3. **权限检查** - 审查所需权限
4. **用户评价** - 查看⭐评分和下载量
5. **更新时间** - 优先选择近期更新的技能

---

## 📊 成本优化潜力

根据研究结果：

| 优化方式 | 潜在节省 |
|---------|---------|
| Prompt Caching | 最高 90% |
| Token Optimizer | 30-50% (估计) |
| 记忆格式压缩 | 37% |
| 语义缓存 | 68.8% (来自自我进化报告) |

**综合优化潜力**: **50-80%** 成本降低

---

## 🔍 搜索关键词建议

未来搜索可使用：
- `clawdhub install <skill-name>`
- `awesome-openclaw-skills <category>`
- `site:lobehub.com openclaw skills`
- `site:mcpmarket.com tools skills`

---

**报告生成时间**: 2026-03-18T14:51:00+08:00  
**下次搜索**: 按需进行
