<?php
require __DIR__ . '/vendor/autoload.php';

$connection = new \Domnikl\Statsd\Connection\UdpSocket('127.0.0.1', 8125); 
$statsd = new \Domnikl\Statsd\Client($connection, 'app.metrics'); 
$statsd->gauge('foo', rand(100, 400) / rand(400, 900));
echo "Hello world!";
?>
