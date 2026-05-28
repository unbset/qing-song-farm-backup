---
name: knowledge-vault-architecture
description: Design and implement structured, tiered knowledge management systems inside folder-based vaults (Obsidian, markdown repos) for long-running AI-assisted operations. Covers directory architecture, memory classification rules, experience pipelines, template systems, and quality principles.
---

# Knowledge Vault Architecture

Design tiered knowledge systems in folder-based vaults for AI-assisted long-running operations. The vault IS the memory — no cloud services, vector DBs, or complex infrastructure required.

## When to Use

Use this skill when a user asks you to:

- Set up a memory/knowledge system in an Obsidian vault or markdown repo
- Create a "long-term growth" knowledge base for operations (farm, factory, lab, business)
- Design a "learning system" that accumulates experience over time
- Build an AI-assisted knowledge management structure
- Organize existing notes/materials into a tiered architecture

**Do NOT use this skill when:**
- The user wants an API-based memory system (Hindsight, Mem0, etc.) — use `hindsight-architect`
- The user just needs basic note-taking help — use `obsidian` skill

## Core Pattern: The 5-Tier Architecture

Organize vault knowledge into five tiers with distinct lifecycles:

```
00_Strategy/      — Permanent. 经营原则、长期目标、风险偏好、发展路线
01_Knowledge/     — Long-term. SOP、最佳实践、经验总结、供应商档案
02_Operations/    — Short-term (30-90d). 日常运营数据、采购、销售、日志
03_Incidents/     — Medium-term (1yr). 异常事件、根因分析、复盘报告
04_Agent_Runtime/ — Ephemeral (7-30d). Agent 执行日志、失败案例、运行状态
```

### Tier Lifecycle Summary

| Tier | Retention | Cleaning | Source of Truth |
|------|-----------|----------|-----------------|
| Strategy | Permanent | Manual archiving only | Core principles |
| Knowledge | Long-term | Version supersession | Refined experience |
| Operations | 30-90 days | Auto-clean | Raw operational data |
| Incidents | 1yr after close | Auto-archived after review | Event analysis |
| Agent Runtime | 7-30 days | Auto-clean | Debugging & metrics |

### Key Design Rule

**Data flows upward:**
```
Operations → Incidents → Knowledge → Strategy
```

Raw operations data and incidents are the source material. Analysis extracts lessons that get refined into Knowledge (SOPs, best practices). Long-term patterns feed back into Strategy.

## Phase 1: Assess the Domain

Before designing, understand:

1. **What is the operation?** (farm, factory, lab, business, research)
2. **What already exists?** Scan for existing notes, files, past work
3. **What data flows matter?** Identify key data types (purchases, sensors, tasks, incidents)
4. **Who interacts?** (single operator, team, AI agents)
5. **What infrastructure is available?** (Obsidian, git, cloud, none of the above)

## Phase 2: Design the Architecture

### 2a. Tune the 5-Tier Structure

Adapt the base pattern to the domain. Rename directories if it helps domain readability:

```
— 00_Strategy/         or  00_战略/
— 01_Knowledge/        or  01_知识库/
— 02_Operations/       or  02_运营/
— 03_Incidents/        or  03_事件/
— 04_Agent_Runtime/    or  04_Agent运行/
```

For each tier, define:
- **Purpose**: 1-2 sentences
- **Content scope**: What goes in here
- **Lifecycle**: Retention period and cleaning rules
- **Relationships**: What other tiers feed/read from it
- **Naming convention**: File name pattern (e.g. `YYYY-MM-DD_EventType_Summary.md`)

### 2b. Write README for Each Directory

Every directory gets a README.md that a future agent or human can read to understand its purpose. Include:

```markdown
# Directory Name — Purpose

> Lifecycle description. Retention policy.

## Contents

## Another Directory

## File naming
```

### 2c. Create the Core Documents

Create these vault-root documents:

| Document | Purpose |
|----------|---------|
| **Memory_Rules.md** | What enters long-term memory, what is banned, classification rules, auto-summary triggers, SOP precipitation rules, incident review rules, agent log retention rules |
| **Memory_Namespace_Map.md** | Table of all namespaces with lifecycle, retrieval priority, auto-summary permissions, write conditions |
| **Experience_Pipeline.md** | Full data flow from raw operations through incident analysis to knowledge precipitation. Define 3-4 pipelines with step-by-step workflows |
| **Agent_Architecture.md** | (If AI agents are planned) Define agent roles, responsibilities, inputs, outputs, memory access patterns, implementation roadmap |

