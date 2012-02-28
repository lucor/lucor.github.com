--- 
layout: post
title: Enabling fingerprint scanner on ThinkPad running Ubuntu Hardy in four steps
date: 2008-06-20 00:42:54 +02:00
categories: [howto, linux]
comments: true
---
Install the ThinkFinger utilities and the relative PAM module:
<pre>
~$ sudo apt-get install thinkfinger-tools libpam-thinkfinger
</pre>
Acquire and test your fingerprint:
<pre>
~$ sudo tf-tool --acquire
~$ sudo tf-tool --verify
</pre>
Enable the PAM module:
<pre>
~$ sudo /usr/lib/pam-thinkfinger/pam-thinkfinger-enable
</pre>
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
