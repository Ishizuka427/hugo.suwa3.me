---
title: "CodeDeploy"
date: "2019-11-24T13:00:00.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
---

sidekiqの設定をAnsibleで自動化したものを  
AWS CodeDeployで自動化しようと格闘しました。  
とりあえず途中まで進んだものを備忘録的に書いておきます。

まずIAMロールを作成

![](http://wp.suwa3.me/wp-content/uploads/2019/11/image.png?w=1024)

CodeDeployダッシュボードへ移動し  
そのロールARNを元に  
アプリケーション、デプロイグループの作成をします。

![](http://wp.suwa3.me/wp-content/uploads/2019/11/image-1.png?w=1024)

デプロイタイプはシンプルなものを選びます。  
対象のEC2インスタンスを選択します。

![](http://wp.suwa3.me/wp-content/uploads/2019/11/image-2.png?w=1024)

デプロイ設定は、今回ES2インスタンス1台なのでOne at Timeを選択します。  
詳細は以下URL  
[CodeDeploy でデプロイ設定を使用する - AWS CodeDeploy](https://docs.aws.amazon.com/ja_jp/codedeploy/latest/userguide/deployment-configurations.html)  
ロードバランサーはEC2内部でNginx稼働しているため、今回は指定しません。

![](http://wp.suwa3.me/wp-content/uploads/2019/11/image-3.png?w=1024)

デプロイの作成で  
GitHubのトークン名は  
一度ブラウザでGitHubからログアウトして  
アカウント名を入力してあげます。  
以下URL参照  
[ステップ 6: アプリケーションをインスタンスにデプロイする - AWS CodeDeploy](https://docs.aws.amazon.com/ja_jp/codedeploy/latest/userguide/tutorials-github-deploy-application.html)

![](http://wp.suwa3.me/wp-content/uploads/2019/11/image-4.png?w=1024)

次はリポジトリの紐付けです！

肝心のAnsibleリポジトリが  
個人的に、まだまだまとめられてないなぁと感じるので  
ディレクトリ掘って整備が完了次第、続きをやりたいと思います。
