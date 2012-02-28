---
layout: post
title: "[Drupal7] How display block programmatically"
date: 2011-10-19 11:29:20 +02:00
categories: [drupal, php]
comments: true
---
If you want to display a block in your template:
{% codeblock lang:php %}
$block = block_load($module, $delta);
print render(_block_gAet_renderable_array( _block_render_blocks( array($block) )));
{% endcodeblock %}
where:

$module Name of the module that implements the block to load.

$delta Unique ID of the block within the context of $module. Pass NULL to return an empty block object for $module.

Reference links:
<ul>
	<li><a title="block_load API" href="http://api.drupal.org/api/drupal/modules--block--block.module/function/block_load/7" target="_blank">block_load API</a></li>
	<li><a title="Drupal.org comment" href="http://api.drupal.org/api/drupal/includes--module.inc/function/module_invoke/7#comment-15884" target="_blank">Drupal.org comment</a></li>
</ul>
