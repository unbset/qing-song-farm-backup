# Farm Vault Example — 言渊's Farm Memory System

Concrete reference from a real session. A user (言渊) runs a farm operation in China and wanted a "long-term growth AI memory system" in their Obsidian vault at `D:/我的农场`.

## Context

- **Existing vault**: Already had `.obsidian/` config, some notes (初心.md, 助手提示词.md, Urien/言渊画像.md), a `农场/` directory with earlier work
- **Tools installed**: Hermes Agent + hindsight-local skill
- **User's explicit constraints**:
  - 不要过度复杂化 (don't overcomplicate)
  - 当前阶段优先"稳定结构"而不是高级自治 (stable structure over advanced autonomy)
  - 不要配置云服务 (no cloud services)
  - 不要引入复杂向量数据库 (no vector DBs)
  - 不要做高级RAG优化 (no advanced RAG)

## Directory Structure Created

```
D:/我的农场/
├── AI_记忆体系/                          ← All tier dirs under one parent folder
│   ├── 00_Strategy/
│   │   ├── README.md
│   │   └── System_Principles.md          — 8 core principles
│   ├── 01_Knowledge/
│   │   └── README.md
│   ├── 02_Operations/
│   │   └── README.md
│   ├── 03_Incidents/
│   │   └── README.md
│   ├── 04_Agent_Runtime/
│   │   └── README.md
│   ├── Templates/
│   │   ├── Incident_Template.md
│   │   ├── SOP_Template.md
│   │   ├── Daily_Operations_Template.md
│   │   ├── Strategy_Template.md
│   │   └── Supplier_Profile_Template.md
│   ├── Memory_Rules.md                   — 7 sections
│   ├── Memory_Namespace_Map.md           — 5 namespaces
│   ├── Experience_Pipeline.md            — 4 pipelines
│   └── Agent_Architecture.md             — 7 agent roles
├── .git/                                 — Git repo initialized
├── .gitignore                            — Excludes .claude/, .claudian/, workspace files
├── Urien/
├── 农场运营方案/
├── 初心.md
└── 助手提示词.md
```

Later refactoring: all tier directories were moved under `AI_记忆体系/` to reduce vault root clutter. Internal relative paths between tier dirs remain valid since they moved together as a group. README.md cross-references use plain directory names (not hyperlinks), so no path updates were needed.

## Key Design Decisions

### Directory naming: Chinese category names rejected
The user's vault was in Chinese, but the directory prefixes (00_, 01_, etc.) were kept in the framework style from the knowledge-vault-architecture skill. README files explained each directory in Chinese.

### Templates: Markdown-only, not Obsidian-specific
All templates used standard markdown with YAML frontmatter (tags, type, status). No Templater plugin syntax or Dataview queries in templates — just pure markdown that any editor can open.

### Experience pipeline emphasis
The user explicitly wanted to avoid "聊天记录堆积式记忆" (chat-log-accumulation memory). All 4 pipelines were designed to transform raw data into structured knowledge.

### Incident closure rule
A key rule: "复盘完成后，经验总结必须沉淀到 01_Knowledge 目录" — after post-mortem, experience MUST be written to the knowledge directory. This prevents incidents from becoming dead documents.

## Templates Created

### Incident_Template.md
YAML frontmatter with `tags: [incident, template]`, `type: incident`, `status: open`. 7 sections covering event description, emergency response, 5-Whys root cause, solutions (short/long-term), experience summary, closure checklist, and links.

### SOP_Template.md
YAML frontmatter with `type: sop`, `version: v1`, `status: draft/active/superseded`. Steps with expected outcomes and warnings, acceptance criteria checklist, exception handling table, resource requirements, version history.

### Daily_Operations_Template.md
YAML frontmatter with `type: daily_ops`. Status dashboard (weather, temperature, humidity), livestock status (batch/age/health/feed), equipment status (ventilation/temp/water/power), purchases, sales, tasks, and notes.

### Strategy_Template.md
YAML frontmatter with `type: strategy`. Background, measurable goals, option analysis (multiple options with pros/cons/resources/effects), decision rationale with risk table, execution plan with phases, tracking checkpoints, post-mortem, and links.

### Supplier_Profile_Template.md
YAML frontmatter with `type: supplier_profile`, `status: active`. Contact info, products/services table, evaluation scores (1-5 across quality/price/stability/delivery/service), transaction history, and notes.

## Lessons Learned

1. **Start with the directory READMEs** — they're the quickest way to communicate the architecture to both humans and future AI sessions
2. **System_Principles.md first** — it becomes the anchor document that everything else references
3. **Write templates in plain markdown** — Obsidian-specific syntax limits portability
4. **Incident closure is the critical workflow** — without mandatory experience precipitation, the whole system becomes a dead archive
5. **AGENTS.md file in the vault root** — consider adding one so future AI sessions understand the vault structure immediately
