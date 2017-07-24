#!/bin/bash

usage()
{
    echo ""
    echo "Usage:      $0 <branch>"
    echo "Dscription: merge <branch> into develop with --no-ff, and then push to origin." 
    echo ""
}
if [ "$1" = "-h" ]; then
    usage
    exit
elif [ "$1" = "" ]; then
    usage
    exit
else
    git checkout develop
    git merge --no-ff $1
    git push origin develop
fi

