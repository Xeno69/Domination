**Domination** 有很多参数，登录管理员可以更改。如果使用了数据库，则这些参数也可以在 `dom_params2` 数据库表中进行更改(使用数据库总是覆盖管理员所做的更改)。或者如果有人要修改任务，也可以在任务根文件夹内的 `description.ext` 中进行更改（同样，如果使用数据库，则数据库参数值将覆盖 `description.ext` 值）。

***

**可用参数 （第一 `description.ext` 、数据库, 第二 服务器大厅）：**

#### **d_MainTargets_num / 主要目标：**
> 默认: Complete, ordered (-1 in description.ext)<br/>
> 将要游戏的主要目标数量。数量取决于使用的岛屿<br/>
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
> 玩家可以选择下一个目标的主要目标数, Entire map/-1 表示所有目标, Off/0 表示关闭目标选择<br/>

#### **d_MissionType / 任务类型：**
> 默认: 0<br/>
> 可用选项：<br/>
>   - 默认任务类型 (0), 意味着可以执行主要目标和副任务<br/>
>   - 只有主要任务 (1), 只有主要目标会产生<br/>
>   - 只有支线任务 (2), 只会出现支线任务<br/>

#### **d_retakefarps / 收复前沿补给点**
> 默认： 0 (Yes), 1 (No) 表示关闭<br/>
> 如果禁用 (1, No) 则任务开始时所有 前沿补给点 都可用<br/>

#### **d_with_MainTargetEvents / 主要目标随机事件：**
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

#### **d_mt_respawngroups / 重新生成主要目标敌方 AI 单位作为增援部队**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_ai_persistent_corpses / Persistent AI corpses**
> 默认： 1 (No, disabled; 0 or Yes to enable it)<br/>

#### **d_ao_bfires / Big main target fires:**
> 默认： 1 (No, disabled; 0 or Yes to enable it)<br/>

#### **d_weather / Internal weather system:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_enable_fog / Enable fog (internal weather system):**
> 默认： 0 (Yes, enables; 1 or No 禁用)<br/>
> A3 new fog system<br/>

#### **d_WithWinterWeather / With winter weather:**
> 默认： 1 (No, disabled; 0 or Yes to enable it)<br/>
> If enabled (0) it adds some winter weather elemnts like different environment coloring and snow<br/>

#### **d_withsandstorm / With sandstorm:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> Enabled on islands where it makes sense, like Altis for example<br/>

#### **d_MaxNumAmmoboxes/ Max. number ammo boxes:**
> 默认： 10<br/>
> Maximum number of ammo boxes which can be dropped from vehicles (loaded from ammo point at base)<br/>
> Available values are 10, 20 and 30<br/>

#### **d_max_truck_cargo / Engineer truck cargo capacity:**
> 默认： 6<br/>
> Maximum number of static weapons an engineer can load into an engineer truck<br/>
> Available values are 1, 3, 6, 9, 12 and 16<br/>

#### **d_no_faks / Remove Fist Aid Kits:**
> 默认： 1 (No, disabled; 0 or Yes to remove FAKs)<br/>
> Removes first aid kits, makes only sense when using it in combination with FAK revive<br/>

#### **d_with_suppress / Player can be suppressed**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_timemultiplier / Time Multiplier (1 real second = x ingame seconds):**
> 默认： 1 (disabled)<br/>
> If a value bigger than 1 is used time will run faster<br/>
> Available values are 1, 6, 12, 30, 45, 60, 90 and 120<br/>

#### **d_with_dynsim / Dynamic Simulation:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If enabled the mission uses the game internal [Dynamic Simulation](https://community.bistudio.com/wiki/Arma_3_Dynamic_Simulation)<br/>

#### **d_with_bis_dynamicgroups / With BIS Dynamic Groups (Squad Mgmt):**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If enabled the mission uses BIs [Dynamic Groups management dialog](https://community.bistudio.com/wiki/Arma_3_Dynamic_Groups)<br/>
> It's available in the mission via Status Dialog (hold U-key to access the mission Status Dialog)<br/>

