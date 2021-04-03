---
title: "usermod/cronでdocker-compose"
date: "2019-09-03T13:00:00.000Z"
categories: 
  - "%e6%9c%aa%e5%88%86%e9%a1%9e"
tags: 
  - "cron"
  - "docker-compose"
---

本日のTODOリストです。

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-03-20.54.40.png?w=686)

ポートを変えるのは気休めだけれども、やってみたいなあと思います。

ユーザー名を変えるのはできた！

[Linuxのユーザー名を変更する - そんなこと猫でもできる](https://nekodeki.com/linuxのユーザー名を変更する/)

そんなこと猫でもできるらしい。

うさぎでもできるかな。

 $ sudo docker-compose run --rm web bundle exec bin/tootctl media remove --days=25 

このコマンドをcronで実行しようとおもって調べた。

\# docker-composeコマンドについて

\- docker-compose.ymlがある場所で実行される

\- ファイルパス-fでdocker-compose.ymlがある場所を指定して実行させることも可能 （下記参照）

 $ 0 0 \* \* \* docker-compose -f /\*\*\*\*\*\*/\*\*\*\*\*\*\*/mastodon/docker-compose.yml run --rm web ..... 

\- rootのcrontabに設定する場合はsudoは不要

\- crontabは各ユーザーそれぞれにcrontabがある

\- rootになった状態で crontab -u（ユーザー名）のようにすれば、それぞれのcrontabを見ることができる

\- ユーザー名-uを指定しない場合は、今のユーザーのcrontabが表示される

![](http://wp.suwa3.me/wp-content/uploads/2019/09/image-7.png?w=727)

**cron 3ステップ**

1.cronでやる前に手動で動くか確認。

2.動いたらcronで毎分確認。

3.動いたら定時で確認。

最近、難しそうだなあってことでも

「調べてやってみればできるのでは？」

ってきもちになってきた。

そして、案外やってみればできるということに気づいた。

とにかくどんどん行動してみている。

たのしいー

ちなみにs3のビフォーアフターです！

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-02-21.09.44.png?w=558)

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-04-0.02.13.png?w=535)

画像削除、成功です。やったねえ
