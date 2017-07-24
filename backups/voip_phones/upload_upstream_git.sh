#!/bin/bash

help()
{
    echo "DESCRIPTION"
    echo "        Add remote \"zorro\" for <repo>, create a branch \"zorro\" to track "
    echo "        zorro/upstream, merge branch <from_branch> to branch zorro, then push zorro to"
    echo "        downstream."
    echo "HOWTOS"
    echo "        1. Create a empty remote repo R on the repository host "
    echo "        2. run proj.sh to clone and customize a repo CR from remote "
    echo "        3. Create local repo LR for upstream codes "
    echo "        4. run this script in LR "
    echo "        5. run git pull in CR "
    echo ""
    echo "UASGE"
    echo "        ./to_downstream.sh <repo> <from_branch>"
    echo ""
}

if [ "$1" = "" -o "$2" = "" ]; then
    echo $1 
    echo $2
    help
    exit
fi

git remote add -f zorro "$1"
git checkout -b zorro zorro/upstream 
echo "Merge branch $2 and push branch zorro the downstream..."
git merge "$2"
git push zorro zorro:upstream

