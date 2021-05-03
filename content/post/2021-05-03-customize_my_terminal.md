---
title: "Customize my Terminal"
date: "2021-05-03T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Tech"
---

GWだしターミナルのカスタマイズしたい！  
ということで、いじってみました。備忘録です。

## 環境
- macOS Catalina
- zsh

## 最終形態

zshrc
```
source ~/.git-prompt.sh

# Prompt option display settings
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# Default prompt
setopt PROMPT_SUBST ; PS1='💠 %F{cyan}%n@%m%f: %F{white}%~%f %F{red}$(__git_ps1 "(%s)")%f
\$ '
```

![](/images/SS_2021-05-03_22.57.02.png)

デスクトップの背景にはM78星雲を設定し、ターミナルの背景を半透明にしてうっすらと見えるようにしてあります。非常にエモいですね。  
制御文字で、ターミナルを起動するたびに[バルタン星人](https://github.com/Ishizuka427/dot-Alien_Baltan)が出現するようにしました。これでリモートサーバーと間違えません。

## プロンプト
表示させたいもの
- ユーザー名
- ホスト名
- カレントディレクトリ
- 現在のブランチ名

プロンプト部分の表示が長くなると入力できる長さが短くなってしまうので、入力部分のみ改行して表示させたい。

パラメータ|出力内容
--|--
%n|ユーザー名
%m|ホスト名
%~|カレントディレクトリ

※ブランチ名については後述します

シンプルに書くとこんな感じ

```
PS1='%n@%m: %~ %#'

# 表示
ユーザー名@ホスト名: ~/Ishizuka427 %
```

### 色をつける

%F{色}文字列%f

ユーザー名、ホスト名の部分をcyan色にしてみます。
```
%F{cyan}%n@%m%f
```

black, red, green, yellow, blue, magenta, cyan, white の7色から選んで指定できます。

### 現在のブランチ名

https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

コメントアウト部分に詳細な使い方が書かれていました。

1. git-prompt.sh を隠しファイルで保存して、zshrc 内で読み込みます。
2. `GIT_PS1_SHOWXXXX=` ステータスを好みに応じて編集します。(ブランチの横に、差分がなければ=が表示されたり、トラックされていないファイルがあった場合に%が表示されたりします)
3. `setopt PROMPT_SUBST ; PS1=` を追記して、好きな場所に`$(__git_ps1 "(%s)")`を置きます。

```
source ~/.git-prompt.sh

# Prompt option display settings
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# Default prompt
setopt PROMPT_SUBST ; PS1='%n@%m: %~ $(__git_ps1 "(%s)") \$ '
```

## バルタン星人

~/.zprofile に制御文字をベタ書きしました。  
ドットで推しの絵を書いたら、ターミナルに表示させると楽しいです。  
↓下記をひたすら組み合わせる。

```
$ sudo vi ~/.zprofile
echo '    \e[47m  \e[0m'

$ source  ~/.zprofile
```

## 感想
プロンプトの文字色の変更は`PS1=`以降の可読性が下がるなぁと感じたので、いじらないならいじらないほうが良さそうと思いました。
