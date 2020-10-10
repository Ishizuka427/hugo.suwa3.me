---
title: "WordpressのEC2インスタンス内MySQLバックアップ"
date: "2019-10-04T13:00:00.000Z"
categories: 
  - "%e6%9c%aa%e5%88%86%e9%a1%9e"
tags: 
  - "aws"
  - "dump"
  - "ec2"
  - "mysql"
  - "rds"
  - "wordpress"
---

WordpressのEC2インスタンス内にあるMySQLデータをバックアップします。

[MySQLのデータベースをmysqldumpでバックアップ/復元する方法](https://weblabo.oscasierra.net/mysql-mysqldump-01/)

上記を参考にして進めました。

  
まずはEC2内に入りエクスポート

$ mysqldump --single-transaction --databases \[DB名\] -u \[ユーザー名\] -p > /tmp/backup20191004.sql

**オプション解説**

\--single-transaction

データの整合性を維持する。ワントランザクションで作業を行う設定する

\--databases \[DB名\] 

DB名の指定

\-u \[ユーザー名\] 

ユーザー名の指定

\-p

上で指定したユーザー名のパスワードを使用するオプション

  
dumpファイルを取ることに成功しました！

Next Step

[RDSを作成します。](https://suwa.home.blog/2019/10/04/rds作成時ポイント、お引っ越し/)
