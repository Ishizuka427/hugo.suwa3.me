---
title: "Slack見落とし撲滅作戦 Python + Selenium"
date: "2020-01-19T13:00:00.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
  - "python"
  - "selenium"
  - "%e8%87%aa%e5%8b%95%e5%8c%96"
---

Slackで、自分宛てにメンションされたものを見落としてしまい  
どうしたものかと悩んでいた際に、同僚から

「Slack内の検索窓で『to:@<自分の名前>』って検索すれば、自分宛てのメンションを検索できますよ」

と、教えてもらい  
「そんな機能あるのか！」  
と、感動したと同時に  
「しかしその検索する行為ですら、わたしは忘れてしまう人間なのだ！」  
と、絶望したので  
なんとか教えていただいた便利機能を有効的に使えないかと考えたのが

『Slack見落とし撲滅作戦』

です。

案① ブラウザ版Slack内の検索窓で｢to:@<自分の名前>｣と毎朝検索するのを習慣化する  
案② たぶん習慣化できないのでPython + Seleniumで自動化する

とりあえず途中までやったので  
備忘録です。

# 環境

- MacOS Mojavi 10.14.6
- Python3
- pip

# 環境分離してseleniumをインストール

`selenium-slack`ディレクトリを作成します。

```
$ mkdir selenium-slack
$ cd selenium-slack/
```

仮想環境を作成します。

```
$ python3 -m venv myvenv
```

有効化します。

```
$ source myvenv/bin/activate
```

seleniumをインストールします。

```
$ pip3 install selenium
```

# ChromeDriver のインストール

**ChromeDriver**とは、Google Chromeを操作するために必要なドライバ（ソフト）です。 ブラウザごとに専用のドライバが用意されています。

バージョンを指定してChromeDriverをインストールします。  
例えば、現在つかっているChromeのバージョンをチェックして

![](/images/image.png)

![](/images/スクリーンショット-2020-01-20-1.41.39.png)

それに合わせたバージョンのChromeDriverをインストールします。  
[ChromeDriver - WebDriver for Chrome](http://chromedriver.chromium.org/downloads)

例えば79であれば、こちらです。

![](/images/image-1.png)

![](/images/スクリーンショット-2020-01-20-0.11.23.png)

  
ChromeDriverプログラムのパスを指定してあげます。

```
 $ driver = webdriver.Chrome(executable_path='./chromedriver')
```

  
試しにサンプルを書いてみます。

```
$ vim sample.py
 from selenium import webdriver
 driver = webdriver.Chrome(executable_path='./chromedriver')
 driver.get('https://www.google.com/')
```

  
実行してみると、Chromeブラウザが起動します。

```
 $ python3 sample.py
```

![](/images/スクリーンショット-2020-01-19-23.57.41.png)

  
今回はSlackの操作をしたいので  
URLを指定して起動させます。  
`sample.py`の3行目 `driver.get`以降のURLを書き換えます。

```
sample.py
 from selenium import webdriver
 driver = webdriver.Chrome(executable_path='./chromedriver')
 driver.get('https://app.slack.com/client')
```

  
実行してみると、Slackのサインイン画面が表示されます。

```
 $ python3 sample.py
```

![](/images/スクリーンショット-2020-01-20-0.17.19.png)

  
次はサインインをするためにワークスペースのSlack URLを入力します。  
fn+F12(WindowsはF12)で、デベロッパーツールを開いてみます。  
下画像の矢印部分をクリックすると、選択した部分の中身を見ることができます。

![](/images/スクリーンショット-2020-01-20-0.18.39-1.png)

  
入力したい箇所を選択してみるます。

![](/images/スクリーンショット-2020-01-20-0.18.59-1.png)

  
対応している部分を確認してみると `id="domain"`とのことなので  
idを目印に入力させたいと思います。  
id属性は基本的にひとつだけ指定できるものなので、idで指定できるのであれば  
それが一番効率が良いみたいです。

![](/images/スクリーンショット-2020-01-20-0.19.21.png)

  
例えば`id="domain"`の欄に、`suwa3` と入力したい場合  
`sample.py`の下に`stats = driver.find_element_by_css_selector("#domain").send_keys("suwa3")`  
を追加します。

```
sample.py
 from selenium import webdriver
 driver = webdriver.Chrome(executable_path='./chromedriver')
 driver.get('https://app.slack.com/client')
 stats = driver.find_element_by_css_selector("#domain").send_keys("suwa3")
```

  
実行してみると、suwa3と入力されています。

```
 $ python3 sample.py
```

![](/images/スクリーンショット-2020-01-20-0.31.31.png)

以下の記事を参考にしました。  
(参照) [Python + Selenium で Chrome の自動操作を一通り](https://qiita.com/memakura/items/20a02161fa7e18d8a693#by-id)  
(参照) [Selenium webdriverよく使う操作メソッドまとめ](https://qiita.com/mochio/items/dc9935ee607895420186#%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E3%82%92%E5%85%A5%E5%8A%9B%E3%81%97%E3%81%9F%E3%81%84%E3%81%A8%E3%81%8D)

このような具合で、動作一つ一つを確認しながら書いていきます。  
上記のQiita記事はとても参考になるので  
自動化させたい動作を一行一行書いてみて、試行錯誤してみてください。

また、続きを書いたら更新したいと思います！

# おまけ

実行のたびにChromeが起動してプロセスが走るため、検証が終わったらChromeを終了をさせてあげてください。

![](/images/スクリーンショット-2020-01-20-0.33.37.png)
