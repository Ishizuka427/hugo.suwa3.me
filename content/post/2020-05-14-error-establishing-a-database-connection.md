---
title: "Error establishing a database connection"
date: "2020-05-14T13:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Tech"
---

コマンド一覧

```
$ ssh wp
$ sudo su -
$ tar cvJf wp.suwa3.me-backup-mysql-20200515.tar.xz  /var/lib/mysql
$ mv /root/wp.suwa3.me-backup-mysql-20200515.tar.xz /home/ec2-user/
$ chown ec2-user /home/ec2-user/wp.suwa3.me-backup-mysql-20200515.tar.xz

# ローカルへ移動
$ scp wp:/home/ec2-user/wp.suwa3.me-backup-mysql-20200515.tar.xz ~/tmp/

# wpサーバーへ移動
$ service mysqld restart
```

![](/images/スクリーンショット-2020-05-14-21.07.22.png)

blog 開こうとしたらこれです(ゲンナリ)  
なんか前にもあったぞ。。

これ前にもあって、対処方法と原因究明した作業ログをblogにまとめたのに  
DBの接続エラーのときは、その情報を見れなくない・・？ってなりました。

* * *

自分でホスティングしているシステムがエラーで動かなくなった場合  
仕事の予行演習だと思って取り組むがモットーなので  
対処方法を作業ログとして残します！  

だいたい再起動すれば動くことが多いですが、基本的にDB再起動は最終手段で、データの保全を最優先して情報収集に努めます。

## 環境

- Amazon Linux  
- LAMP構成  
- WordPress  

### ■ MySQL の接続エラー対処

```
$ ps -ef | grep mysql
ec2-user 14969 14947  0 12:07 pts/1    00:00:00 grep --color=auto mysql
```

ない

```
# tail -n 100 /var/log/mysqld.log
```

なぜかタイムスタンプがおかしかった。  
~~他の闇が見えかけた🙈~~

### ■ ディスクの使用状況を確認

```
# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        483M   60K  483M   1% /dev
tmpfs           493M     0  493M   0% /dev/shm
/dev/xvda1      7.9G  5.0G  2.8G  64% /
```

### ■ データの存在・大きさを確認して圧縮

```
# ls /var/lib/mysql
auto.cnf  ibdata1  ib_logfile0  ib_logfile1  mysql  mysql_upgrade_info  performance_schema  wordpress@002ddb
```

```
# grep datadir /etc/my.cnf
datadir=/var/lib/mysql
```

#### データサイズを確認

```
# du -chs /var/lib/mysql
209M    /var/lib/mysql
209M    total
```

#### tar.xz形式で圧縮するために、コマンドの確認

```
# xz --version
xz (XZ Utils) 5.1.2alpha
liblzma 5.1.2alpha
```

以下を実行

```
# tar cvJf wp.suwa3.me-backup-mysql-20200514.tar.xz  /var/lib/mysql
```

#### 圧縮後のデータサイズを確認

```
# ls -lh
total 6.9M
-rwxr-xr-x 1 root root  68K Nov 30 08:19 certbot-auto
-rw-r--r-- 1 root root 6.8M May 14 12:37 wp.suwa3.me-backup-mysql-20200514.tar.xz
```

### ■ rootで作業していたので移動

```
# mv /root/wp.suwa3.me-backup-mysql-20200514.tar.xz /home/ec2-user/
```

※ オーナーも変更する

```
# chown ec2-user /home/ec2-user/wp.suwa3.me-backup-mysql-20200514.tar.xz
```

確認

```
$ pwd
/home/ec2-user
$ ll
合計 24360
drwxrwxr-x 29 ec2-user ec2-user   28672  3月  8 09:17 git-2.24.1
drwxrwxr-x 29 ec2-user ec2-user   28672  3月  8 09:06 git-2.25.1
-rw-rw-r-- 1 ec2-user ec2-user 9026631  2月 17 06:30 git-2.25.1.tar.gz
-rw-rw-r-- 1 ec2-user ec2-user 8733670  3月  8 09:13 v2.24.1.tar.gz
-rw-r--r-- 1 ec2-user root     7114612  5月 14 12:37 wp.suwa3.me-backup-mysql-20200514.tar.xz
```

#### ■ scp

```
$ scp wp:/home/ec2-user/wp.suwa3.me-backup-mysql-20200514.tar.xz ~/tmp/
```

情報収集しつつ、データのバックアップが取れました。

### ■ 再起動

```
# service mysqld restart
```

復旧完了しました。