### 2d. Memory_Rules.md — Detailed Contents

The Memory Rules document is the system's constitution. Include these sections:

**1. Permitted long-term memory** — what qualifies for Strategy or Knowledge directories:
- Business strategy, vision, long-term goals, major decisions with rationale
- Verified SOPs, best practices, equipment manuals, supplier profiles
- Post-mortem-confirmed experience summaries (from Incidents)
- Industry research, regulatory information

**2. Forbidden long-term memory:**
- PII (personal IDs, bank accounts, passwords)
- Unverified guesses (unless tagged "pending-verification" and placed in a temp area)
- Redundant content already covered by existing knowledge
- Temporary calculation intermediates
- Agent internal debug logs
- Raw chat transcripts (non-operational content)

**3. Classification decision tree:**
```
New information →
  Strategy/principles/positioning? → 00_Strategy (permanent)
  Knowledge/SOP/experience?        → 01_Knowledge (long-term)
  Daily operations data?           → 02_Operations (short-term)
  Anomaly/failure/risk?            → 03_Incidents (medium-term)
  Agent execution records?         → 04_Agent_Runtime (short-term)
```

**4. Auto-summary triggers:**
- 30+ ops entries → monthly ops summary → extract patterns → 01_Knowledge
- 5+ closed incidents → quarterly risk summary → common root causes → update SOPs
- 50+ agent logs → performance analysis → optimization suggestions → Strategy

**5. SOP versioning rules:**
- `SOP_Topic_v1.md` → `SOP_Topic_v2.md` (update reason in changelog)
- Update when: post-mortem confirms better approach, operations discover optimization, equipment changes
- Quality gate: step clear, expected outcome defined, scope/prerequisites listed, version/date tracked

**6. Incident closure checklist:**
- [ ] Root cause confirmed
- [ ] Solution verified effective
- [ ] Experience summary written to 01_Knowledge
- [ ] Related SOP updated (if needed)

**7. Agent log retention:**
- Normal logs: 7 days, auto-clean
- Failure/exception logs: 30 days, delete after analysis
- Critical decisions: archive to 00_Strategy
- Memory call records: 7 days, debug only

### 2e. Memory_Namespace_Map.md — Table Format

Use this standard table structure for each namespace:

```markdown
## strategy — 战略命名空间

| 属性 | 值 |
|------|-----|
| **用途** | 存储经营战略、定位、原则、风险偏好、发展规划 |
| **生命周期** | **永久保留**，不参与任何自动清理 |
| **检索优先级** | 最高 |
| **自动总结** | 不允许 |
| **长期保留** | 是 |
| **写入条件** | 仅当信息涉及长期经营方向、原则、风险政策时写入 |
```

Repeat for all five namespaces: strategy, knowledge, operations, incidents, agent_runtime. Each entry defines purpose, lifecycle, retrieval priority, auto-summary permission, long-term retention flag, write conditions, and cleanup rules.

### 2f. Experience_Pipeline.md — Detailed Pipelines

Define 3-4 concrete pipelines that describe how data flows from raw capture to lasting knowledge:

**Pipeline 1: Operations → Best Practices**
```
Trigger: Same successful operation repeated 5+ times, efficiency improvement, stable quality
Steps:
  Step 1: Pattern recognition — find recurring success patterns in 02_Operations
  Step 2: Draft — write preliminary guide, tag "pending-verification"
  Step 3: Verify — reproduce pattern under 3+ different conditions
  Step 4: Precipitate — verified → 01_Knowledge as best practice;
                         failed → record reason, tag "invalid pattern"
```

**Pipeline 2: Incident → Experience (MANDATORY for all incidents)**
```
Trigger: Equipment failure, disease, supply disruption, repeated errors, metric anomaly
Steps:
  Step 1: Record incident → 03_Incidents/ (use Incident template)
  Step 2: Emergency response — log actions taken and effects
  Step 3: Root cause analysis — 5 Whys, confirm root cause
  Step 4: Solution design & execute — implement, verify effectiveness
  Step 5: Post-mortem — 6 review questions (what happened, why, what worked, what didn't,
          how to prevent, which SOP to update)
  Step 6: Knowledge precipitation (MANDATORY) — write experience to 01_Knowledge,
          update SOP if needed, mark incident "closed-experience-precipitated"
```

