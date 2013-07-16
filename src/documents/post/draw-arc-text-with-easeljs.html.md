---
layout: post
title: "Draw arc text with EaselJS"
date: 2012-07-27 16:51
comments: true
tags: [Javascript, EaselJS, HTML 5]
urls: ["2012/07/draw-arc-text-with-easeljs"]
abstract: Today I've released a first version of easeljs-arctext, an EaselJS extension that allows drawing of text along arc path.
---

Today I've released a first version of [easeljs-arctext](https://github.com/lucor/easeljs-textarc), an EaselJS extension that allows drawing of text along arc path.

See below for sample code.

``` javascript
canvas = document.getElementById("canvas");
var stage = new Stage(canvas);
//Draw the text "Text Arc" with font "20pt Arial", color "black" and radius 100
var text = new TextArc("Text Arc", '20pt Arial', '#000', 100);
text.textAlign = "center";
text.x = 200;
text.y = 300;
stage.addChild(text);
stage.update();
``` 

Comments or suggestions are welcome ;)
