---
title: "Docker image"
date: "2019-07-01T13:00:24.000Z"
categories: 
  - "%e6%9c%aa%e5%88%86%e9%a1%9e"
tags: 
  - "docker"
---

## Docker imageの操作方法

* * *

目次

1. imageの検索
2. imageの取得
3. imageが取得できたか一覧で確認する
4. imageの詳細を見る
5. imageの削除

* * *

### 1\. imageの検索

centosを検索してみます。

$ docker search centos | more

![](/images/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-07-01-21.11.16.png)

* * *

### 2\. imageの取得

$ docker pull centos

* * *

### 3\. imageが取得できたか一覧で確認する

左から

名前、タグ、IDの順、作られた日付、容量

タグが違っていてもIDが同じであれば実体は同じ。

$ docker images

![](/images/img_20190702_012415.png)

REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
 misskey\_web          latest              0e061f36c9be        8 days ago          526MB
 ・・・・・・　　・・・・・　　・・・・・・・　・・・・・・　　・・・・ 
 centos                     latest              9f38484d220f        3 months ago        202MB 

* * *

### 4\. imageの詳細を見る

$ docker inspect "REPOSITORY":"TAG"

もしくは

$ docker inspect "IMAGE ID"

IMAGE IDで指定する場合は一つに絞ることができればOKなので、最初の3〜4文字を入力するだけでも見ることができる。

実際にcentosの詳細を見てみる。

$ docker inspect centos:latest

![](/images/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-07-02-0.29.02.png)

上記画像のような設定を見ることができる。

* * *

### 5\. imageの削除

remove imageと言う意味でrmiコマンドを使用することでimageを削除することができる。

$ docker rmi "REPOSITORY":"TAG"

もしくは

$ docker rmi "IMAGE ID"
