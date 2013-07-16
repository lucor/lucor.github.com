---
layout: post
title: "Ubuntu and LDAP: force authentication during a bind request"
date: 2012-05-28 17:21
comments: true
tags: [linux, ubuntu, ldap]
urls: ['2012/05/ubuntu-and-ldap-force-authentication-during-a-bind-request']
abstract: ""
---

Default LDAP installation on Ubuntu server allows anonymous binding and directory access.
If you want avoid this behavior you may set the olcRequires to authc using the ldif format with the following command:

``` 
$ sudo ldapadd -Y EXTERNAL -H ldapi:/// -f ldap_disable_bind_anon.ldif
``` 
where *ldap_disable_bind_anon.ldif* is:

```
dn: cn=config
changetype: modify
add: olcDisallows
olcDisallows: bind_anon

dn: cn=config
changetype: modify
add: olcRequires
olcRequires: authc

dn: olcDatabase={-1}frontend,cn=config
changetype: modify
add: olcRequires
olcRequires: authc
```
