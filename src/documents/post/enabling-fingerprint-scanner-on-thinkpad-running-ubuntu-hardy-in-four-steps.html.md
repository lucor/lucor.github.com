--- 
layout: post
title: Enabling fingerprint scanner on ThinkPad running Ubuntu Hardy in four steps
date: 2008-06-20 00:42:54 +02:00
tags: [howto, linux]
comments: true
urls: ['2008/06/enabling-fingerprint-scanner-on-thinkpad-running-ubuntu-hardy-in-four-steps']
abstract: ""
---
Install the ThinkFinger utilities and the relative PAM module:
``` bash
~$ sudo apt-get install thinkfinger-tools libpam-thinkfinger
```
Acquire and test your fingerprint:
``` bash
~$ sudo tf-tool --acquire
~$ sudo tf-tool --verify
```
Enable the PAM module:
``` bash
~$ sudo /usr/lib/pam-thinkfinger/pam-thinkfinger-enable
```
Enjoy :-)

Resources:
<ul>
<li>
<a href="https://wiki.ubuntu.com/ThinkFinger">wiki.ubuntu.com/ThinkFinger</a>
</li>
<li>
<a href="https://bugs.launchpad.net/ubuntu/+source/thinkfinger/+bug/203973">Bug #203973 in thinkfinger (Ubuntu)</a>
</li>
</ul>