**Pipeline 3: Major Decisions → Strategy**
```
Trigger: Major purchase/sale, investments, direction changes, risk strategy
Steps:
  Step 1: Record decision with rationale and expected outcome
  Step 2: Track execution and actual results
  Step 3: Evaluate — compare expected vs actual, analyze deviation
  Step 4: Strategic precipitation — verified patterns → 00_Strategy;
          failures → 03_Incidents → Pipeline 2
```

**Pipeline 4: Agent Runtime → System Improvement**
```
Trigger: Agent failure rate exceeds threshold, quality below target
Steps:
  Step 1: Collect failure/low-efficiency cases from 04_Agent_Runtime
  Step 2: Classify — tool issue? memory issue? reasoning issue?
  Step 3: Optimize — update config, prompts, or workflow
  Step 4: Verify — track post-optimization effect
  Step 5: Record — optimization knowledge to 01_Knowledge
```

**Quality control gate** for all pipelines:

| Check | Standard | Block condition |
|-------|----------|----------------|
| Reproducibility | Verified 3+ times | Can't reproduce → tag "pending-verification" |
| Causality | Clear cause → effect | Only correlation → "needs further analysis" |
| Actionability | Steps clear, executable | Vague → add detail |
| Timeliness | Still valid | Outdated → tag "expired" |
| Uniqueness | No contradiction | Conflict → verify, update knowledge |

### 2g. Agent_Architecture.md — Future Agent Planning

If the user plans AI agents, define each agent role in a structured table:

| Agent | Role | Input | Output | Memory Accessed |
|-------|------|-------|--------|----------------|
| COO | Operations coordination | All agent reports, ops data | Commands, scheduling, daily summary | operations, knowledge, strategy |
| Finance | Budget, cost, revenue | Purchases, sales, costs | Budget advice, cost reports, P&L | operations, knowledge |
| Livestock | Health, feed, environment | Sensors, feeding logs | Status reports, alerts, feed advice | operations, knowledge, incidents |
| Supply Chain | Inventory, procurement | Stock, orders, suppliers | Procurement suggestions, inventory | operations, knowledge |
| Risk | Risk identification | All data sources | Risk assessments, early warnings | incidents, knowledge, strategy |
| Strategy | Long-term planning | All agent summaries | Strategic advice, development plan | all tiers |

Define for each: responsibilities, inputs, outputs, memory access patterns, and how they form long-term experience. Provide an implementation roadmap from Phase 1 (human + memory) to Phase N (full automation).

## Phase 3: Create Templates

Design document templates that are:
1. **Structured** — YAML frontmatter with type tags for Obsidian Dataview/querying
2. **Filled by agent** — Section headers, bullet placeholders, clear fields
3. **Chain-compatible** — Each template supports the output → input pipeline (Incident produces a Knowledge entry)

### Required Templates

| Template | Purpose | Key Sections |
|----------|---------|--------------|
| **Incident_Template.md** | Event capture through review | Tags, severity, timeline, response, 5-Whys root cause, solution, verification, closure checklist, knowledge link |
| **SOP_Template.md** | Standard operating procedure | Version, steps with expected outcomes, acceptance criteria, exception handling, resources, version history |
| **Daily_Operations_Template.md** | Daily operational log | Weather, livestock status, equipment, purchases, sales, tasks, notes, next-day plan |
| **Strategy_Template.md** | Strategic decision record | Background, goals, options analysis, decision rationale, execution plan, tracking, post-mortem |
| **Supplier_Profile_Template.md** | Vendor/partner record | Contact, products, evaluation scores, transaction history, notes |

### Template detail: Incident_Template.md

The incident template is the most important — it drives the entire experience pipeline. Include:

- **YAML frontmatter**: tags (incident, template), type (incident), status (open/closed), created date
- **Basic info**: event ID (INC-YYYYMMDD-NNN), discovered time, reporter, type (disease/equipment/supply/safety/error), severity (green/yellow/orange/red), current status
- **Section 1: Event description** — chronological narrative
- **Section 2: Emergency response** — table of actions taken, effects; control checklist
- **Section 3: Root cause analysis** — direct cause, root cause (5 Whys), systemic factors checklist
- **Section 4: Solutions** — short-term (executed) and long-term (preventive) tables
- **Section 5: Experience summary** — key lessons (1-3), SOPs to update, new SOPs needed
- **Section 6: Closure checklist** — 6 checkboxes (root cause confirmed, solution verified, experience precipitated, SOP updated, prevention in place, incident closed)
- **Section 7: Links** — related incidents, operations records, knowledge entries, agent logs

