REPLACE INTO spell_script_target(entry, type, targetEntry, inverseEffectMask) VALUES
(40821,1,23310,0),
(40824,1,23323,0),
(40675,1,23278,0);

INSERT INTO gameobject(guid, id, map, spawnMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecsmin, spawntimesecsmax, animprogress, state) VALUES
('165008', '185319', '530', '1', '2704.23', '7093.49', '364.978', '1.04337', '0', '0', '0.49834', '0.866982', '-30', '-30', '100', '1'),
('165009', '185319', '530', '1', '2753.27', '7126.18', '365.783', '1.05985', '0', '0', '0.505469', '0.862845', '-32', '-32', '100', '1'),
('165010', '185319', '530', '1', '2691.3', '7138.98', '364.625', '0.872928', '0', '0', '0.422738', '0.906252', '-34', '-34', '100', '1'),

('165011', '185317', '530', '1', '2706.38', '7109.67', '366.645', '1.11798', '0', '0', '0.53033', '0.847792', '-3600', '-3600', '100', '1'),
('165012', '185319', '530', '1', '2719.56', '7101.63', '366.646', '1.39286', '0', '0', '0.641483', '0.767137', '-3600', '-3600', '100', '1'),
('165013', '185319', '530', '1', '2703.45', '7117.77', '371.337', '1.46983', '0', '0', '0.670524', '0.741888', '-3600', '-3600', '100', '1'),
('165014', '185319', '530', '1', '2726.29', '7111.26', '381.055', '2.6283', '0', '0', '0.967246', '0.25384', '-3600', '-3600', '100', '1'),
('165015', '185319', '530', '1', '2728.29', '7124.96', '378.587', '3.2684', '0', '0', '0.997991', '-0.0633595', '-3600', '-3600', '100', '1'),
('165016', '185319', '530', '1', '2720.67', '7133.52', '366.646', '4.50538', '0', '0', '0.776382', '-0.630263', '-3600', '-3600', '100', '1');

UPDATE creature_template SET InhabitType=7 WHERE entry IN(23059,23260,23500);

-- per script auras hence deletion
DELETE FROM creature_template_addon WHERE entry IN(23409,23310);

