#!/bin/bash
# @desc: 当前时间戳、日期显示；时间戳转日期、时间戳转日期
# 显示当前系统时区日期和时间戳：  ./ets.sh
# 系统时区日期转时间戳：  ./ets.sh "2018-08-08 12:37:07"
# 时间戳转系统时区日期：  ./ets.sh 1533703027

user_input=$1
if [ -z "${user_input}" ];
then
    echo "now:"
    date "+%Y-%m-%d %H:%M:%S"
    date +%s
else
    #用长度判断用户输入是 时间戳还是格式化日期
    if [ "${#user_input}" -lt 15 ];
    then
        date -j -f "%s" "${user_input}" "+%Y-%m-%d %H:%M:%S"
    else
        date -j -f "%Y-%m-%d %H:%M:%S" "${user_input}" "+%s"
    fi
fi
