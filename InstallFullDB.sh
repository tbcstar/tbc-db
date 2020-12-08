#!/bin/bash

####################################################################################################
#
#   简单的帮助程序脚本以插入干净的TBC-DB
#
####################################################################################################

# 需要在每个官方DB/核心版本上进行更改
FULLDB_FILE="TBCDB_1.8.0_VengeanceStrikesBack.sql"
DB_TITLE="v1.8 'Vengeance Strikes Back'"
NEXT_MILESTONES="0.12.4 0.13"

#internal use
SCRIPT_FILE="InstallFullDB.sh"
CONFIG_FILE="InstallFullDB.config"

# testing only
ADDITIONAL_PATH=""

#从$CONFIG_FILE分配和读取的变量
DB_HOST="localhost"
DB_PORT="3306"
DATABASE=""
USERNAME=""
PASSWORD=""
MYSQL=""
CORE_PATH=""
DEV_UPDATES="NO"
FORCE_WAIT="YES"

function create_config {
# (创建)配置文件
cat >  $CONFIG_FILE << EOF
####################################################################################################
# 这是'$SCRIPT_FILE'脚本的配置文件
#
# 你需要插入
#   DB_HOST:      数据库所在的主机
#   DB_PORT:      运行数据库的端口
#   DATABASE:     你的数据库
#   USERNAME:     用户名
#   PASSWORD:     密码
#   CORE_PATH:    你到核心目录的路径(可选:如果你想自动应用剩余的核心更新使用)
#   MYSQL:        你的mysql命令(通常是mysql)
#
####################################################################################################

## 定义mangos数据库驻留的主机(通常是本地主机)
DB_HOST="localhost"

## 定义运行mangos数据库的端口(通常为3306)
DB_PORT="3306"

## 定义要在其中添加干净TBC-DB的数据库
DATABASE="tbcmangos"

## 定义你的用户名
USERNAME="mangos"

## 定义您的密码(建议限制对该文件的读访问!)
PASSWORD="mangos"

## 定义核心文件夹的路径(这是可选的)
##   如果设置了核心更新位于sql/Update从这个命令目录将自动添加
CORE_PATH=""

## 定义你的mysql程序，如果这不同
MYSQL="mysql"

## 如果在应用整个数据库之前需要稍等，请定义
FORCE_WAIT="YES"

## 定义是否需要使用用于处理开发SQL文件的'dev'目录
##   将变量设置为“YES”以使用dev目录
DEV_UPDATES="NO"

# 享受使用工具
EOF
}

function display_help {
echo
echo "欢迎使用TBC-DB助手 $SCRIPT_FILE"
echo
echo "在兼容bash的终端(如Git bash)上运行此工具"
echo
echo "要配置该文件，请编辑 $CONFIG_FILE"
echo
}

# 检查配置文件是否存在
if [ ! -f $CONFIG_FILE ]
then
  create_config
  display_help
  exit 1
fi

. $CONFIG_FILE
export MYSQL_PWD="$PASSWORD"
MYSQL_COMMAND="$MYSQL -h$DB_HOST -P$DB_PORT -u$USERNAME $DATABASE"

## Print header
echo
echo "欢迎使用TBC-DB助手 $SCRIPT_FILE"
echo

if [ "$FORCE_WAIT" != "NO" ]
then
  echo "注意: 你的数据库 $DATABASE 将被重置为TBC-DB!"
  echo "请将您的存储库更新!"
  echo "按CTRL+C退出"
  # 显示一个迷你进度条
  for i in {1..10}
  do
   echo -ne .
   sleep 1
  done
  echo .
fi

## Full Database
echo "> 正在处理TBC数据库 $DB_TITLE ..."
$MYSQL_COMMAND < "${ADDITIONAL_PATH}Full_DB/$FULLDB_FILE"
if [[ $? != 0 ]]
then
  echo "ERROR: 无法应用 ${ADDITIONAL_PATH}Full_DB/$FULLDB_FILE"
  exit 1
fi
echo "  $DB_TITLE 正在应用!"
echo
echo

## Updates
echo "> 正在处理数据库更新 ..."
COUNT=0
for UPDATE in "${ADDITIONAL_PATH}Updates/"[0-9]*.sql
do
  if [ -e "$UPDATE" ]
  then
    echo "    追加 $UPDATE"
    $MYSQL_COMMAND < "$UPDATE"
    if [[ $? != 0 ]]
    then
      echo "ERROR: 无法应用 $UPDATE"
      exit 1
    fi
    ((COUNT++))
  fi
