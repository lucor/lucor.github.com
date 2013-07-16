--- 
layout: post
title: Installing JBoss eap 4.3 on Red Hat 5.3
date: 2009-12-15 16:37:42 +01:00
tags: [howto, jboss]
comments: true
urls: ['2009/12/installing-jboss-eap-4-3-on-red-hat-5-3']
abstract: ""
---
<h2>Requirements</h2>
<ul>
	<li>JDK 1.5 or 1.6</li>
	<li>Installer Jboss eap 4.3 or higher</li>
</ul>
<h2>Installation</h2>
<h3>Create jboss user</h3>
```
~# adduser jboss && passwd jboss
```
<h3>Update ~/.bashrc</h3>
```
#JAVA Settings
export JAVA_HOME=/usr/java/latest
export PATH=$JAVA_HOME/bin:$PATH

#JBOSS Settings
export JBOSS_HOME=/home/jboss/EnterprisePlatform-4.3.0.GA_CP07/jboss-as
export JAVAPTH=$JAVA_HOME/bin
export JBOSS_CONF=default
export JBOSS_HOST="0.0.0.0"
```
<h3>Install JBoss eap</h3>
```
~$ java -jar enterprise-installer-4.3.0.GA_CP07.jar
```
Follow the graphic installer and complete the installation.
<h2>Set up as service</h2>
As root:
```
ln -s /home/jboss/EnterprisePlatform-4.3.0.GA_CP07/jboss-as/bin/jboss_init_redhat.sh jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc3.d/S84jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc5.d/S84jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc4.d/S84jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc6.d/K15jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc0.d/K15jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc1.d/K15jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc2.d/K15jboss
```

Edit the $JBOSS_HOME/bin/jboss_init_redhat.sh to allow loading the user profile:
```
#Add this line before any script content
. /home/jboss/.bashrc
```

<h2>Test</h2>
As root:
```
~# service jboss start
```

Now JBoss should be available at:
http://YOUR_ADDRESS:8080
