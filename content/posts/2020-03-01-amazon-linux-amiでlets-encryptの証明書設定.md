---
title: "Amazon Linux AMIでLet's Encryptの証明書設定"
date: "2020-03-01T13:00:00.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
  - "certbot"
---

ここ (WordPress) のblogの証明書が切れていたので発行しました。

```
$ certbot-auto certonly 
 -bash: certbot-auto: コマンドが見つかりません
```

無いなぁ

```
$ certbot --help
 -bash: certbot: コマンドが見つかりません
```

パス通し忘れてそのままっぽい。

```
$ cat /etc/*release*
 NAME="Amazon Linux AMI"
 VERSION="2018.03"
 ID="amzn"
 ID_LIKE="rhel fedora"
 VERSION_ID="2018.03"
```

なるほど  
[AWS EC2のAmazon LinuxでLet's Encryptのサーバ証明書を取得する - Qiita](https://qiita.com/kanehara/items/a2c322acc3d2a96ff42d)

> Let's Encryptのサーバ証明書の導入ツール certbot は、AWS EC2のAmazon Linuxには、正式には対応していないため、導入の記録として経過をこの記事に残す。

ぴえん😢  
とりあえずwgetして実行してみる

```
$ wget https://dl.eff.org/certbot-auto
$ sudo ./certbot-auto --debug
```

入ったか確認

```
$ pwd
 /home/ec2-user
 $ ls
 certbot-auto
```

homeにあると間違えて消しそうなので  
certbot-autoは `/usr/bin` の下に移動します。

```
$ sudo mv ~/certbot-auto /usr/bin/
```

コマンド実行されるか確認

```
$ certbot-auto --help
 Requesting to rerun /usr/bin/certbot-auto with root privileges…
```

ちなみにコマンドであるcertbot-autoで  
実行されるライブラリ群が入っているcertbotは `/opt/eff.org/` の下にありました。

# 自動更新の設定をする

![](/images/スクリーンショット-2020-03-01-21.38.39.png)

あと3ヶ月で切れるっぽいです。  
[certbotを使ってサイトをhttps化した | おそらくはそれさえも平凡な日々](https://songmu.jp/riji/entry/2019-06-10-certbot-https.html)

更新の自動化を参考に設定していきます。  
rootのcronで動かしていきます。

```
# /etc/cron.d/certbot-renew
0 0 1 */2 * certbot-auto renew
```

[Let's encrypt運用のベストプラクティス - Qiita](https://qiita.com/tkykmw/items/9b6ba55bb2a6a5d90963)

> renew を実行すると、これまでに取得した全ての証明書の期限がチェックされ、30日以内に期限が切れるものを自動的に更新します。

3ヶ月で切れる証明書の発行を2ヶ月おきにcron実行するので  
renewオプションコマンドで大丈夫そうです。

ただ、`30日以内に期限が切れるものを自動的に更新` なので  
1分後にcron実行されるかなどのテストができないの。

「2ヶ月後に実行されていたらいいなぁ」  
の、気持ちで待ちます😃
