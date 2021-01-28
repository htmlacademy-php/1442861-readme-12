<?php
require(__DIR__ . '/init.php');
require(__DIR__ . '/helpers.php');

if (!file_exists(__DIR__ . '/config.php')) {
    trigger_error('Создайте файл config.php на основе config.sample.php и внесите туда настройки сервера MySQL', E_USER_ERROR);
}

$config = require(__DIR__ . '/config.php');
$is_auth = rand(0, 1);
$user_name = 'Alexey Lyapin'; // укажите здесь ваше имя


mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$db = new mysqli(...array_values($config['db']));
$db->set_charset("utf8mb4");
