#!/bin/sh
# -*- coding: utf-8 -*-
#
# node-red-bashboardをインストールする
#

docker-compose exec node-red \
	       sh -c "cd /data;npm install node-red-dashboard" &&\
docker-compose restart node-red
