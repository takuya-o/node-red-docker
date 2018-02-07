#!/bin/sh
# -*- coding: utf-8 -*-
#
# node-red-bashboardをインストールする
# ついでにURL短縮 goo.glもインストールするようにした
#

docker-compose exec node-red \
	       sh -c "cd /data;\
                      npm install node-red-dashboard &&\
                      npm install node-red-contrib-shorturl" &&\
docker-compose restart node-red
