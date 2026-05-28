# Skill Inventory — 三层架构 + 五顶帽子分类清单

> 按 Hermes（调度中枢）/ gbrain（推理）/ hindsight（记忆）三层架构整理所有已安装 skill。
>
> **五顶帽子速查：** Hermes 以 5 种模式响应任务，每种模式对应一组 skill：
> - 👑 **CEO** → gbrain-query + gbrain-strategic-reading + hindsight（战略复盘）
> - 👔 **COO** → project-management + sn-da-excel + gbrain-query（运营/SOP）
> - 🤝 **CRM** → marketing/sales 角色 + gbrain 分析（用户/会员）
> - 🎬 **Content** → marketing 角色（小红书/抖音/品牌）+ gbrain 调研
> - 💰 **Finance** → finance 角色 + gbrain-query + sn-da-excel（成本/营收）

---

## Hermes 层（调度与执行）

## Hermes 层（调度与执行）

| Skill | 角色 | 说明 |
|-------|------|------|
| `farm-system-rules`（本 skill） | 宪法 | 三层架构运行规则 |
| `todo`（Hermes 内置） | 任务跟踪 | 任务列表与进度管理 |
| `delegate_task`（Hermes 内置） | 并行派发 | 子任务委派，最多 3 个并发 |
| `nexus-orchestrator` | 编排方法论 | 多 Agent 流水线（7 阶段 + 4 场景） |

---

## gbrain 层（推理 / 规划 / 决策辅助）

| Skill | 功能 |
|-------|------|
| `gbrain-query` | 知识检索与综合回答，带引用溯源 |
| `gbrain-perplexity-research` | 联网调研 + 增量分析（已知 vs 新发现） |
| `gbrain-strategic-reading` | 战略视角分析读物，产出 playbook |
| `gbrain-cross-modal-review` | 第二模型质量审核，交叉验证 |
| `gbrain-minion-orchestrator` | 后台任务 / 子 Agent 编排调度 |
| `gbrain-briefing` | 只读日报汇编，会议上下文汇总 |
| `gbrain-ask-user` | 向用户呈现选项，辅助决策 |

---

## hindsight 层（长期记忆）

| Skill | 功能 |
|-------|------|
| `hindsight-local` | 本地记忆 retain/recall/reflect CLI |
| `hindsight-architect` | 记忆架构设计 |
| `hindsight-docs` | 完整文档参考（63 个引用文件） |

---

## 领域专家层（agency-agents-zh）

按农场 8 大运营域分类：

### 养殖管理（3 类）
- `supply-chain/supply-chain-strategist`
- `specialized/specialized-risk-assessor`
- `specialized/livestock-archive-auditor`

### 供应链（4 个）
- `supply-chain/inventory-forecaster`
- `supply-chain/vendor-evaluator`
- `supply-chain/route-optimizer`
- `supply-chain/strategist`

### 财务（8 个）
- `finance/financial-forecast-analyst`
- `finance/invoice-management-expert`
- `finance/financial-risk-control-analyst`
- 等 8 个

### 营销（36 个）
- `marketing/xiaohongshu-operator`
- `marketing/douyin-strategist`
- `marketing/wechat-official-account`
- `marketing/short-video-editing-coach`
- 等 36 个

### 设计（8 个）
- `design/ui-designer`
- `design/ux-researcher`
- `design/brand-guardian`
- `design/image-prompt-engineer`
- 等 8 个

### 项目管理（6 个）
- `project-management/senior-pm`
- `project-management/project-shepherd`
- `project-management/studio-producer`
- 等 6 个

### 销售（8 个）
- `sales/account-strategist`
- `sales/deal-strategist`
- `sales/outbound-strategist`
- 等 8 个

### 法务 / 人力（各 2 个）
- `legal/contract-review-expert`
- `legal/policy-document-writer`
- `hr/recruitment-specialist`
- `hr/performance-management`

### 专项（46 个）
包括：留学规划、政务数字化、企业培训、定价优化、风险评估、AI 治理等。按需调用。

---

## 工具层

| Skill | 功能 |
|-------|------|
| `sn-da-excel-workflow` 系列（45 个） | Excel 数据分析、统计、可视化 |
| `sn-da-image-caption` | 图片理解与数据提取 |
| `sn-da-large-file-analysis` | 万行以上 Excel 高性能读取 |

---

## 排除清单（已安装但农场不用）

```
game-development/*       — 游戏开发
spatial-computing/*      — XR/空间计算  
roblox-studio/*          — Roblox
unity/*                  — Unity
unreal-engine/*          — 虚幻引擎
godot/*                  — Godot
blender/*                — 3D 建模
engineering/ 中的 FPGA、ASIC、Solidity、iOS、Android、voice-ai 等角色
```
