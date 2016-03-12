
ckerfile` links

[`latest`](https://github.com/yamamoto-febc/sacloud-docker)[(Dockerfile)](https://github.com/yamamoto-febc/sacloud-docker)

# さくらのクラウドAPI CLI

さくらのクラウドAPIのコマンドラインツール[`sacloud`](https://github.com/sakura-internet/node-sacloud)用イメージです。

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
