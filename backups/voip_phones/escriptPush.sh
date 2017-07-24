#/bin/bash

DEST_DIR="/data"
cd $EBINS_HOME/target_scripts

FILE_LIST="procBaseAddr.sh watch.sh"
for FILE in $FILE_LIST
do
    adb push $FILE $DEST_DIR
    echo "$FILE pushed."
done

