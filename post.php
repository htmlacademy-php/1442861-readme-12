<?php
require(__DIR__.'/bootstrap.php');

if(!isset($_GET['id'])){
    call_404("id поста не указан",$user_name,$is_auth);

};
$id = $_GET['id'];


$sql_post_info= 'SELECT post.id,post.date_created, header, type, content_text,cite_author,content_media,views,
        post.user_id as user_id,COUNT(repost.id) as repost_number, COUNT(DISTINCT like_post.id) as likes

    FROM post 
    LEFT JOIN repost on post.id = post_id
    LEFT JOIN like_post on post.id = like_post.post_id
    JOIN content_type ON content_type_id = content_type.id
    WHERE post.id = ?
    GROUP BY (post.id)';


$post_info = prepare_statement($db,$sql_post_info,[$id])->get_result()->fetch_all(MYSQLI_ASSOC);

if (count($post_info) === 0) {
    call_404("Пост с id = ".$id,$user_name,$is_auth);
    };

$sql_author = 'SELECT user.id,username,reg_date,avatar, COUNT(p.id) as post_number, COUNT(s.id) as subscribers

    FROM user 
    JOIN post p ON user.id = p.user_id 
    LEFT JOIN subscription s on user.id = s.user_id
    WHERE user.id = ?
    GROUP BY (p.id)';

$author = prepare_statement($db,$sql_author,array($post_info[0]['user_id']))->get_result()->fetch_all(MYSQLI_ASSOC);


$sql_hashtags = 'SELECT name 
    FROM hashtag_post
    JOIN hashtag on hashtag.id = hashtag_id
    WHERE post_id = ?' ;

$hashtags = prepare_statement($db,$sql_hashtags,[$id])->get_result()->fetch_all(MYSQLI_ASSOC);

$sql_comments = 'SELECT avatar, date_created, content, username 
    FROM comment
    JOIN user on user_id = user.id
    WHERE post_id = ?
    ORDER BY date_created DESC' ;
$comments = prepare_statement($db,$sql_comments,[$id])->get_result()->fetch_all(MYSQLI_ASSOC);

$content = include_template('post-template.php',['post_info'=>$post_info[0], 'user_name'=>$user_name, 'hashtags'=>$hashtags, 'comments'=>$comments, 'author'=>$author[0],]);
$page = include_template('layout.php', ['content' => $content, 'page_name' => 'Пост','is_auth' => $is_auth, 'user_name' =>$user_name,]);

print($page);
