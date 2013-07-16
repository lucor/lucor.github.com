---
layout: post
title: "[Drupal7] Speed up Simpletest tests usign live database"
date: 2012-04-05 18:17
tags: [drupal, php, simpletest]
urls: ['2012/04/drupal-speed-up-simpletest-tests-usign-live-database']
comments: true
abstract: "If you want to speed up Drupal Simpletest bootstrap a simple trick is to use the live database instead of the sandbox enviroment created by Simpletest."
---
If you want to speed up Drupal Simpletest bootstrap a simple trick is to use the live database instead of the sandbox enviroment created by Simpletest.
To do this simply override setUp and tearDown methods as reported below:

``` php
<?php
class SampleTest extends DrupalWebTestCase {
  function setUp() {
    $this->setup = TRUE;
  }

  function tearDown() {
  }
  
  //Your test here...
```

Please note now you are using the live database... so eventual fake contents created by unit tests must be removed manually ;)
