#!/bin/bash

out="/shared/rtc_android_72/src/out"

chmod 777 $out/debug
chmod 777 $out/debug/arm64-v8a $out/debug/armeabi-v7a
chmod 777 $out/debug/arm64-v8a/libzorro.so $out/debug/armeabi-v7a/libzorro.so
chmod 777 $out/debug/arm64-v8a/lib.unstripped $out/debug/armeabi-v7a/lib.unstripped
chmod 777 $out/debug/arm64-v8a/lib.unstripped/libzorro.so $out/debug/armeabi-v7a/lib.unstripped/libzorro.so

chmod 777 $out/release
chmod 777 $out/release/arm64-v8a $out/release/armeabi-v7a
chmod 777 $out/release/arm64-v8a/libzorro.so $out/release/armeabi-v7a/libzorro.so
chmod 777 $out/release/arm64-v8a/lib.unstripped $out/release/armeabi-v7a/lib.unstripped
chmod 777 $out/release/arm64-v8a/lib.unstripped/libzorro.so  $out/release/armeabi-v7a/lib.unstripped/libzorro.so
