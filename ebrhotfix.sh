#!/bin/bash

usage()
{
    echo ""
    echo "Usage:      $0 <tag>"
    echo "Dscription: merge hotfix into master and develop with --no-ff, and then push to origin." 
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
    git checkout master 
    git merge --no-ff hotfix-$1
    git tag -a $1
    git push origin master
    git push origin $1

    git checkout develop
    git merge --no-ff hotfix-$1
    git push origin develop

    git branch -D hotfix-$1
fi

