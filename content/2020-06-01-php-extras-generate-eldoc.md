---
title: "Warning"
date: "2020-06-01T13:00:00.000Z"
categories: 
  - "poem"
  - "tech-blog"
tags: 
---

Emacsでphpの環境を整えていたら依存packageでWarningがウザくて2年前のissueがcloseしていなかった話です。

今日はEmacsに`php-mode` をインストールしていたら

```
Warning (emacs): PHP function descriptions not loaded. Try M-x php-extras-generate-eldoc
```

👆このWarningが出続けて仕方ないので  
「依存packageなのかな？」  
と、いうことで `php-extras-generate-eldoc` もインストールしたの。

でも、調べてみたら2年前に「noisyだ！」ってissueが飛ばされていて、未だにcloseしていなかった。(状況が若干違うし、今回よりも酷かったぽいけれど)  
これ普通に警告うるさいもんな・・と思いました。  
警告が一度出てyesでもすれば、それ以降は不要だと思う。

[spacemacs - PHP function descriptions not loaded. Try M-x php-extras-generate-eldoc - Emacs Stack Exchange](https://emacs.stackexchange.com/questions/44530/php-function-descriptions-not-loaded-try-m-x-php-extras-generate-eldoc/44639#44639)

> I set the following in my spacemacs config:  

```
   dotspacemacs-excluded-packages '(
                                    php-extras
                                    )
```

👆これでWarning非表示にはできるらしい。  
対処療法って感じ。

ちなみにGitHubで詳細はこちらに書かれています。  
[](https://github.com/arnested/php-extras/blob/develop/php-extras-gen-eldoc.el#L46-L50)[https://github.com/arnested/php-extras/blob/develop/php-extras-gen-eldoc.el#L46-L50](https://github.com/arnested/php-extras/blob/develop/php-extras-gen-eldoc.el#L46-L50)

* * *

お昼休みは、Go勉強会の課題をやっていました。  
「gRPCわからんなー」  
と思って調べて  
HTTP/2の利点がふんわりわかった (gRPCは分からん)

あと気になったのはGo製静的サイトジェネレーター  
[HUGO](https://gohugo.io/) です。触ってみよう。

LLVMも興味あったので少し調べました。  
[大学院生のためのLLVM | POSTD](https://postd.cc/llvm-for-grad-students/)  
以前、学生時代に言語自作の課題が出されて  
最近思い出して言語の自作について調べていたら  
思っていたよりも沼で泣きながら撤退したのだけれども  
LLVMを使えば、ある程度環境が整った状態から作れるのでは・・  
と、少し希望の光が見えたよ。勉強がてらやってみたいなぁ。
