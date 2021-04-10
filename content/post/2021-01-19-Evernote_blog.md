---
title: "Evernote blog"
date: "2021-01-19T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Evernote"
  - "Tech"
---

# Evernote blog

今日から試験的に Evernote で blog を書いてみたいと思います。  

今まで Hugo+Netlify で3ヶ月ほどblogを運用していましたが、[Postach.io](https://postach.io/) という Evernote のノートブックをそのままブログにできるサービスがあることを知って、思うところもあり乗り換えてみようと考えました。

## Hugo+Netlify から Evernote+Postach.io へ乗り換えようと考えた理由

### 1) Hugo は Theme カスタマイズが大変そう

GitHub上 などで公開されている Theme を読み込んで簡単に変更できますが、それらをカスタマイズするにはリポジトリをフォークして、cssファイルなどを上書きする必要があります。(ちょっと面倒くさい)

### 2) git 管理が煩わしい

静的サイトジェネレーターは更新の度に git push するのが手間なうえ、書き直したエモい差分が GitHub 上で公開されてしまうなどの問題があります。(これはプライベートリポジトリで管理してしまえば解決します。)

### 3) Markdown では細やかな色付けが難しい

カスタマイズすることで不可能ではないですが、基本的にモノクロで少しさびしいです。

### 4) WYSIWYGエディタマイブームが来ている

GitHub 上でオープンソースの WYSIWYG エディタを探したり、「編集作業とは」について考えることが増えたり、人生で初の WYSIWYG ブームが到来中です。

### 5) Evernote to Markdown のGitHubリポジトリを見つけた

`*.enex`形式でエクスポートされた Evernote を、Markdown ファイルに変換する CLI ツールを見つけました。いつでも Hugo に戻ってこられるね♪

---

Wordpress to Markdown の際も画像の移行で詰まったけれど、たぶん Evernote to Markdown も画像なり日本語のファイル名なりでエラーしそうな予感がしています。Wordpress on EC2 から Hugo+Netlify に乗り換えてから、すっかり blog の更新が減ってしまった。正直、Hugo を触っていて一番テンションが上がった瞬間って、Wordpress からエクスポートしてきた記事を CLI ツールで Markdown に変換して、それを Hugo で問題なく表示できた瞬間がピークでした。  
  
**更新するために、わたしにとって大事なのは書いていてテンションがあがるツールなのでは？**という思いがフツフツと湧いてきたのが大きかったです。  
乗り換える決め手となったのが `Evernote to Markdown の GitHub リポジトリを見つけた` なので、**いずれ Hugo か Git管理 での Blog に戻るでしょう**というツンデレ記事な部分はあります。Blog 書くだけで草生えるしね。

---

**MEMO**

救済措置用  

・Evernote to Markdown  
https://n350071.com/release-enex-to-markdown/  
https://github.com/wormi4ok/evernote2md  
https://github.com/n350071/enex-to-markdown  
