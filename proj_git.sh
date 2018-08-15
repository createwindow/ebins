#!/bin/bash

arcconfig="./.arcconfig"
upstream_branch="upstream"
develop_branch="develop"
initial_branch="initial"

help()
{
    echo ""
    echo "UASGE"
    echo "        ./proj.sh [--os] <repository> <directory> "
    echo ""
}

repo_clone()
{
    git clone "$1" "$2"
}

arcconfig_gen()
{
    echo "{" >> $arcconfig
    echo "    \"phabricator.uri\" : \"https://phabricator.ushow.media/\"" >> $arcconfig
    echo "}" >> $arcconfig
}

if [ "$1" = "" ];then
    help 
    exit 
fi

init()
{
    if [ "$1" = "" ]; then
        help
        return
    elif [ "$1" = "--os" ]; then
        if [ "$2" = "" -o "$3" = "" ]; then
            help
            return
        fi
        upstream=yes
        repo=$2
        dir=$3
    else
        if [ "$1" = "" -o "$2" = "" ]; then
            help
            return
        fi
        repo=$1
        dir=$2
    fi
    
    repo_clone "$repo" "$dir"
    cd "$dir"
    arcconfig_gen
    git add $arcconfig
    git commit -m "add .arcconfig"
    git push origin master
    git branch $develop_branch master
    git branch $initial_branch $develop_branch 
    git push origin $develop_branch $initial_branch
    git branch -u origin/$develop_branch $develop_branch
    git branch -u origin/$initial_branch $initial_branch
    if [ "$upstream" = "yes" ]; then
        git branch $upstream_branch master
        git push origin $upstream_branch
        git branch -u origin/$upstream_branch $upstream_branch
    fi
}

init $1 $2 $3

