#!/bin/bash

if [ "$1" = "1" ]; then
  sed -i ''  '/\/zorro/d' .gitignore
elif [ "$1" = "0" ]; then
  git checkout .gitignore
else
  sed -i ''  '/\/zorro/d' .gitignore
fi

