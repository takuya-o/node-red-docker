#!/bin/sh
# -*- coding: utf-8 -*-
# node-redのupgradeをする
set -e

if [ "$1" = "-f" ];then
  # gitリポジトリのupstreamマージとDockerレジストリ push
  git checkout docker-compose
  git fetch --all #開発ブランチで
  git push . node-red/master:master  #Upstreamをローカルにコピー
  git push origin master:master      #UpstreamをGitLabに保存
  git push --tags origin

  NR_VERSION=$(git tag -l --sort=creatordate "v*"|
    egrep -v -e '\-(docker-compose|release|beta.*)$'|
    tail -3|sort -r|head -1|
    sed 's/^v//')
  git merge -Xtheirs -m "Upgrade to ${NR_VERSION} from upstream" master
  git push
  git tag -s -a v${NR_VERSION}-docker-compose -m "Upgrade to ${NR_VERSION} from upstream" || true # ignore exist error
  git push origin refs/tags/v${NR_VERSION}-docker-compose

  # dockerイメージ保存
  docker compose pull
  (. ./.env &&
    NODE_VERSION=$(echo ${VERSION}|sed -e 's/^:[^-]*//') &&
    TAG=$CI_REGISTRY_IMAGE:${NR_VERSION}${NODE_VERSION} &&
    docker tag nodered/node-red$VERSION $TAG &&
    docker push $TAG)
fi

set -eu

docker compose pull

docker compose down
docker compose up -d node-red  # node-red1などは手動起動する

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
docker compose exec -u root node-red sh -c "mkdir /.npm /.config && chown $CUID:$CGID /.npm /.config"

# 前提のnode-red-contrib-tensorflowのバージョン指定インストール
# docker compose exec node-red sh -c "cd /data && npm i github:kazuhitoyokoi/node-red-contrib-tensorflow#143b3cbbd5671df3e05302f6435cd12f3046bb10"
# 0.2.2タグがなくなったのでhash指定

# 実際のインストール
docker compose exec node-red sh -c "cd /data &&
  npm install @tensorflow/tfjs-node &&
  npm audit fix"
docker compose restart node-red

# defaultのsetting.jsの保存
NR_VERSION=$(git tag -l --sort=creatordate "v*"|egrep -v -e '\-(docker-compose|release|beta.*)$'|tail -3|sort -r|head -1|sed 's/^v//')
if [ ! -f settings.${NR_VERSION}.js ];then
  docker cp `docker compose ps -q node-red`:/usr/src/node-red/node_modules/node-red/settings.js settings.${NR_VERSION}.js
fi

