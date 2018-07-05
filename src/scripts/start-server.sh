#!/bin/bash

cd $(dirname $(readlink -f $0))

nohup ./bin/ngrokd \
      -tlsKey=./assets/server/tls/snakeoil.key \
      -tlsCrt=./assets/server/tls/snakeoil.crt \
      -domain="example.com" \
      -httpAddr=":80" -httpsAddr=":443" \
      -tunnelAddr=":8080" \
      </dev/null >>/tmp/ngrokd.log 2>&1 &
