# 农场 AI 系统 — Skill 职责映射

> 本文档从农场运营角度出发，梳理所有已安装 skill 的职责边界。
> 确保每个 skill 各司其职，不交叉、不打架、不重复。

---

## 一、核心原则

```
任何任务 → Hermes 判断 → 分配到对应 skill 执行 → 结果返回 Hermes 整合
            ↓
     需要沉淀？→ hindsight 写入（仅限 Hermes 指令）
```

- 每个 skill 只做自己职责内的事
- 交叉地带由 Hermes 裁定
- 所有写入 hindsight 的操作必须经过 Hermes 明确指令

---

## 二、农场运营域 × Skill 映射

### 2.1 养殖管理（核心生产）

**职责：** 养殖环境监控、健康管理、饲料管理、生长追踪、疫病防控

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| 日常养殖数据记录 | 手动写 02_Operations | 原始数据，不经过 AI |
| 养殖异常判断 | `gbrain-query` + hindsight 查历史 | 推理+历史参考 |
| 疫病识别与应对 | `hindsight-local recall` 查过往疫情 | 查历史经验 |
| 养殖参数优化 | `gbrain-strategic-reading` | 战略视角分析 |
| 批量养殖数据分析 | `sn-da-excel-workflow` 系列 | Excel 数字分析 |

**不用的 skill：** agency-agents 中的工程/设计/营销角色（和养殖无关）

---

### 2.2 供应链管理

**职责：** 饲料/物资采购、库存管理、供应商评估、物流

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| 供应商档案管理 | `supply-chain` 类角色 | 专业供应商评估 |
| 库存预测 | `supply-chain/supply-chain-inventory-forecaster` | 专业预测 |
| 采购决策分析 | `gbrain-perplexity-research` 联网查价格 | 需要外部行情 |
| 采购价格趋势 | `gbrain-query` 综合分析 | 数据推理 |
| 供应商评估报告 | 沉淀到 hindsight 01_Knowledge | 可复用经验 |

**不用的 skill：** hindsight 只存结果，不参与采购决策本身

---

### 2.3 财务管理

**职责：** 成本核算、收益分析、预算管理、投入产出分析

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| 批次成本计算 | `finance/financial-forecast-analyst` | 财务专业分析 |
| 发票管理 | `finance/invoice-management-expert` | 税务专业 |
| 投入产出分析 | `gbrain-query` 综合多批次数据 | 需要推理对比 |
| 预算规划 | `gbrain-strategic-reading` + hindsight | 战略级决策 |
| 财务报告归档 | 沉淀到 hindsight 01_Knowledge | 可追溯 |

---

### 2.4 市场营销

**职责：** 产品销售、渠道运营、品牌建设、客户关系

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| 产品卖点文案 | `marketing` 类角色（小红书运营等） | 专业营销 |
| 市场行情调研 | `gbrain-perplexity-research` | 联网调研 |
| 销售渠道分析 | `sales/sales-deal-strategist` | 销售策略 |
| 品牌定位 | `design/brand-guardian` | 品牌专业 |
| 定价策略 | `gbrain-query` + hindsight 查历史 | 需要综合判断 |

**限制：** marketing 角色只负责*输出内容方案*，不负责*记忆存储*

---

### 2.5 风险管理

**职责：** 风险识别、预警、应急预案、合规检查

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| 疫病风险评估 | `gbrain-query` + hindsight 查历史疫情 | 推理+历史 |
| 市场风险分析 | `gbrain-perplexity-research` | 联网获取最新信息 |
| 风险事件记录 | 写入 hindsight 03_Incidents | 必须归档 |
| 应急预案制定 | `gbrain-strategic-reading` | 战略规划 |
| 合规检查 | `legal/contract-review-expert` | 法务专业 |

**核心流程：** 风险识别→gbrain分析→Hermes判断→Incident归档到hindsight

---

### 2.6 运营管理

**职责：** 日常任务排期、人员管理、流程执行、任务跟踪

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| 日常任务拆解 | `project-management` 类角色 | 项目管理专业 |
| 多任务并行执行 | `gbrain-minion-orchestrator` | 编排调度 |
| 进度跟踪 | `todo` + Hermes 直接管理 | 轻量级跟踪 |
| 流程优化建议 | `gbrain-query` 综合历史数据 | 推理优化 |
| 运营日志撰写 | 手动或按 Daily_Operations_Template | 原始记录 |

---

### 2.7 战略规划

**职责：** 长期目标、投资决策、发展方向、经营策略

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| 中长期战略制定 | `gbrain-strategic-reading` + `gbrain-query` | 深度推理 |
| 多方案对比 | `gbrain-query` | 综合分析 |
| 行业趋势研究 | `gbrain-perplexity-research` | 联网调研 |
| 战略决策记录 | 写入 hindsight 00_Strategy | 永久保存 |
| 年度复盘 | `hindsight-local recall` 全年数据 + gbrain 分析 | 经验总结 |

---

### 2.8 知识管理

**职责：** SOP 维护、经验沉淀、Incident 复盘、知识库建设

| 场景 | 调用 skill | 理由 |
|------|-----------|------|
| SOP 创建/更新 | 按 SOP_Template 写入 01_Knowledge | 结构化知识 |
| Incident 复盘 | 按 Incident_Template 写入 03_Incidents | 必走流程 |
| 经验总结 | 复盘完成后→沉淀到 01_Knowledge | 可复用 |
| 知识检索 | `hindsight-local recall` | 唯一记忆来源 |
| 知识体系优化 | `hindsight-architect` | 架构设计 |

**严格执行：** 只有 hindsight 负责知识存储，其他任何 skill 不得写入。

