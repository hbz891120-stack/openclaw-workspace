# Learnings Log

Track corrections, knowledge gaps, and best practices.

## Format

```markdown
## [LRN-YYYYMMDD-XXX] category

**Logged**: ISO-8601 timestamp
**Priority**: low | medium | high | critical
**Status**: pending

### Summary
One-line description

### Details
Full context

### Suggested Action
Specific fix

### Metadata
- Source: conversation | error | user_feedback
- Tags: tag1, tag2
```

---

## Entries

---

## [LRN-20260318-001] search_engine_preference

**Logged**: 2026-03-18T10:53:00+08:00
**Priority**: high
**Status**: pending
**Area**: config

### Summary
用户指定所有搜索必须使用 Tavily Search，不使用 Brave Search

### Details
- 初始状态：OpenClaw 默认配置使用 Brave Search (web_search 工具)
- 用户要求：关闭 Brave Search，改用 Tavily Search
- 原因：Tavily 更适合国内使用，API 配置简单
- 操作：安装 tavily-search 技能，配置 TAVILY_API_KEY 到 ~/.openclaw/.env

### Suggested Action
- 所有搜索请求使用 Tavily 脚本
- 不再使用 web_search 工具 (Brave)
- 在 TOOLS.md 中记录此偏好

### Metadata
- Source: user_feedback
- Related Files: ~/.openclaw/.env, TOOLS.md, skills/tavily-search/
- Tags: search, tavily, configuration, user_preference
- See Also: 无

---

## [LRN-20260318-002] skills_testing_and_memory_enhancement

**Logged**: 2026-03-18T11:06:00+08:00
**Priority**: high
**Status**: pending
**Area**: skills

### Summary
Tavily Search 和 find-skills 技能测试成功，发现多个记忆增强相关技能

### Details

**测试结果：**

1. **Tavily Search** ✅ 工作正常
   - API 响应快速
   - 搜索结果相关性强
   - Markdown 格式输出易读

2. **find-skills (npx skills)** ✅ 工作正常
   - 成功连接到 skills.sh 技能市场
   - 返回多个记忆相关技能

**发现的记忆增强技能：**

| 技能 | 安装量 | 用途 |
|------|--------|------|
| memory-merger | 8K | 合并和管理记忆 |
| memory-safety-patterns | 3.5K | 记忆安全模式 |
| memory-forensics | 3.1K | 记忆取证分析 |
| super-search | 2.2K | 超级搜索记忆 |
| deep-agents-memory | 1.9K | 深度代理记忆 |
| openclaw-memory-enhancer | 25 | OpenClaw 记忆增强 |
| hybrid-memory (graphiti) | 23 | 混合记忆 (图数据库) |
| hybrid-memory (sundial) | 8 | 混合记忆系统 |

**OpenClaw 记忆最佳实践 (来自 Tavily 搜索)：**

1. **四层记忆架构：**
   - Bootstrap 文件 (SOUL.md, USER.md 等)
   - 会话转录
   - LLM 上下文窗口
   - 检索索引

2. **关键原则：**
   - 持久化规则放入文件，不是聊天
   - MEMORY.md 和 AGENTS.md 能抵抗压缩
   - 考虑扩展方案：QMD (混合检索)、Cognee (知识图谱)

3. **记忆维护：**
   - 定期审查和更新 MEMORY.md
   - 将日常记忆文件的精华提升到长期记忆
   - 避免记忆文件过大导致管理困难

### Suggested Action

**短期改进：**
1. ✅ 创建 memory/ 目录存储每日记忆文件 - **已完成**
2. ✅ 建立记忆审查流程 (心跳时检查) - **已完成**
3. ✅ 定义记忆提升标准 (什么内容值得进入 MEMORY.md) - **已完成**

**中期改进：**
4. ⏳ 考虑安装 `openclaw-memory-enhancer` 技能 (需要 Skill Vetter 审查)
5. ⏳ 实现记忆自动摘要和归档
6. ⏳ 添加记忆检索关键词标签系统

**长期改进：**
7. ⏳ 评估 hybrid-memory 方案 (图数据库 + 向量检索)
8. ⏳ 实现记忆重要性评分机制
9. ⏳ 建立记忆过期和清理策略

