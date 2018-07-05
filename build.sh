#!/bin/bash

BASE_DIR=$(dirname $(readlink -f $0))

clean() {
    cd $BASE_DIR &&
        rm -rf ngrok/ pack/ pack.tgz
}

clone() {
    cd $BASE_DIR
    git clone https://github.com/inconshreveable/ngrok.git
}

build() {
    cd $BASE_DIR &&
        cp src/makefile.static.mk ngrok/Makefile &&
        cp src/generate-tls-files.sh ngrok/ &&

        cd $BASE_DIR/ngrok &&
        ./generate-tls-files.sh &&
        make static-all
}

pack() {
    cd $BASE_DIR &&
        rm -rf pack/ pack.tgz &&
        mkdir pack/ &&
        cp -a ngrok/bin ngrok/assets pack/ &&
        cp -a src/scripts/* pack/ &&
        tar -czvf pack.tgz pack/
}

all() {
    clean
    clone
    build
    pack
}

builder() {
    cd $BASE_DIR &&
        docker build -t golang-builder ./src/
}

docker-all() {
    cd $BASE_DIR
    builder
    docker run --rm -v $PWD:/project -it golang-builder sh -c \
           "/project/build.sh all"
}

eval "$*"
