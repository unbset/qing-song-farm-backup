# Third-Party Skill Vetting Checklist

> 本会话中多次评估了第三方 repo（Maestro E2E、agentmemory、Mission Control、LangGraph），总结出以下检查清单，用于未来快速判断是否值得安装。

---

## 检查流程

### 第一步：理解项目本质

```
项目是什么？
  ├── 一个 Skill 库（有 SKILL.md / skill.json） → 继续
  ├── 一个独立应用/平台（需部署服务） → 谨慎（问用户是否真要部署）
  └── 一个 Python/JS 框架/库 → 跳过（Hermes 的工具链已够用）
```

### 第二步：判断与现有系统的关系

```
和已有系统对比：
  ├── 功能重叠？→ 跳过（如 agentmemory → hindsight 已覆盖）
  ├── 角色冲突？→ 跳过（如 LangGraph → Hermes 已在编排）
  ├── 补充空白？→ 继续
  └── 复杂度代价 > 收益？→ 跳过
```

### 第三步：匹配用户的三层架构

```
该 skill 会做什么？
  ├── 推理/规划/决策辅助 → gbrain 层（可装）
  ├── 长期记忆/知识库写入 → hindsight 层（已有，除非不冲突）
  ├── 编排/调度 → Hermes 层（已有）
  └── 以上都不是 → 问用户意图
```

---

## 本会话历史否决清单

| Repo | 否决原因 | 教训 |
|------|---------|------|
| mobile-dev-inc/Maestro（E2E 测试） | 误装 — 不是 AI 编排而是移动端测试 | 先看 README 第一段确认项目性质 |
| vectorize-io/hindsight | ✅ 已装 | 记忆系统，符合需求 |
| mobile-dev-inc/Maestro（AI 编排） | 没有可安装的 skill | 不是所有 repo 都是 skill 仓库 |
| rohitg00/agentmemory | 和 hindsight 功能重叠 + 记忆污染风险 | 已有系统时，同类工具先对比再装 |
| jnMetaCode/agency-agents-zh | ✅ 已装 | 有 215 个标准 Hermes skill 文件 |
| garrytan/gbrain | ✅ 部分安装（7/49） | 大型 repo 需筛选而非全装 |
| builderz-labs/mission-control | 是部署平台不是 skill 库 | 区分"部署服务"和"安装 skill" |
| langchain-ai/langgraph | Python 框架不适合农场场景 | 方法论问题不要用代码框架解决 |

---

## 核心原则

1. **优先装方法论，不装基础设施** — 一个 Markdown skill 比一个需要部署的服务更有价值
2. **不装和已有系统冲突的** — 已有 hindsight 就不装第二个记忆系统
3. **不装与农场无关的** — 游戏开发、移动端测试、区块链等一律跳过
4. **大型 repo 只装相关子集** — 像 gbrain 只装 7/49 个 skill
5. **问用户前先自己分析** — 给出清晰建议（装/不装/部分装）再让用户决定
