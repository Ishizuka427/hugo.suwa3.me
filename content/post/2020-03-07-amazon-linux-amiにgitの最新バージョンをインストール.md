---
title: "Amazon Linux AMIにGitの最新バージョンをインストール"
date: "2020-03-07T13:00:00.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
  - "git"
---

WordPressのサーバーにgit cloneしてこようと思ったら躓いたので、備忘録です。

```
       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2018.03-release-notes/
```

普段yumでインストールするので  
今回もCentOSを前提にして調べました。

```
$ yum -y install https://centos7.iuscommunity.org/ius-release.rpm
Error: Package: ius-release-2-1.el7.ius.noarch (/ius-release)
```

```
$ yum -y install https://centos6.iuscommunity.org/ius-release.rpm
Complete!
```

```
$ yum -y install git2u
Error: Package: git216-perl-Git-2.16.6-2.el6.ius.noarch (ius)
```

なるほど、CentOS 6っぽいけれども  
インストールしようとするとコケる。

Gitの公式リファレンスで  
ソースからgitをインストールする方法を確認します。

[Git - Gitのインストール](https://git-scm.com/book/ja/v2/%E4%BD%BF%E3%81%84%E5%A7%8B%E3%82%81%E3%82%8B-Git%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)

Git のバイナリをコンパイルしてインストールするために必要な  
依存ライブラリをインストール

```
$ sudo yum install curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel
```

git-2.24.1.tar.gz

![](/images/スクリーンショット-2020-03-08-18.12.36.png)

```
$ wget https://github.com/git/git/archive/v2.24.1.tar.gz
```

ダウンロードが終わったら、コンパイルしてインストールします。

```
$ tar -zxf v2.24.1.tar.gz
$ cd git-2.24.1
$ make configure
$ ./configure --prefix=/usr
$ make all doc info
    * tclsh failed; using unoptimized loading
    MSGFMT    po/hu.msg make[1]: *** [po/hu.msg] エラー 127
make: *** [all] エラー 2
# ぐぬぬ
$ sudo make install install-doc install-html install-info
```

[yumでGitの最新版をLinuxにインストールする - Qiita](https://qiita.com/suke/items/ee0033a2ee9e68eee13e)

最終的にこれで入りました。

ソースからインストールするのは[manコマンドの日本語化](https://wp.suwa3.me/2019/10/20/man%e3%82%b3%e3%83%9e%e3%83%b3%e3%83%89%e3%81%ae%e6%97%a5%e6%9c%ac%e8%aa%9e%e5%8c%96/)した時以来だったので  
古典的な方法だけれども、確実な方法ではあるため  
慣れておきたいなぁ  
と、いうことでまとめました。
