---
title: "Django GirlsチュートリアルでつくったものでDockerfile作成"
date: "2019-10-20T11:20:36.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
  - "django"
  - "djangogirls"
  - "docker"
  - "python"
---

まずDocker Hubで使いたいイメージを探します。  
公式のものなど、なるべく信頼できるイメージをつかった方が良さげです。  
Django Girlsチュートリアルでつくったものはこちらです。

$ ls 
blog            manage.py        myvenv 
README.md        db.sqlite3        mysite            requirements.txt

元になるイメージはpython:3.7.5-slim-busterを選びました。  
Django起動時に打ち込んでいるコマンドを  
Dockerfileに書き込んでいきます。

$ vi Dockerfile 

FROM python:3.7.5-slim-buster 
COPY . /app/ 
WORKDIR /app 
RUN pip3 install -r requirements.txt 
RUN python3 manage.py collectstatic --noinput 
CMD python3 manage.py runserver 0.0.0.0:8000

イメージ名にはわかりやすい名前をつけて  
タグにはバージョン（日付や0.1.0など）を指定してあげると良いです。  
無記入だとlatestになります。

$ docker build -t \[イメージ名\]:\[タグ\] . 
例えば 
$ docker build -t djangogirls:0.1.0 .

最後のドットを忘れないように注意です。  
一覧を出すには

$ docker images 
REPOSITORY        TAG          IMAGE ID             CREATED              SIZE 
djangogirls              latest        53a38ee83c1a      24 minutes ago 

Dockerを走らせる前に  
ローカルで何か走っていないか確認します。  
※特にローカルで走らせているものがなければ、以下読み飛ばしてもOKです。

$ ps -ef | grep runserver 
  502  2437   479   0 土02PM ttys000    0:00.60 /Library/Frameworks/Python.framework/Versions/3.7/Resources/Python.app/Contents/MacOS/Python manage.py runserver 
  502  2438  2437   0 土02PM ttys000   58:01.79 /Library/Frameworks/Python.framework/Versions/3.7/Resources/Python.app/Contents/MacOS/Python manage.py runserver 
  502 26677 13920   0  3:55PM ttys003    0:00.01 grep runserver

とても大まかに書くと

2437（子:Django）    479（親:shell） 
2438（子:Python）　  2437（親:Django） 
26677 13920 => いま検索したgrepコマンドが走っているので無視

だいたいこんな感じです。  
shellは殺さず、2437を殺せば親のDjangoもろとも子の2438も死ぬので  
Djangoで走りっぱなしでいたrunserverをkillします。

$ kill 2437

killできたか確認。

$ ps -ef | grep runserver 
  502 26680 13920   0  3:55PM ttys003    0:00.01 grep runserver

Dockerを走らせます。djangogirlsはDocker IDでもOKです。

$ docker run -it --rm -p          djangogirls

下記にアクセス

http://127.0.0.1:8000/

![](http://wp.suwa3.me/wp-content/uploads/2019/10/image-8.png?w=840)

できた👏

**Tips**  
全体的に重かったので.dockerignoreを作成し、いったん無視するファイルを指定します。

$ vi .dockerignore 

myvenv 
db.sqlite3

myvenvは仮想環境なので不要です。  
db.sqlite3はDockerに乗せるには今後重くなる可能性が高いので  
もしデプロイする際にはMySQLなど外付けDBを使っても良いかもです。  
ちなみにDBをignoreで無視するとDockerを走らせた際に赤文字で

You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, blog, contenttypes, sessions. 
Run 'python manage.py migrate' to apply them.

このようにDBに問題ありなどと表示されます。  
あえてignoreしている場合はスルーです。
