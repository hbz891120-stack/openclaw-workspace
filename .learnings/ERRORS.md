# Errors Log

Track command failures and exceptions.

## Format

```markdown
## [ERR-YYYYMMDD-XXX] skill_or_command_name

**Logged**: ISO-8601 timestamp
**Priority**: high
**Status**: pending

### Summary
Brief description of what failed

### Error
Actual error message

### Context
- Command attempted
- Environment details

### Suggested Fix
What might resolve this
```

---

## Entries

---

## [ERR-20260318-001] clawdhub_install

**Logged**: 2026-03-18T10:22:00+08:00
**Priority**: medium
**Status**: resolved

### Summary
clawdhub CLI 安装失败 - 依赖缺失

### Error
```
Error [ERR_MODULE_NOT_FOUND]: Cannot find package 'undici' imported from 
/Users/11th/.npm-global/lib/node_modules/clawdhub/dist/http.js
```

### Context
- Command attempted: `clawdhub install Jacky1n7/openclaw-tavily-search`
- Environment: macOS, Node.js v24.14.0
- 首次安装 clawdhub 后缺少 undici 依赖

### Suggested Fix
手动安装缺失依赖：
```bash
npm install -g undici
```

### Resolution
- **Resolved**: 2026-03-18T10:23:00+08:00
- **Notes**: 安装 undici 后 clawdhub 正常工作，但遇到 API 速率限制

### Metadata
- Reproducible: yes
- Related Files: ~/.npm-global/lib/node_modules/clawdhub/

---

*(No more entries)*
