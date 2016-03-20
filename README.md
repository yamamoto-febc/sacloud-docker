
# さくらのクラウドAPI CLI

さくらのクラウドAPIのコマンドラインツール[`sacloud`](https://github.com/sakura-internet/node-sacloud)用イメージです。

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/)


## `Dockerfile` links

[`latest`](https://github.com/yamamoto-febc/sacloud-docker/tree/master/0.0.16),[`0.0.16`](https://github.com/yamamoto-febc/sacloud-docker/tree/master/0.0.16)[(Dockerfile)](https://github.com/yamamoto-febc/sacloud-docker/tree/master/0.0.16)

[`latest-debug`](https://github.com/yamamoto-febc/sacloud-docker/tree/master/0.0.16/debug),[`0.0.16-debug`](https://github.com/yamamoto-febc/sacloud-docker/tree/master/0.0.16/debug)[(Dockerfile)](https://github.com/yamamoto-febc/sacloud-docker/tree/master/0.0.16/debug)

**`debug`イメージはnode-debugを用いたデバッグを行える、sacloud開発者向けタグです。**

## 使い方

以下の環境変数を指定して起動します。
アクセストークン、アクセストークンシークレットは
さくらのクラウドのコントロールパネルから取得しておいてください。
([こちらのページ](http://knowledge.sakura.ad.jp/tech/1939/2/)が参考になると思います。)

* SACLOUD_ACCESS_TOKEN : アクセストークン
* SACLOUD_ACCESS_TOKEN_SECRET : アクセストークンシークレット
* SACLOUD_REGION : リージョン(以下のいずれかを指定)
      石狩第1ゾーン : is1a
      石狩第2ゾーン : is1b
      東京第1ゾーン : tk1a
      Sandbox     : tk1v

* SACLOUD_DEBUG_OPTIONS : **`debug`イメージのみ** node-debugコマンドへの引数

### 起動コマンド書式

```bash
docker run -it --rm -e SACLOUD_ACCESS_TOKEN=アクセストークン \
                    -e SACLOUD_ACCESS_TOKEN_SECRET=シークレット \
                    -e SACLOUD_REGION=is1a  \
                    yamamotofebc/sacloud 実行したいコマンド
```

### サーバ一覧取得の例
```bash
docker run -it --rm -e SACLOUD_ACCESS_TOKEN=アクセストークン \
                    -e SACLOUD_ACCESS_TOKEN_SECRET=シークレット \
                    -e SACLOUD_REGION=is1a  \
                    yamamotofebc/sacloud show server
```
sacloudコマンドの詳しい使い方は[こちら](https://github.com/sakura-internet/node-sacloud/wiki/Getting-started-Guide)を参照してください。

## docker-composeを使う場合

以下のようなdocker-compose.mlファイルを用意しておくと
環境変数の指定をまとめて行うことができます。

#### docker-compose.yml
```docker-compose
sacloud:
  image: yamamotofebc/sacloud
  environment:
    SACLOUD_ACCESS_TOKEN: "アクセストークン"
    SACLOUD_ACCESS_TOKEN_SECRET: "シークレット"
    SACLOUD_REGION: "is1a"
```

#### サーバ一覧取得の実行例
```bash
docker-compose run --rm sacloud show server
```

## docker-composeで`debug`イメージを使う例

sacloudの開発時は以下のようなdocker-compose.ymlを用いると
ソース編集の即時反映、chromeでのデバッグなどが行えます。

#### docker-compose.yml
```docker-compose
sacloud-debug:
  image: yamamotofebc/sacloud:latest-debug
  environment:
    SACLOUD_ACCESS_TOKEN: "アクセストークン"
    SACLOUD_ACCESS_TOKEN_SECRET: "シークレット"
    SACLOUD_REGION: "is1a"
    SACLOUD_DEBUG_OPTIONS: "--save-live-edit"
  ports:
    - "8080:8080"
  volumes:
    - /path/to/your/local/sacloud/src:/usr/local/lib/node_modules/sacloud
```

#### サーバ一覧取得の実行例
```bash
docker-compose run --rm --service-ports sacloud-debug show server
```
