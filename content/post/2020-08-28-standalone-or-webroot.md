---
title: "standalone or webroot"
date: "2020-08-28T13:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
---

## 証明書

また証明書が切れて、つらい思いをしたので備忘録！  
来週あたり手動で `certbot renew` を実行して  
大丈夫そうだったら cron 化しちゃう。

```
$ sudo su -
# cd cert-venv/
# source bin/activate
(cert-venv)# certbot --help

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  certbot [SUBCOMMAND] [options] [-d DOMAIN] [-d DOMAIN] ...

Certbot can obtain and install HTTPS/TLS/SSL certificates.  By default,
it will attempt to use a webserver both for obtaining and installing the
certificate. The most common SUBCOMMANDS and flags are:

obtain, install, and renew certificates:
    (default) run   Obtain & install a certificate in your current webserver
    certonly        Obtain or renew a certificate, but do not install it
    renew           Renew all previously obtained certificates that are near
expiry
    enhance         Add security enhancements to your existing configuration
   -d DOMAINS       Comma-separated list of domains to obtain a certificate for
(略)
```

今回は完全に切れちゃったので `certbot renew` は使えません。

```
(cert-venv)# certbot certonly --dry-run -d wp.suwa3.me
Saving debug log to /var/log/letsencrypt/letsencrypt.log

How would you like to authenticate with the ACME CA?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: Spin up a temporary webserver (standalone)
2: Place files in webroot directory (webroot)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2
```

**standalone か webroot  
**standalone は簡易 web サーバーが立ち上がって証明書の発行を行う  
(それは既にある Apache とぶつかる)

今回既に web サーバーが立ち上がっているので  
Let's Encrypt 側に証明してもらうルートディレクトリの場所を伝える  
と、いうことで webroot (つまり2) を選択する。

```
Input the webroot for wp.suwa3.me: (Enter 'c' to cancel): /var/www/
```

Apacheを再起動します。

```
(cert-venv)# service httpd restart
Stopping httpd:                                            [  OK  ]
Starting httpd:                                            [  OK  ]
```
