TBC-DB for CMaNGOS/mangos-tbc
======================
A content database for [mangos-tbc][10], and *World of Warcraft Client Patch
2.4.3* - [_Fury of the Sunwell_][50]. It is compatible only with client 2.4.3 (build 8606).

**TBC-DB** is released under the GPL v3.  The file (`LICENSE.md`)
**must** be a part of any redistributable packages made from this software.  No
licenses should be removed from this software if you are making redistributable
copies.

**TBC-DB** contains copyrighted materials that are not part of the GPL v3.
Informations about copyrighted materials are located in the file (`COPYRIGHT.md`).

World of Warcraft content and materials are trademarks and copyrights of Blizzard or its licensors. All rights reserved.
**TBC-DB** is part of CMaNGOS project and is not affiliated with Blizzard or its licensors.

Compatibility
-------------
The *TBC-DB* database is compatible with [mangos-tbc][10] core only.

准备开始
---------------
该数据库存储库的基本原理是拥有一个SQL文件，该文件保存数据库中的每个表。
将某些内容更改为数据库后，将通过在updates目录中添加小的SQL更新文件来完成修改。
每当用户（可能是您或TBC-DB开发人员）希望将某些内容更改到数据库中时，
他/她都必须创建并添加正确的SQL文件。这有助于跟踪在何时何地进行了哪些更改。

安装
------------
TBC-DB是以下内容的主要内容数据库：tbcmangos通过生物，物品，物体，任务等来定义世界。

必须从CMaNGOS Project的tbcmangosCMaNGOS核心发行版mangos-tbc创建数据库后才能应用它。

如果在安装mangos核心时使用了默认值，则只需在以下命令中运行兼容bash的shell（例如Windows的Bash Git）即可./InstallFullDB.sh。

它将创建一个文件InstallFullDB.config。

如果您已修改用于连接数据库的默认值，则要使用此数据库存储库，您将必须InstallFullDB.config根据配置MySQL服务器的方式打开，并在所需的数据库，用户名和密码中进行编辑。对于芒果核心默认值是username:mangos，password:mangos，database:mangos。出于安全原因，强烈建议使用其他用户名和密码。

一旦在MySQL中配置了所需的数据库用户和权限，就可以再次运行该./InstallFullDB.sh命令以将各个数据表加载到数据库中，填充它们并应用自上一个里程碑以来的所有更新。

有关完整的安装指南，请参阅CMaNGOS安装说明。

Contributing
------------
You are welcome to contribute to this database project. There are three main ways of contributing. Choose the one fitting your skills.

1. Open a ticket/issue on [CMaNGOS issue tracker][15] on GitHub. Describe the issue as accurately as
possible, how things currently are, how things should be instead. Example: "NPC Mighty Skeleton in Western Plaguelands does not wield its weapon. It should have a sword.". You can improve your issue report by giving the ID/entry of the creature, object, quest, spell... it helps developers to find quickly where is the problem. In-game GM commands like `.guid`, `.lookup quest (or creature, spell, object)`, `.gobject near (or target)` are great to get those informations
2. If you have SQL knowledge you can also open a ticket/issue and provide a fix, even partial. To help you to understand the DB structure, have a look a the [wiki page][16] or feel free to ask developers in the issue report. You can also try to fix currently open issues
3. Make a pull request. If you feel like [cloning the database repository][17], you can test your own fixes and [do a pull request][18] that will be reviewed and discussed with you before merging

Whenever possible, provide sources about the issue to help developers to get a better understanding of the issue (wowwiki, wowpedia, wowhead, official data...). Note that everything coming from private servers *is not* a reliable source.

Note that the more complete your contribution is (i.e. close to a pull request), the quicker it will become part of the database.
But as this is a community project, the developers will always try to help you move through the various stages of contributing!

[1]: https://github.com/cmangos/mangos-tbc "mangos-tbc"

[10]: https://github.com/cmangos/mangos-tbc/ "mangos tbc"
[12]: https://github.com/cmangos/tbc-db/ "content database"
[13]: http://www.cmangos.net/ "CMaNGOS Project"
[14]: https://github.com/cmangos/issues/wiki/Installation-Instructions "CMaNGOS installation instructions"
[15]: https://github.com/cmangos/issues/issues/ "CMaNGOS issue tracker"
[16]: https://github.com/cmangos/issues/wiki/mangosdb_struct
[17]: https://help.github.com/articles/fork-a-repo/
[18]: https://help.github.com/articles/creating-a-pull-request/

[50]: http://eu.blizzard.com/en-gb/games/wow/ "World of Warcraft"
[51]: http://www.wowpedia.org/Patch_2.4.3 "WoW 2.4.3 - Fury of the Sunwell"

[101]: http://github.com/ "github - social coding"
