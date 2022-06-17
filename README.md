# hugo.suwa3.me
![Vercel](https://therealsujitk-vercel-badge.vercel.app/?app=hugo.suwa3.me)

hugo.suwa3.me is based on Hugo and Vercel.

## How to Create A New post
I can use the `new` command to do.  
Ref. Write a blog with the title "example-title" on December 1, 2021
```sh
$ hugo new content/posts/2021-12-01-example-title.md
```
Set the following at the top of the blog.
```
---
title: "Example Title"
date: 2021-12-01T00:00:00.000Z
categories: 
  - "tech-blog"
  - "note"
tags:
  - "Tech"
  - "life"
---
```

Categories | Description
-- | -- 
tech-blog | Technical content
note | Non-technical content

Tags | Description
-- | -- 
Tech | Technical content
life | Poem

※ I want to subdivide and increase the number of tag types in the future.

## build

```
$ make vercel hugo
$ hugo server -D
```