done
if [ "$COUNT" != 0 ]
then
  echo "  $COUNT 数据库更新应用成功"
else
  echo "  没有发现任何新的数据库更新应用"
fi
echo
echo

## Instances
echo "> 处理副本文件 ..."
COUNT=0
for INSTANCE in "${ADDITIONAL_PATH}Updates/Instances/"[0-9]*.sql
do
  if [ -e "$INSTANCE" ]
  then
    echo "    追加 $INSTANCE"
    $MYSQL_COMMAND < "$INSTANCE"
    if [[ $? != 0 ]]
    then
      echo "ERROR: 无法应用 $INSTANCE"
      exit 1
    fi
    ((COUNT++))
  fi
done
if [ "$COUNT" != 0 ]
then
  echo "  $COUNT 副本文件应用成功"
else
  echo "  没有找到任何要应用的副本文件"
fi
echo
echo

#
#               Core updates
#

echo "> 试图检索数据库中最近的核心更新 ..."
LAST_CORE_REV=0
CORE_REVS="$(grep -r "^.*required_s[0-9]*.* DEFAULT NULL" ${ADDITIONAL_PATH}Full_DB/* | sed 's/.*required_s\([0-9]*\).*/\1/') "
CORE_REVS+=$(grep -ri '.*alter table.*required_s' ${ADDITIONAL_PATH}Updates/* | sed 's/.*required_s\([0-9]*\).*required_s\([0-9]*\).*/\1 \2/')
if [ "$CORE_REVS" != "" ]
then
  for rev in $CORE_REVS
  do
    if [ "$rev" -gt "$LAST_CORE_REV" ]
    then
      LAST_CORE_REV=$rev
    fi
  done
fi

if [ "$LAST_CORE_REV" -eq "0" ]
then
  echo "ERROR: 无法获得数据库中的最新核心修订版"
  exit 1
else
  echo "  在DB中发现最近的核心修订是 $LAST_CORE_REV"
fi
echo
echo

# process future release folders
if [ "$CORE_PATH" != "" ]
then
  if [ ! -e $CORE_PATH ]
  then
    echo "提供了到核心的路径，但是没有找到目录! $CORE_PATH"
    exit 1
  fi
  UPD_PROCESSED=0
  UPD_FOUND=0

  for NEXT_MILESTONE in ${NEXT_MILESTONES};
  do
    # A new milestone was released, apply additional updates
    if [ -e ${CORE_PATH}/sql/updates/${NEXT_MILESTONE}/ ]
    then
      echo "> 尝试从里程碑 $NEXT_MILESTONE 应用核心更新..."
      for f in "${CORE_PATH}/sql/archives/${NEXT_MILESTONE}/"s*_mangos_*.sql
      do
        CUR_REV=$(basename $f | sed 's/^s\([0-9]*\)_.*/\1/')
        if [ "$CUR_REV" -gt "$LAST_CORE_REV" ]
        then
          # found a newer core update file
          echo "    追加核心更新 `basename $f` 到数据库 $DATABASE"
          $MYSQL_COMMAND < $f
          if [[ $? != 0 ]]
          then
            echo "ERROR: 无法应用 $f"
            exit 1
          fi
          ((UPD_PROCESSED++))
        else
          ((UPD_FOUND++))
        fi
      done
    fi
  done

  # 应用主文件夹中的剩余文件
  echo "> 尝试从路径 $CORE_PATH 应用其他核心更新..."
  for f in "$CORE_PATH/sql/updates/mangos/"*_mangos_*.sql
  do
    CUR_REV=$(basename "$f" | sed 's/^s\([0-9]*\).*/\1/')
    if [ "$CUR_REV" -gt "$LAST_CORE_REV" ]
    then
      # found a newer core update file
      echo "    追加核心更新 `basename $f` 到数据库 $DATABASE"
      $MYSQL_COMMAND < $f
      if [[ $? != 0 ]]
      then
        echo "ERROR: 无法应用 $f"
        exit 1
      fi
      ((UPD_PROCESSED++))
    else
      ((UPD_FOUND++))
    fi
  done
  echo "  已完成核心更新: $UPD_PROCESSED"
  echo "  已在DB中找到核心更新: $UPD_FOUND"
  echo
  echo

  # 应用dbc文件夹
  echo "> 尝试应用 $CORE_PATH/sql/base/dbc/original_data ..."
  for f in "$CORE_PATH/sql/base/dbc/original_data/"*.sql
  do
    echo "    追加DBC文件更新 `basename $f` 到数据库 $DATABASE"
    $MYSQL_COMMAND < $f
    if [[ $? != 0 ]]
    then
      echo "ERROR: 无法应用 $f"
      exit 1
    fi
  done
  echo "  成功应用DBC数据"
  echo
  echo
  # 应用dbc更改(对已知错误/缺失数据的特定修复)
  echo "> 尝试应用 $CORE_PATH/sql/base/dbc/cmangos_fixes ..."
  for f in "$CORE_PATH/sql/base/dbc/cmangos_fixes/"*.sql
  do
    echo "    追加CMaNGOS DBC文件修复 `basename $f` 到数据库 $DATABASE"
    $MYSQL_COMMAND < $f
    if [[ $? != 0 ]]
    then
      echo "ERROR: 无法应用 $f"
      exit 1
    fi
  done
  echo "  成功应用DBC更改"
  echo
  echo

  # 应用ScriptDev2数据
  echo "> 尝试应用 $CORE_PATH/sql/scriptdev2 ..."
  for f in "$CORE_PATH/sql/scriptdev2/"*.sql
  do
    echo "    追加SD2文件更新 `basename $f` 到数据库 $DATABASE"
    $MYSQL_COMMAND < $f
    if [[ $? != 0 ]]
    then
      echo "ERROR: 无法应用 $f"
      exit 1
    fi
  done
  echo "  ScriptDev2数据已成功应用"
  echo
  echo
fi

#
#               ACID Full file
#
# 应用 acid_tbc.sql
echo "> 尝试应用 ${ADDITIONAL_PATH}ACID/acid_tbc.sql ..."
$MYSQL_COMMAND < ${ADDITIONAL_PATH}ACID/acid_tbc.sql
if [[ $? != 0 ]]
then
  echo "ERROR: 无法应用 ${ADDITIONAL_PATH}ACID/acid_tbc.sql"
  exit 1
fi
echo "  成功应用ACID"
echo
echo

#
#               CMaNGOS自定义更新文件
#
# 应用 cmangos_custom.sql
echo "> 尝试应用 ${ADDITIONAL_PATH}utilities/cmangos_custom.sql ..."
$MYSQL_COMMAND < ${ADDITIONAL_PATH}utilities/cmangos_custom.sql
if [[ $? != 0 ]]
then
  echo "ERROR: 无法应用 ${ADDITIONAL_PATH}utilities/cmangos_custom.sql"
  exit 1
fi
echo "  CMaNGOS自定义更新已成功应用"
echo
echo

#
#    开发者更新
#
if [ "$DEV_UPDATES" == "YES" ]
then
  echo "> 尝试应用开发更新 ..."
  for UPDATEFILE in ${ADDITIONAL_PATH}dev/*.sql
  do
    if [ -e "$UPDATEFILE" ]
    then
        for UPDATE in ${ADDITIONAL_PATH}dev/*.sql
        do
            echo "    进程更新 $UPDATE"
            $MYSQL_COMMAND < $UPDATE
            [[ $? != 0 ]] && exit 1
        done
        echo "  已完成开发更新应用"
    else
        echo "  没有要处理的开发更新"
    fi
    break
  done
  for UPDATEFILE in ${ADDITIONAL_PATH}dev/*/*.sql
  do
    if [ -e "$UPDATEFILE" ]
    then
        for UPDATE in ${ADDITIONAL_PATH}dev/*/*.sql
        do
            echo "    进程更新 $UPDATE"
            $MYSQL_COMMAND < $UPDATE
            [[ $? != 0 ]] && exit 1
        done
        echo "  已应用开发子更新"
    else
        echo "  没有开发子更新要处理"
    fi
    break
  done
  echo
  echo
fi

echo "您现在已经将一个干净且最新的TBC-DB数据库加载到 $DATABASE 中"
echo "享受使用TBC-DB"
echo
