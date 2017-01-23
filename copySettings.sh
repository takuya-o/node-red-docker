#!/bin/sh

# docker-compose-run.sh直後は./dataがなくエラーなる
# data/settings.jsなどをコピー

#Dockerfileで作成した settings.js 取得
ID=`docker run -it -d nodered_node-red sh`
docker cp $ID:/data .
docker cp $ID:/usr/src/node-red/node_modules/node-red/settings.js ./data/
docker stop $ID
docker rm $ID
