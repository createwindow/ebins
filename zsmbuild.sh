#!/bin/bash

dbg="yes"
prd=""
arg=""
starmaker_dir="$HOME/workspace/code/ushow/starmaker-android-client"
# starmaker_dir="/Volumes/Samsung_T5/starmaker-android-client"
imissyo_dir="$HOME/workspace/code/ushow/voicex-android-client"

usage()
{
  echo ""
  echo "Usage: $0 [OPTION]"
  echo "OPTION: -d, debug."
  echo "        -r, release."
  echo "        -s, StarMaker."
  echo "        -t, StarMakerLite."
  echo "        -g, Sargam."
  echo "        -i, iMissYo."
  echo "        -h, for help."
}

while getopts "drstgih" option
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
      dir="$starmaker_dir"
    ;;
    t) if [ "$prd" = "sargam" ]; then
        usage
        exit 1
      fi
      prd="starmakerlite"
      dir="$starmaker_dir"
    ;;
    g) if [ "$prd" = "starmakerlite" ]; then
        usage
        exit 1
      fi
      prd="sargam"
      dir="$starmaker_dir"
    ;;
    i) if [ "$prd" = "starmakerlite" -o  "$prd" = "sargam" -o "$prd" = "starmaker" ]; then
        echo "$prd"
        usage
        exit 1
      fi
      prd="imissyo"
      dir="$imissyo_dir"
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
  rm -f "$dir/app/build/outputs/apk/product/debug/*.apk"
elif [ "$prd" = "starmaker" -a "$dbg" = "no" ]; then
  echo "StarMaker     ===> yes"
  echo "Release       ===> yes"
  arg="aPR"
  rm  "$dir/app/build/outputs/apk/product/release/*.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "yes" ]; then
  echo "StarMakerLite ===> yes"
  echo "Debug         ===> yes"
  arg="aTD"
  rm  "$dir/app/build/outputs/apk/thevoice/debug/*.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "no" ]; then
  echo "StarMakerLite ===> yes"
  echo "Release       ===> yes"
  arg="aTR"
  rm  "$dir/app/build/outputs/apk/thevoice/release/*.apk"
elif [ "$prd" = "sargam" -a "$dbg" = "yes" ]; then
  echo "sargam        ===> yes"
  echo "Debug         ===> yes"
  arg="assembleSargamDebug"
  rm  "$dir/app/build/outputs/apk/sargam/debug/*.apk"
elif [ "$prd" = "sargam" -a "$dbg" = "no" ]; then
  echo "sargam        ===> yes"
  echo "Release       ===> yes"
  arg="assembleSargamRelease"
  rm  "$dir/app/build/outputs/apk/sargam/release/*.apk"
elif [ "$prd" = "imissyo" -a "$dbg" = "yes" ]; then
  echo "iMissYo       ===> yes"
  echo "Debug         ===> yes"
  arg="aPD"
  rm  "$dir/app/build/outputs/apk/product/debug/*.apk"
elif [ "$prd" = "imissyo" -a "$dbg" = "no" ]; then
  echo "iMissYo       ===> yes"
  echo "Release       ===> yes"
  arg="aPR"
  rm  "$dir/app/build/outputs/apk/product/release/*.apk"
else
  usage
  exit
fi

cd $dir
./gradlew "$arg" -PfastBuild
# ./gradlew "$arg" -PminApi17

