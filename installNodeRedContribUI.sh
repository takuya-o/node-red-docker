#!/bin/sh

# node-red-contrib-uiをインストールする

docker-compose exec node-red sh -c "cd /data;npm install node-red-contrib-ui"
