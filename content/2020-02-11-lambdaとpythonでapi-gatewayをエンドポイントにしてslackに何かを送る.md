---
title: "LambdaとPythonでAPI GatewayをエンドポイントにしてSlackに何かを送る"
date: "2020-02-11T13:00:00.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
  - "api"
  - "lambda"
  - "python"
---

## 経緯

今週の水曜日に[JAWS-UG 初心者支部#23 次回のハンズオン勉強会向けのチューター向け予習会](https://jawsug-bgnr.connpass.com/event/163557/)へ参加することになりました。

Lambdaは、花屋時代にローカル環境でテスト実行してみてQiitaに上げたきりだったので  
その時の記事 => [Pythonでaws-sam-cliをローカル実行するまで](https://qiita.com/suwa3/items/505d137d7073c7a5243f)

もうすこし踏み込んで  
(実用性を意識しながらLambdaを触ってみたいなぁ)  
と、思った＆予習も兼ねて  
『API GatewayをエンドポイントにしてLambdaを起動しSlackに何かを流す』  
というのをやってみました。

API Gatewayをエンドポイントにした実行を試したいと考えた理由として  
外部から連携したい場合、HTTPリクエストを受けて発火させる場面が多くあるので  
これから効率化を考える際に、よく使いそうな手法として要領を掴んで慣れておきたかったからです。

逆にAPI Gatewayを使わないパターンとして  
AWS内のサービスを使うときは、わざわざエンドポイントを外に置かなくても  
AWSのサービス同士はだいたいIAMロールを使えばAWS内でセキュアに連携できます。

## 流れ

流れとしては  
SlackでIncoming Webhookの設定をしてWebhook URLを控えます。

Lambdaのコンソール上で関数を作成して  
Webhook URLをその関数内で使用し、連携させます。

API Gatewayのコンソール上でLambda関数を紐付けて  
エンドポイントをデプロイすると、発火用のURLが発行されます。

そのURLにアクセスする(HTTPリクエストが届く)と  
それを合図にしてLambdaが起動して  
SlackのBotが起動する、という仕組みです。

* * *

- Slack  
    1\. Incoming Webhookの設定  
    2\. Webhook URLを控える
- Lambda  
    1\. 関数の作成  
    2\. 関数内にWebhook URLを仕込む
- API Gateway  
    1\. Lambda関数の紐付け  
    2\. エンドポイントをデプロイして発火用URLを控える
- (例えば)ブラウザなど  
    エンドポイントURLにアクセスしてみる
- Slack  
    Botが起動する

## Slack

### Incoming Webhookの設定

まずはSlackの設定です。  
『Slackをカスタマイズ』を選択します。

![](images/image-2.png)

左上の『MENU』から  
『App 管理』を選択します。

![](images/image-3.png)

『 Incoming Webhook』を検索し、アプリを『Slackに追加』します。

![](images/スクリーンショット-2020-02-12-11.35.22.png)

### Webhook URLを控える

Botを動かしたいチャンネルを選択したら、『Incoming Webhookインテグレーションの追加』をします。  
発行されたWebhook URLを控えます。  
セットアップの手順も、ザックリと参考にします。

![](images/image-4.png)

ここでBotのアイコンや名前の設定なども行えます。

## Lambda

### 関数の作成

関数名を入力します。  
myfunctionでもtestでも、わかりやすい名前でOKです。  
関数を記述する言語(ランタイム)はPythonを使用します。  
実行ロールの選択は、今回特にAWS内のリソースには触らないので『基本的な Lambda アクセス権限で新しいロールを作成』でOKです。  
RDSやAWS内の何かと連携する場合は、必要な権限を付与してください。

![](images/スクリーンショット-2020-02-12-11.50.04.png)

### 関数内にWebhook URLを仕込む

Slackに表示させるプログラムを作成します。

```
import json
import urllib.request

def lambda_handler(event, context):
    # TODO implement
    post_slack()
    return {
        'statusCode': 200,
        'body': json.dumps('pong')
    }

def post_slack():
    message = """
    本日のランチを提案するクマー
    1. 学食
    2. スパニッシュ
    3. 喫茶店
    """

    send_data = {
        "text": message,
    }
    send_text = "payload=" + json.dumps(send_data)
    # URLには自分のWebhook URLを入力してください
    request = urllib.request.Request(
        "https://hooks.slack.com/services/********************", 
        data=send_text.encode('utf-8'), 
        method="POST"
    )
    with urllib.request.urlopen(request) as response:
        response_body = response.read().decode('utf-8')
```

## API Gateway

### Lambda関数の紐付け

API Gatewayのコンソール画面から  
『APIを作成』を選択して、PrivateではないREST APIの『構築』を選びます。

![](images/image-5.png)

プロトコルの選択、諸々の設定を行います。

☑REST  
☑新しいAPI  
API名: My API  
エンドポイントタイプ: リージョン

![](images/スクリーンショット-2020-02-14-9.58.18.png)

『アクション』を選択して、リソースを作成します。

![](images/image-6.png)

リソース名を設定します。  
今回はSlackとしました。

![](images/スクリーンショット-2020-02-14-10.10.16.png)

次にメソッドを作成します。  
『アクション』から、『メソッドの作成』を選びます。

![](images/image-7.png)

Slackリソースのプルダウンをクリックして

![](images/image-8.png)

『GET』を選択します。

![](images/image-9.png)

チェックをクリックします。

![](images/image-10.png)

セットアップをします。

☑Lambda関数  
☑Lambdaプロキシ統合の使用  
Lambda関数: myfunction  
クリックすると候補が表示されるので、使用したいLambda関数を選択します。

![](images/スクリーンショット-2020-02-14-10.29.43.png)

API Gatewayに、Lambda関数を呼び出す権限を与えます。

作成したAPIをデプロイします。

![](images/image-11.png)

デプロイのステージ名を決めます。

![](images/スクリーンショット-2020-02-15-14.36.54.png)

URLが作成されるので、こちらにアクセスしてみます。

![](images/スクリーンショット-2020-02-15-14.38.14.png)

早速Slackの通知が来ました。

![](images/スクリーンショット-2020-02-15-14.43.33.png)

Slackを確認したところ  
無事、届いていました👏

![](images/スクリーンショット-2020-02-15-14.45.58.png)

(参照)[AWS Lambdaで作るSlack bot (Incoming Webhook) - Qiita](https://qiita.com/yokoc1322/items/553ad147b82277b2beca)  
(参照)[初めてのAPI Gateway ｜ Developers.IO](https://dev.classmethod.jp/cloud/aws/sugano-009-api-gateway/)
