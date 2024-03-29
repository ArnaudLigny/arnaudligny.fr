#!/usr/local/bin/php
<?php
if (php_sapi_name() !== 'cli') {
    return;
}

date_default_timezone_set('Europe/Paris');
require_once 'vendor/autoload.php';

use Cecil\Builder;
use Symfony\Component\Yaml\Yaml;

$getopt = getopt('e::');

$options = Yaml::parse(file_get_contents('config.yml'));
$options_dev = [
    'site' => [
        'baseurl' => 'http://localhost:8000/',
    ],
];

$prod = (isset($getopt['e']) && $getopt['e'] == 'prod') ? true : false;
$options = (!$prod) ? array_replace_recursive($options, $options_dev) : $options;

$cecil = new Builder($options);
$cecil->build(true);

if (!$prod) {
    echo "Start server http://localhost:8000\n";
    echo "Ctrl-C to stop it\n";
    exec('php -S localhost:8000 -t _site');
}
