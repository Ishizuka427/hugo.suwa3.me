---
title: "主にPostgreSQL作業ログ"
date: "2020-02-23T13:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
---

全てのサービスの現在のステータスを確認する

```
$ service --status-all
```

[Linux service関連　基本コマンドメモ](https://qiita.com/manjiroukeigo/items/2b217ffbb50b119d5f58)

```
$ service postgresql status
```

```
$ service postgresql restart
```

PostgreSQLを読み込まないので.env.productionの  
DB\_HOST=にループバックアドレスを指定  
下記は.env.production一部抜粋 (最終的に空欄でOKだった)

```
# psql -U mastodon mastodon_production -h 127.0.0.1
psql: could not connect to server: Connection refused
    Is the server running on host "127.0.0.1" and accepting
    TCP/IP connections on port 5432?
```

【問題1】そもそもローカルから疎通が取れない  
【問題2】初期デフォルトのDBにpg\_dumpしたものが、まだ残っている

二度目にpg\_dumpしてきたやつについては下記のようにやり直す。

1. 論理DBを消す (初期化)
2. 論理DBを作成
3. マイグレーション (テーブルやカラムを作成)
4. リストア

**PostgreSQLの初期化**

```
$ service postgresql initdb
```

↑Ubuntuはできなかった。そういう仕様らしい。

> ところが、Ubuntu の PostgreSQL パッケージをインストールしても、initdb が見つかりません (実際には別の場所にインストールしているのですが、これは後述します)
> 
> [Ubuntu で PostgreSQL を使ってみよう(続編) | Let's Postgres](https://lets.postgresql.jp/documents/tutorial/ubuntu/4)

postgresユーザーに切り替え＆直接パスを指定する必要があった。

```
$ sudo su postgres -
$ /usr/lib/postgresql/9.6/bin/initdb /var/lib/postgresql/9.6/main
```

**論理DBの作成**

postgresユーザーでpsqlして

```
$ psql
# CREATE DATABASE mastodon_production ENCODING 'UTF-8';
# CREATE USER mastodon CREATEDB;
```

パスワードの設定をします。

```
# ALTER ROLE mastodon WITH PASSWORD '****';
```

mastodonユーザーでDB名を指定して入る

```
$ psql mastodon_production
```

**リストア**

gzipで圧縮したものを解凍して、出力した値をpsqlコマンドでmastodon\_productionにリストアしていきます。

```
$ scp -i ~/.ssh/**.pem dump-latest.sql.gz ******@*.***.6.***:~/
$ gzip -dc dump-latest.sql.gz | psql -U postgres -d mastodon_production
```

* * *

時間がなくなってきたので  
一時停止してバックグラウンド実行させたい  
(参照) [実行中のコマンドをバックグランドに切り替える](https://qiita.com/strsk/items/1c971c1b7b3e9b08a445)

```
$ bg 1
Command 'bd' not found, but can be installed with:

sudo apt install bd
```

bgコマンド、ないんかーい😢  
screen？  
**やってません💢**

```
$ sudo apt install bg
```

インストールに時間かかりそう  
今日は諦めてここまで。
