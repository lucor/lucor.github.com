--- 
layout: post
title: How enable the PHP Tidy extension for MAMP
date: 2010-07-20 16:21:14 +02:00
tags: [mamp, mac, php]
comments: true
urls: ['2010/07/how-enable-the-php-tidy-extension-for-mamp']
abstract: ""
---
<ol>

<li>
Download the PHP source in according with your environment:

``` bash
$ php -v
PHP 5.2.11 (cli) (built: Dec 12 2009 13:19:08)
```
</li>

<li>
Extract in a temporary folder
``` bash
$ cd ~ && tar zxvf php-5.2.11.tar.gz && cd php-5.2.11
```
</li>
<li>
Patch the <code><em>ext/iconv/iconv.c</em> file </code>remove the <em><code>lib</code></em> on <em><code>#define iconv libiconv</code></em> so that the code reads like this:
``` cpp
#ifdef HAVE_LIBICONV
#define iconv iconv
#endif
```
</li>
<li>
Patch the ext/tidy/tidy.c file moving the line 34: #include "tidy.h" to line 24 of tidy.c so that the code reads like this:
``` cpp
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "tidy.h"
#include "php.h"
#include "php_tidy.h"

#if HAVE_TIDY

#include "php_ini.h"
```
</li>
<li>
Instruct the system to build universal binaries, that will work on both 32 and 64 bit systems by entering the following commands in the terminal console:
``` bash
$ MACOSX_DEPLOYMENT_TARGET=10.6
$ CFLAGS="-arch i386 -arch x86_64 -g -Os -pipe -no-cpp-precomp"
$ CCFLAGS="-arch i386 -arch x86_64 -g -Os -pipe"CXXFLAGS="-arch i386 -arch x86_64 -g -Os -pipe"
$ LDFLAGS="-arch i386 -arch x86_64 -bind_at_load"
$ export CFLAGS CXXFLAGS LDFLAGS CCFLAGS MACOSX_DEPLOYMENT_TARGET
```
</li>
<li>Configure & make
``` bash
$ LIBS=-lresolv ./configure --with-tidy=shared && make
```
</li>
<li>
Copy the module in MAMP
``` bash
$ cp ./modules/tidy.so /Applications/MAMP/bin/php5/lib/php/extensions/no-debug-non-zts-20060613/
```
</li>
<li>
Enable the module in the /Applications/MAMP/conf/php5/php.ini adding the following line in the extension section:
``` bash
extension=tidy.so
```
</li>
<li>Restart the webserver</li>
<li>Check with php_info() if the tidy extension is loaded correctly ;-)</li>
</ol>
Reference Links:
<ul>
	<li><a title="Installing PHP 5.2.10 on OS X 10.6 Snow Leopard" href="http://www.firewing1.com/node/31" target="_blank" rel="nofollow">Installing PHP 5.2.10 on OS X 10.6 Snow Leopard</a></li>
	<li><a title="How to compile PHP with '--enable-zip' on Mac OS-X SnowLeopard (10.6)" href="http://symphony-cms.com/discuss/thread/35577/#position-14"  target="_blank" rel="nofollow">How to compile PHP with '--enable-zip' on Mac OS-X SnowLeopard (10.6)</a></li>
	<li><a href="http://forum.mamp.info/viewtopic.php?f=4&t=6569" target="_blank" rel="nofollow">http://forum.mamp.info/viewtopic.php?f=4&t=6569</a></li>
</ul>
