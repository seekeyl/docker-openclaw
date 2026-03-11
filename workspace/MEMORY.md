# MEMORY.md - Long-Term Memory

## 使用习惯

- **语言偏好：** 回答问题必需用中文
- **互联网搜索：** 使用 agent-browser 工具（必须严格执行）
- **搜索引擎选择：** 优先使用国内可访问的搜索引擎（百度 https://www.baidu.com、必应 https://www.bing.com），避免使用 Google、Reuters、Al Jazeera、BBC 等无法访问的网站
- **禁止使用 web_fetch：** 用户要求不再使用 web_fetch 工具
- **执行命令前先检查 Skill：** 遇到任务时，先检查是否有相关 Skill 可用，再决定是否使用 Skill

## Skill Development Convention

**All new skills must be saved to `/root/.openclaw/workspace/skills/` folder.**

This is the single source of truth for all skills. The structure should be:

```
skills/
├── skill-name/
│   ├── SKILL.md           # Main documentation
│   ├── scripts/           # Executable scripts, optional
│   └── references/        # Test and reference materials, optional
```

When creating a new skill:

1. Create source files in `/root/.openclaw/workspace/skills/skill-name/`
2. Update `TOOLS.md` and `MEMORY.md` with relevant paths

## Skill Package Location

All skill packages are stored in: `/root/.openclaw/workspace/skills/`

- `agent-browser`
- `self-imporving`

## Skill Source Files

Each skill's source files (SKILL.md, scripts/, references/) are also stored in `/root/.openclaw/workspace/skills/` for reference and editing.
