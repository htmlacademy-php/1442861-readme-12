use readme;


/*Вносим типы контента*/

insert into content_type (type,icon)
values ('post-quote','quote'),
('post-text','text'),
('post-photo', 'photo'),
('post-link','link'),
('post-video','video');

/*Вносим пользователей*/
insert into user(email,username,password,avatar)
values ('lyapinmsc+user1@gmail.com','Лариса','hashed_password123','userpic-larisa-small.jpg'),
('lyapinmsc+user2@gmail.com','Владик','hashed_password321','userpic.jpg'),
('lyapinmsc+user3@gmail.com','Виктор', 'hashedpassword123','userpic-mark.jpg');

/*Вносим список постов*/
insert into post (header, content_text,content_media,user_id,content_type_id,views,cite_author,date_created)
values ('Цитата','Мы в жизни любим только раз, а после ищем лишь похожих',null,1,1,10,'Неизвестный автор',default),
('Игра престолов','Не могу дождаться начала финального сезона своего любимого сериала!',null,2,2,40,null,'2021-01-18 10:15:45'),
('Наконец, обработал фотки!',null,'rock-medium.jpg',3,3,2,null,'2021-01-16 15:35:00'),
('Моя мечта',null,'coast-medium.jpg',1,3,49,null,'2020-12-30 19:16:00'),
('Лучшие курсы',null,'www.htmlacademy.ru',2,4,123,null,'2020-02-25 11:00:00');

/*Добавляем комментарии*/
insert into comment(content,user_id,post_id)
values ('Очень интересный пост!','1','1'),
('Тестовый комментарий. Очень длинный комментарий. Самый длинный комментарий из всех! Если бы этот комментарий увидел Лев толстой, ему бы понравилось, но он добавил бы еще больше текста. А все очень просто: Этот комментарий хочет быть самым длинным из тех, которые включены в исходный insert, чтобы протестировать длину строки','2','1'),
('Короткий, но сильный комментарий.','2','3'),
('Very_Angry_comment!1!1!111','3','1'),
('Бесполезный комментарий','3','1'),
('Senseless comment','1','3');

/*Выводим список постов, отсортированный по убыванию популярности*/
select post.id, header,views, username, type 
from post 
join user on user_id = user.id 
join content_type on content_type_id = content_type.id 
order by views desc;

/*Выводим список постов для пользователя 1*/
select p.id,header, username,views 
from post p 
join user u on user_id = u.id
where user_id = 1;

/*Выводим список комментариев, оставленных к посту 1*/
select content,c.date_created,username,header
from comment c
join post p on post_id = p.id
join user u on c.user_id = u.id
where post_id = 1;

/*Добавляем лайки к постам 1 (от юзера 2) и 2 (от юзера 4)*/
insert into like_post (user_id,post_id)
values (1,2),
(2,4);

/*Добавляем несколько подписок пользовтелей друг на друга*/
insert into subscription (user_id, subscriber_id)
values(2,3),
(2,1),
(1,3);

/*Добавляем несколько хэштегов*/
insert into hashtag (name)
values('cool'),
('Круто'),
('Хэштэг1'),
('Мейнстрим');

/*Привязываем хэштеги к постам*/
insert into hashtag_post (post_id,hashtag_id)
values(1,2),
(2,3),
(3,1),
(3,4),
(5,1),
(2,2),
(4,3);

/*Вносим несколько репостов*/
insert into repost (post_id,user_id)
values(2,1),
(3,2),
(4,2),
(4,1),
(4,3);