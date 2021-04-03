---
title: "Amazon Linux AMIにPython3系をインストール"
date: "2020-03-20T13:00:00.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
  - "python"
---

https://wp.suwa3.me/2019/12/28/pixela%e3%81%a8%e3%81%84%e3%81%86%e8%8d%89api%e3%82%b5%e3%83%bc%e3%83%93%e3%82%b9%e3%82%92%e5%88%a9%e7%94%a8%e3%81%97%e3%81%a6%e3%80%81wordpress%e3%81%aepv%e6%95%b0%e3%82%92github%e9%a2%a8%e3%81%ab-2/

Pixela × GA cronの中身が置いてある[GitHubリポジトリ](https://github.com/Ishizuka427/wp-pixela/blob/master/google_analytics_access.py)です。

こちらのcronがうまく実行できていなかったので  
まずは手動で実行してみて  
何のerrorが出るかを確認して対処しました。

## 日付を指定して実行

日付を指定して実行するには  
コメントのように書き直します。  
参照: [datetime --- 基本的な日付型および時間型 — Python 3.8.2 ドキュメント](https://docs.python.org/ja/3/library/datetime.html)

```
def main():
  analytics = initialize_analyticsreporting()
  yesterday = date.today() - datetime.timedelta(days=1)
  # yesterday = datetime.date(2020, 2, 24) 　# 日付を指定して実行する場合
  response = get_report(analytics, yesterday)
```

## 手動実行してerrorの確認

サーバーにログイン後  
登録されているcron一覧を表示します。

```
# crontab -l
0 2 * * * cd /opt/wp-pixela && python3 google_analytics_access.py
```

試しに手で実行してみました。

```
# cd /opt/wp-pixela && python3 google_analytics_access.py
-bash: python3: command not found
```

## errorの原因

python3が無いっぽい。  
参照: [Python3.6 インストール on Amazon Linux AMI - Qiita](https://qiita.com/hitobb/items/62bcd1c4995d996d4652)

```
# which python3
/usr/bin/which: no python3 in (/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin:/root/bin)
```

pythonはある。

```
# which python
/usr/bin/python
```

バージョンが  
2.7.16なので直します。

```
# python -V
Python 2.7.16
```

Amazon Linux 2 では無いことを確認します。

```
# cat  /etc/system-release 
Amazon Linux AMI release 2018.03
```

インストール可能なPythonのバージョンを、新しいものから順に確認してみます。

```
# yum list | grep python38
# yum list | grep python37
# yum list | grep python36
mod24_wsgi-python36.x86_64           3.5-1.25.amzn1                amzn-updates 
python36.i686                        3.6.10-1.16.amzn1             amzn-updates 
python36.x86_64                      3.6.10-1.16.amzn1             amzn-updates 
python36-bcc.x86_64                  0.6.0-5.2.amzn1               amzn-updates 
python36-bcc.noarch                  0.10.0-1.1.amzn1              amzn-updates 
python36-debug.i686                  3.6.10-1.16.amzn1             amzn-updates 
python36-debug.x86_64                3.6.10-1.16.amzn1             amzn-updates 
python36-devel.i686                  3.6.10-1.16.amzn1             amzn-updates 
python36-devel.x86_64                3.6.10-1.16.amzn1             amzn-updates 
python36-libs.i686                   3.6.10-1.16.amzn1             amzn-updates 
python36-libs.x86_64                 3.6.10-1.16.amzn1             amzn-updates 
python36-lit.noarch                  0.5.1-1.0.amzn1               amzn-updates 
python36-pip.noarch                  9.0.3-1.27.amzn1              amzn-updates 
python36-setuptools.noarch           36.2.7-1.33.amzn1             amzn-main    
python36-test.i686                   3.6.10-1.16.amzn1             amzn-updates 
python36-test.x86_64                 3.6.10-1.16.amzn1             amzn-updates 
python36-tools.i686                  3.6.10-1.16.amzn1             amzn-updates 
python36-tools.x86_64                3.6.10-1.16.amzn1             amzn-updates 
python36-virtualenv.noarch           15.1.0-1.14.amzn1             amzn-main    
```

python3.6をインストールすることにしました。

## Python3.6をインストール

```
# yum -y install python36-devel python36-libs python36-setuptools 
```

確認してみた。良さそう。

```
# python -V
Python 2.7.16
# python3 -V
Python 3.6.10
```

pip3が入っていなさそうなので入れます。

```
# pip --version
pip 9.0.3 from /usr/lib/python2.7/dist-packages (python 2.7)
# pip3 --version
-bash: pip3: command not found
```

```
# python3 -m ensurepip --upgrade
```

python3で実行してみました。

```
# cd /opt/wp-pixela && python3 google_analytics_access.py
Traceback (most recent call last):
  File "google_analytics_access.py", line 5, in <module>
    import requests
ModuleNotFoundError: No module named 'requests'
```

requestsモジュールを入れ忘れている。  
とりあえず全部入れます。

```
# pip3 install google-api-python-client oauth2client requests python-dotenv
```

再度、実行してみます。

```
# cd /opt/wp-pixela && python3 google_analytics_access.py
```

できました👏

![](/images/スクリーンショット-2020-03-21-21.23.33.png)
