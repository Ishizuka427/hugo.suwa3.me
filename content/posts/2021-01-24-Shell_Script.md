---
title: "Shell Script"
date: "2021-01-24T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Shell Script"
---

# Shell Script

Shell Script をキチンとやろうと思って色々さわったので備忘録メモです。

# [独学プログラマー](https://honto.jp/netstore/pd-contents_0628926695.html)のPart3 (第16章 Bash, 第17章 正規表現) を読む

## Bash (オプション_コラム)

```
$ ls --author -l    # Ubuntu
```

--author オプション初めて使ったかも。ls の help を見たら -A とのこと。なるほど〜

```
$ ls --help    # Ubuntu
Usage: ls [OPTION]... [FILE]...
List information about the FILEs (the current directory by default).
Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.

Mandatory arguments to long options are mandatory for short options too.
  -a, --all                  do not ignore entries starting with .
  -A, --almost-all           do not list implied . and ..
      --author               with -l, print the author of each file
(略)
```

macOS では --author オプションが存在しなかった(;_;)

ただ -author オプションであれば動作するのだけれど、これは -a, -u, -t, -h, -o, -r を同時に指定したコマンドというだけで Ubuntu 上の --author とは別物らしい。(そりゃそうか) ほえ〜〜

```
$ ls -author -l    # macOS
```

## 正規表現

_口ではなんとでも言える。コードを見せなさい。ーーリーナス・トーバルズ_

き、厳しい〜〜

正規表現に自信のないわたしにはグサグサ刺さった上に、何も言えない気持ちになりました・・

```
$ python3 -c "import this" > zen.txt
$ cat zen.txt 
The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!
```

grep の練習用として使うテキスト(Tim Peters の詩)が詩人だなぁと思ったので載せました。

```
$ grep Beautiful zen.txt 
Beautiful is better than ugly.

$ grep -i beautiful zen.txt    # -i は大文字小文字の違いを無視
Beautiful is better than ugly.

$ grep -o Beautiful zen.txt    # -o は一致した単語のみ抽出
Beautiful

$ grep ^If zen.txt    # キャレット記号(^)は行の先端に一致するものを表示
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.

$ grep idea. zen.txt    # ピリオド(.)は xx. の xx の後ろに何がきても一致する
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!

$ grep im. zen.txt
The Zen of Python, by Tim Peters
Explicit is better than implicit.
Simple is better than complex.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.

$ grep idea.$ zen.txt    # ドル記号($)は行の終端に一致するパターン
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.

$ grep im.$ zen.txt    # 何も表示されない

$ grep implicit.$ zen.txt    # implicit. で終わる行が表示される
Explicit is better than implicit.
```

### 複数文字との一致

$ echo Two too. | grep -i t[wo]o

**Two too**.

$ echo Two too twoo. | grep -i t[wo]o

**Two too two**o.

$ echo Two too twoo towo. | grep -i t[wo]o

**Two too two**o towo.

↑一致する部分を赤く表示

[abc] は a, b, c のどれか1文字に一致する。

つまり t[wo]o は`t で始まり、その次に o か w の文字がきて、次に o がくる` ということ。

※ macOS(zsh) では再現されず。Ubuntu で実行しました。

### 数値との一致

$ echo 123 hi 34 hello. | grep [[:digit:]]

**123** hi **34** hello.

$ echo 123 hi 34 hello. | grep -o [[:digit:]]

**1**

**2**

**3**

**3**

**4**

### 繰り返し

$ echo tw two twoo twooo not too. | grep two*

**tw two twoo twooo** not too.

「直前のパターンが0回以上一致」

two* であれば `tw という文字のあとに0回以上のoが続く文字列に一致する` ということ。

$ echo _hello_there | grep -o _.*_

**_hello_**

ピリオド(.)は、どんな文字にも一致する。

アスタリスク(*)と組み合わせることで、どんな文字列にも一致する。

このアスタリスクは**貪欲なので**、できるだけ長い文字列に一致する。

$ echo _hi_bye_hi_there | grep -o _.*_

**_hi_bye_hi_**

### エスケープ

$ echo I love $ | grep $

I love $

$ echo I love $ | grep \\$

I love **$**

特殊な文字をエスケープして本来の文字に一致させたい場合、文字の前にバックスラッシュ(\)をつける。

# [シェルスクリプト練習問題（入門編）](http://g-network.boo.jp/wiki/2018/02/post-879/)について

後日やる

# [シェルスクリプト練習問題（中級編）](http://g-network.boo.jp/wiki/2018/02/post-909/)について

MEMO

[one-tab](https://www.one-tab.com/page/5ymg3YMESzGyShTP4RwR0Q)
![image.png](image/image.png)
