#!/bin/bash

# set -x

addr2line="$HOME/Library/Android/sdk/ndk-bundle/toolchains/arm-linux-androideabi-4.9/\
prebuilt/darwin-x86_64/bin/arm-linux-androideabi-addr2line"
ndk_stack="$HOME/Library/Android/sdk/ndk-bundle//prebuilt/darwin-x86_64/bin/ndk-stack"

so_name="libzorro.so"
so_dir_debug="/Volumes/espace/shared_vagrant/rtc_android_51/src/out/Debug/lib"
so_dir_release="/Volumes/espace/shared_vagrant/rtc_android_51/src/out/Release/lib"
so_debug="$so_dir_debug"/"$so_name"
so_release="$so_dir_release"/"$so_name"

usage()
{
  echo ""
  echo "Usage: $0 [OPTION]"
  echo "OPTION: -n, using ndk-stack."
  echo "        -f, file input for ndk-stack (if -n is enabled)."
  echo "        -d, for debug (default option)."
  echo "        -r, for release."
  echo "        -h, for help."
  echo "EXAMPLE:" 
  echo "         $0 -d -n" 
  echo "         $0 -d -n -f xxx.logcat" 
  echo "         $0 0x11 0x22" 
  echo "         $0 -r 0x11 0x22" 
}

arg_num=0
while getopts "nfdrh" option
do
  case $option in
    h) usage
        exit 
    ;;
    n) use_ndk_stack="true"
       let arg_num=arg_num+1 
    ;;
    f) if [ ! "$use_ndk_stack" = "true" ]; then
         echo "Invalid option: f"
         usage
         exit
       else
         ndk_stack_dump="true"
         let arg_num=arg_num+1 
       fi
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
    ?) usage
       exit 1
    ;;
  esac
done

if [ "$build" = "" ]; then
  build="d"
fi

if [ "$use_ndk_stack" = "" ]; then
  use_ndk_stack="false"
fi

if  [ "$ndk_stack_dump" = "" ]; then
  ndk_stack_dump="false"
fi

if [ "$build" = "d" ]; then
  so_dir="$so_dir_debug"
  so="$so_debug"
else
  so_dir="$so_dir_release"
  so="$so_release"
fi

if [ "$use_ndk_stack" = "true" ]; then
  if [ "$ndk_stack_dump" = "false" ]; then
    adb logcat | "$ndk_stack" -sym "$so_dir"
  else
    if [ ! -z "$3" ]; then
      "$ndk_stack" -sym "$so_dir" -dump $3
    else
      help
      exit
    fi
  fi
else
  if [ $arg_num -eq 0 ]; then
    $addr2line -C -f -e $so $1 $2 $3 $4
  elif [ $arg_num -eq 1 ]; then
    $addr2line -C -f -e $so $2 $3 $4 $5
  elif [ $arg_num -eq 2 ]; then
    $addr2line -C -f -e $so $3 $4 $5 $6
  elif [ $arg_num -eq 3 ]; then
    $addr2line -C -f -e $so $4 $5 $6 $7
  else
    echo "Error: too many arguments"
    exit
  fi
fi

