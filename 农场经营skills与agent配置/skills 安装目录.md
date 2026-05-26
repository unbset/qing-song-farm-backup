# 你现在最应该优先安装的能力（按优先级）

| 优先级 | 已安装skill             | 能力                                             |
| --- | -------------------- | ---------------------------------------------- |
| 1   | hindsight            | 记忆系统                                           |
| 2   | agency-agents-zh     | 200个角色，以及工作分配                                  |
| 3   | gbrain               | 推理/规划/决策辅助                                     |
| 4   | Hermes WebUI         | 可视化面板                                          |
| 5   | obsidian integration | 在 Obsidian 里直接管理 Git 版本控制——自动提交、推送、查看修改历史、对比差异 |
| 6   |                      |                                                |
| 7   |                      |                                                |
| 8   |                      |                                                |
|     |                      |                                                |

今日（2026年5月26日）安装清单（言渊的农场系统）
    ======================================================================

    🔴 Hindsight（长期记忆系统）          3 个 skill
      hindsight-architect     记忆架构设计
      hindsight-docs          Hindsight 文档参考（63个引用文件）
      hindsight-local         本地记忆 retain/recall/reflect

    🟢 agency-agents-zh（专家角色库）    200 个 skill
      📚 学术        6    🛠 工程      35
      🎨 设计        8    🏦 金融       8
      💼 销售        8    📢 营销      36
      🔬 专项       46    🧪 测试       9
      🎮 游戏开发     5    🤝 支持       7
      💰 付费媒体     7    📦 产品       5
      📋 项目管理     6    🥽 空间计算    6
      🚚 供应链      4    👔 人力资源    2
      ⚖️ 法务        2

    🟡 gbrain（推理/规划/决策辅助）       7 个 skill
      gbrain-query                    知识检索与综合回答
      gbrain-perplexity-research      联网调研增量分析
      gbrain-strategic-reading        战略分析产出 playbook
      gbrain-cross-modal-review       第二模型质量审核
      gbrain-minion-orchestrator      后台任务编排
      gbrain-briefing                 日报汇编
      gbrain-ask-user                 选项呈现辅助决策

    🟠 NEXUS 编排系统                    1 个 skill
      nexus-orchestrator              多智能体流水线（16个引用文件）

    ⚪ 三层架构运行规则                    1 个 skill
      farm-system-rules               Hermes×gbrain×hindsight 边界规则

    🔵 Obsidian 集成（非 Hermes skill）
      obsidian-git v2.35.2            Git 版本控制插件

    ======================================================================
      合计：212 个 Hermes skill + 1 个 Obsidian 插件
    ======================================================================

8 个农场运营域，各有明确分工：


    养殖管理     →  gbrain 推理 + hindsight 查历史 + Excel 分析
    供应链       →  供应商角色 + gbrain 行情调研
    财务         →  财务角色 + gbrain 综合对比
    营销         →  营销角色（出方案不存储）
    风险管理     →  gbrain 分析 + Incident 归档到 hindsight
    运营管理     →  项目管理角色 + minion 编排
    战略规划     →  gbrain 深度推理 + 联网 + 归档 00_Strategy
    知识管理     →  hindsight 唯一（其他任何 skill 不得写入）


    5 条红线：
    1. gbrain 只产临时分析，不存
    2. agency-agents 只输出内容，不存
    3. hindsight 只存不分析
    4. 所有沉淀必须经 Hermes 审批
    5. NEXUS 是方法论，不直接执行

    排除清单： 游戏开发、空间计算、Roblox/Unity/Unreal 等与农场无关的 skill 已标注不用。

--- 
---
# 目前系统是：

|层级|职责|
|---|---|
|Hermes|主人格/总入口|
|gbrain|深度分析/战略|
|hindsight|长期记忆|
|agency-agents|专家角色|
|NEXUS|多Agent流水线|
|rules|系统边界|
标准的“联邦式智能系统”。

# 建立“边界”。

例如：

| 系统        | 边界     |
| --------- | ------ |
| hindsight | 不做推理   |
| gbrain    | 不长期记忆  |
| agency    | 不负责战略  |
| NEXUS     | 不产生价值观 |

这会极大降低：
- Context 污染
- Agent 幻觉
- 权责混乱

很多人系统后面崩掉，就是因为：“所有 Agent 什么都干。”

# 现在系统已经超过： 人脑天然管理上限。

后面你会逐渐出现：
- skill 冲突
- prompt 漂移
- Agent 身份污染
- 记忆冗余
- 任务重复
- context 膨胀
- 推理越来越慢

这是一定会发生的。不是能力问题，而是： 所有复杂系统都会熵增。