#### **d_arsenal_mod / Use only mod weapons in [Virtual Arsenal](https://community.bistudio.com/wiki/Arma_3_Arsenal):**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If enabled and you use a [CUP version](https://github.com/Xeno69/Domination/wiki/Versions-and-needed-mods-addons#CUP) of the mission then only CUP weapons will show up in Virtual Arsenal<br/>

#### **d_no_mortar_ar / Mortar bag packs in [Virtual Arsenal](https://community.bistudio.com/wiki/Arma_3_Arsenal):**
> 默认： 1 (No, mortar bags; 0 or Yes to add them again)<br/>
> If set to 1/No then no mortar bags will be added to [Virtual Arsenal](https://community.bistudio.com/wiki/Arma_3_Arsenal) (0 to make mortars show again)<br/>

#### **d_ao_markers / Turn off markers at AO for tower and camps:**
> 默认： 1 (No, disabled; 0 or Yes to enable it)<br/>

#### **d_with_base_sabotage / With base sabotage:**
> 默认： 1 (No)<br/>
> If set to 0 (Yes) then every now and then a group of elite soldiers will drop over your base and try to sabotage you<br/>

#### **d_house_patrol / With enemy AI house patrol at main targets:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_pylon_lodout / Pylon loadout enabled:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If enabled players will be able to change they [pylon loadout](https://community.bistudio.com/wiki/Arma_3_Vehicle_Loadouts) when they enter a vehicle (available via hold action menu on base)<br/>

#### **d_pylon_noclust / Remove cluster ammo from pylon loadout**
> 默认： 0 (Yes, 启用； 1 or No to add cluster bombs again)<br/>
> Removes cluster bombs from pylon loadout if enabled because they cause too much lag in MP<br/>

#### **d_with_minefield / With minefield at main targets:**
> 默认： 0 (Yes, 启用； 1 or No to disable minefields)<br/>
> Sometimes spawns a random minefield at main targets if enabled<br/>

#### **d_va_percentage / Limit Virtual Arsenal ammo box access too 1000**
> 默认： 0 (Yes, 启用； 1 or No for no limit)<br/>
> If enabled players can only access a dropped ammo box about 1000 times before it gets deleted<br/>

#### **d_dis_servicep / Disable all service points, including FARPs (no refuel, no repair, no rearm)**
> 默认： 1 (No; 0 or Yes to disable service points)<br/>

#### **d_InitialViewDistance / Initial Viewdistance:**
> 默认： 1600 (meter)<br/>
> Inital client viewdistance, available are (in meter) 1000, 1600, 2000, 3000, 3500, 4000, 4500 and 5000<br/>

#### **d_MaxViewDistance / Maximum Viewdistance:**
> 默认： 5000 (meter)<br/>
> Maximum viewdistance a client can select via Status Dialog. Available are (in meter) 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000 and 10000<br/>

#### **d_ViewdistanceChange / Viewdistance changable:**
> 默认： 0 (Yes, 启用； 1 or No for no vd change)<br/>
> If disabled players can not change their client viewdistance<br/>

#### **d_playerspectateatbase / Player can spectate other players at base flag:**
> 默认： 0 (Yes, 启用； 1 or No too disable)<br/>

#### **d_with_ai / With AI recruitment:**
> 默认： 1<br/>
> When AI recruitment is enabled all players can mark artillery targets, call in artillery, call in a drop aircraft, call in CAS. They are also all engineers and medics.</br>
> 可用选项：<br/>
>   - Enabled (0)<br/>
>   - Disabled (1)<br/>
>   - Enabled but block recruited AI from entering static weapons (2)<br/>

#### **d_with_ai_features / With AI features but no AI recruit:**
> 默认： 1 (No, disabled; 0 or Yes to enable<br/>
> Same as d_with_ai above, just no AI recruitment<br/>

#### **d_max_ai / Recruit AI (max.):**
> 默认： 8<br/>
> 可用选项： 4, 6, 8, 10, 12, 14 and 16<br/>

#### **d_ai_alone_in_vehicle / AI can drive vehicle without a player inside:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_ai_silent / Bots are silent**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_GrasAtStart / Grass:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If disabled then no grass is rendered (changes terraingrid)<br/>

#### **d_Terraindetail / Player can disable grass:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If disabled players can not turn off grass (change terraingrid)<br/>

#### **d_EnableSimulationCamps / Enable simulation for enemy camps:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If disabled the simulation for object compositions at main targets is enabled (means they can be destroyed)<br/>
> If disabled players can not turn off grass (change terraingrid)<br/>

#### **d_WithRevive / With revive:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If disabled no revive is available, players can then only spawn at one of the available spawn points when they die<br/>

#### **d_WithReviveSpectating / With revive spectating:**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If disabled players can only see themself when they are in unconscious state<br/>

#### **d_only_medics_canrevive / Only medics can revive:**
> 默认： 1 (disabled)<br/>

#### **d_ACEMedicalR / Use ACE Medical Revive and not mission Revive (if ACE is available):**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> If disabled the mission uses it's own revive instead of the ACE one<br/>

#### **xr_max_lives / Max lives (revive):**
> 默认： 30<br/>
> Determines how many lives a player has<br/>
> 可用选项： 1, 5, 10, 20, 30, 40, 50 and Unlimited (-1)<br/>

#### **xr_lifetime / Life time:**
> 默认： 300 (seconds)<br/>
> Time a player stays in unconscious state if nobody revives him/her or he/she does not respawn. If the time is up the player respawns at base<br/>
> Available options in seconds: 60, 120, 180, 240, 300, 600 and 1200<br/>

#### **xr_respawn_available_after / Respawn possible after:**
> 默认： 5 (seconds)<br/>
> If a player dies it takes xr_respawn_available_after seconds until he/she can respawn<br/>
> Available options in seconds: 5, 30, 60, 90, 120, 180, 240, 300 and 600<br/>

#### **d_show_playernames / Show player names:**
> 默认： 0 (Yes, 启用； 1 or No to show no player names for example above head)<br/>

#### **d_playernames_state / Default player name state:**
> 默认： 1<br/>
> 可用选项：<br/>
>   - Off (0)<br/>
>   - Names (1)<br/>
>   - Health (2)<br/>

#### **d_show_player_marker / Player marker:**
> 默认： 1<br/>
> 可用选项：<br/>
>   - Off (0)<br/>
>   - Name only (1)<br/>
>   - Marker only (2)<br/>
>   - Health (3)<br/>

#### **d_force_isstreamfriendlyui / Force no HUD**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_WithAmbientRadio / With ambient radio:**
> 默认： 1 (Yes, 启用； 0 or No to disable<br/>

#### **d_with_3Dicon / With 3D draw icon above wreck repair/ammo point:**
> 默认： 1 (Yes, 启用； 0 or No to disable<br/>

#### **d_AutoKickTime / Air vecs autokick time:**
> 默认： 1800 (seconds)<br/>
> Autokick time means that a player who connects the first time during the mission will be kicked out of attack planes and choppers so he/she doesn't waste them<br/>
> Available options in seconds: 0 (disabled), 60, 300, 1800 and 3600<br/>

#### **d_score_needed_to_fly / Flying choppers and planes only allowed when a player has a score higher than:**
> 默认： 10<br/>
> If a SQL database is available players will get kicked out of air vehicles if their score is below d_score_needed_to_fly. Doesn't affect inital choppers like MHQ/transport; can be disabled with -1 (Disabled)<br/>
> Available options in seconds: -1 (disabled), 10, 50, 100, 500, 1000, 2000 and 5000<br/>

#### **d_without_nvg / Without NVgoggles:**
> 默认： 1 (No, disabled; 0 or Yes to remove nv goggles)<br/>
> If enabled removes night vision goggles from players and AI and blocks NV sights<br/>

#### **d_without_ti / Disable Thermal Imaging (TI) for inf weapons/optics:**
> 默认： 1 (No, disabled; 0 or Yes to enable it)<br/>
> If enabled thermal imaging for infantry weapons/optics is blocked<br/>

#### **d_without_vec_ti / Disable vehicle TI:**
> 默认： 1 (No, disabled; 0 or Yes to remove termal imaging)<br/>
> If enabled removes termal imaging from vehicles<br/>

#### **d_without_vec_nvg / Disable vehicle NVG:**
> 默认： 1 (No, disabled; 0 or Yes to remove night vision)<br/>
> If enabled removes night vision from vehicles<br/>

#### **d_vec_at_farp / Add action menu "Spawn vehicle" to FARPs:**
> 默认： 0 (Yes, 启用； 1 or No to remove the acion menu)<br/>

#### **d_engineerfull / Engineer full repair (old versions):**
> 默认： 1 (No, disabled; 0 or Yes to enable it)<br/>
> If enabled an engineer has a lot more options to repair and refuel a vehicle when he has a toolkit in his bag<br/>

#### **d_mhqvec_create_cooldown / Seconds till a player can create a new vec at MHQ:**
> 默认： 120 (seconds)<br/>
> Available options in seconds: 0 (disabled), 60, 120, 300, 600, 1200 and 1800<br/>

#### **d_launcher_cooldown / Launcher Cooldown Time in seconds:**
> 默认： 120 (seconds)<br/>
> Time it takes to fire a guided launcher again (too avoid players spamming targets with missiles)<br/>
> Available options in seconds: 0 (disabled), 60, 120, 180, 240 and 300<br/>

#### **d_arty_unlimited / Disable artillery cooldown**
> 默认： 0 (No, artillery cooldown enabled; 1 or Yes to disable artillery cooldown)<br/>

#### **d_enable_civs / Enable civilians**
> 默认： 0 (No, disabled; 1 or Yes to enable civilians)<br/>

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
> Available options (in meters): 150, 250, 350 and 450<br/>

#### **d_enable_civ_vehs_locked / Civilian vehicles - lock vehicles**
> 默认： 1 (Yes, 启用； 0 or No to disable)<br/>

#### **d_tell_arty_cas / Always announce enemy artillery / CAS**
> 默认： 0 (No, 启用； 1 or Yes 禁用)<br/>

#### **d_disable_airai / Disable enemy air**
> 默认： 0 (No, air ai enabled; 1 or Yes to disable air ai)<br/>

#### **d_occ_bldgs / Enemy AI will occupy buildings**
> 默认： 1 (Yes, 启用； 0 or No to disable)<br/>

#### **d_ai_awareness_rad / AI Advanced - enhanced awareness (common units)**
> 默认： -1 (No)<br/>
> Available options in meters: No (-1), 10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 450, 500, 550, 600, 650, 700, 800, 900 and 1000<br/>

#### **d_snp_aware / Garrisoned infantry sniper mode - advanced awareness**
> 默认： 0 (No, disabled; 1 or Yes to enable it)<br/>

#### **d_ai_pursue_rad / AI Advanced - enemy active pursuit radius**
> 默认： -1 (no)<br/>
> Available options in meters: -1 (No), 10, 25, 50, 75, 100, 125, 150, 175, 200, 225, 250, 275, 300, 400, 500, 750 and 1000<br/>

#### **d_ai_aggressiveshoot / AI Advanced - enemy shoots aggressively at players**
> 默认： 0 (No, disabled; 1 or Yes to enable it)<br/>

#### **d_ai_quickammo / AI Advanced - enemy granted frequent ammo refills**
> 默认： 0 (No, disabled; 1 or Yes to enable it)<br/>

#### **d_occ_cnt / Garrisoned infantry group count - occupy mode**
> 默认： 4<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25 and 30<br/>

#### **d_occ_rad / Occupy deployment radius**
> 默认： 250 (meter)<br/>
> Available options (in meter): 125, 250 and 350<br/>

#### **d_ovrw_cnt / Garrisoned infantry group count - overwatch mode**
> 默认： 2<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25 and 30<br/>

#### **d_ovrw_rad / Overwatch deployment radius**
> 默认： 250 (meter)<br/>
> Available options (in meter): 125, 250 and 350<br/>

#### **d_amb_cnt / Garrisoned infantry group count - ambush mode**
> 默认： 2<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25 and 30<br/>

#### **d_amb_rad / Ambush deployment radius**
> 默认： 250 (meter)<br/>
> Available options (in meter): 125, 250 and 350<br/>

#### **d_snp_cnt / Garrisoned infantry group count - sniper mode**
> 默认： 2<br/>
> 可用选项： 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30 and 45<br/>

#### **d_snp_rad / Sniper deployment radius**
> 默认： 425 (meter)<br/>
> Available options (in meter): 250, 425, 650 and 900<br/>

#### **d_max_bar_cnt / Maximum number of enemy infantry barracks**
> 默认： 5<br/>
> 可用选项： 1, 2, 3, 4, 5, 6 and 7<br/>

#### **d_max_camp_cnt / Maximum number of enemy camps to capture**
> 默认： -1<br/>
> 可用选项： -1 (3-5), 1, 2, 3, 4 and 5<br/>

#### **d_camp_center / Locate the first enemy camp to capture near the center of the main target**
> 默认： 0 (No, disabled; 1 or Yes to spawn the first camp close to the main target center)<br/>

#### **d_camp_static_weapons / Defend with static weapons**
> 默认： 1 (Yes, 启用； 0 or No to disable<br/>

#### **d_WithMHQTeleport / Teleport or spawn at MHQ:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_MHQDisableNearMT / Disable MHQ if less than x m away from MT:**
> 默认： 500 (meter)<br/>
> Available options (in meter): 0 (Off), 500, 700, 900, 1000 and 2000<br/>
> Removes fuel from MHQ if closer than x meters away from the main target center<br/>

#### **d_NoMHQTeleEnemyNear / No MHQ tele when enemy near:**
> 默认： 50 (meter)<br/>
> Available options (in meter): 0 (Disabled), 50, 100, 200 and 500<br/>

#### **d_with_mhq_camo / MHQ Camo enabled:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>
> Spawns a camo net over the MHQ<br/>

#### **d_WithTeleToBase / Enable teleport to base:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_respawnatsql / Respawn at Squad Leader:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_MTTowerSatchelsOnly / MT Tower Satchels only:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>
> Main target can only be destroyed by satchels if enabled<br/>

#### **d_IllumMainTarget / Illuminate main target:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_sub_kill_points / Subtract score when a player dies:**
> 默认： 0<br/>
> 可用选项： 0 (No), 1, 2, 3, 4, 5, 6, 7, 8, 9 and 10<br/>

#### **d_pilots_only / Only pilots can fly:**
> 默认： 1 (No, disabled; 0 or Yes to enable<br/>
> If enabled a player needs pilot headgear and pilot uniform to fly<br/>

#### **d_WithLessArmor / Armor at main targets:**
> 默认： 0<br/>
> 可用选项： 0 (Normal), 1 (Less), 2 (None) and -1 (Random)<br/>

#### **d_WithLessArmor_side / Armor at side missions:**
> 默认： 0<br/>
> 可用选项： 0 (Normal), 1 (Less) 2 (None) and -1 (Random)<br/>

#### **d_EnemySkill / Skill Enemy:**
> 默认： 2<br/>
> 可用选项： 0 (Very Low), 1 (Low), 2 (Normal), 3 (High) and 4 (Very High)<br/>

#### **d_WithIsleDefense / With isle defense:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>
> Currently completely disabled as AI driving and path finding is not a strength of the game<br/>

#### **d_without_sm_bonus / Without sidemission bonus vehicles:**
> 默认： 1 (No, disabled; 0 or Yes for no bonus vecs)<br/>
> If enabled no side mission bonus vehicle spawns if a side mission is resolved (see [Malden NBV version](https://github.com/Xeno69/Domination/wiki/Versions-and-needed-mods-addons#NBV) )</br>

#### **d_smallgrps / Reduce number of AI units in groups depending on player numbers**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>
> Reduces enemy AI group size depending on player numbers. Lower player number, lower group count.<br/>

#### **d_skillfps / Adjust AI subskill if server FPS is low**
> 默认： 0 (Yes, 启用； 1 or No 禁用)<br/>

#### **d_ParaAtBase / Parachute from base:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_HALOWaitTime / HALO at base wait time:**
> 默认： 0<br/>
> Available options (in seconds): 0, 300, 600, 1800 and 3600<br/>
> Time a player has to wait till the next parajump from base<br/>

#### **d_WithJumpFlags / No parachute jump flags:**
> 默认： 1 (No, disabled; 1 or Yes to enable<br/>

#### **d_HALOJumpHeight / HALO jump height:**
> 默认： 2000 (meter)<br/>
> Available options (in meter): 500, 700, 888, 1000, 2000 and 5000<br/>

#### **d_LockArmored / Lock armored enemy armored vecs:**
> 默认： 1 (No, disabled; 1 or Yes to enable<br/>

#### **d_LockCars / Lock armored enemy cars:**
> 默认： 1 (No, disabled; 1 or Yes to enable<br/>

#### **d_LockAir / Lock armored enemy air vecs:**
> 默认： 1 (No, disabled; 1 or Yes to enable<br/>

#### **d_enemy_vecs_lift / Enemy AI vehicles can be air lifted:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_maxnum_tks_forkick / Max number TKs for kick:**
> 默认： 10<br/>
> 可用选项： 1, 2, 3, 5, 10, 20, 30, 40 and 1000000 (disable)<br/>
> Starting with 4.24 players won't get kicked but put into a jail for some time<br/>

#### **d_player_kick_shootingbase / Kick players shooting at base:**
> 默认： 10<br/>
> 可用选项： 2, 3, 5, 10, 20, 30 and 1000 (No kick)<br/>

#### **d_no_teamkill / No teamkilling possible:**
> 默认： 0 (Yes, 启用； 1 or No to disable<br/>

#### **d_sub_tk_points / Negative TK points:**
> 默认： 10<br/>
> 可用选项： 0, 1, 5, 10, 20, 30 and 50<br/>
> Score a player gets subtracted for killing another player<br/>

#### **d_WreckDeleteTime / Delete wrecks after:**
> 默认： 3600<br/>
> 可用选项： 1800, 3600, 5400, 7200 and -1 (Never)<br/>
> This is only for bonus vehicle wrecks players get when solving a side mission or a main target<br/>

#### **d_WreckMaxRepair / Wreck max repairs:**
> 默认： 3<br/>
> 可用选项： 1, 2, 3, 4, 5, 10, 20 and 10000000 (Infinite)<br/>
> How often a bonus wreck can be repaired at the wreck point<br/>

#### **d_drop_radius / Air drop radius:**
> 默认： 0 (meter)<br/>
> Available options (in meter): 0 (Exact position), 10, 30, 50 and 100<br/>

#### **d_drop_max_dist / Airdrop max. dist:**
> 默认： 500 (meter)<br/>
> Available options (in meter): 100, 500, 1000, 2000, 5000 and 10000000 (Infinite)<br/>
