---
title: "Configure init.el so that twilight-bright-theme works"
date: 2021-11-21T00:00:00.000Z
categories: 
  - "tech-blog"
tags:
  - "Tech"
---

## Theme の設定が効いていない
emacs のバージョンを上げてから Theme が効いていない Error を放置していたので何とかしました。ちなみにこの Error を解消したら Theme より下に設定されていたものたちが全て効くようになりました。今回の件で、Error は早めに摘もうという気持ちになりました。

## 修正箇所
これは emacs のバージョンを上げるたびに起こりうる Error のため、忘れないように手順を残しておきます。  
emacs version: 27.2  
  
修正前の init.el
```lisp
;; Theme
(leaf twilight-bright-theme :ensure t)
(require 'twilight-bright-theme)
(load-theme twilight-bright t)
```
  
修正後の init.el
```emacs-lisp
;; Theme
(leaf twilight-bright-theme :ensure t)
(require 'twilight-bright-theme)
(setq custom-theme-directory "~/.emacs.d/elpa/twilight-bright-theme-20130605.843/")
(load-theme 'twilight-bright t)
```

1. `'twilight-bright-theme` から Tag jump して `/elpa` 配下で設定しているフルパスを入手する ※ `alt + .`
2. `setq custom-theme-directory` で、1で入手したフルパスを指定する
3. `twilight-bright` の先頭にシングルクォートを付けてシンボルにする

あとは `;; Theme` 以下を上から一行ずつ eval して表示を確認していく

![](/images/SS_2021-11-21_18.33.59.png)

マーカーみたいでかわゆい
