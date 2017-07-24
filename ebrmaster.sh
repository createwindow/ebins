#!/bin/bash

usage()
{
    echo ""
    echo "Usage:      $0 <tag>"
    echo "Dscription: merge develop into master with --no-ff, and then push to origin." 
    echo "            Add a tag reference named <tag> to this master commit." 
    echo ""
}
if [ "$1" = "-h" ]; then
    usage
    exit
elif [ "$1" = "" ]; then
    usage
    exit
else
    git checkout -b release-$1 develop
    git checkout master 
    git merge --no-ff release-$1
    git tag -a $1
    git branch -D release-$1 
    git push origin master 
    git push origin $1
    git checkout develop
fi

