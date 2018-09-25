#!/bin/bash

starmaker_dir="/Users/guoyi/mywork/ushow/starmaker-android-client"
dbg="yes"
prd="starmaker"
arg=""
starmaker_dir="/Users/guoyi/mywork/ushow/starmaker-android-client"

usage()
{
  echo ""
  echo "Usage: $0 [OPTION]"
  echo "OPTION: -d, debug."
  echo "        -r, release."
  echo "        -s, StarMaker."
  echo "        -t, StarMakerLite."
  echo "        -h, for help."
}

while getopts "drsth" option
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
    s) if [ "$prd" = "starmakerlite" ]; then
        usage
        exit 1
      fi
      prd="starmaker"
    ;;
    t) prd="starmakerlite"
    ;;
    ?) usage
       exit 1
    ;;
  esac
done

if [ "$prd" = "starmaker" -a "$dbg" = "yes" ]; then
  echo "StarMaker     ===> yes"
  echo "Debug         ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/product/debug/productDebug-minApi21-armeabi-v7a.apk"
elif [ "$prd" = "starmaker" -a "$dbg" = "no" ]; then
  echo "StarMaker     ===> yes"
  echo "Release       ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/product/release/productRelease-minApi21-armeabi-v7a.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "yes" ]; then
  echo "StarMakerLite ===> yes"
  echo "Debug         ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/thevoice/debug/thevoiceDebug-minApi21-armeabi-v7a.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "no" ]; then
  echo "StarMakerLite ===> yes"
  echo "Release       ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/thevoice/release/thevoiceRelease-minApi21-armeabi-v7a.apk"
else
  usage
  exit
fi

echo "API           ===> 21"
echo "ARM           ===> v7"
adb install -r $app

# adb install -r ./app/build/outputs/apk/product/debug/productDebug-minApi17-armeabi-v7a.apk
