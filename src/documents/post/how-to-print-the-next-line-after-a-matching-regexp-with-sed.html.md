--- 
layout: post
title: How to print the next line after a matching regexp with sed
date: 2009-02-28 12:35:51 +01:00
tags: [tips, linux]
comments: true
urls: ['2009/02/how-to-print-the-next-line-after-a-matching-regexp-with-sed']
abstract: ""
---

``` bash
~ $ cat example.txt
first line
second line
third line
another line

~ $ sed -n '/second/{n;p;}' &lt; example.txt
third line

~ $ sed -n '/second/{n;p;n;p;}' &lt; example.txt
third line
another line

```
