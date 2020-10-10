---
title: "wordpress export to markdown"
date: "2020-09-12T13:00:50.000Z"
categories: 
  - "tech-blog"
tags: 
---

WordPress の Markdown 化に、以下のツールを使うことにしました。  
Node 製の変換ツールです。

wordpress-export-to-markdown  
[https://github.com/lonekorean/wordpress-export-to-markdown](https://github.com/lonekorean/wordpress-export-to-markdown)

README.md の通りに進めていきます。

* * *

## 準備

Nodeのバージョン管理ツールをbrewで入れる

```
$ brew install n
```

バージョンを指定してNodeをインストール

```
$ sudo n 12.18.2
```

wordpress-export-to-markdown をインストール

```
$ npm install wordpress-export-to-markdown
```

## 実行

```
$ npx wordpress-export-to-markdown --prefix-date=true --input evenarabbitcanunderstand.WordPress.2020-09-12.xml

    Starting wizard...
    ? Path to output folder? (output) 
    ? Path to output folder? output
    ? Create year folders? (y/N) 
    ? Create year folders? No
    ? Create month folders? (y/N) 
    ? Create month folders? No
    ? Create a folder for each post? (Y/n) 
    ? Create a folder for each post? Yes
    ? Save images attached to posts? (Y/n) 
    ? Save images attached to posts? Yes
    ? Save images scraped from post body content? (Y/n) 
    ? Save images scraped from post body content? Yes
```

## 問題

スクリーンショット画像が `[FAILED]` する。

## 原因

ファイル名にカタカナが入ると `[FAILED]` するらしい。  
該当箇所に当たりをつけた。

node\_modules/wordpress-export-to-markdown/src/writer.js

```
async function processPayloadsPromise(payloads, loadFunc, config) {
    const promises = payloads.map(payload => new Promise((resolve, reject) => {
        setTimeout(async () => {
            try {
                const data = await loadFunc(payload.item, config);
                await writeFile(payload.destinationPath, data);
                console.log(chalk.green('[OK]') + ' ' + payload.name);
                resolve();
            } catch (ex) {
                console.log(chalk.red('[FAILED]') + ' ' + payload.name + ' ' + chalk.red('(' + ex.toString() + ')'));
                reject();
```

## 次回

- フォークして git clone してバグ修正する。
- Mac のスクショ画像、デフォルトでファイル名に「スクリーンショット〇〇」と入るので、それも「Screenshots〇〇」などに変更する。
