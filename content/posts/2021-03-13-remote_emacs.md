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

リモートサーバー上に、local にあるような Emacs 環境をつくりたい
<br>
<br>

### == 経緯 ==

リモートサーバー上に local で動いている spacemacs (emacs の設定群)の init.el を、そのまま貼ってみた。

＿人人人人人人人人人人＿

＞　まともに動かない　＜

￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^￣

素の Emacs だと動く・・。

これを機に、卒spacemacs してプレーンな Emacs をカスタマイズしていこう！
<br>
<br>

### 設定したものたち
---

1. leaf  
  スタンダードな設定と、ミニバッファの補完パッケージを入れました。  
  (参考: https://emacs-jp.github.io/tips/emacs-in-2020)
  
2. ssh  
  多段 ssh できるように設定する。  
  ※ Trump を使って ssh 接続する際に踏み台を使う場合は、先に ~/.ssh/config の設定をしてしまうほうがラク。  
  ```~/.ssh/config  
  # Gateway
  host XXXX
  HostName XXX.XX.X.XX
     User hoge

  # RemoteHost-out
    Host YYYY
    HostName YY.YYY.YY.YY
    User huga
    ProxyCommand ssh -W %h:%p XXXX
  ```  
3. Trump  
  デフォルトで入っているみたいなので特に設定はなし    
  `C-x C-f /ssh:huga@YYYY:/home/huga` 
  sudo 使う場合    
  `C-x C-f /ssh:user3@hostname3|sudo:hostname3:path/to/file`    
  (参考: https://www.emacswiki.org/emacs/TrampMode)  
4. Theme  
  Twilight Bright が気に入っているので入れたい♡  
  リモートサーバーに Theme の設定を入れてみるも、色が反転してしまって可愛くない・・。ターミナルから emacs を触っているから？Trump で ssh して emacs を触るぶんにはOKだったので、ターミナルで emacs は触らないこ とにしました。  
  (参考: https://github.com/jimeh/twilight-bright-theme.el)  
  ```init.el  
  ;; Theme  
  (leaf twilight-bright-theme :ensure t)
  (require 'twilight-bright-theme)
  (load-theme twilight-bright t)
  ```  
5. 行数表示
  モブプロ時に行数が出てほしいので  
   `M-x linum-mode`  
  色の変更もできました♡  
  ```init.el
  ;; linum-mode の行数色
  (set-face-foreground 'linum "#e6e6fa")
  (set-face-background 'linum "#696969")
  ```
