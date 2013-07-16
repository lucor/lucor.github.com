--- 
layout: post
title: Execute commands on folder and files containing spaces
date: 2008-05-08 05:06:40 +02:00
tags: [tips, linux]
comments: true
urls: ['2008/05/execute-commands-on-folder-and-files-containing-spaces']
abstract: ""
---
On Linux or Unix systems perform recursively a command on items might contain white space, quote marks, or backslashes can be a problem when using <em>find | xargs</em> combination.

To solve this you may use:

``` bash
find -type d -print0 | xargs -0 <command>
find -type f -print0 | xargs -0 <command>
```
For example to fix recursively permission:
``` bash
find -type d -print0 | xargs -0 chmod 755
find -type f -print0 | xargs -0 chmod 644
```
