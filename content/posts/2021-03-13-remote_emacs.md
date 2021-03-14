---
title: "Remote Emacs"
date: "2021-03-13T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Emacs"
---


# Emacs 奮闘記
  
## 🌟 ゴール
---

VM 上に、local にあるような Emacs 環境をつくりたい

### ◆ VM 上に local で動いている spacemacs の init.el をそのまま貼ってみた

→まともに動かない。素の emacs だと動く。

### ◆ 素の emacs を入れていい感じに設定群を入れてみる

https://emacs-jp.github.io/tips/emacs-in-2020

leaf のスタンダードなものと

ミニバッファの補完パッケージを入れた。ここまでは VM 上でも OK

### ◆ お気に入り Theme の Twilight Bright を入れたい！

https://github.com/jimeh/twilight-bright-theme.el

ということで設定を入れて local で eval → OK

VM 上で同様に設定を入れるも色が反転して可愛くない・・なぜ・・

**ターミナルから emacs を開いている起因？**

### ◆ emacs から ssh で VM サーバーに接続する方針

1. いったん ~/.ssh/config を編集して一発 ssh でログインできるようにする。(多段 ssh 設定する)
2. Trump を使う。

https://www.emacswiki.org/emacs/TrampMode

デフォルトで入っているみたいなので特に設定はなし

`C-x C-f /ssh:bird@bastion|ssh:you@remotehost:/path`

local と (最低限) 同じような設定＆Theme でリモートサーバー先の file を emacs で開けた🙌

あとはモブプロ時に行数出てほしい

`M-x linum-mode`
