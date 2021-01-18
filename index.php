<?php
require('init.php');
require('helpers.php');
if (!file_exists('config.php'))
{
    trigger_error('Создайте файл config.php на основе config.sample.php и внесите туда настройки сервера MySQL',E_USER_ERROR);
}
$config = require('config.php');
$is_auth = rand(0, 1);
$user_name = 'Alexey Lyapin'; // укажите здесь ваше имя


mysqli_report(MYSQLI_REPORT_ERROR| MYSQLI_REPORT_STRICT);
$db = new mysqli(...array_values($config['db']));
$db->set_charset("utf8mb4");

$sql_types = 'select type,icon from content_type';
$types = $db->query($sql_types)->fetch_all(MYSQLI_ASSOC);


$sql_posts = 'SELECT date_created, header, type, content_text,cite_author,content_media,views, avatar,username 
    FROM post 
    JOIN user ON user_id = user.id 
    JOIN content_type ON content_type_id = content_type.id 
    ORDER BY views DESC LIMIT 6';

$posts = $db->query($sql_posts)->fetch_all(MYSQLI_ASSOC);


$content = include_template('main.php',['posts' => $posts,'types'=>$types,]);
$page = include_template('layout.php', ['content' => $content, 'page_name' => 'Главная страница','is_auth' => $is_auth, 'user_name' =>$user_name,]);
print($page);