--- 
layout: post
title: Discovery hosts and services with PHP and Nmap
date: 2008-06-19 23:39:38 +02:00
tags: [pear, php, nmap]
comments: true
urls: ['2008/06/discovery-hosts-and-services-with-php-and-nmap']
abstract: "How to: scan network to retrieve hosts and services information using Net_Nmap"
---
Requirements:
<ul>
<li><a title="PHP.net" href="http://www.php.net" target="_blank">PHP5</a></li>
<li><a title="Net_Nmap" href="http://pear.php.net/package/Net_Nmap" target="_self">PEAR::Net_Nmap</a></li>
<li><a title="nmap" href="http://nmap.org/" target="_blank">nmap</a></li>
</ul>

``` php
<?php

/**
 * Scan network to retrieve hosts and services information.
 */

require_once 'Net/Nmap.php';

//Define the target to scan
$target = array('127.0.0.1','www.yourserver.com');

$options = array('nmap_binary' => '/usr/local/bin/nmap');

try {
    $nmap = new Net_Nmap($options);

    //Enable nmap options
    $nmap_options = array('os_detection' => true,
                          'service_info' => true,
                          'port_ranges' => 'U:53,111,137,T:21-25,80,139,8080',//to scan only specified ports
                          );

    $nmap->enableOptions($nmap_options);

    //Scan target
    $res = $nmap->scan($target);

    //Get failed hosts
    $failed_to_resolve = $nmap->getFailedToResolveHosts();

    if (count($failed_to_resolve) > 0) {
        echo 'Failed to resolve given hostname/IP: ' .
             implode (', ', $failed_to_resolve) .
             "\n";
    }

    //Parse XML Output to retrieve Hosts Object
    $hosts = $nmap->parseXMLOutput();

    //Print results
    foreach ($hosts as $key => $host) {
        echo 'Hostname: ' . $host->getHostname() . "\n";
        echo 'Address: ' . $host->getAddress() . "\n";
        echo 'OS: ' . $host->getOS() . "\n";
        echo 'Status: ' . $host->getStatus . "\n";
        $services = $host->getServices();
        echo 'Number of discovered services: ' . count($services) . "\n";
        foreach ($services as $key => $service) {
            echo "\n";
            echo 'Service Name: ' . $service->name . "\n";
            echo 'Port: ' . $service->port . "\n";
            echo 'Protocol: ' . $service->protocol . "\n";
            echo 'Product information: ' . $service->product . "\n";
            echo 'Product version: ' . $service->version . "\n";
            echo 'Product additional info: ' . $service->extrainfo . "\n";
        }
    }
} catch (Net_Nmap_Exception $ne) {
    echo $ne->getMessage();
}
?>
```