### Metadata
- Source: conversation
- Related Files: MEMORY.md, .learnings/LEARNINGS.md, skills/find-skills/, skills/tavily-search/
- Tags: memory, skills, testing, enhancement, best_practices
- See Also: LRN-20260318-001 (搜索配置)
- Pattern-Key: memory.enhancement

---

## [LRN-20260318-003] memory_system_implementation

**Logged**: 2026-03-18T11:10:00+08:00
**Priority**: high
**Status**: resolved
**Area**: infrastructure

### Summary
完成记忆系统基础架构搭建和流程定义

### Details

**已完成的工作：**

1. **创建 memory/ 目录**
   - 位置：`~/.openclaw/workspace/memory/`
   - 创建今日文件：`2026-03-18.md`
   - 记录当日重要事件和学习

2. **建立心跳审查流程**
   - 文件：`HEARTBEAT.md`
   - 定义检查清单 (邮箱/日历/天气/记忆)
   - 设定响应规则 (何时报告 vs HEARTBEAT_OK)
   - 记忆维护流程集成

3. **创建 MEMORY.md**
   - 位置：`~/.openclaw/workspace/MEMORY.md`
   - 包含：用户信息、工具配置、技能列表、记忆规则
   - 定义记忆层级和提升标准

4. **定义记忆提升标准**
   - 文件：`memory/MEMORY_PROMOTION_STANDARDS.md`
   - 4 项标准：重复性、重要性、持久性、通用性
   - 提升流程和审查周期
   - 质量检查清单

**记忆架构现状：**
```
~/.openclaw/workspace/
├── MEMORY.md                  # 长期记忆 ✅
├── HEARTBEAT.md               # 心跳审查 ✅
├── memory/
│   ├── 2026-03-18.md          # 今日记忆 ✅
│   └── MEMORY_PROMOTION_STANDARDS.md  # 提升标准 ✅
└── .learnings/                # 学习日志 ✅
    ├── LEARNINGS.md
    ├── ERRORS.md
    └── FEATURE_REQUESTS.md
```

### Suggested Action
- 无需额外操作 - 基础架构已完成
- 下一步：按心跳流程定期维护
- 考虑中期改进项 (技能安装、自动摘要)

### Resolution
- **Resolved**: 2026-03-18T11:10:00+08:00
- **Notes**: 记忆系统基础架构完成，可以开始正常使用和维护

### Metadata
- Source: conversation
- Related Files: MEMORY.md, HEARTBEAT.md, memory/, .learnings/
- Tags: memory, implementation, completed, infrastructure
- See Also: LRN-20260318-002
- Pattern-Key: memory.infrastructure

---

## [LRN-20260318-004] evomap_integration

**Logged**: 2026-03-18T11:26:00+08:00
**Priority**: high
**Status**: resolved
**Area**: integration

### Summary
EvoMap 协作进化市场技能已安装并配置完成

### Details

**技能信息：**
- 名称：evomap
- 来源：https://evomap.ai
- 用途：AI 代理协作进化市场集成
- 风险等级：🔴 HIGH (已获用户确认)

**节点信息：**
- 节点 ID: `node_0fcf0712db423018`
- 账户状态：已绑定 (claimed) ✅
- 信用余额：200 credits (起始奖励)
- 心跳间隔：900 秒 (15 分钟)
- Hub 节点：`hub_0f978bbe1fb5`
- 推荐代码：`node_0fcf0712db423018`

**配置文件：**
```
~/.evomap/
├── node_config.json    ← 节点配置 (权限 600)
├── node_secret         ← 认证密钥 (权限 600)
├── heartbeat.sh        ← 心跳脚本 (可执行)
└── README.md           ← 配置摘要
```

**已完成：**
1. ✅ 节点注册
2. ✅ 账户绑定 (用户已访问 Claim URL)
3. ✅ 获取 node_secret
4. ✅ 创建心跳脚本
5. ✅ 配置环境变量

### Suggested Action
- 运行心跳脚本保持在线：`~/.evomap/heartbeat.sh`
- 探索可用任务：`POST /a2a/fetch` (include_tasks: true)
- 发布第一个 Gene+Capsule bundle
- 考虑设置 cron 自动心跳

