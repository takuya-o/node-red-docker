## upgrade
```bash
$ git pull github
$ git push . github/maser:master

$ git merge master

$ docker-compose pull
$ docker-compose build

$ docker-compose down
$ docker-compose up -d

$ docker cp `docker-compose ps -q`:/usr/src/node-red/node_modules/node-red/settings.js .
```


## HTTP版
./data/settings.jpを作る copySettings.sh
ただ、HTTP版では、WebSocketがproxy超えられないので、
問題が多発するのでお勧めではない。

docker-compose-http ブランチで作っていたけど、./data/
の作り替えだけで済むので、docker-composeブランチ + *.sh
で十分。

## HTTPS対応
Dockerfileの中でsettings.jsを作らないとダメかと思っていたけど
結局、証明書作りなど外でやることもあるので、証明書作りと共に
makeHttpsKey.sh に外だしした

docker-compose ブランチで対応

### Let's Encrypt版もあるよ
letsencrypt.sh

# 追加Node

## Node-RED ダッシュボード
https://localhost:1880/ui/ でアクセスできるUI部品
をインストールするスクリプトinstallNodeRedDashboard.sh
(URL短縮も一緒に入る)

## Google URL Shortner Service
GoogleのURL短縮
```sh
$ docker-compose exec node-red \
	       sh -c "cd /data;npm install node-red-contrib-shorturl" &&\
$ docker-compose restart node-red
```

## node-red-admin
じつはいらなかった。

### node-red-adminツール
dockerhubサイトではホスト側にnode-red-adminをインストールする方法も紹介されている
```bash
$ sudo npm install -g node-red-admin  #グローバルにadminツールをインストール
$ node-red-admin target http://node-red.example.com/admin install node-red-dashboard
```
target の defaultは http://localhost:1880/

#### Adminツール サブコマンド
see: [Node-RED日本ユーザ会 : Adminツール](https://nodered.jp/docs/node-red-admin)
* list - インストール済みNodeのリストを表示する
* info - モジュールまたはNodeセットの詳細情報を表示する
* enable - 指定したモジュールまたはNodeセットを有効にする
* disable - 指定したモジュールまたはNodeセットを無効にする
* search - npm公開リポジトリで指定したキーワードに関連するNode-REDモジュールを検索する
* ninstall - npm公開リポジトリからNode-REDモジュールをインストールする
* remove - npm公開リポジトリからインストールしたNode-REDモジュールを削除する


## Node-RED RSSフィードパース
RSSを読み込むノード をインストールするスクリプト
node-red-node-feedparserは、既に取り込まれていた。


# おまけ:  ./data* について
HTTP/HTTPS版、UI有り版、flows.json空とかいろいろ試した

