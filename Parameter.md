**Domination** 有很多参数，登录管理员可以更改。如果使用了数据库，则这些参数也可以在 `dom_params2` 数据库表中进行更改(使用数据库总是覆盖管理员所做的更改)。或者如果有人要修改任务，也可以在任务根文件夹内的 `description.ext` 中进行更改（同样，如果使用数据库，则数据库参数值将覆盖 `description.ext` 值）。

***

**可用参数 （第一 `description.ext` 、数据库, 第二 服务器大厅）：**

#### **d_MainTargets_num / 主线任务：**
> 默认: Complete, ordered (-1 in description.ext)<br/>
> 将要游戏的主线任务数量。数量取决于使用的岛屿<br/>
> Complete, ordered 的意思是所有目标都将按正确顺序使用<br/>

#### **d_TimeOfDay / 当日时间：**
> 默认: 7<br/>
> 任务开始时间，可用时间 00:00-23:00，以1小时为单位<br/>

#### **d_enablefatigue / 禁用疲劳：**
> 默认: 1 (No, 无效； 0 或 Yes 消除疲劳)<br/>
> 如果启用（0，Yes），则玩家不会感到疲劳<br/>

#### **d_enablesway / 消除摆动：**
> 默认: 1 (No, 无效； 0 or Yes 消除摆动)<br/>
> 如果启用（0，Yes），那么玩家将没有摆动<br/>

#### **d_with_targetselect_count / 玩家可以从可用目标中选择：**
> 默认: 4<br/>
> 玩家可以选择下一个目标的主线任务数, Entire map/-1 表示所有目标, Off/0 表示关闭目标选择<br/>

#### **d_MissionType / 任务类型：**
> 默认: 0<br/>
> 可用选项：<br/>
>   - 默认任务类型 (0), 意味着可以执行主线任务和支线任务<br/>
>   - 只有主要任务 (1), 只有主线任务会产生<br/>
>   - 只有支线任务 (2), 只会出现支线任务<br/>

#### **d_retakefarps / 收复前沿补给点**
> 默认： 0 (Yes), 1 (No) 表示关闭<br/>
> 如果禁用 (1, No) 则任务开始时所有 前沿补给点 都可用<br/>

#### **d_with_MainTargetEvents / 主线任务随机事件：**
> 默认： 0 (绝不)<br/>
> 可用选项：<br/>
>   - 绝不 (0)<br/>
>   - 低的 (1)<br/>
>   - 中等 (2)<br/>
>   - 总是 (-1)<br/>
>   - 总是， 多个事件 (-2)<br/>

#### **d_with_ranked / 等级模式：**
> 默认： 1 (No, 禁用； 0 or Yes 启用它)<br/>
> 如果启用了等级模式，那么玩家需要特定的等级才能获得更好的武器，驾驶攻击机和直升机。例如，调用 CAS 需要花费分数等等<br/>

#### **d_transf_allow / 允许在等级模式中向其他玩家转移分数：**
> 默认： 0 (Yes), 1 (No) 关闭<br/>

#### **d_sm_dorandom / 随机支线任务：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果被禁用，支线任务的顺序总是相同的<br/>

#### **d_bonus_vec_type / 奖励载具：**
> 默认： 0<br/>
> 可用选项：<br/>
>   - 普通 (0)<br/>
>   - 无支线任务奖励载具 (1)<br/>
>   - 无主线任务奖励载具 (2)<br/>
>   - 无任何任务奖励载具 (3)<br/>

#### **d_ao_check_for_ai / 完成主线任务条件：**
> 注意：仅适用于 coop 版本，不适用于 TT 版本<br/>
> 默认： 1<br/>
> 可用选项：<br/>
>   - 占领所有营地并摧毁无线电塔 (0)<br/>
>   - AI单位数量少，占领了所有营地，摧毁了无线电塔 (1)<br/>
>   - 少量的AI单位和无线电塔被摧毁 (2)<br/>

