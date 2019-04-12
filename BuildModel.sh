#!/bin/sh
#!/usr/bin/env python3

#  BuildModel.sh
#  
#
#  Created by Alexander Laurence on 12/04/2019.
#  

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd "$DIR"

python3 train.py --train training_data/ --val testing_data/ --num_classes 2
