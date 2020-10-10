#!/bin/bash

# starmaker_dir="/Users/guoyi/mywork/ushow/starmaker-android-client"
dbg="yes"
prd=""
arg=""
# starmaker_dir="/Volumes/Samsung_T5/starmaker-android-client"
starmaker_dir="$HOME/workspace/code/ushow/starmaker-android-client"
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
  echo "        -m, arm64."
  echo "        -p, just show apk dir."
  echo "        -h, for help."
}

while getopts "drstgimph" option
do
  case $option in
    h) usage
        exit 
    ;;
    m) arm64="yes"
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
        usage
        exit 1
      fi
      prd="imissyo"
      dir="$imissyo_dir"
    ;;
    p) only_position="yes"
    ;;
    ?) usage
       exit 1
    ;;
  esac
done

if [ "$prd" = "starmaker" -a "$dbg" = "yes" ]; then
  echo "StarMaker     ===> yes"
  echo "Debug         ===> yes"
  app="$dir/app/build/outputs/apk/product/debug/productDebug-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/product/debug/productDebug-minApi21-arm64-v8a.apk"
  fi
elif [ "$prd" = "starmaker" -a "$dbg" = "no" ]; then
  echo "StarMaker     ===> yes"
  echo "Release       ===> yes"
  app="$dir/app/build/outputs/apk/product/release/productRelease-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/product/release/productRelease-minApi21-arm64-v8a.apk"
  fi
elif [ "$prd" = "starmakerlite" -a "$dbg" = "yes" ]; then
  echo "StarMakerLite ===> yes"
  echo "Debug         ===> yes"
  app="$dir/app/build/outputs/apk/thevoice/debug/thevoiceDebug-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/thevoice/debug/thevoiceDebug-minApi21-arm64-v8a.apk"
  fi
elif [ "$prd" = "starmakerlite" -a "$dbg" = "no" ]; then
  echo "StarMakerLite ===> yes"
  echo "Release       ===> yes"
  app="$dir/app/build/outputs/apk/thevoice/release/thevoiceRelease-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/thevoice/release/thevoiceRelease-minApi21-arm64-v8a.apk"
  fi
elif [ "$prd" = "sargam" -a "$dbg" = "yes" ]; then
  echo "Sargam        ===> yes"
  echo "Debug         ===> yes"
  app="$dir/app/build/outputs/apk/sargam/debug/sargamDebug-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/sargam/debug/sargamDebug-minApi21-arm64-v8a.apk"
  fi
elif [ "$prd" = "sargam" -a "$dbg" = "no" ]; then
  echo "sargam        ===> yes"
  echo "Release       ===> yes"
  app="$dir/app/build/outputs/apk/sargam/release/sargamRelease-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/sargam/release/sargamRelease-minApi21-arm64-v8a.apk"
  fi
elif [ "$prd" = "imissyo" -a "$dbg" = "yes" ]; then
  echo "iMissYo       ===> yes"
  echo "Debug         ===> yes"
  app="$dir/app/build/outputs/apk/product/debug/imissyoDebug-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/sargam/debug/imissyoDebug-minApi21-arm64-v8a.apk"
  fi
elif [ "$prd" = "imissyo" -a "$dbg" = "no" ]; then
  echo "iMissYo       ===> yes"
  echo "Release       ===> yes"
  app="$dir/app/build/outputs/apk/product/release/imissyoDebug-minApi21-armeabi-v7a.apk"
  if [ "$arm64" = "yes" ]; then
    app="$dir/app/build/outputs/apk/sargam/release/imissyoDebug-minApi21-arm64-v8a.apk"
  fi
else
  usage
  exit
fi

echo "API           ===> 21"
echo "ARM           ===> v7"
echo "$app"
if [ ! "$only_position" = "yes" ]; then
  adb install -r $app
fi

# adb install -r ./app/build/outputs/apk/product/debug/productDebug-minApi17-armeabi-v7a.apk
