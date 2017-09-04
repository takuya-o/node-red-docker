#!/bin/sh
# -*- coding: utf-8 -*-
#
# node-red-bashboardをインストールする
# ついでにURL短縮 goo.glもインストールするようにした
#

#node-red-contrib-facebookにpythonが必要?

#docker-compose exec --user root node-red sh -c "apk add --no-cache python make g++"
docker-compose exec node-red \
	       sh -c "cd /data;\
                      npm install node-red-dashboard &&\
                      npm install node-red-contrib-shorturl" &&\
docker-compose restart node-red

#うまく動かない
#	npm install node-red-contrib-facebook