#### **d_mt_respawngroups / 重新生成主线任务敌方 AI 单位作为增援部队**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_ai_persistent_corpses / 永久显示 AI 尸体**
> 默认： 1 (No, 无效； 0 or Yes 启用)<br/>

#### **d_ao_bfires / 主线任务火力：**
> 默认： 1 (No, 无效； 0 or 启用)<br/>

#### **d_weather / 内部的天气系统：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_enable_fog / 启用雾霾(内部天气系统)：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> A3 新雾系统<br/>

#### **d_WithWinterWeather / 冬季的天气：**
> 默认： 1 (No, 无效； 0 or 启用)<br/>
> 如果启用（0），则会添加一些冬季天气元素，例如不同的环境颜色和降雪<br/>

#### **d_withsandstorm / 沙尘暴天气：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 在有意义的岛屿上启用，例如 Altis <br/>

#### **d_MaxNumAmmoboxes/ 最大限度。弹药箱数量：**
> 默认： 10<br/>
> 可以从车辆上放下的弹药箱的最大数量（从基地的弹药点装载）<br/>
> 可用值为10、20和30<br/>

#### **d_max_truck_cargo / 工程卡车的载货量：**
> 默认： 6<br/>
> 工程师可装载到工程卡车中的最大静态武器数量<br/>
> 可用值为 1、3、6、9、12和16<br/>

#### **d_no_faks / 删除急救箱：**
> 默认： 1 (No, 无效； 0 or Yes to remove FAKs)<br/>
> 删除急救箱，仅在与 FAK Revive 组合使用时才有意义<br/>

#### **d_with_suppress / 玩家可以被压制：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_timemultiplier / 时间倍数 (真实 1 秒 = 游戏中 X 秒)：**
> 默认： 1 (正常)<br/>
> 如果使用大于1的值，则时间将运行得更快<br/>
> 可用值为 1, 6, 12, 30, 45, 60, 90 and 120<br/>

#### **d_with_dynsim / 动态模拟：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果启用，任务使用游戏内部 [动态模拟](https://community.bistudio.com/wiki/Arma_3_Dynamic_Simulation) <br/>

#### **d_with_bis_dynamicgroups / 使用 BIS 动态组（小队管理）：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果启用，任务将使用 BIs [动态组管理对话框](https://community.bistudio.com/wiki/Arma_3_Dynamic_Groups) <br/>
> 可通过状态对话框在任务中使用（按住U键可访问任务状态对话框） <br/>

#### **d_arsenal_mod / 在 [虚拟武库](https://community.bistudio.com/wiki/Arma_3_Arsenal) 中仅使用 Mod 武器:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果启用并且您使用的是 [CUP版本](https://github.com/Xeno69/Domination/wiki/Versions-and-needed-mods-addons#CUP) 的任务，只有 CUP 武器会出现在虚拟武库中<br/>

