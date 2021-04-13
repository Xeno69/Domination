# 统治

---

Arma3多人游戏模式最多可容纳50名玩家。抓住各种（随机）目标并解决辅助任务。提供Coop和PvPvE版本。

这项屡获殊荣的游戏任务是Arma系列中最古老的任务之一。统治是由Xeno创建的。

---

# 资源

[Steam](https://steamcommunity.com/sharedfiles/filedetails/comments/332088703)

[Github](https://github.com/Xeno69/Domination)

---

# 配置数据库

[配置数据库](Database.md)

---

# 模组说明

[模组说明](VersionsAndNeededModsAddons.md)

# 参数说明

---

[参数说明](Parameter.md)

---

# 在本地执行任务

要在本地执行《统治》任务：

* 将任务文件夹 `co30_Domination.Altis` 复制到本地 `mpmission` 目录中
* 将任务加载到 Eden 编辑器中，然后单击 **Play（玩）** -> **Multiplayer（多人游戏）** -> **OK（确定）** 以运行本地代码

---

# 编辑任务

《统治》任务可以在 Eden 编辑器中进行修改。

《统治》任务支持的所有地图均作为 PBO 发布。但是，您可以使用任何 PBO 工具来修改和捆绑您自己的任务修改。选择`co30_Domination.Altis`作为 PBO 源，以捆绑默认地图（Altis）。

如果要捆绑或修改Altis以外的地图，请按照以下步骤操作：

* 删除 `co30_Domination.Altis/mission.sqm`
* 复制适当的 `mission.sqm` 文件从 `mission_sqm` 文件夹到 `co30_Domination.Altis`
* 重命名您复制到 `mission.sqm` 的文件
* 删除 `co30_Domination.Altis/x_setup.sqf`
* 复制适当的 `x_setup.sqf` 文件从 `mission_sqm` 文件夹到 `co30_Domination.Altis`
* 重命名复制到的文件 `x_setup.sqf`
* 改名 `co30_Domination.Altis` 为 `co30_Domination.NewMap` (例如 `co30_Domination.Malden`)
* 使用您的首选 PBO 工具运行源文件 `co30_Domination.Malden`

---

# 更新日志

[更新日志](ChangeLog.md)


---
> 请记住，只有将工作贡献回 [源存储库](https://github.com/Xeno69/Domination), 您才能与社区共享所做的修改。
