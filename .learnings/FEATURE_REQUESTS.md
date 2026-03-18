# Feature Requests Log

Track user-requested capabilities.

## Format

```markdown
## [FEAT-YYYYMMDD-XXX] capability_name

**Logged**: ISO-8601 timestamp
**Priority**: medium
**Status**: pending

### Requested Capability
What the user wanted to do

### User Context
Why they needed it

### Suggested Implementation
How this could be built
```

---

## Entries

---

## [FEAT-20260318-001] auto_search_fallback

**Logged**: 2026-03-18T10:53:00+08:00
**Priority**: low
**Status**: pending

### Requested Capability
当 Tavily Search 失败时，自动回退到其他搜索方式

### User Context
当前配置只使用 Tavily Search，但如果 API 配额用尽或服务不可用，搜索功能会完全失效

### Suggested Implementation
- 检测 Tavily API 错误
- 可选回退方案：web_search (Brave) 或直接告知用户
- 在 TOOLS.md 中记录回退策略

### Metadata
- Frequency: first_time
- Related Features: tavily-search, web_search

---

*(No more entries)*
