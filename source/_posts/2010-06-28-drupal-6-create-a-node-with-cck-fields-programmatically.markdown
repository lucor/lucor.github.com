--- 
layout: post
title: "Drupal 6: how create a node with CCK fields programmatically"
date: 2010-06-28 16:19:04 +02:00
categories: [php, drupal]
---
{% codeblock lang:php %}
<?php 

require_once './includes/bootstrap.inc';
drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);
module_load_include('inc', 'node', 'node.pages');

$node = new stdClass();

//Set up default values, if required.
node_object_prepare($node);

//Specify the content type
$node->type = 'profile';

//Specify an author for the node
$node->uid = 1;

//Add the title
$node->title = 'Test';

//Add the CCK fields data
$node->field_name[0]['value'] = 'Name';
$node->field_surname[0]['value'] = 'Surname';

//Save the node object into the database.
node_save($node);

//Debug the created node
print '<pre>';
print_($node);
print '</pre>';
{% endcodeblock %}
