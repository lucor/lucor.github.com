---
layout: post
title: "Ubuntu and LDAP: force authentication during a bind request"
date: 2012-05-28 17:21
comments: true
categories: [linux, ubuntu, ldap]  
---

Default LDAP installation on Ubuntu server allows anonymous binding and directory access.
If you want avoid this behavior you may set the olcRequires to authc using the ldif format with the following command:

``` 
$ sudo ldapadd -Y EXTERNAL -H ldapi:/// -f ldap_authc.ldif
``` 
where

{% include_code ldap_authc.ldif lang:bash %}