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

## node-red-contribu-ui
https://localhost:1880/ui/ でアクセスできるUI部品
をインストールするスクリプトinstallNodeRedContribUI.sh

## ./data*
HTTP/HTTPS版、UI有り版、flows.json空とかいろいろ試した

