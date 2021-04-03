---
title: "WordPress移行_途中経過"
date: "2020-09-06T13:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
---

ホスティングしているWordPressサイトを  
静的サイトへ移行します。

![](/images/スクリーンショット-2020-09-07-10.11.16.png)

まず、やるべき内容を書き出しました。  
作業に入る前にWordPressのバージョンなどを上げたよ。

## backup

```
mysqldump --single-transaction -u ***** -p ************* > /tmp/wp-2020-09-05.dump
```

※ セキュリティホールになる可能性もあるので  
バックアップファイルは/tmp配下には置かず/home配下などのほうが良いかも。  
侵入された際に、どのユーザーでも見れてしまう場所にファイルは置かない。

## ローカルにWordPress on Docker

docker-compose で立ち上げる。  
image の wordpress バージョンや php のバージョンはなるべく揃える。

```
version: "3.8"

services:

  wordpress:
    image: wordpress:5.*.*-php7.*-apache
    restart: always
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb
    volumes:
      - wordpress:/var/www/html

  db:
    image: mysql:5.7
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_DATABASE: exampledb
      MYSQL_USER: exampleuser
      MYSQL_PASSWORD: examplepass
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql

volumes:
  wordpress: {}
  db: {}
```
