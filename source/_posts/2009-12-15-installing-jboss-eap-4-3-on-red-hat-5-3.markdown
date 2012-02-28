--- 
layout: post
title: Installing JBoss eap 4.3 on Red Hat 5.3
date: 2009-12-15 16:37:42 +01:00
categories: [howto, jboss]
comments: true
---
<h2>Requirements</h2>
<ul>
	<li>JDK 1.5 or 1.6</li>
	<li>Installer Jboss eap 4.3 or higher</li>
</ul>
<h2>Installation</h2>
<h3>Create jboss user</h3>
<pre>
~# adduser jboss && passwd jboss
</pre>
<h3>Update ~/.bashrc</h3>
<pre>
#JAVA Settings
export JAVA_HOME=/usr/java/latest
export PATH=$JAVA_HOME/bin:$PATH

#JBOSS Settings
export JBOSS_HOME=/home/jboss/EnterprisePlatform-4.3.0.GA_CP07/jboss-as
export JAVAPTH=$JAVA_HOME/bin
export JBOSS_CONF=default
export JBOSS_HOST="0.0.0.0"
</pre>
<h3>Install JBoss eap</h3>
<pre>
~$ java -jar enterprise-installer-4.3.0.GA_CP07.jar
</pre>
Follow the graphic installer and complete the installation.
<h2>Set up as service</h2>
As root:
<pre>
ln -s /home/jboss/EnterprisePlatform-4.3.0.GA_CP07/jboss-as/bin/jboss_init_redhat.sh jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc3.d/S84jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc5.d/S84jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc4.d/S84jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc6.d/K15jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc0.d/K15jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc1.d/K15jboss
ln -s /etc/rc.d/init.d/jboss /etc/rc2.d/K15jboss
</pre>

Edit the $JBOSS_HOME/bin/jboss_init_redhat.sh to allow loading the user profile:
<pre>
#Add this line before any script content
. /home/jboss/.bashrc
</pre>

<h2>Test</h2>
As root:
<pre>
~# service jboss start
</pre>

Now JBoss should be available at:
http://YOUR_ADDRESS:8080
