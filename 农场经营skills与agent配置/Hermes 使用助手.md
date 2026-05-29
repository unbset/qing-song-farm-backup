 
## hermes curator介绍
   hermes curator 是 Hermes Agent 的技能生命周期维护工具（Skill Lifecycle Manager）。它的职责是自动管理你创建的那些技能——清理、归档、备份，防止技能池变得越来越乱。



    核心能力：

    | 子命令            | 作用                                                |
    |-------------------|-----------------------------------------------------|
    | status            | 查看所有技能的状态（使用频率、活跃度、是否被pin等） |
    | run               | 手动触发一次维护检查                                |
    | pause / resume    | 暂停/恢复自动维护                                   |
    | pin / unpin       | 锁定某个技能，跳过所有自动处理                      |
    | archive / restore | 归档不用的技能 / 恢复归档的技能                     |
    | prune             | 清理长时间无人使用的技能                            |
    | backup / rollback | 归档前自动备份（tar.gz），支持回滚                  |



    工作原理：

    - 只处理 created_by: "agent" 的技能（也就是我这样的 AI 创建的那些技能）
    - 内置技能（比如 hermes-agent、kanban 等）和从技能市场安装的技能——不碰
    - 不删除任何东西——最激进的操作为止于归档（archive）到 ~/.hermes/skills/.archive/
    - 被 pin 的技能完全不受任何自动处理的影响

    数据来源：~/.hermes/skills/.usage.json，记录每个技能的 use_count、view_count、patch_count、last_activity_at。

    可通过 config 配置：
    - curator.enabled — 是否启用自动维护
    - curator.interval_hours — 多久跑一次检查
    - curator.stale_after_days — 多少天不活跃标记为 stale
    - curator.archive_after_days — 再等多少天归档

    使用场景举例：

    - 你之前让我保存了十几个 farm 相关的 skill，有些早已过时——curator 会自动识别哪些长期没用，标记为 stale，再归档，避免技能列表越滚越长
    - 我可以 pin 掉你明确要求保留的核心技能，防止被误归档
    - 归档前 curator 会自动打 tar.gz 快照，随时可以 rollback 恢复


---- 
## AI农场经营系统备份

 备份脚本已写好并推送至仓库：/mnt/d/我的农场/backup.sh

    使用方法：
    bash
    bash /mnt/d/我的农场/backup.sh


    脚本功能：
    - 自动检测 青松农场经营系统/ 是否有改动 → 提交并推送
    - 自动检测 hermes-skills/ 是否有改动 → 从 ~/.hermes/skills/ 同步更新并推送
    - 无变化则跳过，节约时间

    以后你想备份的时候，运行 bash backup.sh 就行了。

---

