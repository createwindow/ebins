#!/bin/sh

cat a.txt | while read i; do
    echo "$i"
done

