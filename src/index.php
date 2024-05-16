<?php
require_once __DIR__ . '/vendor/autoload.php';
use Vorlis\Service\Main;
use Vorlis\Service\Tree;

$te = new Main();
$tree = new Tree();
var_dump($tree());
var_dump($te->GetTest());
dump($te->GetTest());
echo "HI DOCKER NEW SERVICE";