---
title: ".gitignore&新リポジトリ"
date: "2019-09-24T13:00:00.000Z"
categories: 
  - "%e6%9c%aa%e5%88%86%e9%a1%9e"
tags: 
  - "git"
  - "github"
  - "hexo"
  - "netlify"
---

静的サイトジェネレーターの続きやりました。

Hexoのローカルサーバーを hexo server コマンドで起動しようとしたら

すでに何か走っているらしく起動できなかったので、調べてみた。

```
$  lsof  -i:4000
```

![](/images/2019-09-24_17.19.09.png)

$ ps -ef | grep 80174

![](/images/2019-09-24_17.34.21.png)

ふむふむ

Hexoだな。

ヘクソって屁糞みたいで汚い。

C+cしても止まらないので、まあいいやとおもい放置です。

$ kill -KILL 80174

で指定して止めることも可能ぽい。

Hexoのディレクトリをgit管理してNetlifyでデプロイするのを早くやりたいので

リポジトリを作るまえにtreeで確認したら

942 directories, 6294 files

途方もない量でした。

どうやら

$HOME/blog/node\_modules

この下に大量のディレクトリやファイルがあるみたい。

$ vi .gitignore

と書いたら

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-24-17.53.28.png?w=243)

なんと最初から不要そうなものが書いてある！

ふしぎ！

**gitignore とは** Git の管理に含めないファイルを指定するためのファイル。 
設定方法：無視設定を行いたいフォルダに .gitignore という名前でテキストファイルを作成する。

gitignore のテンプレ、ググると各言語ごとに用意されている。

なるほどー

  
チェックを入れずにリポジトリつくって

$ git init .

$ `git remote add origin git@github.com:suwa3/Hexo-blog.git`

$ git commit -m 'Initial commit' --allow-empty

$ `git push --set-upstream origin master`

空コミットを追加して、あとはいつも通り

$ git add .
$ git commit -m "new blog"
$ git push

で、いけました。

Netlifyの登録をして

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-25-0.03.39.png?w=1024)

ここまで進んだ！

カスタムドメインはhexo.suwa3.meかなあ。

AWSのRoute53でsub domainの設定のとき

AレコードじゃなくてNSレコードを指定するの忘れずにやります、おー！
