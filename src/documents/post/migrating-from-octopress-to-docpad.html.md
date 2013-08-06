---
layout: post
title: "Migrating from Octopress to Docpad"
date: 2013-08-06 10:51
comments: true
tags: [Javascript, Docpad, coffeescript]
abstract: As well as careless this blog over the past months I decided to make amends by giving it some love with a restyle and at the same time take a look at Docpad. So here we are, let's start the migration from Octopress to Docpad.
---

# Migrating from Octopress to Docpad

In these days I've discovered an interesting project: [Docpad](http://docpad.org). 

From the Docpad site: 

> DocPad is a next generation web framework; allowing for content management via the file system, rendering via plugins, and static site generation for deployment anywhere. It's built with Node and Express.js, making it naturally fast and easily extendable.

As well as careless this blog over the past months I decided to make amends by giving it some love with a restyle and at the same time take a look at Docpad

So here we are, let's start the migration from Octopress to Docpad.

## The setup

Obviously the first thing I need was Docpad, it is very simple to bootstrap a new site: 

```
$ npm install -g docpad@6.48
$ mkdir lucor.www
$ cd lucor.www
$ docpad run
```

The installer will ask for a skeleton:

```
info: Which skeleton will you use?
  1) HTML5 Boilerplate
  2) HTML5 Boilerplate with Grunt
  3) Twitter Bootstrap
  4) Twitter Bootstrap with Jade
  5) Twitter Bootstrap with Coffeekup
  6) Kitchensink
  7) Benjamin Lupton's Website
  8) DocPad's Website
  9) Bevry's Website
  10) Startup Hostel's Website
  11) NodeChat
  12) SlidePad
  13) Reveal.js
  14) Conference Boilerplate
  15) Meny
  16) YUI PureCSS
  17) No Skeleton
```

The installer will download the required node modules,  docpad plugins and will start a DocPad instance listening to http://localhost:9778/

## The theme
 
For prototyping I'm an enthusiast Twitter Bootstrap user, but for this blog I want to give a try to YUI PureCSS so I've hacked the [Pure CSS Blog layout](http://purecss.io/layouts/blog/)

To include your css and javascript simply add copy them to src/documents folder or if you use external resources add directacly in docpad.coffee configuration file.

This skeleton come with three layouts written using [eco](https://github.com/docpad/docpad-plugin-eco) (embedded CoffeeScript templates) out of the box: default, post and page. Suite perfectly for my needs.

## The collections
DocPad using [Backbone.js](http://documentcloud.github.com/backbone/) for its Models, and [QueryEngine](https://github.com/bevry/query-engine) for its Collections.

The selected template come with two collections: pages and posts. Again… nice.

The docpad-livereload plugin automatically should be build a new version using grunt so you can view your changes in the browser.

```
for i in $(ls *.markdown); do 
  mv $i $(basename $i .markdown).html.md
done
```

## The plugins
Docpad have a lots of [helpers and plugins](http://docpad.org/docs/plugins) the only one missed to port my old blog was a navigation bar for blog posts.  Create a new plugin is easy so I wrote [docpad-plugin-navlinks](https://github.com/lucor/docpad-plugin-navlinks)

Below the list of plugin I've used:

* cleanurls - Adds support for urls like /blog/hello as well as the original url /blog/hello.html
* ghpages - Deploy to GitHub Pages as easy as docpad deploy-ghpages
* highlightjs - Adds Highlight.js syntax highlighting to code snippets
* navlinks - Adds the ability to generate a navigation bar for documents with links to the next and previous document of a specified collection.
* partials - Adds the ability to create re-usable partials for your templates within DocPad
* related - Scans your documents tags: 'tag1', 'tag2' metadata to produce a listing of related documents
* services - Adds support for many 3rd party services to DocPad

## The source code
If you are interested the source code is available on [github](https://github.com/lucor/lucor.github.com/tree/docpad-source)

Hope you enjoy new blos site, see you around.
