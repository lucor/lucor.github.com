---
layout: post
title: "[Drupal7] How display block programmatically"
date: 2011-10-19 11:29:20 +02:00
tags: [drupal, php]
comments: true
urls: ['2011/10/drupal7-how-display-block-programmatically']
abstract: "How to: display a block programmatically in Drupal 7"
---
If you want to display a block in your template:
``` php
$block = block_load($module, $delta);
print render(_block_get_renderable_array( _block_render_blocks( array($block) )));
```
where:

*$module* Name of the module that implements the block to load.

*$delta* Unique ID of the block within the context of $module. Pass NULL to return an empty block object for $module.

Reference links:
<ul>
	<li><a title="block_load API" href="http://api.drupal.org/api/drupal/modules--block--block.module/function/block_load/7" target="_blank" rel="nofollow">block_load API</a></li>
	<li><a title="Drupal.org comment" href="http://api.drupal.org/api/drupal/includes--module.inc/function/module_invoke/7#comment-15884" target="_blank" rel="nofollow">Drupal.org comment</a></li>
</ul>