-- felguard degrader
REPLACE INTO creature_template_spells(entry, setId, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, spell9, spell10) VALUES
(23055,0,40220,40219,0,40221,40497, 0,40222, 0,0,40658);
UPDATE creature_template SET MovementType=2,SpeedRun=6/7,SpeedWalk=2.5/2.5,UnitFlags=33088 WHERE entry IN(23055);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`,MovementType) VALUES
(165070, 23055, 530, 1, 2698.0789,7144.136,363.9454, 5.864306449890136718, 3600,3600,2);
INSERT INTO creature_movement_template(entry, pathId, point, position_x, position_y, position_z, orientation, waittime, script_id, comment) VALUES
(23055,0,1,2714.206,7155.271,364.9454,100,0,0,''),
(23055,0,2,2746.0994,7132.8657,366.66104,100,0,0,''),
(23055,0,3,2751.7275,7116.828,364.53604,100,0,0,''),
(23055,0,4,2728.3975,7079.55,365.1837,100,0,0,''),
(23055,0,5,2712.4624,7070.4985,364.5587,100,0,0,''),
(23055,0,6,2696.378,7083.818,364.82578,100,0,0,''),
(23055,0,7,2683.325,7106.382,364.8019,100,0,0,''),
(23055,0,8,2687.7502,7134.1475,364.3204,100,0,0,''),
(23055,0,9,2698.0789,7144.136,363.9454,100,0,0,'');
REPLACE INTO spell_script_target(entry, type, targetEntry, inverseEffectMask) VALUES
(39985,1,23055,0),
(40309,1,23055,0),
(40382,1,23113,0),
(40523,1,23220,0),
(40222,1,23116,0);

-- possession transfer
REPLACE INTO spell_script_target(entry, type, targetEntry, inverseEffectMask) VALUES
(40503,1,23055,0),
(41962,1,23113,0);

-- doomguard punisher
UPDATE creature_template SET UnitFlags=33555200 WHERE entry IN(23113);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `spawndist`) VALUES
(165071, 23113, 530,  1, 2719.868408203125, 7118.2900390625, 367.393798828125, 2.757620096206665039, 3600,3600,0);
REPLACE INTO creature_template_spells(entry, setId, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, spell9, spell10) VALUES
(23113,0,40560,40561,0,40563,40565, 0,40493, 0,0,40659);

-- shivan assassin
UPDATE creature_template SET UnitFlags=33555200 WHERE entry IN(23220);
REPLACE INTO creature_template_spells(entry, setId, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, spell9, spell10) VALUES
(23220,0,40736,41597,40737,0,0,41593,41594,0,0,40741),
(23220,1,41578,41596,41589,0,0,41595,41594,0,0,40741),
(23220,2,41579,40727,41590,0,0,41593,41595,0,0,40741);

-- legion ring fog
INSERT INTO gameobject(guid, id, map, spawnMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecsmin, spawntimesecsmax) VALUES
(165000, 185593, 530, 1, 2746.94970703125, 7058.314453125, 365.6990966796875, -2.4085543155670166, 0, 0, -0.93358039855957031, 0.358368009328842163,300,300),
(165001, 185593, 530, 1, 2709.848876953125, 7176.9287109375, 365.082122802734375, -2.28637886047363281, 0, 0, -0.90996074676513671, 0.414694398641586303,300,300),
(165002, 185593, 530, 1, 2691.05908203125, 7169.12060546875, 365.026031494140625, -2.9844982624053955, 0, 0, -0.99691677093505859, 0.078466430306434631,300,300),
(165003, 185593, 530, 1, 2728.8203125, 7054.16552734375, 364.6177978515625, 1.448621988296508789, 0, 0, 0.662619590759277343, 0.748956084251403808,300,300),
(165004, 185593, 530, 1, 2785.76123046875, 7141.00537109375, 365.608306884765625, 1.553341388702392578, 0, 0, 0.700908660888671875, 0.713251054286956787,300,300),
(165005, 185593, 530, 1, 2793.702392578125, 7123.61962890625, 365.73089599609375, 1.780234098434448242, 0, 0, 0.7771453857421875, 0.629321098327636718,300,300),
(165006, 185593, 530, 1, 2653.01171875, 7082.4140625, 364.652435302734375, 1.640606880187988281, 0, 0, 0.731352806091308593, 0.6819993257522583,300,300),
(165007, 185593, 530, 1, 2646.74169921875, 7099.4150390625, 365.21844482421875, -3.10665225982666015, 0, 0, -0.999847412109375, 0.017469281330704689,300,300);

-- legion ring invis dummies - NEVER ALTER GUIDS
UPDATE creature_template SET visibilityDistanceType=3,ExtraFlags=ExtraFlags|(0x00001000 + 0x00040000) WHERE entry IN(23059);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `spawndist`) VALUES
(165006, 23059, 530,  1,  2673.309814453125, 7256.97705078125, 364.484954833984375, 5.358160972595214843, 120,120,0),
(165007, 23059, 530,  1,  2610.99560546875, 7158.17626953125, 365.232421875, 4.939281940460205078, 120,120,0),
(165008, 23059, 530,  1,  2640.186767578125, 7089.37158203125, 380.826904296875, 0.383972436189651489, 120,120,0),
(165009, 23059, 530,  1,  2743.690673828125, 7050.56884765625, 369.98248291015625, 1.099557399749755859, 120,120,0),
(165010, 23059, 530,  1,  2788.0244140625, 7135.5322265625, 366.646942138671875, 6.150593280792236328, 120,120,0),
(165011, 23059, 530,  1,  2657.841552734375, 7102.865234375, 366.466766357421875, 4.410363197326660156, 120,120,0),
(165012, 23059, 530,  1,  2733.799072265625, 7059.09814453125, 365.9569091796875, 1.307625651359558105, 120,120,0),
(165013, 23059, 530,  1,  2699.6904296875, 7170.9482421875, 366.384765625, 4.646986007690429687, 120,120,0),
(165014, 23059, 530,  1,  2716.3046875, 7110.63720703125, 378.397247314453125, 1.535889744758605957, 120,120,0),
(165015, 23059, 530,  1,  2737.630126953125, 7048.65380859375, 369.985626220703125, 2.740166902542114257, 120,120,0),
(165016, 23059, 530,  1,  2702.165283203125, 7182.06201171875, 372.310546875, 5.724679946899414062, 120,120,0),
(165017, 23059, 530,  1,  2641.975830078125, 7093.42431640625, 370.56085205078125, 0.959931075572967529, 120,120,0),
(165018, 23059, 530,  1,  2716.810791015625, 7123.8974609375, 381.9453125, 0.890117883682250976, 120,120,0),
(165019, 23059, 530,  1,  2698.5, 7184.1318359375, 382.820770263671875, 5.358160972595214843, 120,120,0),
(165020, 23059, 530,  1,  2646.747314453125, 7087.203125, 366.033599853515625, 3.281219005584716796, 120,120,0),
(165021, 23059, 530,  1,  2729.756103515625, 7133.9970703125, 365.11492919921875, 1.099557399749755859, 120,120,0),
(165022, 23059, 530,  1,  2841.743408203125, 7179.919921875, 365.34954833984375, 6.056292533874511718, 120,120,0),
(165023, 23059, 530,  1,  2719.316162109375, 7117.03857421875, 372.79345703125, 1.221730470657348632, 120,120,0),
(165024, 23059, 530,  1,  2798.247314453125, 7135.8212890625, 380.569305419921875, 3.368485450744628906, 120,120,0),
(165025, 23059, 530,  1,  2710.518798828125, 7101.47021484375, 365.037139892578125, 4.101523876190185546, 120,120,0),
(165026, 23059, 530,  1,  2720.6337890625, 7118.56591796875, 390.681640625, 2.844886541366577148, 120,120,0),
(165027, 23059, 530,  1,  2707.0546875, 7175.10986328125, 366.391021728515625, 3.470639228820800781, 120,120,0),
(165028, 23059, 530,  1,  2798.3125, 7135.76416015625, 380.513671875, 3.420845270156860351, 120,120,0),
(165029, 23059, 530,  1,  2720.6572265625, 7118.38818359375, 364.808502197265625, 1.919862151145935058, 120,120,0),
(165030, 23059, 530,  1,  2809.994873046875, 7194.27099609375, 366.137908935546875, 4.520402908325195312, 120,120,0),
(165031, 23059, 530,  1,  2640.1357421875, 7089.3779296875, 380.880340576171875, 0.314159274101257324, 120,120,0),
(165032, 23059, 530,  1,  2736.756591796875, 7054.98681640625, 366.3319091796875, 4.909610271453857421, 120,120,0),
(165033, 23059, 530,  1,  2640.108642578125, 7089.31640625, 380.78717041015625, 0.331612557172775268, 120,120,0),
(165034, 23059, 530,  1,  2741.514892578125, 7046.78125, 381.3975830078125, 2.30383467674255371, 120,120,0),
(165035, 23059, 530,  1,  2720.707275390625, 7118.52978515625, 387.119415283203125, 4.97418832778930664, 120,120,0),
(165036, 23059, 530,  1,  2696.166259765625, 7180.3203125, 372.2474365234375, 4.171336650848388671, 120,120,0),
(165037, 23059, 530,  1,  2727.377197265625, 7117.9912109375, 381.880859375, 1.780235767364501953, 120,120,0),
(165038, 23059, 530,  1,  2675.72900390625, 7103.96826171875, 364.220672607421875, 1.151917338371276855, 120,120,0),
(165039, 23059, 530,  1,  2796.9560546875, 7131.7275390625, 370.00738525390625, 5.288347721099853515, 120,120,0),
(165040, 23059, 530,  1,  2698.5478515625, 7184.32275390625, 382.842193603515625, 4.97418832778930664, 120,120,0),
(165041, 23059, 530,  1,  2679.14013671875, 7025.615234375, 365.57647705078125, 5.916666030883789062, 120,120,0),
(165042, 23059, 530,  1,  2794.26318359375, 7137.64697265625, 369.997314453125, 2.670353651046752929, 120,120,0),
(165043, 23059, 530,  1,  2761.377685546875, 7127.076171875, 365.47247314453125, 4.15388345718383789, 120,120,0),
(165044, 23059, 530,  1,  2625.68359375, 7059.68310546875, 370.51171875, 5.427973747253417968, 120,120,0),
(165045, 23059, 530,  1,  2720.486328125, 7118.60205078125, 385.396881103515625, 4.014257431030273437, 120,120,0),
(165046, 23059, 530,  1,  2696.384033203125, 7168.09619140625, 366.134765625, 5.495421886444091796, 120,120,0),
(165047, 23059, 530,  1,  2720.54541015625, 7118.66650390625, 388.92303466796875, 6.2657318115234375, 120,120,0),
(165048, 23059, 530,  1,  2791.796142578125, 7125.8779296875, 366.809326171875, 4.959937095642089843, 120,120,0),
(165049, 23059, 530,  1,  2742.82080078125, 7054.6171875, 366.5819091796875, 2.156373500823974609, 120,120,0),
(165050, 23059, 530,  1,  2741.46533203125, 7046.78662109375, 381.363494873046875, 2.356194496154785156, 120,120,0),
(165051, 23059, 530,  1,  2566.70166015625, 7078.59716796875, 366.779266357421875, 1.48352980613708496, 120,120,0),
(165052, 23059, 530,  1,  2704.923095703125, 7125.87158203125, 364.916534423828125, 2.635447263717651367, 120,120,0),
(165053, 23059, 530,  1,  2657.59326171875, 7093.521484375, 366.408599853515625, 3.124608516693115234, 120,120,0),
(165054, 23059, 530,  1,  2774.77685546875, 7215.87744140625, 364.92901611328125, 5.777040004730224609, 120,120,0),
(165055, 23059, 530,  1,  2644.49951171875, 7087.3662109375, 370.490234375, 5.98647928237915039, 120,120,0),
(165056, 23059, 530,  1,  2720.393310546875, 7118.421875, 393.345947265625, 0.366519153118133544, 120,120,0),
(165057, 23059, 530,  1,  2698.490478515625, 7184.18310546875, 382.858001708984375, 4.852015495300292968, 120,120,0),
(165058, 23059, 530,  1,  2731.11669921875, 7076.525390625, 365.219268798828125, 3.211405754089355468, 120,120,0),
(165059, 23059, 530,  1,  2741.490478515625, 7046.80908203125, 381.32598876953125, 2.146754980087280273, 120,120,0),
(165060, 23059, 530,  1,  2723.220458984375, 7123.8896484375, 380.16259765625, 4.171336650848388671, 120,120,0),
(165061, 23059, 530,  1,  2723.76220703125, 7111.38623046875, 381.966705322265625, 0.523598790168762207, 120,120,0),
(165062, 23059, 530,  1,  2706.931396484375, 7153.68310546875, 365.243896484375, 3.665191411972045898, 120,120,0),
(165063, 23059, 530,  1,  2798.307373046875, 7135.75537109375, 380.449951171875, 3.577924966812133789, 120,120,0),
(165064, 23059, 530,  1,  2735.5947265625, 7108.46435546875, 365.023468017578125, 5.724679946899414062, 120,120,0),
(165065, 23059, 530,  1,  2712.518310546875, 7117.578125, 381.820526123046875, 0.959931075572967529, 120,120,0),
(165066, 23059, 530,  1,  2783.120361328125, 7132.931640625, 366.559326171875, 2.464375257492065429, 120,120,0),
(165067, 23059, 530,  1,  2812.93701171875, 6980.07373046875, 364.995635986328125, 5.25344085693359375, 120,120,0),
(165068, 23059, 530,  1,  2783.102783203125, 6985.13720703125, 365.203521728515625, 2.146754980087280273, 120,120,0);

-- overseer shartuul - text npc
UPDATE creature_template SET ModelId2=19595, `UnitFlags` = 33554688 WHERE entry=23063; -- UnitFlags change guessed based on 23228
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`,MovementType,spawndist) VALUES
(165072, 23063, 530, 1, 2720.7197265625, 7118.57275390625, 400.159149169921875, 6.091198921203613281, 120,120,0,0),
(165073, 23063, 530, 1, 2720.5087890625, 7118.55224609375, 367.38104248046875, 1.343903541564941406, 120,120,0,0);

