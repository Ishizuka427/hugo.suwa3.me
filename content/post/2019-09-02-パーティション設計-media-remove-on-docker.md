---
title: "パーティション設計/media remove on Docker"
date: "2019-09-02T13:00:00.000Z"
categories: 
  - "%e6%9c%aa%e5%88%86%e9%a1%9e"
tags: 
  - "docker"
  - "linux"
  - "s3"
---

最近言われて嬉しかった言葉は

｢戦闘民族だよね。戦い生きるみたいな生き方をしている｣

です。

精神的腕力のあるゴリラを目指している身としては身に余る言葉です。

なんか殺傷力高くて瞬発力ありそう。

media削除のコマンドを試す前に

「メディアストレージの容量を確認して、ビフォーアフター見てみたいなあ」

と、いうことで

postgresqlが稼働しているdisk容量を確認するコマンドを調べたの。

```
$ df -Th
```

dfコマンドにType付き＆人に優しいhumanizeな表示で見ることができました。

/dev/xvda1       20G   13G  7.0G  65% /

ふむふむ。

ラズパイも見てみました。

/dev/mmcblk0p1 vfat       253M   41M  213M   16% /boot

mmcblk0p1で調べたらSDカードのパーティションとのこと。

ふん？？

![](http://wp.suwa3.me/wp-content/uploads/2019/09/image.png?w=702)

（下記サイトより引用）

ふむふむ。

[fdiskの操作方法](https://www.express.nec.co.jp/linux/distributions/knowledge/system/fdisk.html)

> また、重要なのが「swap」パーティションだ。  
> このパーティションはメインメモリが不足しているときにメインメモリのかわりとして使用できる領域のことだ。  
> これは高価なメインメモリを安価な記憶媒体で補うと同時に、メインメモリ以上の容量を確保するため、比較的に昔からある仕組みだ。とても便利だし、設定しない理由はない。  
> やたらと大きくしてもパフォーマンスは発揮されないので注意しよう。
> 
> Linuxのパーティションとは？とパーティションの区切り方を詳細解説  
> [https://eng-entrance.com/linux-partition](https://eng-entrance.com/linux-partition)

パーティションの中でもswapって大事なんやなー

> swap領域を確保する一番手っ取り早い方法として、EC2のインスタンスストアスワップボリュームがあります。  
> これは、EC2のインスタンスタイプがm1.smallとc1.mediumのときのみ  
> /dev/xvda3ないし/dev/xvde3という900MBのmkswap済みディスクが  
> EC2のブート時に自動で提供されます(デバイス名はAMIによりまちまちです)。  
> 他のインタンスタイプではm1/c1ファミリーであっても提供されず、  
> またManagement ConsoleやAWS APIでは本ボリュームを確認できないことに注意しましょう。
> 
> Amazon EC2(Linux)のswap領域ベストプラクティス ｜ DevelopersIO  
> [https://dev.classmethod.jp/cloud/ec2linux-swap-bestpractice/](https://dev.classmethod.jp/cloud/ec2linux-swap-bestpractice/)

**swapの設定しなきゃ！！**

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-02-18.04.58.png?w=733)

**してた！！！**

全く記憶にないけど、とりあえずコピペ頑張ったんだなってきもちです。

 $ sudo docker-compose run --rm web bundle exec bin/tootctl media remove --days=30 

↑いろいろ脇道にそれましたが、画像削除のコマンドを打ってみました。

![](http://wp.suwa3.me/wp-content/uploads/2019/09/image-3.png?w=885)

_**error**_

![](http://wp.suwa3.me/wp-content/uploads/2019/09/image-4.png?w=909)

移動したらできた。

確かにdocker-composeするときはDockerのあるところでやっていたわ。

Docker沈黙タイムです。

![](http://wp.suwa3.me/wp-content/uploads/2019/09/image-5.png?w=932)

いまだかつてない沈黙です。

長いな？

Linuxディレクトリ構造でも読んで待とう。

・・・・・・・・・・・・・・・・

いま現在blog書きながら待っていますが、終わる気配がありません。

帰りたいんだけど😢

しかも散々脇道にそれてパーテーションについて調べて忘れかけていたけれど

メディアストレージはpostgresqlではなくAWSのs3使っているので

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-02-16.43.30.png?w=1024)

ビフォーアフターはs3のストレージを見よう。
