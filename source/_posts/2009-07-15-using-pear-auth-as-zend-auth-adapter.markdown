--- 
layout: post
title: Using Pear::Auth as Zend_Auth adapter
date: 2009-07-15 14:57:04 +02:00
categories: [pear, zend, php]
---
If you use both Pear and Zend framework you may want to extend the <a href="http://framework.zend.com/manual/en/zend.auth.html">Zend_Auth</a> adapters to use all the containers shipped with the <a href="http://pear.php.net/package/Auth">Pear::Auth</a> package.

Let's go to create the class implements the Zend_Auth_Adapter_Interface starting from the Zend_Auth_Adapter_Ldap class.

<strong>My_Zend_Auth_Adapter_PearAuth</strong>
{% codeblock lang:php %}
<?php
class My_Zend_Auth_Adapter_PearAuth implements Zend_Auth_Adapter_Interface
{

/**
* The array of arrays of Pear::Auth options passed to the constructor.
*
* @var array
*/
protected $_options = null;

/**
* The username of the account being authenticated.
*
* @var string
*/
protected $_username = null;

/**
* The password of the account being authenticated.
*
* @var string
*/
protected $_password = null;

/**
* The Pear::Auth container.
*
* @var string
*/
protected $_container = null;

protected $_logger = null;

/**
* Constructor
*
* @param  string $container The Pear::Auth container to use
* @param  array  $options  An array of arrays of Pear::Auth options
* @param  string $username The username of the account being authenticated
* @param  string $password The password of the account being authenticated
* @return void
*/
public function __construct($container, array $options = array(), $username = null, $password = null)
{
$this->setOptions($options);
if ($username !== null) {
$this->setUsername($username);
}
if ($password !== null) {
$this->setPassword($password);
}
$this->_container = $container;
}

public function setLogger($logger)
{
$this->_logger = $logger;
}

/**
* Returns the array of arrays of Pear::Auth options.
*
* @return array|null
*/
public function getOptions()
{
return $this->_options;
}

/**
* Sets the array of arrays of Pear::Auth options to be used by
* this adapter.
*
* @param  array $options The array of arrays of of Pear::Auth options
* @return My_Zend_Auth_Adapter_PearAuth Provides a fluent interface
*/
public function setOptions($options)
{
$this->_options = is_array($options) ? $options : array();
return $this;
}

/**
* Returns the username of the account being authenticated, or
* NULL if none is set.
*
* @return string|null
*/
public function getUsername()
{
return $this->_username;
}

/**
* Sets the username for binding
*
* @param  string $username The username for binding
* @return My_Zend_Auth_Adapter_PearAuth Provides a fluent interface
*/
public function setUsername($username)
{
$this->_username = (string) $username;
return $this;
}

/**
* Returns the password of the account being authenticated, or
* NULL if none is set.
*
* @return string|null
*/
public function getPassword()
{
return $this->_password;
}

/**
* Sets the password for the account
*
* @param  string $password The password of the account being authenticated
* @return My_Zend_Auth_Adapter_PearAuth Provides a fluent interface
*/
public function setPassword($password)
{
$this->_password = (string) $password;
return $this;
}

/**
* Authenticate the user
*
* @throws Zend_Auth_Adapter_Exception
* @return Zend_Auth_Result
*/
public function authenticate()
{
require_once 'Pear/Auth.php';

$messages = array();
$messages[0] = ''; // reserved
$messages[1] = ''; // reserved

$username = $this->_username;
$password = $this->_password;

if (!$username) {
$code = Zend_Auth_Result::FAILURE_IDENTITY_NOT_FOUND;
$messages[0] = 'A username is required';
return new Zend_Auth_Result($code, '', $messages);
}
if (!$password) {
/* A password is required because some servers will
* treat an empty password as an anonymous bind.
*/
$code = Zend_Auth_Result::FAILURE_CREDENTIAL_INVALID;
$messages[0] = 'A password is required';
return new Zend_Auth_Result($code, '', $messages);
}

//Override $_POST variables required by Auth pear package.
$_POST['username'] = $username;
$_POST['password'] = $password;

$_auth = new Auth($this->_container, $this->_options, '', false);

//Enable logging
if (isset ($this->_options['enableLogging']) &amp;&amp; $this->_options['enableLogging'] &amp;&amp;
!is_null($this->_logger)) {
$_auth->logger = $this->_logger;
}

$_auth->start();

if ($_auth->getAuth()) {
//Destroy Pear::Auth session to avoid unespected behaviour
$_auth->logout();
$messages[] = "$username authentication successful";
return new Zend_Auth_Result(Zend_Auth_Result::SUCCESS, $username, $messages);
}

$messages[] = "$username authentication failed.";
return new Zend_Auth_Result(Zend_Auth_Result::FAILURE, $username, $messages);
}
}
{% endcodeblock %}

and now let's go to use it, for example in our controller

{% codeblock lang:php %}
<?php
....
$auth = Zend_Auth::getInstance();
$config = new Zend_Config_Xml('APPLICATION_HOME/configs/auth_ldap.xml', 'production');
$options = $config->ldap->toArray();
$authAdapter = new Zend_Auth_Adapter_PearAuth('LDAP', $options, $username, $password);
$result = $auth->authenticate($authAdapter);
if(!is_null($result) &amp;&amp; $result->isValid()) {
$authorized = true;
}
....
{% endcodeblock %}

In the example above I've used the LDAP container but this should be valid for all supported containers by Pear::Auth.

Hope this helps ;-)