-- fel portal alarm
UPDATE creature_template SET InhabitType=4 WHERE entry IN(23310);

-- warp gate shield
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `spawndist`) VALUES
(165069, 23116, 530, 1, 2720.1474609375, 7117.634765625, 370.161407470703125, 5.864306449890136718, 120,120,0);
UPDATE creature_template SET ModelId1=16480,ModelId2=14501,UnitFlags=33554432,InhabitType=4 WHERE entry IN(23116);

-- eye of shartuul
UPDATE `creature_template` SET `UnitFlags` = 33554688 WHERE `entry` = 23228;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `spawndist`) VALUES
(165101, 23228, 530,  1,  2715.020751953125, 7150.41650390625, 364.84857177734375, 3.141592741012573242, 120,120,0);

-- shartuul
UPDATE creature_loot_template SET ChanceOrQuestChance=10 WHERE item IN(32941,32942);

-- fel eye stalk
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `spawndist`) VALUES
(165074, 23323, 530,  1,  2661.85595703125, 7116.08056640625, 364.81884765625, 0.069813169538974761, 120,120,0),
(165075, 23323, 530,  1,  2765.94287109375, 7108.23974609375, 365.380584716796875, 2.932153224945068359, 120,120,0),
(165076, 23323, 530,  1,  2680.595947265625, 7119.134765625, 365.24493408203125, 0.104719758033752441, 120,120,0),
(165077, 23323, 530,  1,  2708.497314453125, 7147.0693359375, 365.0872802734375, 5.044001579284667968, 120,120,0),
(165078, 23323, 530,  1,  2724.443115234375, 7085.98583984375, 365.05938720703125, 1.623156189918518066, 120,120,0),
(165079, 23323, 530,  1,  2720.76416015625, 7171.126953125, 364.8935546875, 4.607669353485107421, 120,120,0),
(165080, 23323, 530,  1,  2750.74609375, 7123.388671875, 365.726287841796875, 3.298672199249267578, 120,120,0),
(165081, 23323, 530,  1,  2785.990966796875, 7132.04345703125, 365.59259033203125, 3.333578824996948242, 120,120,0),
(165082, 23323, 530,  1,  2771.262939453125, 7090.49609375, 366.265289306640625, 2.670353651046752929, 120,120,0),
(165083, 23323, 530,  1,  2714.682861328125, 7053.255859375, 364.603668212890625, 1.518436431884765625, 120,120,0),
(165084, 23323, 530,  1,  2703.6708984375, 7175.42822265625, 365.73480224609375, 4.939281940460205078, 120,120,0),
(165085, 23323, 530,  1,  2758.40234375, 7070.04345703125, 365.0390625, 2.30383467674255371, 120,120,0),
(165086, 23323, 530,  1,  2676.508544921875, 7075.41943359375, 364.303314208984375, 0.750491559505462646, 120,120,0),
(165087, 23323, 530,  1,  2729.609619140625, 7062.931640625, 364.34063720703125, 1.710422635078430175, 120,120,0),
(165088, 23323, 530,  1,  2768.834716796875, 7123.1806640625, 365.41943359375, 3.228859186172485351, 120,120,0),
(165089, 23323, 530,  1,  2744.436767578125, 7104.27392578125, 366.52532958984375, 2.548180580139160156, 120,120,0),
(165090, 23323, 530,  1,  2753.605712890625, 7088.6669921875, 365.8505859375, 2.286381244659423828, 120,120,0),
(165091, 23323, 530,  1,  2691.811279296875, 7071.34619140625, 365.12359619140625, 1.029744267463684082, 120,120,0),
(165092, 23323, 530,  1,  2695.287353515625, 7139.48681640625, 364.668548583984375, 5.602506637573242187, 120,120,0),
(165093, 23323, 530,  1,  2701.402099609375, 7089.1884765625, 364.855224609375, 0.994837641716003417, 120,120,0),
(165094, 23323, 530,  1,  2689.90625, 7103.5380859375, 364.58349609375, 0.593411922454833984, 120,120,0),
(165095, 23323, 530,  1,  2687.1572265625, 7154.9140625, 365.25018310546875, 5.410520553588867187, 120,120,0),
(165096, 23323, 530,  1,  2755.311767578125, 7140.78759765625, 365.7725830078125, 3.700098037719726562, 120,120,0),
(165097, 23323, 530,  1,  2737.277099609375, 7141.54541015625, 365.505767822265625, 3.996803998947143554, 120,120,0),
(165098, 23323, 530,  1,  2743.630615234375, 7076.92822265625, 365.999267578125, 2.111848354339599609, 120,120,0),
(165099, 23323, 530,  1,  2664.564453125, 7086.8486328125, 364.774444580078125, 0.523598790168762207, 120,120,0),
(165100, 23323, 530,  1,  2729.71533203125, 7153.318359375, 365.595794677734375, 4.258603572845458984, 120,120,0);

-- fel portal alarm
UPDATE creature_template SET UnitFlags=33554688 WHERE entry IN(23310);

-- Legion Ring Event InvisMan Lg
UPDATE creature_template SET ModelId2=19595 WHERE entry IN(23260);

-- teleport locations
INSERT INTO game_tele(position_x, position_y, position_z, orientation, map, name) VALUES
(4011.529053,5892.626465,267.864288,0.263285,530,'BashirLanding'),
(2745.096924,7133.574707,366.522736,0,530,'ShartuulsTransporter'),
(2334.837891,7273.681152,366.146301,2.816611,530,'Ogrila');


