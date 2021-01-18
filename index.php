<?php
require('init.php');
require('helpers.php');
if (!file_exists('config.php'))
{
    trigger_error('Создайте файл config.php на основе config.sample.php и внесите туда настройки сервера MySQL');
}
$config = require('config.php');
$is_auth = rand(0, 1);
$user_name = 'Alexey Lyapin'; // укажите здесь ваше имя


$db_host = $config['db']['db_host'];
$db_port = $config['db']['db_port'];
$db_user = $config['db']['db_user'];
$db_password = $config['db']['db_password'];
$db_database = $config['db']['db_database']; 

mysqli_report(MYSQLI_REPORT_ERROR| MYSQLI_REPORT_STRICT);
$db = new mysqli($db_host,$db_user,$db_password,$db_database,$db_port);
$db->set_charset("utf8mb4");

$sql_types = 'select type,icon from content_type';
$types = $db->query($sql_types)->fetch_all(MYSQLI_ASSOC);


$sql_posts = 'select date_created, header, type, content_text,cite_author,content_media,views, avatar,username from post join user on user_id = user.id join content_type on content_type_id = content_type.id order by views desc';
$posts = $db->query($sql_posts)->fetch_all(MYSQLI_ASSOC);


$content = include_template('main.php',['posts' => $posts,'types'=>$types,]);
$page = include_template('layout.php', ['content' => $content, 'page_name' => 'Главная страница','is_auth' => $is_auth, 'user_name' =>$user_name,]);
print($page);