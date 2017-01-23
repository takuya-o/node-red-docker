#!/bin/sh
# -*- coding: utf-8 -*-
#
# HTTPS対応のための追加スクリプト
#

# docker-compose-run.shすると ./data以下に証明書や
#setting.jsが無くて動かないので、
# docker-compose stop
# ./makeHttpsKey.sh
# docker-compose start
# すると動くようになる


# https用のおれおれ証明書作成
if [ -f data/privkey.pem -a -f data/fullchain.pem ];then
   echo "Already created keys." 1>&2
   exit 1
fi
mkdir data
cd data/
openssl genrsa -out privkey.pem 1024
openssl req -new -key privkey.pem -out private-csr.pem
openssl x509 -req -days 365 -in private-csr.pem -signkey privkey.pem -out fullchain.pem

#Dockerfileで作成した settings.js 取得
ID=`docker run -it -d nodered_node-red sh`
docker cp $ID:/data ..
docker cp $ID:/usr/src/node-red/node_modules/node-red/settings.js ../data/
sed -i.bak -e 's@^//\(var fs = require("fs");\)@\1\n&@' \
           -e "s@^    //https: {@    https: {\n\
        key: fs.readFileSync('/data/privkey.pem'),\n\
        cert: fs.readFileSync('/data/fullchain.pem')\n\
    },\n&@"\
	   -e 's@    //\(requireHttps: true\)@    \1,\n&@'\
	   ../data/settings.js

docker stop $ID
docker rm $ID
