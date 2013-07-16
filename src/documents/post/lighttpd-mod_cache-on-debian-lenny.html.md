--- 
layout: post
title: lighttpd + mod_cache on debian lenny
date: 2009-03-18 17:38:27 +01:00
tags: [howto, performance, lighttpd, linux]
comments: true
urls: ['2009/03/lighttpd-mod_cache-on-debian-lenny']
abstract: ""
---
``` bash
~# mkdir ~/tmp && cd ~/tmp
~# apt-get install dpkg-dev
~# apt-get source lighttpd
~# apt-get build-dep lighttpd
~# wget http://www.linux.com.cn/modcache/lighttpd-1.4.19.modcache.v.1.6.0.patch
~# cd lighttpd-1.4.19
~# patch -p0 < ../lighttpd-1.4.19.modcache.v.1.6.0.patch
~# echo debian/tmp/usr/lib/lighttpd/mod_cache.so > debian/lighttpd.install  
~# dpkg-buildpackage  -uc -b
~# ls -l ../*.deb
```

Install the debian packages with dpkg and enjoy :-)

Reference Links:
<ul>
<li><a href="http://www.debian.org/doc/manuals/apt-howto/ch-sourcehandling.en.html">APT HOWTO - Working with source packages</a></li>
</ul>
