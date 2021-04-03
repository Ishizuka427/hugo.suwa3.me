---
title: "Pixelaという草APIサービスを利用して、WordPressのPV数をGitHub風に草生やしてサイドバーに表示させたい"
date: "2019-12-25T13:00:00.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
---

タイトルのとおりです。  
[https://pixe.la/](https://pixe.la/)

## 準備

1. 「うさぎでもわかる」にGoogle Analytics導入
2. Google AnalyticsにAPIでアクセスできるように設定  
    \- Analytics Reporting APIの有効化と設定  
    (参照) https://tan-taka.com/diver-demo/powered/6725  
    \- 認証に利用するjsonファイルのDL  
    \- Google AnalyticsにAPIユーザーを追加  
    (参照) https://note.com/virtual\_surfer/n/na161952a6d32
3. Google AnalyticsのデータをAPIで取得する  
    \- GoogleのAPIにアクセスするためのライブラリをインストール  
    \- Pythonでプログラムを書く  
    GoogleAnalytics  
    google\_analytics\_access.py

## 作業ログ

```
# 仮想環境
$python3 -m venv myenv
$source myenv/bin/activate 
```

```
# .pyを作成して中身を編集＆.jsonを移動
$vim google_analytics_access.py
$mv ~/Downloads/wordpress-pixela-a7b704b80f96.json ~/Ishizuka427/wp-pixela/
```

```
# 依存パッケージをインストール
$ pip install --upgrade google-api-python-client 
$ pip install --upgrade oauth2client
```

こんな感じ

```
(myenv) codmon-mbp:wp-pixela a_ishizuka$ ls
google_analytics_access.py      myenv
wordpress-pixela-a7b704b80f96.json 
```

なんとか準備おわったので  
これからがんばります~  
API~~泣きそう~~
