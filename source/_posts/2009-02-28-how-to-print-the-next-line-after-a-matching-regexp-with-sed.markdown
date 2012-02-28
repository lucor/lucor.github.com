--- 
layout: post
title: How to print the next line after a matching regexp with sed
date: 2009-02-28 12:35:51 +01:00
categories: [tips, linux]
comments: true
---
{% codeblock %}
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

{% endcodeblock %}
