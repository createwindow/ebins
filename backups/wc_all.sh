#!/bin/bash

find $1 -type f -exec wc -l {} \; | awk '{sum+=$1}END{print sum}'
