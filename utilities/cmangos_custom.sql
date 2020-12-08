-- -------------------------------
-- CMaNGOS自定义DB更新
-- -------------------------------

-- 该文件包含对数据库内容的SQL更新，这些更新已知与官方/嗅探数据不同
-- 这些更新适用于确保从游戏角度出发的预期功能
-- （使用CMaNGOS核心时，又名“ Blizzlike”）。
--
-- 这些更新不应该是完整数据库转储的一部分（如数据库版本一样）或插入常规文件中
-- SQL更新文件，我们需要保持DB数据作为“纯”尽可能地对它们进行分析和
-- 从中推断出正确的核心行为。
-- 
-- 需要这些更新的可能但非详尽的理由:
--	- CMaNGOS内核没有正确处理这些更新修复的数据(还没有)
--	- 官方/嗅探数据来自于不同的扩展/补丁，并且可能自经典版本以来发生了变化
--	- 来自客户端的官方/嗅探数据与服务器端数据不同
--	- 数据或解析错误


-- -------------------------------
-- Gameobject 自定义修改
-- -------------------------------

-- ============================================================
-- 经典的部分
-- ============================================================
-- Make Moonwell GO server-side (visible by GM only)
UPDATE gameobject_template SET data3=1 WHERE entry=177272; 

-- 将补给箱陷阱的半径设置为零，以防止当玩家到来时触发陷阱(它应该在玩家使用原始围棋时触发)
UPDATE gameobject_template SET data2=0 WHERE entry IN (175534, 175535, 175536, 175537);

-- 让Dawn's的陷阱只被GM看到
UPDATE gameobject_template SET data2=5, data3=0, data8=0 WHERE entry=176110;
-- Dawn's Gambit: add data from GO trap 176110 until we are able to trigger trap GOs without spells
UPDATE gameobject_template SET data2=5, data3=18110, data4=1, data8=1 WHERE entry=177304; 

-- The Demon Seed GO: make it despawnable on use with short autoclose value
UPDATE gameobject_template SET data3=65536, data5=1 WHERE entry=3524;

-- Add missing GO template 175622 spawn by GO Rookery Egg 175124 (guessed data)
DELETE FROM gameobject_template WHERE entry=175622;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`) VALUES
(175622, 6, 477, 'Rookery Egg Spawner', 1, 0, 0, 2, 15745, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- 设置10码半径的夜精灵捕熊器走，因为它需要被SD2脚本触发否则(该脚本还不存在)
UPDATE gameobject_template SET data2=10 WHERE entry=109515;

-- 为Ragnaros GO设置一个70码的直径，因为它需要被SD2脚本触发(而这个脚本还不存在)
UPDATE gameobject_template SET data2=70 WHERE entry=178088;

-- 目前，如果核心所持有的物品不是任务的目标，那么它就不能在特定任务中使用

-- Link Hive'Ashi Pod GO to quest 1126 so it is usable by players on the quest
UPDATE gameobject_template SET data8=1126 WHERE entry=178553; 

-- 链接紫水晶GOs到任务3602，这样玩家可以在任务中使用它们
UPDATE gameobject_template SET data8=3602 WHERE entry IN (152620, 152621, 152622, 152631);

-- Link Crate with Holes, Snufflenose Command Stick and Snufflenose Owner's Manual GOs to quest 1221 so they are usable by players on the quest
UPDATE gameobject_template SET data8=1221 WHERE entry IN (68865, 21530, 21277);

-- Thaurissan Relic - original tbc-db value 0, classic-db (and classic sniff) value 3702 - the quest which involves actually using this object is 3701
UPDATE gameobject_template SET data1=3701 WHERE entry=153556;

UPDATE `gameobject` SET `position_z` = 133.60325 WHERE `guid` = 132224 AND `id` = 176589; -- Black Lotus Sniff Z = -61.28984

-- 使181444(克尔苏加德触发器)在使用时不可使用
UPDATE gameobject_template SET data4=1 WHERE entry=181444;

-- ============================================================
-- TBC的部分
-- ============================================================
-- Hellfire Hot Spot Spreader
UPDATE gameobject_template SET data8=1 WHERE entry=183929; -- set serverside so that it's not visible to players
-- Sealed Tome traps
UPDATE gameobject_template SET data8=1 WHERE entry IN (181831,181838,181840,181842,181844);
-- Corki's Prison - make data match 182351
UPDATE gameobject_template SET data2=19660800 WHERE entry IN (182349,182350);
-- Consuming Flames Trap
UPDATE gameobject_template SET data3=0, data8=1 WHERE entry=178673; -- 21650, 0

-- Zul'Aman - Tanzar's Trunk - Is not subject to group loot per blizzlike data but all the other chests are. Confirmed data in sniff to be 0, however no such issues reported on retail. Confirmation that blizz sends unfixed GO template data???
UPDATE gameobject_template SET data15=1 WHERE entry IN(186648);

-- -------------------------------
-- 物品自定义修改
-- -------------------------------

-- ============================================================
-- 经典的部分
-- ============================================================

-- 魔法玛瑙应该和其他魔法宝石一样有等级=0
UPDATE item_template SET class=0 WHERE entry=5514;

-- -------------------------------
-- 生物自定义修改
-- -------------------------------

-- None

-- -------------------------------
-- 任务自定义修改
-- -------------------------------

-- None
