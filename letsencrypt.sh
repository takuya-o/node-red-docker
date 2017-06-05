#!/bin/sh

#
# docker用の証明書を作る
# 出来た証明書を使うには/etc/letsencrypt/(archive|live)にo+rx必要
#

sudo certbot certonly -v -t -m takuya@page.on-o.com -d node-red.docker.on-o.com -d node-red.on-o.com --apache

#消すときには sudo certbot delete -v で、一覧から選択して消す (使っていたならその前にrevokeした方が良いかも)
