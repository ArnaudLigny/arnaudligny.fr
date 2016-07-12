#!/usr/local/bin/php
<?php
if (php_sapi_name() !== 'cli') {
    return;
}
date_default_timezone_set('Europe/Paris');
require_once 'vendor/autoload.php';
use Symfony\Component\Finder\SplFileInfo;
use Symfony\Component\Finder\Finder;
use GlValidator\GlW3CValidator;

$validator = new GlW3CValidator(__DIR__.'/result');
$finder = new Finder();
$files  = $finder->files()->in(__DIR__.'/_site/');

$results = $validator->validate(
    [$files],
    ['html', 'css'],
    function (SplFileInfo $file) {
        //echo $file->getRealpath().PHP_EOL;
        echo '.';
    }
);

echo "\nSome HTML/CSS files are not W3C valid:\n";
print_r(array_filter($results, function ($var)
{
    return(!is_null($var));
}));
