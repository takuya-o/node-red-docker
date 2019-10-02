#!/bin/sh
# -*- coding: utf-8 -*-
# user指定した場合にもノードpacketのインストール可能にする
if [ -f .env ];then
    . .env
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
