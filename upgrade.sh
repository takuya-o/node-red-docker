#!/bin/sh
# -*- coding: utf-8 -*-
# node-redのupgradeをする
set +eu

docker-compose pull

docker-compose down
docker-compsoe up -d

# tensolflow 高速化パッケージのインストール
# 準備 enablePackageInstallOnUser.shより
if [ -f .env ];then
    . $PWD/.env
fi
if [ -z "$CUID" ];then
    #コンテナ用のCUIDが無ければ$UIDから作る
    CUID="$UID"
fi
if [ -z "$CGID" ];then
    #コンテナ用のCGIDが無ければ$CUIDから作る
    CGID=`uid -g $CUID`
fi
docker-compose exec -u root node-red sh -c "mkdir /.npm /.config && chown $CUID:$CGID /.npm /.config"

# 実際のインストール
docker-compose exec node-red sh -c "cd/data && npm install @tensorflow/tfjs-node && npm audit fix"
