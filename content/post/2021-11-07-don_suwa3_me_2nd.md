---
title: "don.suwa3.me_2nd"
date: "2021-11-07T00:00:00.000Z"
categories: 
  - "tech-blog"
tags:
  - "Tech"
---

## さくらのVPS
何台もポコポコ建てる気はないので1台分の「さくらのVPS」に登録

```
- [x] さくらのVPSに登録
CPU: 仮想2Core
メモリ: 1GB
SSD: 50GB
```
勘でこのスペックにしたけど多分足りない。  
おそらく build で失敗するし、力技で構築できたとしても実運用はできなさそう。(メモリ不足で落ちる)  
足りなくなったらサーバースペック上げれば良いか！  
構築しながら Ansible 書いてしまおう。がんばろう。  

## スタートスクリプト
[Mastodon | さくらのクラウド ドキュメント](https://manual.sakura.ad.jp/cloud/startup-script/public-script/mastodon.html)
  
Mastodon の構築を一発でやってくれるスクリプトがあるらしい。  
楽チンで良いなーと思ったけれど、運用中にどこで何の設定しているのかわからなくなりそうなので、さくらのスタートスクリプトは使わないことにしました。  

設定時に[ドキュメント](https://docs.joinmastodon.org/admin/prerequisites/)と合わせてTODOリストとして使う。  

## 設定済みリスト
### 主にセキュリティ周りの設定

```
- [x] ssh 鍵の設定
- [x] id, pass でのログインを許可しない
- [x] 作業用ユーザーを作成して sudo 権限を付与
- [x] デフォルトユーザーを削除
- [x] port の変更 (/etc/ssh/sshd_config)
- [x] ufw の設定
- [x] さくらでパケットフィルタの設定解除
```

EC2 のときは稼働時間に応じて課金だったので、構築中の使わないときはサーバーを落としていた。
さくら VPN は定額？っぽいので落とさなくても良さそう。踏み台にされたくないので最低限の設定はしておく。。  
※ログイン試行の log を見やすくするために port の変更もしておく
### その他の設定

```
- [x] ~/.ssh/config の設定
- [x] vim の install
```

MEMO:  
デフォルトの vi が使いづらかったので vim を入れた  

## ラバーダック・デバッグ

> ラバーダック・デバッグ とは、ソフトウエア工学におけるコードのデバッグ手法である。ラバーダック・デバッグは、The Pragmatic Programmer[1]という本で紹介された、プログラマーがラバーダックを持ち歩きアヒルちゃんに向かってコードを1行ずつ説明することによりデバッグを行うという話が由来である。この手法には、他にも多くの別名があり、しばしば様々な無生物が用いられている。

![](/images/170504.jpeg)

[https://ja.wikipedia.org/wiki/ラバーダック・デバッグ](https://ja.wikipedia.org/wiki/%E3%83%A9%E3%83%90%E3%83%BC%E3%83%80%E3%83%83%E3%82%AF%E3%83%BB%E3%83%87%E3%83%90%E3%83%83%E3%82%B0)
  
作業しながら独り言が多くて(たいてい無意識)まわりは「話しかけられているのかな？」と誤解して切り分けのアドバイスをくれたりするのだけれども、全く耳に入ってこないうえに話しているうちに整理されて解決するので、独り言用にアヒルちゃんでも置いておこうかと思いました。  
> 他人を煩わせることなく目的を達成できる。  ~ Wikipedia/ラバーダック・デバッグ ~
  
これ大事  

そしてわたし自身も独り言に対して翻弄されずに「そうなんですかね〜」みたいに対応できる、優秀なアヒルになるべくアヒル力を磨いていきたいです。  
  
ちなみに以前働いていた職場のベテランエンジニアは、わたしが初歩的な質問をすると  
「どうなんですかね〜」  
と言って、よくしらばっくれていた。(仕方ないので自分で調べた)(最初から自分で調べろ案件)  
わたしの独り言にも「うーむ？」と生返事だったので、流石アヒル力が高かったのだなと今になって思います！




