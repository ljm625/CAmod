## Player ranks
label-player-level = 当前军衔：{ $level }
label-player-level-current-xp = 当前经验值：{ $currentXp }
label-player-level-required-xp = 下一级所需经验值：{ $nextLevelXp }

label-player-influence-level = 影响力等级：{ $level }
label-player-influence-level-time = 距离下一级：{ $time }
label-player-influence-coalition = 联盟：{ $coalition }
label-player-influence-policy = 政策：{ $policy }

label-covenant-level = 誓约等级：{ $level }
label-covenant-description = 通过摧毁敌方采矿车，
    或摧毁/占领/渗透敌方建筑来获得。

## ObserverStatsLogic
options-observer-stats =
    .none = 信息：无
    .basic = 基础
    .economy = 经济
    .production = 生产
    .support-powers = 支援技能
    .combat = 战斗
    .army = 军队
    .upgrades = 升级
    .build-order = 建造顺序
    .units-produced = 已生产单位
    .earnings-graph = 收入（图表）
    .army-graph = 军队价值（图表）
    .team-army-graph = 队伍价值（图表）

## chrome/gamesave-loading.yaml
label-gamesave-loading-screen-loadtime-line1 = 抱歉载入时间较长，这是 OpenRA 引擎读取存档的方式所致。
label-gamesave-loading-screen-loadtime-line2 = 引擎会从开局开始以最快速度回放整局游戏（对局越长，加载越久）。

## chrome/ingame-player.yaml
button-command-bar-attack-move =
    .tooltip = 攻击移动
    .tooltipdesc =
    选中单位会移动到目标位置，
    并攻击沿途遇到的敌人。

    指定目标时按住 <(Ctrl)> 可下达“突击移动”，
    会攻击沿途遇到的所有单位和建筑。

    先左键点击图标，再右键点击目标位置。

button-command-bar-force-move =
    .tooltip = 强制移动
    .tooltipdesc =
    选中单位会移动到目标位置
     - 压制目标的默认行为
     - 车辆会尝试碾压目标位置上的敌人
     - 直升机会在目标位置降落
     - 超时空坦克会朝目标位置传送

    先左键点击图标，再右键点击目标。
    指挥单位时按住 <(Alt)> 可临时启用。

button-command-bar-force-attack =
    .tooltip = 强制攻击
    .tooltipdesc =
    选中单位会攻击指定单位或位置
     - 压制目标的默认行为
     - 允许指定己方或盟友单位为目标
     - 远程火炮单位会始终攻击指定位置，
       无视该处单位与建筑

    先左键点击图标，再右键点击目标。
    指挥单位时按住 <(Ctrl)> 可临时启用。

button-command-bar-guard =
    .tooltip = 护卫
    .tooltipdesc =
    选中单位会跟随目标单位。

    先左键点击图标，再右键点击目标单位。

button-command-bar-deploy =
    .tooltip = 部署
    .tooltipdesc =
    选中单位会执行默认部署行为
     - MCV 会展开为建造厂
     - 建造厂会收起为 MCV
     - 运输单位会卸下乘员
     - 爆破卡车和 MAD 坦克会自爆
     - 布雷车会部署地雷
     - 飞机会返航

    对选中单位立即生效。

button-command-bar-scatter =
    .tooltip = 分散
    .tooltipdesc =
    选中单位会停止当前行为，
    并移动到附近位置。

    对选中单位立即生效。

button-command-bar-stop =
    .tooltip = 停止
    .tooltipdesc =
    选中单位会停止当前行为。
    选中建筑会重置集结点。

    对选中目标立即生效。

button-command-bar-queue-orders =
    .tooltip = 路点模式
    .tooltipdesc =
    使用路点模式可向选中单位下达多个串联命令。
    单位在接到命令后会立即开始执行。

    先左键点击图标，再在游戏世界中下达命令。
    指挥单位时按住 <(Shift)> 可临时启用。

button-stance-bar-attackanything =
    .tooltip = 见敌即攻姿态
    .tooltipdesc =
    将选中单位设为“见敌即攻”姿态：
     - 单位会主动攻击视野内的敌方单位和建筑
     - 单位会跨战场追击攻击者

button-stance-bar-defend =
    .tooltip = 防御姿态
    .tooltipdesc =
    将选中单位设为“防御”姿态：
     - 单位会主动攻击视野内敌人
     - 单位不会主动移动或追击敌人

button-stance-bar-returnfire =
    .tooltip = 还击姿态
    .tooltipdesc =
    将选中单位设为“还击”姿态：
     - 单位会反击攻击它们的敌人
     - 单位不会主动移动或追击敌人

button-stance-bar-holdfire =
    .tooltip = 停火姿态
    .tooltipdesc =
    将选中单位设为“停火”姿态：
     - 单位不会向敌人开火
     - 单位不会主动移动或追击敌人

button-top-buttons-beacon-tooltip = 放置信标
button-top-buttons-sell-tooltip = 出售
button-top-buttons-power-tooltip = 断电
button-top-buttons-repair-tooltip = 修理

## SupportPowerTimerWidget
support-power-timer = { $support-power }: { $time }

supportpowers-support-powers-palette =
    .ready = 就绪
    .hold = 暂停中

## IngameMenuLogic
menu-ingame =
    .leave = 离开
    .abort = 中止任务
    .restart = 重新开始
    .surrender = 投降
    .load-game = 读取游戏
    .save-game = 保存游戏
    .music = 音乐
    .settings = 设置
    .return-to-map = 返回地图
    .resume = 继续
    .save-map = 保存地图
    .exit-map = 退出地图编辑器
    .encyclopedia = 百科
