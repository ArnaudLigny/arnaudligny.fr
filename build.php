#!/usr/local/bin/php
<?php
if (php_sapi_name() !== 'cli') {
    return;
}
date_default_timezone_set('Europe/Paris');
require_once 'vendor/autoload.php';
use PHPoole\PHPoole;

$getopt = getopt('e::');

$options_dev = [
    'site' => [
        'title'   => "Arnaud Ligny",
        'baseurl' => 'http://localhost:8000/',
        'menu' => [
            'main' => [
                'index' => [
                    'id'   => 'index',
                    'name' => 'AL',
                ],
                'about' => [
                    'id'      => 'about',
                    'disabled' => true,
                ],
            ],
        ],
    ],
    'frontmatter' => [
        'format' => 'yml'
    ],
];
$options_prod = array_replace_recursive($options_dev, [
    'site' => [
        'baseurl' => 'http://arnaudligny.fr/',
    ],
]);

$prod = (isset($getopt['e']) && $getopt['e'] == 'prod') ? true : false;

$options = ($prod) ? $options_prod : $options_dev;

$phpoole = new PHPoole('./', null, $options);
$phpoole->build();

if (!$prod) {
    exec('php -S localhost:8000 -t _site');
}