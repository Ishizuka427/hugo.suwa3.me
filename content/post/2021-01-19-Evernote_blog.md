---
title: "Evernote blog"
date: "2021-01-19T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Evernote"
---

# Evernote blog

今日から試験的にEvernoteでblogを書いてみたいと思います。

今までHugo+Netlifyで3ヶ月ほどblogを運用していましたが、[Postach.io](https://postach.io/) というEvernoteのノートブックをそのままブログにできるサービスがあることを知って、思うところもあり乗り換えてみようと考えました。

## ✾ Hugo+Netlify から Evernote+Postach.io へ乗り換えようと考えた理由

### 1) HugoはThemeカスタマイズが手間

GitHub上などで公開されているThemeを読み込んで簡単に変更できますが、それらをカスタマイズするにはリポジトリをフォークして、cssファイルなどを上書きする必要があります。(ちょっと面倒くさい)

### 2) git管理が煩わしい

静的サイトジェネレーターは更新の度にgit pushするのが手間なうえ、書き直したエモい差分がGitHub上で公開されてしまうなどの問題があります。(これはプライベートリポジトリで管理してしまえば解決します。)

### 3) Markdownでは細やかな色付けが難しい

カスタマイズすることで不可能ではないですが、基本的にモノクロで少しさびしいです。

### 4) WYSIWYGエディタマイブームが来ている

GitHub上でオープンソースのWYSIWYGエディタを探したり、「編集作業とは」について考えることが増えたり、人生で初のWYSIWYGブームが到来中です。

### 5) Evernote to Markdown のGitHubリポジトリを見つけた

*.enex形式でエクスポートされたEvernoteを、Markdownファイルに変換するCLIツールを見つけました。いつでもHugoに戻ってこれるね♪

---

Wordpress to Markdownの際も画像の移行で詰まったけれど、たぶんEvernote to Markdownも画像なり日本語のファイル名なりでエラーしそうな予感がしています。

Wordpress on EC2 から Hugo+Netlify に乗り換えてから、すっかりblogの更新が減ってしまった。

正直、Hugoを触っていて一番テンションが上がった瞬間って、Wordpress からエクスポートしてきた記事をCLIツールでMarkdownに変換して、それをHugoで問題なく表示できた瞬間がピークでした。

**更新するために、わたしにとって大事なのは書いていてテンションがあがるツールなのでは？**という思いがフツフツと湧いてきたのが大きかったです。

乗り換える決め手となったのが `Evernote to Markdown のGitHubリポジトリを見つけた` なので、**まぁいずれHugoかGit管理でのBlogに戻るでしょう**というツンデレ記事な部分はあります。Blog書くだけで草生えるしね。

p.s.

|個人的にHugoのThemeで |

---

**MEMO**

救済措置用

・Evernote to Markdown

https://n350071.com/release-enex-to-markdown/

https://github.com/wormi4ok/evernote2md

https://github.com/n350071/enex-to-markdown
![image.png](image/image.png)
