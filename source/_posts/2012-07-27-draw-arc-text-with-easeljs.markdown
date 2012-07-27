---
layout: post
title: "Draw arc text with EaselJS"
date: 2012-07-27 16:51
comments: true
categories: [javascript, EaselJS, html5, canvas]
---

Today I've released a first version of [easeljs-arctext](https://github.com/lucor/easeljs-textarc), an EaselJS extension that allows drawing of text along arc path.

It simply add the setRadius method; see below for sample code.

``` javascript Sample code
canvas = document.getElementById("canvas");
var stage = new Stage(canvas);
var text = new Text("Text Arc", '20pt Arial', '#000');
text.textAlign = "center";
text.x = 200;
text.y = 300;
text.setRadius(100);
stage.addChild(text);
stage.update();
``` 

Comments or suggestions are welcome ;)
