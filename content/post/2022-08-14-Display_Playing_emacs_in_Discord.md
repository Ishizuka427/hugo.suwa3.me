---
title: "Display Playing emacs in Discord"
date: "2022-08-14T00:00:00.000Z"
categories: 
  - "tech-blog"
tags:
  - "Tech"
---

## Requirements
- Discord client app is installed.  
If you normally use it in a browser, you need to install it.  

## Install elcord from MELPA
https://github.com/Mstrodl/elcord  

`M-x package-list-packages`  
→ Select and install elcord  

![](/images/image1_2022-08-14.png)  

## init.el

Example  

```lisp
;;; Display "Playing emacs" in Discord
(add-to-list 'load-path "~/.emacs.d/elpa/elcord-20220723.33/")
(require 'elcord)
```

## Discord-side settings
User Settings > Game activity > Add it!  
Specify Emacs.  

![](/images/image2_2022-08-14.png)  

## Done!

![](/images/image3_2022-08-14.png)  
