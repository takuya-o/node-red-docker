#!/bin/sh

# docker-compose-run.sh直後は./dataがなくエラーなる
# data/settings.jsなどをコピー

ID=`docker compose ps -q node-red`

if [ -d ./data ];then
    echo "Already have ./data"
    exit 1
fi

docker cp $ID:/data .
if [ -f ./data/settings.js ];then
    echo "Already have ./data/settings.js"
else
	#Dockerfileで作成した settings.js 取得
	docker cp $ID:/usr/src/node-red/node_modules/node-red/settings.js ./data/
	docker stop $ID
	docker rm $ID
fi