### Template detail: Strategy_Template.md

Covers the full decision lifecycle from proposal to post-mortem:

- **Basic info**: document ID, created date, decision level (core/tactical/operational), validity period, status
- **Background**: why this decision is needed
- **Goals**: measurable targets
- **Option analysis**: for each option — description, pros, cons, resources needed, expected effects
- **Decision**: selected option, rationale, risk table (risk/likelihood/impact/mitigation)
- **Execution plan**: phases with timeline and owners
- **Tracking**: checkpoints with expected vs actual indicators
- **Post-mortem**: goals achieved? deviation reasons? learnings? strategic impact?
- **Links**: related strategy docs, knowledge entries, incidents

## Phase 4: Write System Principles

Define 6-8 core principles that govern the system:

1. **Long-term accumulation** — Every operation and incident must produce reusable knowledge
2. **Traceability** — All important decisions must be traceable (decision, rationale, outcome, review)
3. **Incident closure** — Every incident must complete the full chain: record → analyze → fix → review → knowledge
4. **SOP iteration** — SOPs must be versioned and updateable; document why each version changed
5. **Memory quality** — Guard against memory pollution: no duplicates, unverified claims tagged as "pending", expired content archived
6. **Data → Knowledge** — Operational data is raw material, not the final product; it must be refined into knowledge
7. **Progressive build** — Start simple. Do not add infrastructure that isn't yet needed.

## Pitfalls

- **Cloud/service dependency**: The vault-based approach intentionally avoids cloud services, vector DBs, and complex RAG. If the user asks for those, use `hindsight-architect` instead.
- **Chat-log accumulation**: Do not dump entire conversation histories into long-term memory. Raw chat belongs in Agent_Runtime only, and only if relevant to operations.
- **Over-structuring too early**: The 5 tiers are a starting point. If only 3 fit the domain, use 3. The structure grows with the operation.
- **Missing lifecycle cleanup**: Every tier MUST have a defined cleanup rule. Documents without cleanup rules pile up into noise.
- **Template without usage**: Templates are only useful if the agent actually fills them. Include template usage steps in your methodology.
- **File naming inconsistency**: Agree on a naming convention upfront. `YYYY-MM-DD_Type_Description.md` is a good default.
- **Assuming Obsidian-specific features**: Keep templates compatible with plain markdown. Obsidian Dataview tags are additive, not required.
- **Unverified experience**: Do not precipitate a single observation as a best practice. Require 3+ reproductions or incident review validation before knowledge entry.
- **Over-abstraction**: Experience summaries that are too generic ("improve efficiency") are useless. Keep concrete: include specific conditions, quantities, and thresholds.
- **Installing skills from wrong repo type**: Before installing skills from a GitHub repo, verify the repo actually contains SKILL.md files or a skills/ directory. E2E testing frameworks, desktop apps, and libraries rarely do — only agent-role repos or dedicated skill bundles do.

## Support Files

### references/
- **`farm-vault-example.md`** — Complete worked example from 言渊's farm vault setup. Concrete reference for template contents, naming conventions, and real decisions made during a first session. Updated to reflect later path restructuring (tier dirs under parent folder `AI_记忆体系/`).
- **`vault-git-setup.md`** — Setting up git version control for an Obsidian vault with the obsidian-git plugin. Covers git init, `.gitignore`, plugin config (auto-save interval, push/pull), first commit strategy, **GitHub remote push with PAT troubleshooting (classic vs fine-grained, 401/403 diagnostics)**, and vault + Hermes skills backup workflow.

### templates/
- **`Incident_Template.md`** — Event capture through full review cycle with YAML frontmatter (severity, type, status). Includes root cause analysis (5 Whys) and mandatory knowledge precipitation checklist.
- **`Daily_Operations_Template.md`** — Compact daily operational log with health indicators, equipment status, transactions, tasks, and notes.
- **`SOP_Template.md`** — Standard operating procedure with versioned steps, acceptance criteria, exception handling, and change log.
- **`Strategy_Template.md`** — Strategic decision record with option analysis, decision rationale, execution tracking, and post-mortem.
- **`Supplier_Profile_Template.md`** — Vendor/partner record with evaluation scores and transaction history.
