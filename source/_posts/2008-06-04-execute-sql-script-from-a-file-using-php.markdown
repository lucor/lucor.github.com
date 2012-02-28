--- 
layout: post
title: Execute SQL script from a file using PHP
date: 2008-06-04 18:45:39 +02:00
categories: [php, tips]
comments: true
---
The code below allows to retrieve and execute all SQL statements defined in a SQL script file removing all comments.

{% codeblock lang:php %}
<?php
$sql_file = 'test.sql';

$contents = file_get_contents($sql_file);

// Remove C style and inline comments
$comment_patterns = array('/\/\*.*(\n)*.*(\*\/)?/', //C comments
                          '/\s*--.*\n/', //inline comments start with --
                          '/\s*#.*\n/', //inline comments start with #
                          );
$contents = preg_replace($comment_patterns, "\n", $contents);

//Retrieve sql statements
$statements = explode(";\n", $contents);
$statements = preg_replace("/\s/", ' ', $statements);

require_once 'MDB2.php';

$mdb2 =& MDB2::connect('mysql://usr:pw@localhost/dbnam');

foreach ($statements as $query) {
    if (trim($query) != '') {
        echo 'Executing query: ' . $query . "\n";
        $res = $mdb2->exec($query);

        if (PEAR::isError($res)) {
            die($res->getMessage());
        }
    }
}
?>
{% endcodeblock %}

I have used <a href="http://pear.php.net/package/MDB2">Pear::MDB2</a> abstraction layer to interact with the database but the code above should work with any other db abstraction layer or PHP built-in functions.
