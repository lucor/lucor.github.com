--- 
layout: post
title: Caching dynamic contents using Nginx as reverse proxy cache server
date: 2009-09-21 13:26:04 +02:00
tags: [nginx, performance]
comments: true
urls: ['2009/09/caching-dynamic-content-using-nginx']
abstract: "If you need a static version of your dynamic web application maybe you may interested to configure Nginx as reverse proxy cache so it can cache also dynamic contents (pages with ? in the URI)."
---
If you need a static version of your dynamic web application maybe you may interested to configure Nginx as reverse proxy cache so it can cache also dynamic contents (pages with ? in the URI).

Well, if this is your scenario, let's go to configure Nginx.

<strong>Requirements</strong>
<ul>
    <li>
    Nginx up, running and listening on 80 port
    </li>
    <li>
    A web server, like Apache, listening on 8080 port
    </li>
</ul>

```
server {
    listen       80;
    server_name  www.example.com;

    access_log  /var/log/nginx/host.access.log  main;
    set $prefix  prefix_;

    # proxy module defaults
    proxy_store_access   user:rw  group:rw  all:r;
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  Host       $host;

    # Main location
    location / {

    root /tmp/nginx/;
    index index.html index.htm index.php index.php.html index.php.html;

    # Use this if you don't cache a context (dont_cache_path) , send all requests through the proxy
    location ~ ^/dont_cache_path {
      proxy_pass http://localhost:8080;
    }

    # if the request uri was a directory, store the index page name
    if ($request_uri ~ /$) {
      set $store_extra ${request_uri}index;
    }

    # set the location the proxy will store the data to. Add the index page
    # name if the uri was a directory (nginx can't normally store these)
    proxy_store /tmp/nginx/${prefix}${query_string}${store_extra}.html;

    # go through the proxy if there is no cache
    if (!-f /tmp/nginx/${prefix}${query_string}${store_extra}.html) {
      proxy_pass http://localhost:8080;
    }

    # workaround. headers module doesn't take into account proxy response
    # headers. It overwrites the proxy Cache-Control header, causing
    # private/no-cache/no-store to be wiped, so only set if not using proxy
    if (-f /tmp/nginx/${request_uri}${store_extra}.html) {
      expires 0;
    }

    # handle static files directly. Set their expiry time to max, so they'll
    # always use the browser cache after first request
    location ~* (css|js|png|jpe?g|gif|ico|swf)$ {
      root /var/www/html/;
      expires max;
    }
    error_page 404 = /${prefix}${query_string}${store_extra}.html;
    }
}
```

Restart Nginx and enjoy with your static web site :-)

Reference Links:
<ul>
<li><a href="http://wiki.nginx.org/Main">Nginx wiki</a></li>
<li><a href="http://mark.ossdl.de/2009/07/nginx-to-create-static-files-from-dynamic-content/">how to use nginx to create static files from dynamic content</a></li>
<li><a href="http://www.webtatic.com/blog/2008/04/page-level-caching-with-nginx/">Page-level caching with Nginx</a></li>
</ul>
