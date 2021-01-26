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


$sql_types = 'select id, type,icon from content_type';
$types = $db->query($sql_types)->fetch_all(MYSQLI_ASSOC);




if (isset($_GET['content_type_id']))
    {
        $chosen_type=$_GET['content_type_id'];

        if ($chosen_type>count($types))
        {
            http_response_code(404);
        };

        $sql_posts = 'SELECT post.id,post.date_created,content_type_id, header, type, 
                            content_text,cite_author,content_media,views, avatar,username, 
                            COUNT(distinct comment.content) as comments_number,COUNT(like_post.id) as likes
            FROM post 
            JOIN user ON user_id = user.id 
            JOIN content_type ON content_type_id = content_type.id
            LEFT JOIN comment on post.id = comment.post_id
            LEFT JOIN like_post on post.id = like_post.post_id
            where content_type_id = ?
            GROUP BY (post.id)
            ORDER BY views DESC LIMIT 6';
        $posts = prepare_statement($db,$sql_posts,$chosen_type)->get_result()->fetch_all(MYSQLI_ASSOC);
    }
    else {
        $chosen_type = null;
        $sql_posts = 'SELECT post.id,post.date_created,content_type_id, header, type, 
                            content_text,cite_author,content_media,views, avatar,username, 
                            COUNT(distinct comment.content) as comments_number,COUNT(like_post.id) as likes
            FROM post 
            JOIN user ON user_id = user.id 
            JOIN content_type ON content_type_id = content_type.id
            LEFT JOIN comment on post.id = comment.post_id
            LEFT JOIN like_post on post.id = like_post.post_id
            GROUP BY (post.id)
            ORDER BY views DESC LIMIT 6';
        $posts = $db->query($sql_posts)->fetch_all(MYSQLI_ASSOC);
    }




$content = include_template('main.php',['posts' => $posts,'types'=>$types,'chosen_type'=>$chosen_type,]);
$page = include_template('layout.php', ['content' => $content, 'page_name' => 'Главная страница','is_auth' => $is_auth, 'user_name' =>$user_name,]);

print($page);
