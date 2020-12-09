---
title: "Set_font_for_spacemacs"
date: "2020-12-09T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
---

今日は spacemacs の整備をしたよ。  
お仕事のタスク管理と日報管理をエディタでやりたいなと思って  
Org-mode を検討したけれど、そこまで高機能でなくても良いし  
優先度によっての色分けや、日報へのコピペがしやすい形式を考えて  
spacemacs の markdown-mode をカスタマイズすることにしました。

## Markdown の設定

```
M-x customize-face  
markdown-  
```
↑タブを押す  

`markdown-header-face-1` を選択  
設定画面が開くので `Show All Attributes` を押す。

foreground: 文字色  
background: 背景色

それぞれ設定して、`.spacemacs/init.el` を開きます。  

最後にこういった設定が追加されていると思うので、それらを user-config の中に移動します。  
あとは、他のものもこの形式どおりに書いていけば編集できます。
```emacslisp
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#FFFFFF" :foreground "#505050"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :background "LavenderBlush1" :foreground "salmon" :height 1.0))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :background "honeydew" :foreground "PaleGreen3" :height 1.0))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :background "LightCyan1" :foreground "DeepSkyBlue1" :height 1.0))))
 '(markdown-list-face ((t (:inherit markdown-markup-face :foreground "PaleVioletRed2")))))
```

## Font の設定

Spacemacs documentation
https://develop.spacemacs.org/doc/DOCUMENTATION.html#font

ついでに Font も変更しました。  
`.spacemacs/init.el` を開きます。  

デフォルトが下記  
```emacslisp
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
```

PixelMplus1 というフォントを設定したい場合  
※ Mac は `Library/Fonts/*******-Regular.ttf` などの形式で保存されていますが  
ファイル名 `*******` 部分を記載します。  
```emacslisp
   dotspacemacs-default-font '("PixelMplus12"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)

```

そして出来上がったのがこちら  

![](/images/SS_2020-12-09_22.46.05)

世界一かわいいエディタができあがってしまった..  

フォントのレトロ感がたまらん  
マーカーと色ペンをふんだんに使ったパステルカラー調でテンション爆上がりです。
