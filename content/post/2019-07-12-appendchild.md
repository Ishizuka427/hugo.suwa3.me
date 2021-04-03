---
title: "appendChild"
date: "2019-07-12T13:00:01.000Z"
categories: 
  - "%e6%9c%aa%e5%88%86%e9%a1%9e"
tags: 
  - "javascript"
---

Rabbit gameをつくっていて

左側に謎のBoxがひとつ余分にできていたのと

センタリングできない問題があったの。

謎Boxは、ただの消し忘れで

.

センタリングできない問題は、親子問題で解決しました。

appendChildがなかなか理解できなくて

図に描いたら分かった。

![](/images/19-07-13-19-57-31-847_deco3406595342467071591.jpg)

バツが間違い、星が正しい。

scriptタグ内に、divをbodyの子要素として追加してしまっていたので

boxが外に出てしまっていたの。

developerツールをみて中身理解しようとおもいました。

.

https://suwa3.github.io/Rabbit-game

Rabbit gameは加点式にして

ポイントを貯められる要素つけたい。

.

メンテナンスページに置いて

メンテナンス中にだけ出現するgame良いなあとおもいました🐰
