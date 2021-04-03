---
title: "週末"
date: "2020-05-31T13:00:13.000Z"
categories: 
  - "tech-blog"
tags: 
---

#### wordpress移行タスク

\- \[ \] GoでMarkdown形式出力プログラム書く  
\- \[ \] フロントはReact製静的ファイルジェネレータ検討  
\- \[ \] 記事は全てgit管理に移行  
\- \[ \] JQueryで改造している部分はGitHubActionsに移行

移行タスクの`GoでMarkdown形式出力プログラム書く` ために  
WordPressのデータ構造を把握して  
必要なデータを選定する作業しました。

## WordPressデータ構造

土曜日はひたすらWordPressのデータ構造とにらめっっこしていました。  
[データベース構造 - WordPress Codex 日本語版](https://wpdocs.osdn.jp/%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E6%A7%8B%E9%80%A0#.E3.83.86.E3.83.BC.E3.83.96.E3.83.AB:_wp_posts)

ふだんクエリを直接叩いてCLIで確認することが多くて  
あまりクライアントを使ったことがなかったので  
Sequel Proでポチポチ見てみるのをやりました。  
ついでにQiitaも書いた。  
[Sequel Pro リモートDBへのSSH接続 - Qiita](https://qiita.com/suwa3/items/b840d19f796705c601e6)

どのテーブルの、どのカラムが必要かなぁだとか  
関連性などを見て控えておく作業です。

マルコフ連鎖でblog自動生成や  
データ分析いれて解析するネタに使えそうなので  
データ自体はGitHubのPrivateRepositoryに保管しておきたい。

あとはGoでMySQLに接続する方法を、調べて書いてふむふむしました。

* * *

日曜日は悪夢を3連続でみて朝からメンタルがやられたため  
日中はソファで横になって天井を見ながら泣いていました。

夕方頃から、トランポリンしていたら元気が戻ってきました。  
トランポリン以外何もせずに日曜日が終わりそうで  
不安で、居ても立っても居られなくなったので  
夜から作業をしました。

## Let's Encrypt\_環境

ここのblogの証明書が切れて  
ずっと

```
Error: couldn't get currently installed version for /opt/eff.org/certbot/venv/bin/letsencrypt: 
Traceback (most recent call last):
  File "/opt/eff.org/certbot/venv/bin/letsencrypt", line 7, in <module>
    from certbot.main import main
  File "/opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/certbot/main.py", line 2, in <module>
    from certbot._internal import main as internal_main
  File "/opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/certbot/_internal/main.py", line 10, in <module>
    import josepy as jose
  File "/opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/josepy/__init__.py", line 41, in <module>
    from josepy.interfaces import JSONDeSerializable
  File "/opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/josepy/interfaces.py", line 7, in <module>
    from josepy import errors, util
  File "/opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/josepy/util.py", line 7, in <module>
    import OpenSSL
  File "/opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/OpenSSL/__init__.py", line 8, in <module>
    from OpenSSL import crypto, SSL
  File "/opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/OpenSSL/crypto.py", line 12, in <module>
    from cryptography import x509
ImportError: No module named cryptography
```

このエラーが解消されないため  
結局venvでPython3系の環境を別途作成して  
その環境内で  
`(venv)# certbot certonly -a standalone -d wp.suwa3.me`  
を、実行したらできました。  
👆備忘録として残しておきます。

## PHPバージョン

ここのblogのphpバージョンをあげようと思いました。  
\- \[x\] サイトのバックアップを作成する  
\- \[x\] WordPress 本体、テーマ、プラグインをアップデートする  
\- \[x\] PHP の互換性をチェックする (PHP Compatibility Checkerプラグインを使用)  
\- \[x\] PHP 互換性の問題を修正する

特に問題なさそうだったので、バージョンを上げていきたいと思います。  
下記の記事を参考に進めていきたいです。  
[Amazon Linux 上のWordPress PHPを5.3から7.2にバージョンアップ | ヤマムギ](https://www.yamamanx.com/amazon-linux-wordpress-php-53-72/)  
今日はそろそろ日付が変わるのでここまでです！

* * *

## 明日以降のTODO

\- MySQLに接続 by Go  
\- Go勉強会(6/3)の課題やる  
\- セッションデータストア書くの最後までやる  
\- 上記すべてgit pushする  
\- WordPress phpバージョンを上げる

![](https://assets-don.nzws.me/system/media_attachments/files/000/485/755/original/6cd32eb9e148287f.jpeg?1590916308)

お花のサブスク第二弾が届いたよ😊  
かわいい~~
