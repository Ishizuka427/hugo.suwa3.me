---
title: "証明書_cryptographyいれる作業ログ"
date: "2020-05-13T13:00:56.000Z"
categories: 
  - "tech-blog"
tags: 
---

```
# cat /etc/cron.d/certbot-renew
0 0 11 * * certbot-auto renew
```

```
# date
Wed May 13 14:01:27 UTC 2020
```

```
cd /var/log/
# grep 'renew' cron
May 10 14:07:01 ip-172-31-32-207 crond[2663]: (*system*) RELOAD (/etc/cron.d/certbot-renew)
May 10 14:07:01 ip-172-31-32-207 crond[2663]: (CRON) bad username (/etc/cron.d/certbot-renew)
```

＿人人人人人人人人＿  
＞　bad username 　＜  
￣Y^Y^Y^Y^Y^Y^Y^Y^￣

書き換えた

```
# cat /etc/cron.d/certbot-renew
0 0 14 * * root certbot-auto renew
```

そもそも`certbot-auto` はいってる・・？

```
# certbot-auto --help
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

errorワロタ  
`ImportError: No module named cryptography` です。

```
$ which certbot-auto
/usr/bin/certbot-auto
```

`certbot-auto` コマンド自体は入っている

```
# head -n 50 /usr/bin/certbot-auto
#!/bin/sh
#
# Download and run the latest release version of the Certbot client.
#
# NOTE: THIS SCRIPT IS AUTO-GENERATED AND SELF-UPDATING
#
# IF YOU WANT TO EDIT IT LOCALLY, *ALWAYS* RUN YOUR COPY WITH THE
# "--no-self-upgrade" FLAG
#
# IF YOU WANT TO SEND PULL REQUESTS, THE REAL SOURCE FOR THIS FILE IS
# letsencrypt-auto-source/letsencrypt-auto.template AND
# letsencrypt-auto-source/pieces/bootstrappers/*

set -e  # Work even if somebody does "sh thisscript.sh".

# Note: you can set XDG_DATA_HOME or VENV_PATH before running this script,
# if you want to change where the virtual environment will be installed

# HOME might not be defined when being run through something like systemd
if [ -z "$HOME" ]; then
  HOME=~root
fi
if [ -z "$XDG_DATA_HOME" ]; then
  XDG_DATA_HOME=~/.local/share
fi
if [ -z "$VENV_PATH" ]; then
  # We export these values so they are preserved properly if this script is
  # rerun with sudo/su where $HOME/$XDG_DATA_HOME may have a different value.
  export OLD_VENV_PATH="$XDG_DATA_HOME/letsencrypt"
  export VENV_PATH="/opt/eff.org/certbot/venv"
fi
VENV_BIN="$VENV_PATH/bin"
BOOTSTRAP_VERSION_PATH="$VENV_PATH/certbot-auto-bootstrap-version.txt"
LE_AUTO_VERSION="1.4.0"
BASENAME=$(basename $0)
USAGE="Usage: $BASENAME [OPTIONS]
A self-updating wrapper script for the Certbot ACME client. When run, updates
to both this script and certbot will be downloaded and installed. After
ensuring you have the latest versions installed, certbot will be invoked with
all arguments you have provided.
```

`export VENV_PATH="/opt/eff.org/certbot/venv"` とのことなので  
念の為、権限の確認

```
# ls -lh /opt/eff.org/certbot/venv
total 24K
drwxr-xr-x 2 root root 4.0K May 10 14:04 bin
-rw-r--r-- 1 root root   21 May 10 14:03 certbot-auto-bootstrap-version.txt
drwxr-xr-x 3 root root 4.0K May 10 14:04 include
drwxr-xr-x 3 root root 4.0K May 10 14:03 lib
drwxr-xr-x 3 root root 4.0K May 10 14:03 lib64
drwxr-xr-x 2 root root 4.0K May 10 14:03 local
```

venvを有効化

```
# source /opt/eff.org/certbot/venv/bin/activate
```

pipの確認

```
(venv) # which pip
/opt/eff.org/certbot/venv/bin/pip
```

`cryptography` をpip install

```
(venv) # pip install cryptography
Collecting cryptography
  Downloading 
(略)
Successfully installed cffi-1.14.0 cryptography-2.9.2
(略)
```

入ったので

```
(venv) # certbot-auto --help
Error: couldn't get currently installed version for 
(略)
ImportError: No module named cryptography
```

なんでやーん

venv効いてる？

```
(venv) # which pip
/opt/eff.org/certbot/venv/bin/pip
```

```
(venv) # /opt/eff.org/certbot/venv/bin/pip install --target /opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/ cryptography
```

```
(venv) # /opt/eff.org/certbot/venv/bin/pip install --target /opt/eff.org/certbot/venv/local/lib/python2.7/dist-packages/ zope.interface
```

ねむい・・  
素直に入れ直すにゃん  
あした

[Lets Encryptで証明書更新時にcryptographyのエラーが出た時の対処法](https://qiita.com/srai0628/items/9b9b13a673eced8eb199)
