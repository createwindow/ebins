#!/usr/bin/env python
import sys
import os

# Configure your favorite three-way diff program here.
DIFF3 = "/usr/bin/diffmerge"

# Subversion provides the paths we need as the last three parameters.
LABEL_MINE = sys.argv[-8]
LABEL_OLDER = sys.argv[-6]
LABEL_YOURS = sys.argv[-4]
FILE_MINE  = sys.argv[-3]
FILE_OLDER = sys.argv[-2]
FILE_YOURS = sys.argv[-1]

# Call the three-way diff command (change the following line to make
# sense for your three-way diff program).
cmd = [DIFF3, '--nosplash', '-t1', LABEL_MINE, '-t2', LABEL_OLDER, '-t3', LABEL_YOURS, FILE_MINE, FILE_OLDER, FILE_YOURS]
os.execv(cmd[0], cmd)

