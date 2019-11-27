#!/bin/bash

# set -x

dsym_release="/Volumes/Samsung_T5/rtc_ios_71/src/out/release/ZorroRtcEngineKit.framework.dSYM/Contents/Resources/DWARF/ZorroRtcEngineKit"
dsym_debug="/Volumes/Samsung_T5/rtc_ios_71/src/out/debug/ZorroRtcEngineKit.framework.dSYM/Contents/Resources/DWARF/ZorroRtcEngineKit"

usage()
{
  echo ""
  echo "Usage: $0 [OPTION]"
  echo "OPTION: -d, for debug (default option)."
  echo "        -r, for release."
  echo "        -6, for arch arm64."
  echo "        -h, for help."
  echo "EXAMPLE:" 
  echo "         $0 0x11 0x22" 
  echo "         $0 -r 0x11 0x22" 
  echo "         $0 -r -6 0x11 0x22" 
}

arch="armv7"
arg_num=0
while getopts "dr6h" option
do
  case $option in
    h) usage
        exit
    ;;
    d) if [ "$build" = "r" ]; then
         echo "Invalid option: d"
         usage
         exit
       else
         build="d"
         let arg_num=arg_num+1
       fi
    ;;
    r) if [ "$build" = "d" ]; then
         echo "Invalid option: r"
         usage
         exit
       else
         build="r"
         let arg_num=arg_num+1
       fi
    ;;
    6) arch="arm64"
        let arg_num=arg_num+1
    ;;
    ?) usage
       exit 1
    ;;
  esac
done

if [ "$build" = "" ]; then
  build="d"
fi

if [ "$build" = "d" ]; then
  dsym="$dsym_debug"
else
  dsym="$dsym_release"
fi

if [ $arg_num -eq 0 ]; then
  atos -o $dsym -arch $arch -fullPath $1 $2 $3 $4
elif [ $arg_num -eq 1 ]; then
  atos -o $dsym -arch $arch -fullPath $2 $3 $4 $5
elif [ $arg_num -eq 2 ]; then
  atos -o $dsym -arch $arch -fullPath $3 $4 $5 $6
elif [ $arg_num -eq 3 ]; then
  atos -o $dsym -arch $arch -fullPath $4 $5 $6 $7
else
  echo "Error: too many arguments"
  exit
fi

