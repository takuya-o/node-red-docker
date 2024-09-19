#!/bin/sh
# -*- coding: utf-8 -*-
#
# node-red-contrib-tensorflow を高速化する
# @tensorflow/tfjs-node をインストールする
#

docker compose exec node-red \
               sh -c "cd /data;\
                      npm install @tensorflow/tfjs-node &&\
                      npm fund
                " &&\
docker compose restart node-red
