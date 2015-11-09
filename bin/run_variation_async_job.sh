#!/bin/bash
export PYTHONPATH=/kb/dev_container/modules/variation/lib:$PATH:$PYTHONPATH
python /kb/dev_container/modules/variation/lib/variation/variationServer.py $1 $2 $3
