#!/bin/sh
# -*- coding: utf-8 -*-
#
# node-red-contrib-uiをインストールする
#

docker-compose exec node-red \
	       sh -c "cd /data;npm install node-red-contrib-ui" &&\
docker-compose restart node-red
