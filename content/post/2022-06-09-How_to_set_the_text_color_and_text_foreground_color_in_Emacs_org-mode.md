---
title: "How to set the text color and text foreground color in Emacs org-mode"
date: 2022-06-09T00:00:00.000Z
categories: 
  - "tech-blog"
tags:
  - "Tech"
---

## Background
I wanted to change the text and background colors in Org-mode. I have changed the Markdown text and background colors before. So I tried to remember how to do that, but I forgot, so I looked it up.  
This blog is a reminder.

This is Org-mode before the change.  
![](/image1-2022-06-09)  
The color of the level 1 headline is red, and the color of the level 2 headline and link is the same blue. It is very difficult to see.  

I will change the level 1 headline to a pretty pink color and the color of the link to a more obvious color.  

## Check the Face name.
![](/image2-2022-06-09)  
Place the cursor over the area you wish to examine and type the following command.  
```
M-x describe-face
```
Then the following will appear in the minibuffer.  
`Describe face (default ‘org-level-1’): `

## Show list of Face
Now that you know the Face name, display the list of faces.  
```
M-x list-faces-display
```
![](/image3-2022-06-09)
Look for `org-level-1`.  
Click on the Face name you want to edit.  
ex. org-level-1  

##  Edit text color and text foreground color
![](/image4-2022-06-09)  
Click `Apply` to try it out, or `Apply and save` to save it.  
By the way, here is the cutest color combination I could think of.  
- Foreground: PaleVioletRed1
- Background: LavenderBlush1
![](/image5-2022-06-09)  
Very cute.  

## Finally
I changed the color of the link. It is much easier to see.  
![](/image6-2022-06-09)


