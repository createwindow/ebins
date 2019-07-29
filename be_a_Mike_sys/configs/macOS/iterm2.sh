#!/bin/bash

set -x

location=`pwd`
profile_file="item2.json"
loc_profile_file="$location/$profile_file"
profile_dir="/Users/mike/Library/Application Support/iTerm2/DynamicProfiles"

cd "$profile_dir"

rm -f "$profile_file"

ln -s "$loc_profile_file" "$profile_file"

