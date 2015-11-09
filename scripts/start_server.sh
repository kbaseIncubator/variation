#!/bin/bash
export KB_DEPLOYMENT_CONFIG=/kb/dev_container/modules/variation/deploy.cfg
export PYTHONPATH=/kb/dev_container/modules/variation/lib:$PATH:$PYTHONPATH
uwsgi --master --processes 5 --threads 5 --http :5000 --wsgi-file /kb/dev_container/modules/variation/lib/variation/variationServer.py
