---
title: "Emotional"
date: "2021-10-23T13:00:27.000Z"
categories: 
  - "note"
tags:
  - "life"
---

git submodule 運用のツラみを聞きながら
「そんなのgit submodule の submodule つくって管理すれば良いじゃん！」
などと言っていた時期がわたしにもありました・・
  
すごくポエムを書きたい気分なので、今日の Tag は "life" です。  
  
今まで hugo on Netlify で blog を運用していたのですが  
「Netlify の代替サービスとして vercel が速いらしい！」  
という噂を聞きつけて移行してみました。  
その感想(ポエム)を感情的に書き綴っていきたいと思います。  
  
移行して2週間でトラップにハマり「やっぱり Netlify に戻そう？」となりましたが理由は後述します。  
  
## 移行感想文
  
よくある Netlify vs Vercel の比較として  
「Netlify の無料プランだと CDN が日本リージョンに未対応のため表示が遅い」  
とありますが、確かに表示速度は Vercel 速いです。  
  
Netlify も Vercel も月100GBの無料枠があり、無料枠分を超過すると Netlify は勝手に有料プランに移行して(通知メールがくる)請求がくるらしいのですが、Vercel はなんと利用自体が止まります！安心！そして2週間で利用できなくなったので一旦設定を全部飛ばしました。🥺

これは完全に自業自得なのですが、Vercel は複数人でのサイト管理(Teamsの作成)は "2週間のみ" お試しで利用できて、お試し期間が終わると**有料プランに移行しないと機能が利用できなくなる**みたいです。
(デフォルトのまま進むと Teams を作成してしまうので、忘れず Skip しようね！)
  
  
利用自体が止まるというよりは、有料プランに移行しないと push(変更)が反映されなくなる感じ。

push(変更)が反映されないということに気づかずに、一時間くらい編集しては commit&push を繰り返して
「反映されないぞ、おかしいな〜？」  
と、ハマりました。**赤文字の警告文はちゃんと読もう。**

「もしかしたら空commit が要るのかも」  
と、勘違いして`git commit --allow-empty -m "eternal commit"`を連発していました。

ちなみに --allow-empty するときは "eternal(永遠の) commit" にするのが習慣なのですが、中二病っぽいとかダサいとか言われて不評です。eternal love とかにしようかな。  
  
次は Error 集です。  
  
### Error_1: Failed to fetch one or more git submodules
  
Vercel で hugo をホスティングする際のハマりポイントとして、Theme の管理があるなと思いました。  
   
Vercel の Discussions にて  
 How to integrate submodules from git? #4800  
 https://github.com/vercel/vercel/discussions/4800  
  
1. (過去) Vercel が git submodule をサポートしていない
2. (現在) HTTPを使用した Public git submodule はサポートされている
  
とのこと。`.gitmodules` ファイルの  
`url = git@github.com:Ishizuka427/papercss-hugo-theme.git`
これを https にすれば良いらしい。  
  
```sh
[submodule "themes/papercss-hugo-theme"]
	path = themes/papercss-hugo-theme
	url = https://github.com/Ishizuka427/papercss-hugo-theme.git
```
  
### Error_2: add site dependencies: load resources: loading templates: "/vercel/path0/themes/papercss-hugo-theme/layouts/partials/head.html:14:1": parse failed: template: partials/head.html:14: unclosed action
  
書き換えただけではError解消されず・・  
なんとsubmoduleの情報って複数の場所に書かれているので、一か所変えてポン！とは変わらないらしい。  
  
- .gitmodules の url を編集
- git submodule sync
- git submodule update
  
メモメモ〜  
Theme の内容をイジるとsubmoduleの沼にハマるなと思いました！  
  
### Error_3: WARN 2021/10/23 07:47:24 Module "papercss-hugo-theme" is not compatible with this Hugo version; run "hugo mod graph" for more information.
  
バージョン起因のErrorです。  
Vercel の Framework preset で hugo を選べたけれど、バージョン管理はどこでやっているんだろうね？と、いうことで結局 make で hugo の install&バージョン管理まで行うことにしました。make での build なら、どんなホスティングサービスに移行したってへっちゃらだね！  

## 所感
いろいろトラップがあったり、サポートされていないハマりどころがあったりしたけど、移行自体は難しくないので Vercel ありかなーの気持ちです。喉元過ぎれば何とやら？またハマり次第「やっぱりNetlifyに戻そう？」などと言い始めると思います。
