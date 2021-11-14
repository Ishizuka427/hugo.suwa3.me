---
title: "Fix checkbox"
date: "2021-11-14T00:00:00.000Z"
categories: 
  - "tech-blog"
tags:
  - "Tech"
---

## 暫定対処
https://github.com/zwbetz-gh/papercss-hugo-theme  
hugo の上記 Theme で、Markdown の チェックボックス表記が崩れている状態だった。  
![](/images/SS_2021-11-14_17.56.27.png)

custom.css に以下の修正を加えることで解消した。  
```custom.css
ul li input {
    display: inline;
}
```
![](/images/SS_2021-11-14_17.58.15.png)

ただ、この修正は根本的な解決にはならない。修正の影響範囲が大きくなってしまうため、予期せぬところでまた表記が崩れる可能性が出てくる。  

## 根本解決への道筋(仮)
1. class 属性を付与してそれぞれ表記を指定する → 修正箇所が増えるけれど影響範囲は小さい
2. hugo の Markdown レンダリングエンジンについて調査する → 大変

良い機会なので、hugo の Theme を何か作ってみたいなぁと思いました。

## 郷に入っては郷に従え
https://github.com/zwbetz-gh/papercss-hugo-theme/blob/master/static/css/paper.css#L745-L781  
「ul li xx の場合は」  
ul, li, xx, など、それぞれの場合について細かく指定しているようなので暫定的な対処で良さそう。

## issue&PR 作成の準備_TODO
わたしは手元で既に custom.css に変更を加えてしまっている。
1. papercss hugo theme を使用して最小構成で作成しなおす
2. 同様の表記崩れがあることを確認する
3. スクショを作成して、暫定対処の内容で issue&PR 作成

## 感想
hugo のレンダリングエンジンに手を加えるというのは Theme の世界から外れて hugo の修正になってしまう。まずは Theme の中で完結する(つまり暫定対処の)修正をせざるを得ないのかもしれない。  

ただ暫定的な対処の場合だと hugo 内で Markdown を表記させる場合には妥当だけれども、Org-mode からリスト表示させる場合は `<p></p>` で行っているようだった。つまり Org-mode から表示させたときに、この修正は効かなくなってしまう。

## PaperCSS
README.md を読み、よくよく追ったら papercss hugo theme の `/static/css/paper.css` は以下のファイルから取ってきたものらしい。  
https://github.com/papercss/papercss/tree/master/dist  
そうなると PaperCSS オリジナルを修正する必要が出てくる。(そして、その修正をオリジナルに要求することは、 hugo に転用しているこちらの勝手な都合のため現実的ではない)  
もし仮に papercss hugo them へ issue を報告しても、custom.css で対処する以外の妥当な解決策が思いつかない。  
