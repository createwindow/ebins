#!/bin/bash

dbg="yes"
prd="starmaker"
arg=""
starmaker_dir="$HOME/workspace/code/ushow/starmaker-android-client"
# starmaker_dir="/Volumes/Samsung_T5/starmaker-android-client"

usage()
{
  echo ""
  echo "Usage: $0 [OPTION]"
  echo "OPTION: -d, debug."
  echo "        -r, release."
  echo "        -s, StarMaker."
  echo "        -t, StarMakerLite."
  echo "        -g, Sargam."
  echo "        -h, for help."
}

while getopts "drstgh" option
do
  case $option in
    h) usage
        exit 
    ;;
    d) if [ "$dbg" = "no" ]; then
        usage
        exit 1
      fi
      dbg="yes"
    ;;
    r) dbg="no"
    ;;
    s) if [ "$prd" = "starmakerlite" -o  "$prd" = "sargam" ]; then
        usage
        exit 1
      fi
      prd="starmaker"
    ;;
    t) if [ "$prd" = "sargam" ]; then
        usage
        exit 1
      fi
      prd="starmakerlite"
    ;;
    g) if [ "$prd" = "starmakerlite" ]; then
        usage
        exit 1
      fi
      prd="sargam"
    ;;
    ?) usage
       exit 1
    ;;
  esac
done

if [ "$prd" = "starmaker" -a "$dbg" = "yes" ]; then
  echo "StarMaker     ===> yes"
  echo "Debug         ===> yes"
  arg="aPD"
  rm -f "$starmaker_dir/app/build/outputs/apk/product/debug/*.apk"
elif [ "$prd" = "starmaker" -a "$dbg" = "no" ]; then
  echo "StarMaker     ===> yes"
  echo "Release       ===> yes"
  arg="aPR"
  rm  "$starmaker_dir/app/build/outputs/apk/product/release/*.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "yes" ]; then
  echo "StarMakerLite ===> yes"
  echo "Debug         ===> yes"
  arg="aTD"
  rm  "$starmaker_dir/app/build/outputs/apk/thevoice/debug/*.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "no" ]; then
  echo "StarMakerLite ===> yes"
  echo "Release       ===> yes"
  arg="aTR"
  rm  "$starmaker_dir/app/build/outputs/apk/thevoice/release/*.apk"
elif [ "$prd" = "sargam" -a "$dbg" = "yes" ]; then
  echo "sargam        ===> yes"
  echo "Debug         ===> yes"
  arg="assembleSargamDebug"
  rm  "$starmaker_dir/app/build/outputs/apk/sargam/debug/*.apk"
elif [ "$prd" = "sargam" -a "$dbg" = "no" ]; then
  echo "sargam        ===> yes"
  echo "Release       ===> yes"
  arg="assembleSargamRelease"
  rm  "$starmaker_dir/app/build/outputs/apk/sargam/release/*.apk"
else
  usage
  exit
fi

cd $starmaker_dir
./gradlew "$arg" -PfastBuild
# ./gradlew "$arg" -PminApi17

