---
name: nexus-orchestrator
description: NEXUS 多智能体编排系统 — 7 阶段全生命周期流水线，含 playbook、质量门禁、交接协议和场景操作手册。用于协调多个 AI Agent 协同完成项目。
version: 1.0.0
author: agency-agents-zh / NEXUS
license: MIT
metadata:
  hermes:
    tags: [strategy, orchestration, multi-agent]
---

# NEXUS — 多智能体编排系统

> **NEXUS**（Network of EXperts, Unified in Strategy，专家网络，统一策略）
> 把独立的 AI 专家变成一个同步运转的智能网络。

## 什么时候使用

需要协调**多个 AI Agent 协同工作**时加载本 skill：
- 复杂项目需要跨领域 Agent 配合（工程+设计+营销+财务…）
- 需要按阶段推进、有质量门禁的流水线作业
- 需要标准化 Agent 间交接和上下文传递

---

## 三种部署模式

| 模式 | 智能体数 | 时间线 | 适用场景 |
|------|---------|--------|---------|
| **NEXUS-Full** | 全部 | 12-24 周 | 完整生命周期项目 |
| **NEXUS-Sprint** | 15-25 | 2-6 周 | 功能或 MVP 构建 |
| **NEXUS-Micro** | 5-10 | 1-5 天 | 定向任务执行 |

---

## 核心概念

1. **质量门禁** — 没有基于证据的批准，阶段不能推进
2. **开发-测试循环** — 每个任务做完就测；通过才继续，不通过就重试（最多 3 次）
3. **交接** — Agent 之间结构化的上下文传递（不能冷启动）
4. **证据高于口说** — 截图、测试结果和数据，不是口头声明

---

## 文档引用

完整参考文档位于本 skill 的 `references/` 目录下：

### 核心纲领
- `nexus-strategy.md` — 1100+ 行完整运营纲领

### 阶段手册 (7 份)
- `phase-0-discovery.md` — 情报与发现 (3-7 天)
- `phase-1-strategy.md` — 策略与架构 (5-10 天)
- `phase-2-foundation.md` — 基础与脚手架 (3-5 天)
- `phase-3-build.md` — 构建与迭代
- `phase-4-hardening.md` — 质量与加固
- `phase-5-launch.md` — 上线与增长
- `phase-6-operate.md` — 运营与演进

### 场景操作手册 (4 份)
- `scenario-startup-mvp.md` — 创业 MVP (4-6 周)
- `scenario-enterprise-feature.md` — 企业级功能开发
- `scenario-marketing-campaign.md` — 多渠道营销活动
- `scenario-incident-response.md` — 生产事故处理

### 协调工具
- `agent-activation-prompts.md` — 即用激活提示词模板
- `handoff-templates.md` — 标准化交接模板
- `quickstart.md` — 5 分钟快速入门
- `executive-brief.md` — 高管简报

---

## 使用方式

### 方式一：完整项目（NEXUS-Full）

加载本 skill 后，按 `references/phase-0-discovery.md` 开始，依次推进到 phase-6。

### 方式二：快速任务（NEXUS-Micro）

从 `references/agent-activation-prompts.md` 中找到对应的场景提示词，直接激活。

### 方式三：自定义编排

阅读 `references/nexus-strategy.md` 了解编排原则，自行设计流水线。
