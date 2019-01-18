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
  app="$starmaker_dir/app/build/outputs/apk/starmaker/debug/productDebug-minApi21-armeabi-v7a*.apk"
elif [ "$prd" = "starmaker" -a "$dbg" = "no" ]; then
  echo "StarMaker     ===> yes"
  echo "Release       ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/starmaker/release/productRelease-minApi21-armeabi-v7a*.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "yes" ]; then
  echo "StarMakerLite ===> yes"
  echo "Debug         ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/thevoice/debug/thevoiceDebug-minApi21-armeabi-v7a*.apk"
elif [ "$prd" = "starmakerlite" -a "$dbg" = "no" ]; then
  echo "StarMakerLite ===> yes"
  echo "Release       ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/thevoice/release/thevoiceRelease-minApi21-armeabi-v7a*.apk"
elif [ "$prd" = "sargam" -a "$dbg" = "yes" ]; then
  echo "Sargam        ===> yes"
  echo "Debug         ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/sargam/debug/sargamDebug-minApi21-armeabi-v7a*.apk"
elif [ "$prd" = "sargam" -a "$dbg" = "no" ]; then
  echo "sargam        ===> yes"
  echo "Release       ===> yes"
  app="$starmaker_dir/app/build/outputs/apk/sargam/release/sargamRelease-minApi21-armeabi-v7a*.apk"

else
  usage
  exit
fi

echo "API           ===> 21"
echo "ARM           ===> v7"
adb install -r $app

# adb install -r ./app/build/outputs/apk/product/debug/productDebug-minApi17-armeabi-v7a.apk
