#!/bin/bash

# Replace "PJ_DEF(xxx)" with "xxx", for ctags/gtags parsing PJSIP functions correctly.
PJSIP_HOME="$1"

# sed -i "s/PJ_DEF(\(.*\)) \([a-z,A-Z]\)/\1 \2/g" `grep PJ_DEF\( -rl ./test.c`
sed -i "s/PJ_DEF(\(.*\)) \([a-z,A-Z]\)/\1 \2/g" `grep PJ_DEF\( -rl $PJSIP_HOME`