---

### 2.9 Hermes 五顶帽子（Agent 角色映射）

Hermes 不创建独立 Agent 实体。面对不同任务时切换对应"帽子"，调用底层 skill 执行。

```
你看到的 5 个 Agent        ≠ 5 个独立程序
                         = Hermes 的 5 种工作模式
```

#### CEO Agent（战略与分析）

| 属性 | 内容 |
|------|------|
| **职责** | 战略分析、经营复盘、风险提醒、优先级建议 |
| **不负责** | 日常执行、自动化决策 |
| **调用 skill** | `gbrain-strategic-reading`（战略）、`gbrain-query`（分析）、`gbrain-perplexity-research`（趋势） |
| **记忆操作** | 读 hindsight 历史 + Hermes 指令写入 00_Strategy |
| **典型任务** | "分析下季度经营方向"、"复盘本月数据"、"提醒我潜在风险" |

#### COO Agent（运营与管理）

| 属性 | 内容 |
|------|------|
| **职责** | 农场运营、活动流程、空间动线、SOP 优化 |
| **不负责** | 财务战略、品牌战略 |
| **调用 skill** | `project-management` 类角色、`gbrain-query`（优化建议）、`sn-da-excel-workflow`（数据） |
| **记忆操作** | 读 02_Operations + Hermes 指令更新 SOP |
| **典型任务** | "优化周末活动动线"、"更新接待 SOP"、"今日运营有什么问题" |

#### CRM Agent（用户与会员）

| 属性 | 内容 |
|------|------|
| **职责** | 用户标签、会员分析、用户反馈、社群运营 |
| **不负责** | 内容创作、财务决策 |
| **调用 skill** | `marketing`/`sales` 类角色、`gbrain-query`（分析）、`gbrain-perplexity-research`（调研） |
| **记忆操作** | 读/写 hindsight 用户数据 + 10-数据复盘 |
| **典型任务** | "分析会员复购率"、"整理本周用户反馈"、"社群活动效果如何" |

#### Content Agent（内容与传播）

| 属性 | 内容 |
|------|------|
| **职责** | 短视频选题、内容脚本、小红书内容、品牌传播 |
| **不负责** | 经营战略、用户定价 |
| **调用 skill** | `marketing/小红书运营`、`marketing/抖音策略师`、`design/brand-guardian`、`gbrain-perplexity-research`（热点） |
| **记忆操作** | 只读 hindsight 品牌资料，不做写入 |
| **典型任务** | "帮我想个小红书选题"、"写个拍摄脚本"、"分析这周视频数据" |

#### Finance Agent（财务与成本）

| 属性 | 内容 |
|------|------|
| **职责** | 成本分析、收益分析、回本周期、人效/坪效分析 |
| **不负责** | 用户体验决策、品牌方向 |
| **调用 skill** | `finance` 类角色、`gbrain-query`（对比分析）、`sn-da-excel-workflow`（报表） |
| **记忆操作** | 读 hindsight 财务数据 + Hermes 指令归档 |
| **典型任务** | "算一下这批的利润率"、"分析成本结构"、"什么时候回本" |

#### 切换规则

```
用户说"帮我看看..."
  → Hermes 判断属于哪个帽子
  → 戴上对应帽子
  → 调用该帽子的 skill
  → 出结果
  → 脱帽（不保留角色状态）
  → 输出给用户
```

**5 个帽子共享同一个 Hermes，不独立运行，不持久化状态，不自洽。**

---

## 三、Skill 排除清单（农场不适用）

以下 agency-agents-zh 中的角色与农场经营无关，**不建议调用**：

| 分类 | 不用的原因 |
|------|-----------|
| `game-development/*` | 不做游戏开发 |
| `spatial-computing/*` | 不做 XR/空间计算 |
| `roblox-studio/*` | 不做 Roblox |
| `unity/*` | 不做 Unity 开发 |
| `unreal-engine/*` | 不做虚幻引擎 |
| `godot/*` | 不做 Godot 开发 |
| `blender/*` | 不做 3D 建模 |
| `engineering/*` 中的 | 只取与农场相关部分 |
| - `FPGA/ASIC design` | 不做芯片设计 |
| - `Solidity contract` | 不做区块链 |
| - `iOS/Android developer` | 不做移动端开发 |
| - `voice-ai-integration` | 暂不需语音集成 |

---

## 四、Skill 调用优先级决策树

```
收到任务
├── 需要查历史经验/SOP？
│   └── → hindsight-local recall（唯一来源）
├── 需要联网获取最新信息？
│   └── → gbrain-perplexity-research
├── 需要深度分析/推理/多方案对比？
│   ├── 战略级 → gbrain-strategic-reading
│   └── 战术级 → gbrain-query
├── 需要专业领域输出（文案/设计/法务/财务）？
│   └── → agency-agents 对应角色
├── 需要处理 Excel/数据？
│   └── → sn-da-excel-workflow 系列
├── 需要编排多个 Agent 协作？
│   └── → nexus-orchestrator 方法论
├── 结果是可复用经验？
│   └── → Hermes 审批 → hindsight 写入
└── 以上都不是
    └── → Hermes 直接处理
```

---

## 五、红线规则

1. **gbrain 只产出临时分析，不写入任何记忆**
2. **agency-agents 角色只做专业内容输出，不做存储**
3. **hindsight 是唯一记忆系统，只存不分析**
4. **任何 skill 产出需要沉淀时 → 必须经 Hermes 判断**
5. **nexus-orchestrator 是方法论，不是执行者（不直接调用工具）**
6. **farm-system-rules 是宪法，所有行为不得违反**
