#!/bin/bash

kax -action kaxdown -kaxdown_stream "$1" | tee 1.flv | ffplay -

