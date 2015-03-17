<?php
require_once 'vendor/autoload.php';

use PHPoole\PHPoole;

$phpoole = new PHPoole('./', null, [
    'frontmatter' => [
        'format' => 'ini'
    ]]);
$phpoole->build();