#### **d_no_mortar_ar / [虚拟武库](https://community.bistudio.com/wiki/Arma_3_Arsenal) 中的迫击炮背包：**
> 默认： 1 (No, 迫击炮背包; 0 or Yes 再添加一次)<br/>
> 如果设置 1/No 那么 [虚拟武库](https://community.bistudio.com/wiki/Arma_3_Arsenal) 就不需要再加迫击炮背包(0 迫击炮需再次添加)<br/>

#### **d_ao_markers / 在 AO（占领区域） 处关闭塔楼和营地的标记：**
> 默认： 1 (No, 无效； 0 or 启用)<br/>

#### **d_with_base_sabotage / 基地破坏：**
> 默认： 1 (No)<br/>
> 如果设置为 0 (Yes)，那么时不时会有一群精锐士兵降落在你的基地上，并试图破坏基地<br/>

#### **d_house_patrol / 以敌方的 AI 房屋巡逻 为主要目标：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_pylon_lodout / 启用载具挂架装载：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果启用，玩家将能够改变他们的 [挂架装载](https://community.bistudio.com/wiki/Arma_3_Vehicle_Loadouts) ，当他们进入一载具（可通过基地上的保持行动菜单） 

#### **d_pylon_noclust / 从 挂架装载 中删除 集束炸弹 **
> 默认： 0 (Yes, 启用； 1 or No 再次添加集束炸弹)<br/>
> 如果启用，则从塔挂载中删除 集束炸弹，因为它们导致 MP 的滞后时间<br/>

#### **d_with_minefield / 为主线任务生成雷区：**
> 默认： 0 (Yes, 启用； 1 or No 禁用雷区)<br/>
> 如果启用，有时会在主要目标上产生一个随机雷区<br/>

#### **d_va_percentage / 限制 虚拟武器库弹药箱 使用次数不超过1000次：**
> 默认： 0 (Yes, 启用； 1 or No 没有限制)<br/>
> 如果启用，玩家只能在掉落的弹药箱被删除之前使用它约1000次。<br/>

#### **d_dis_servicep / 禁用所有服务点，包括 FARP 前沿补给点（不加油、不维修、不重新武装）**
> 默认： 1 (No; 0 or Yes 禁用服务点)<br/>

#### **d_InitialViewDistance / 初始视距：**
> 默认： 1600 (米)<br/>
> 初始客户端视野距离，可用的是 (以米为单位)  1000、1600、2000、3000、3500、4000、4500、5000<br/>

#### **d_MaxViewDistance / 最大视距：**
> 默认： 5000 (meter)<br/>
> 客户端可以通过“状态对话框”调整最大视距。 可用的是 (以米为单位) 2000、3000、4000、5000、6000、7000、8000、9000、10000<br/>

#### **d_ViewdistanceChange / 调整视距：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果禁用玩家无法调整其客户端的视距<br/>

#### **d_playerspectateatbase / 玩家可以在基地标志处观看其他玩家：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_with_ai / AI 士兵招募：**
> 默认： 1<br/>
> 启用 AI 招募后，所有玩家都可以 标记炮兵目标，呼叫炮兵，呼叫飞机，呼叫CAS。他们也是工程师和医务人员。</br>
> 可用选项：<br/>
>   - 启用 (0)<br/>
>   - 禁用 (1)<br/>
>   - 启用但阻止新招募的 AI 进入静态武器 (2)<br/>

#### **d_with_ai_features / 具有AI功能，但不招募AI：**
> 默认： 1 (No, 无效； 0 or Yes to 有效<br/>
> 与上面的 d_with_ai 相同（所有玩家都可以 标记炮兵目标，呼叫炮兵，呼叫飞机，呼叫CAS。他们也是工程师和医务人员），只是没有AI招募<br/>

#### **d_max_ai / 招募 AI 最大数量:**
> 默认： 8<br/>
> 可用选项：4、6、8、10、12、14、16<br/>

#### **d_ai_alone_in_vehicle / AI 可以在没有玩家的情况下驾驶载具：**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_ai_silent / 机器人是沉默的：**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_GrasAtStart / 草植：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果禁用，则不渲染任何草植（更改地形网格）<br/>

#### **d_Terraindetail / 玩家可以禁用草植：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果禁用 玩家不能关掉草植（改变地形网格）<br/>

#### **d_EnableSimulationCamps / 敌方阵营启用模拟：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果禁用，则启用对主要目标上的对象合成的模拟（意味着它们可以被销毁）<br/>

#### **d_WithRevive / 复活：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果禁用，则无法复活，玩家死亡时只能在可用的出生点之一出生<br/>

#### **d_WithReviveSpectating / 等待复活时观战：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果禁用，玩家只有在处于昏迷状态时才能看到自己<br/>

#### **d_only_medics_canrevive / 只有医护人员才能进行复活：**
> 默认： 1 (禁用；0 or Yes 启用)<br/>

#### **d_ACEMedicalR / 使用ACE医疗复活而不是任务复活(如果ACE可用):**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 如果被禁用，任务将使用自己的复活而不是ACE复活<br/>

#### **xr_max_lives / 最大生命（重生）：**
> 默认： 30<br/>
> 确定玩家有多少生命<br/>
> 可用选项： 1、5、10、20、30、40、50 、-1（无限）<br/>

#### **xr_lifetime / 昏迷等待时间：**
> 默认： 300 (秒)<br/>
> 如果没有人复活玩家 或 玩家没有选择重生，则玩家处于无意识状态的时间。如果时间到了，玩家将在基地处重生。<br/>
> 可用选项（以秒为单位）： 60、120、180、240、300、600、1200<br/>

#### **xr_respawn_available_after / 重生等待时间：**
> 默认： 5 (秒)<br/>
> 如果玩家死亡，需要等待多少时间，可以重生<br/>
> 可用选项（以秒为单位）： 5、30、60、90、120、180、240、300、600<br/>

#### **d_show_playernames / 显示玩家名称：**
> 默认： 0 (Yes, 启用； 1 or No 在头顶上方不显示任何玩家名称)<br/>

#### **d_playernames_state / 默认的玩家名称状态：**
> 默认： 1<br/>
> 可用选项：<br/>
>   - 关闭 (0)<br/>
>   - 名字 (1)<br/>
>   - 健康 (2)<br/>

#### **d_show_player_marker / 玩家标记：**
> 默认： 1<br/>
> 可用选项：<br/>
>   - 关闭 (0)<br/>
>   - 仅名称 (1)<br/>
>   - 仅标记 (2)<br/>
>   - 健康 (3)<br/>

#### **d_force_isstreamfriendlyui / 强制无 HUD：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_WithAmbientRadio / 带环境无线电：**
> 默认： 1 (Yes, 启用； 0 or No 禁用<br/>

#### **d_with_3Dicon / 使用残骸维修/弹药补给上方的3D绘制图标：**
> 默认： 1 (Yes, 启用； 0 or No 禁用<br/>

#### **d_AutoKickTime / 航空载具占用自动踢出时间：**
> 默认： 1800 (秒)<br/>
> 自动踢出时间意味着在任务中第一次连接的玩家将被踢出攻击机和直升机，这样就不会浪费它们<br/>
> 可用选项（以秒为单位）： 0 (禁用)、60、300、1800、3600<br/>

#### **d_score_needed_to_fly / 要想被允许驾驶直升机和飞机，玩家的得分必须高于以下值：**
> 默认： 10<br/>
> 如果有可用的SQL数据库，则球员的得分低于 `d_score_needed_to_fly` 时，他们将被踢出飞行器。 不会影响MHQ、初始运输直升机等；可以通过设置 `-1` 禁用(禁用)<br/>
> 可用选项（以秒为单位）： -1 (禁用), 10, 50, 100, 500, 1000, 2000 and 5000<br/>

#### **d_without_nvg / 禁用夜视仪:**
> 默认： 1 (No, 无效； 0 or Yes to 移除夜视仪)<br/>
> 如果启用，则从玩家和AI移除夜视仪，并禁用带夜视功能的瞄具<br/>

#### **d_without_ti / 禁用武器装备/光学装备的热成像功能(TI)：**
> 默认： 1 (No, 无效； 0 or 启用)<br/>
> 如果启用，步兵武器光学的热成像功能被禁用<br/>

#### **d_without_vec_ti / 禁用载具热成像功能(TI)：**
> 默认： 1 (No, 无效； 0 or Yes 禁用热成像)<br/>
> 如果启用，则会从载具上移除热成像<br/>

#### **d_without_vec_nvg / 禁用载具夜视仪(NVG)：**
> 默认： 1 (No, 无效； 0 or Yes 禁用夜视仪)<br/>
> 如果启用，则会从载具上移除夜视仪<br/>

#### **d_vec_at_farp / 在 FARP（前哨补给站）中添加“生成載具”操作菜单：**
> 默认： 0 (Yes, 启用； 1 or No 删除操作菜单)<br/>

#### **d_engineerfull / Engineer full repair (old versions):**
> 默认： 1 (No, 无效； 0 or 启用)<br/>
> If enabled an engineer has a lot more options to repair and refuel a vehicle when he has a toolkit in his bag<br/>

#### **d_mhqvec_create_cooldown / Seconds till a player can create a new vec at MHQ:**
> 默认： 120 (seconds)<br/>
> 可用选项（以秒为单位）： 0 (disabled), 60, 120, 300, 600, 1200 and 1800<br/>

#### **d_launcher_cooldown / Launcher Cooldown Time in seconds:**
> 默认： 120 (seconds)<br/>
> Time it takes to fire a guided launcher again (too avoid players spamming targets with missiles)<br/>
> 可用选项（以秒为单位）： 0 (disabled), 60, 120, 180, 240 and 300<br/>

#### **d_arty_unlimited / Disable artillery cooldown**
> 默认： 0 (No, 启用炮兵冷却; 1 or Yes 禁用炮兵冷却)<br/>

#### **d_enable_civs / Enable civilians**
> 默认： 0 (No, 无效； 1 or Yes to enable civilians)<br/>

#### **d_civ_unitcount / Civilian unit count per group**
> 默认： 10<br/>
> 可用选项： 10, 15, 20, 25 and 30<br/>

#### **d_civ_groupcount / Civilian group count per target**
> 默认： 2<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 and 10<br/>

#### **d_civ_pnts / Subtract score when a player kills a civilian:**
> 默认： 3<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 10, 25, 50, 75 and 100<br/>

#### **d_enable_civ_vehs / Civilian vehicles - enabled**
> 默认： 0 (Off)<br/>
> 可用选项： Off, Very Low (10), Low (25), Medium (50), High (75) and Maximum (100)<br/>

#### **d_enable_civ_vehs_rad / Civilian vehicles - spawn radius**
> 默认： 250 (meters)<br/>
> 可用选项（以米为单位）： 150, 250, 350 and 450<br/>

#### **d_enable_civ_vehs_locked / Civilian vehicles - lock vehicles**
> 默认： 1 (Yes, 启用； 0 or No 禁用)<br/>

#### **d_tell_arty_cas / Always announce enemy artillery / CAS**
> 默认： 0 (No, 启用； 1 or Yes 禁用)<br/>

#### **d_disable_airai / Disable enemy air**
> 默认： 0 (No, air ai enabled; 1 or Yes to disable air ai)<br/>

#### **d_occ_bldgs / Enemy AI will occupy buildings**
> 默认： 1 (Yes, 启用； 0 or No 禁用)<br/>

#### **d_ai_awareness_rad / AI Advanced - enhanced awareness (common units)**
> 默认： -1 (No)<br/>
> 可用选项（以米为单位）： No (-1), 10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 450, 500, 550, 600, 650, 700, 800, 900 and 1000<br/>

#### **d_snp_aware / Garrisoned infantry sniper mode - advanced awareness**
> 默认： 0 (No, 无效； 1 or 启用)<br/>

#### **d_ai_pursue_rad / AI Advanced - enemy active pursuit radius**
> 默认： -1 (no)<br/>
> 可用选项（以米为单位）： -1 (No), 10, 25, 50, 75, 100, 125, 150, 175, 200, 225, 250, 275, 300, 400, 500, 750 and 1000<br/>

#### **d_ai_aggressiveshoot / AI Advanced - enemy shoots aggressively at players**
> 默认： 0 (No, 无效； 1 or 启用)<br/>

#### **d_ai_quickammo / AI Advanced - enemy granted frequent ammo refills**
> 默认： 0 (No, 无效； 1 or 启用)<br/>

#### **d_occ_cnt / Garrisoned infantry group count - occupy mode**
> 默认： 4<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25 and 30<br/>

#### **d_occ_rad / Occupy deployment radius**
> 默认： 250 (meter)<br/>
> 可用选项（以米为单位）： 125, 250 and 350<br/>

#### **d_ovrw_cnt / Garrisoned infantry group count - overwatch mode**
> 默认： 2<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25 and 30<br/>

#### **d_ovrw_rad / Overwatch deployment radius**
> 默认： 250 (meter)<br/>
> 可用选项（以米为单位）： 125, 250 and 350<br/>

#### **d_amb_cnt / Garrisoned infantry group count - ambush mode**
> 默认： 2<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25 and 30<br/>

#### **d_amb_rad / Ambush deployment radius**
> 默认： 250 (meter)<br/>
> 可用选项（以米为单位）： 125, 250 and 350<br/>

#### **d_snp_cnt / Garrisoned infantry group count - sniper mode**
> 默认： 2<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30 and 45<br/>

#### **d_snp_rad / Sniper deployment radius**
> 默认： 425 (meter)<br/>
> 可用选项（以米为单位）： 250, 425, 650 and 900<br/>

#### **d_max_bar_cnt / Maximum number of enemy infantry barracks**
> 默认： 5<br/>
> 可用选项： 1, 2, 3, 4, 5, 6 and 7<br/>

#### **d_max_camp_cnt / Maximum number of enemy camps to capture**
> 默认： -1<br/>
> 可用选项： -1 (3-5), 1, 2, 3, 4 and 5<br/>

#### **d_camp_center / Locate the first enemy camp to capture near the center of the main target**
> 默认： 0 (No, 无效； 1 or Yes to spawn the first camp close to the main target center)<br/>

#### **d_camp_static_weapons / Defend with static weapons**
> 默认： 1 (Yes, 启用； 0 or No 禁用<br/>

#### **d_WithMHQTeleport / Teleport or spawn at MHQ:**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_MHQDisableNearMT / Disable MHQ if less than x m away from MT:**
> 默认： 500 (meter)<br/>
> 可用选项（以米为单位）： 0 (Off), 500, 700, 900, 1000 and 2000<br/>
> Removes fuel from MHQ if closer than x meters away from the main target center<br/>

#### **d_NoMHQTeleEnemyNear / No MHQ tele when enemy near:**
> 默认： 50 (meter)<br/>
> 可用选项（以米为单位）： 0 (Disabled), 50, 100, 200 and 500<br/>

#### **d_with_mhq_camo / MHQ Camo enabled:**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>
> Spawns a camo net over the MHQ<br/>

#### **d_WithTeleToBase / Enable teleport to base:**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_respawnatsql / Respawn at Squad Leader:**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_MTTowerSatchelsOnly / MT Tower Satchels only:**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>
> 如果启用，主要目标只能被挎包摧毁 Main target can only be destroyed by satchels if enabled<br/>

#### **d_IllumMainTarget / 照亮主要目标：**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_sub_kill_points / 玩家死亡时减去分数：**
> 默认： 0<br/>
> 可用选项： 0 (No)、1、2、3、4、5、6、7、8、9、10<br/>

#### **d_pilots_only / 仅限飞行员可飞行：**
> 默认： 1 (No, 无效； 0 or Yes to 有效<br/>
> 如果启用，则玩家需要飞行员头饰和飞行员制服才能飞行<br/>

#### **d_WithLessArmor / 主线任务的装甲车辆：**
> 默认： 0<br/>
> 可用选项： 0 (普通)、 1 (较少)、 2 (没有)、 -1 (随机)<br/>

#### **d_WithLessArmor_side / 支线任务的装甲车辆：**
> 默认： 0<br/>
> 可用选项： 0 (普通)、 1 (较少)、 2 (没有)、 -1 (随机)<br/>

#### **d_EnemySkill / 敌军技能：**
> 默认： 2<br/>
> 可用选项： 0 (极低)、1 (低)、2 (普通)、3 (高)、4 (极高)<br/>

#### **d_WithIsleDefense / 岛屿防御：**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>
> 目前由于 AI 驾驶和 巡逻 并不是游戏的强项而被完全禁用<br/>

#### **d_without_sm_bonus / 没有支线任务载具奖励：**
> 默认： 1 (No, 无效； 0 or Yes for no bonus vecs)<br/>
> 如果启用，如果解决了支线任务，则不会产生任何支线任务载具奖励 (参考 [Malden NBV 版本](https://github.com/Xeno69/Domination/wiki/Versions-and-needed-mods-addons#NBV) )</br>

#### **d_smallgrps / 根据玩家人数减少敌人组中的 AI 单位数量：**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> 根据玩家人数减少敌人 AI 组的大小。较低的玩家人数，较低的组数。<br/>

#### **d_skillfps / 如果服务器 FPS 较低，则调整 AI 子技能**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_ParaAtBase / 在基地跳伞：**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_HALOWaitTime / 在基地的跳伞间隔时间：**
> 默认： 0<br/>
> 可用选项（以秒为单位）： 0、 300、 600、 1800 和 3600<br/>
> 玩家必须等到从基地开始下一次跳伞的时间<br/>

#### **d_WithJumpFlags / 没有跳伞标志：**
> 默认： 1 (No, 无效； 1 or Yes to 有效<br/>

#### **d_HALOJumpHeight / 跳伞高度：**
> 默认： 2000 (米)<br/>
> 可用选项（以米为单位）： 500、 700、 888、 1000、 2000 和 5000<br/>

#### **d_LockArmored / 锁定敌人的地面装甲载具：**
> 默认： 1 (No, 无效； 1 or Yes to 有效<br/>

#### **d_LockCars / 锁定敌人的地面载具：**
> 默认： 1 (No, 无效； 1 or Yes to 有效<br/>

#### **d_LockAir / 锁定敌人的飞行载具：**
> 默认： 1 (No, 无效； 1 or Yes to 有效<br/>

#### **d_enemy_vecs_lift / 敌方 AI 载具可以空运：**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_maxnum_tks_forkick / TK 最大允许次数：**
> 默认： 10<br/>
> 可用选项： 1、 2、 3、 5、 10、 20、 30、 40 和 1000000 (禁用)<br/>
> 从 `4.24` 版本开始，玩家不会被踢，但是会入狱禁闭一段时间<br/>

#### **d_player_kick_shootingbase / 踢出在基地射击的玩家：**
> 默认： 10<br/>
> 可用选项： 2, 3, 5, 10, 20, 30 和 1000 (不踢除)<br/>

#### **d_no_teamkill / 关闭队友伤害：**
> 默认： 0 (Yes, 启用； 1 or No 禁用<br/>

#### **d_sub_tk_points / TK 扣减分数：**
> 默认： 10<br/>
> 可用选项： 0、 1、 5、 10、 20、 30 和 50<br/>
> 杀死一名玩家后被扣减分数标准<br/>

#### **d_WreckDeleteTime / 残骸清除时间：**
> 默认： 3600<br/>
> 可用选项： 1800、3600, 5400、7200 和 -1 (绝不)<br/>
> 这仅适用于解决支线任务或主要目标时玩家获得的奖励车辆残骸<br/>

#### **d_WreckMaxRepair / 残骸最大维修时间：**
> 默认： 3<br/>
> 可用选项： 1, 2, 3, 4, 5, 10, 20 和 10000000 (无限)<br/>
> 残骸点多久可以修复一次残骸<br/>

#### **d_drop_radius / 空投误差半径范围：**
> 默认： 0 (meter)<br/>
> 可用选项（以米为单位）： 0 (确切位置)、 10、 30、 50 和 100<br/>

#### **d_drop_max_dist / 空投最大距离：**
> 默认： 500 (meter)<br/>
> 可用选项（以米为单位）： 100、 500、 1000、 2000、 5000 和 10000000 (无限)<br/>
