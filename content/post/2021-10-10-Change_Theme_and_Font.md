---
title: "Change Theme and Font"
date: "2021-10-09T13:00:27.000Z"
categories: 
  - "tech-blog"
tags:
  - "Tech"
---

## hugo でフォントの編集
だいたい assets/css の下に custom.css がある。  
https://github.com/zwbetz-gh/papercss-hugo-theme/blob/master/assets/css/custom.css

使いたいフォントの選定  
日本語の手書き風のやつ  
https://fonts.google.com/specimen/Yomogi#standard-styles

```custom.css
@import url(https://fonts.googleapis.com/css?family=Yomogi);
body {
  background-image: url('{{ "img/geometry2.png" | relURL }}');
  font-family: Neucha,Yomogi,sans-serif;
}

/* font */
tr {
  font-family: Neucha,Yomogi,sans-serif
}
p {
  font-family: Neucha,Yomogi,sans-serif
}
a {
  font-family: Neucha,Yomogi,sans-serif
}
h1,h2,h3,h4,h5,h6 {
  font-family: Neucha,Yomogi,sans-serif
}

th,td {
  font-family: Neucha,Yomogi,sans-serif
}
```

↑年に2回くらいしかcss書かないから覚え書き。  


![](/images/SS_2021-10-10_18.41.52.png)


かなりクセ強めになったけどプライベートなBlogなので良し！