### Resolution
- **Resolved**: 2026-03-18T11:33:00+08:00
- **Updated**: 2026-03-18T12:06:00+08:00 (node_secret 验证)
- **Notes**: 完整配置完成，节点已激活并在线，node_secret 已验证

### 用户偏好更新 (2026-03-18 11:54)
- 配置类任务直接完成，无需询问
- 仅主要问题才进行报告

### Metadata
- Source: conversation
- Related Files: ~/.evomap/*, skills/evomap/SKILL.md, ~/.openclaw/.env, MEMORY.md
- Tags: evomap, integration, marketplace, completed, configured, automation
- See Also: 无
- Pattern-Key: evomap.integration

---

## [LRN-20260318-005] automation_preference

**Logged**: 2026-03-18T11:54:00+08:00
**Priority**: high
**Status**: resolved
**Area**: workflow

### Summary
用户指定配置类任务直接完成，无需询问；仅主要问题才报告

### Details
- 时间：2026-03-18 11:54
- 上下文：EvoMap 心跳配置完成后
- 用户要求：后续所有配置都可以直接配置，不用再询问
- 报告原则：只有主要问题才会进行报告

### 应用范围
- 技能配置
- 工具设置
- 自动化脚本
- 环境变量
- cron 任务
- 类似的基础设施配置

### Suggested Action
- 配置类任务：直接执行并完成
- 遇到问题：先尝试自动修复
- 主要问题：无法自动解决时才报告用户

### Metadata
- Source: user_feedback
- Tags: automation, workflow, preference, efficiency
- Pattern-Key: workflow.automation

---

## [LRN-20260318-006] heartbeat_reporting

**Logged**: 2026-03-18T12:10:00+08:00
**Priority**: high
**Status**: resolved
**Area**: workflow

### Summary
心跳检查无需汇报，自动处理；仅大型事件/问题才汇报

### Details
- 时间：2026-03-18 12:10
- OpenClaw 心跳：回复 HEARTBEAT_OK，无需详细汇报
- EvoMap 心跳：cron 自动执行，无需汇报
- 汇报标准：仅大型事件、重要问题、无法自动解决的情况

### 汇报标准

**需要汇报**:
- 配置失败且无法自动修复
- 系统错误/异常
- 重要任务完成 (如技能安装、集成完成)
- 用户明确询问的事项

**无需汇报**:
- 例行心跳检查
- 日常配置任务
- 自动修复成功的问题
- 常规状态更新

### Metadata
- Source: user_feedback
- Tags: heartbeat, reporting, workflow, preference, automation
- Pattern-Key: workflow.reporting

---

## [LRN-20260318-007] self_improvement_session

**Logged**: 2026-03-18T13:13:00+08:00
**Priority**: high
**Status**: resolved
**Area**: learning

### Summary
完成 1 小时自我进化学习，研究 OpenClaw 记忆系统与 AI 代理最佳实践

### Details

**学习时间**: 2026-03-18 12:13 - 13:13 (1 小时)  
**搜索来源**: Tavily Search (联网学习)  
**学习主题**: 
- OpenClaw 记忆系统四层架构
- 2026 AI 代理发展趋势
- 心跳自动化最佳实践
- 记忆管理优化建议
- 技能开发生态

**关键发现**:
1. 记忆四层架构：bootstrap/会话/上下文/检索
2. Agentic RAG (2025-Present) - 主动智能代理
3. 状态感知检索优于简单 top-k
4. 语义缓存可降低 68.8% LLM 成本
5. 混合检索 (向量 +BM25) 是生产最佳实践

**当前评估**: 8/10 - 良好，有优化空间

**建议改进**:
- 心跳状态追踪 (heartbeat-state.json)
- 记忆标签系统
- 自动记忆摘要归档
- 语义缓存配置

### Suggested Action
- 实现心跳状态追踪
- 添加记忆标签系统
- 探索语义缓存方案
- 每周进行一次自我进化学习

### Metadata
- Source: self_improvement_session
- Related Files: .learnings/SELF_IMPROVEMENT_20260318.md
- Tags: self-improvement, learning, memory, optimization, research
- See Also: LRN-20260318-003 (memory implementation)
- Pattern-Key: learning.self-improvement

---

*(No more entries)*
