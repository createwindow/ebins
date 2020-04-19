#!/bin/bash

# set -x

sdk_framework="ZorroRtcEngineKit.framework"
sdk_dsym="ZorroRtcEngineKit.framework.dSYM"

# webrtc_71_home="$HOME/mywork/rtc_ios_71/src"
webrtc_71_home="/Volumes/Samsung_T5/rtc_ios_71/src"
webrtc_home="$webrtc_71_home"

dir_out_rls="$webrtc_home/out/release"
dir_out_dbg="$webrtc_home/out/debug"

usage()
{
    echo ""
    echo "Usage: $0 [OPTION]"
    echo "OPTION: -t, for test app (default option);"
    echo "        -p, for product app."
    echo "        -d, for debug (default option)."
    echo "        -r, for release."
    echo "        -h, for help."
}

while getopts "tpdr" option
do
    case $option in
        h)  usage
            exit 
        ;;
        t)  if [ "$for_app" = "p" ]; then
                echo "Invalid option: t"
                usage
                exit
            else
                for_app="t"
            fi
        ;;
        p)  if [ "$for_app" = "t" ]; then
                echo "Invalid option: p"
                usage
                exit
            else
                for_app="p"
            fi
        ;;
        d)  if [ "$build" = "r" ]; then
                echo "Invalid option: d"
                usage
                exit
            else
                build="d"
            fi
        ;;
        r)  if [ "$build" = "d" ]; then
                echo "Invalid option: r"
                usage
                exit
            else
                build="r"
                strip="true"
            fi
        ;;
        ?)  usage
            exit 1
        ;;
    esac
done

if [ "$for_app" = "" ]; then
    for_app="t"
fi

if [ "$build" = "" ]; then
    build="d"
fi

printf -- '\n\033[35mfor_app=%s build=%s strip=%s \033[0m \n\n' $for_app $build $strip;

if [ $build = "r" ]; then
    dir_out=$dir_out_rls 
else
    dir_out=$dir_out_dbg
fi

src_framework="$dir_out/$sdk_framework"
src_dsym="$dir_out/$sdk_dsym"

if [ $for_app = "t" ]; then
# ================== TEST APP ===================
client_app="/Volumes/Samsung_T5/rtc_ios_client"
dir_framework_in_app="WebRTCDemo/3rdparty"
dir_dsym_in_app="$dir_framework_in_app"
# ================== TEST APP ===================
elif [ $for_app = "p" ]; then
# ================== StarMaker APP ===================
client_app="$HOME/workspace/code/ushow/starmaker-ios-client"
dir_framework_in_app="StarMaker/Feature/Live/ThirdParty/zorro"
dir_dsym_in_app="$dir_framework_in_app"
# ================== StarMaker APP ===================
fi

dst_framework="$client_app/$dir_framework_in_app"
dst_dsym="$client_app/$dir_dsym_in_app"

rm -rf $dst_framework/sdk_framework
echo "$src_framework ---> $dst_framework ..."
cp -R $src_framework      $dst_framework

if [ $for_app = "t" ]; then
  rm -rf $dst_dsym/$sdk_dsym
  echo "$src_dsym ---> $dst_dsym ..."
  cp -R $src_dsym      $dst_dsym
fi

