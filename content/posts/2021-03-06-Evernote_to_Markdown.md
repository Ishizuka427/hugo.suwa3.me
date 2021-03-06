---
title: "Evernote to Markdown"
date: "2021-03-05T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Evernote"
---

# Evernote to Markdown

ここのREADME.mdの通りに実行したらできました。

https://github.com/wormi4ok/evernote2md

今回はDockerを使ってみました🐳

※バージョンが19系だったので最新の20系にUpdateしました

## Evernoteのエクスポートファイル.enexを.md形式に変換

先にEvernoteの記事をExportしておきます

[ノートをエクスポートする – Evernote ヘルプ＆参考情報](https://help.evernote.com/hc/ja/articles/209005557-ノートをエクスポートする)

```
% mkdir exports
% mv ~/Downloads/Mynote.enex .
% docker run -t --rm -v "$PWD":/tmp -w /tmp wormi4ok/evernote2md:latest exports/Mynote.enex ./notes
Unable to find image 'wormi4ok/evernote2md:latest' locally
latest: Pulling from wormi4ok/evernote2md
ba3557a56b15: Pull complete 
2c339f1d5460: Pull complete 
Digest: sha256:e4d5eb9715f4a8b096e58c393a227f88d3c79fcecb2d2d0da33b0e9c7f0561b2
Status: Downloaded newer image for wormi4ok/evernote2md:latest
Notes: 5 / 5 [===========================================================================================] 100.00% 0s
Done!
```

あるか確認

```
notes % ls
Evernote_blog.md		Shell_Script.md			purpose_of_the_week.md
Kubernetes_Middle_Way.md	image
```

良さそう。

## 日付の編集
2021-01-19-Evernote_blog.md
2021-01-24-Shell_Script.md
2021-01-22-purpose_of_the_week.md
2021-01-24-Kubernetes_Middle_Way.md

## 記事をhugoへ移動

`mv ~/Ishizuka427/notes/*.md ~/Ishizuka427/hugo.suwa3.me/content/posts/`

記事データの編集

タイトルなど書く

これはhugoのドキュメント

[Quick Start | Hugo](https://gohugo.io/getting-started/quick-start/#step-4-add-some-content)

例

```
---
title: "Evernote blog"
date: "2021-01-19T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Evernote"
---
```
