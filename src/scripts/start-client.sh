#!/bin/bash

cd $(dirname $(readlink -f $0))

# export http_proxy="http://127.0.0.1:7777"

nohup ./bin/ngrok \
      -config="./ngrok.yml" \
      -subdomain="demo" 80 \
      </dev/null >>/tmp/ngrok.log 2>&1 &
