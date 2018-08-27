#!/bin/sh

# cp sample.tsv data/

docker stop osmnames-sphinxsearch
docker rm osmnames-sphinxsearch
set -ex

#SOURCE_DIR=/data/osmnames-sphinxsearch
SOURCE_DIR=`pwd`
mkdir -p $SOURCE_DIR/data/input $SOURCE_DIR/data/index $SOURCE_DIR/tmp $SOURCE_DIR/log
sudo rm -rf $SOURCE_DIR/tmp

docker build -t klokantech/osmnames-sphinxsearch:devel .
docker run -d --name osmnames-sphinxsearch \
    -p 9013:80 -p 9313:9312 \
    -v `pwd`/web/:/usr/local/src/websearch/ \
    -v $SOURCE_DIR/data/:/data/ \
    -v $SOURCE_DIR/tmp/:/tmp/ \
    -v $SOURCE_DIR/log/:/var/log/supervisord/ \
    klokantech/osmnames-sphinxsearch:devel

