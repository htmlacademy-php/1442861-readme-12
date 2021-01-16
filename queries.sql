use readme;
insert into content_type (type,icon)
values ('post-quote','quote'),
('post-text','text'),
('post-photo', 'photo'),
('post-link','link'),
('post-video','video');

insert into user(email,username,password)
values ('lyapinmsc+user1@gmail.com','Лариса','hashed_password123'),
('lyapinmsc+user2@gmail.com','Владик','hashed_password321'),
('lyapinmsc+user3@gmail.com','Виктор', 'hashedpassword123');

insert into post (header, content_text,content_media,user_id,content_type_id,views)
values ('Цитата','Мы в жизни любим только раз, а после ищем лишь похожих',null,1,1,10),
('Игра престолов','Не могу дождаться начала финального сезона своего любимого сериала!',null,2,2,40),
('Наконец, обработал фотки!',null,'rock-medium.jpg',3,3,2),
('Моя мечта',null,'coast-medium.jpg',1,3,49),
('Лучшие курсы',null,'www.htmlacademy.ru',2,4,123);

insert into comment(content,user_id,post_id)
values ('Очень интересный пост!','1','1'),
('Тестовый комментарий. Очень длинный комментарий. Самый длинный комментарий из всех! Если бы этот комментарий увидел Лев толстой, ему бы понравилось, но он добавил бы еще больше текста. А все очень просто: Этот комментарий хочет быть самым длинным из тех, которые включены в исходный insert, чтобы протестировать длину строки','2','1'),
('Короткий, но сильный комментарий.','2','3'),
('Very_Angry_comment!1!1!111','3','1'),
('Бесполезный комментарий','3','1'),
('Senseless comment','1','3');

select post.id, header,views, username, type 
from post 
join user on user_id = user.id 
join content_type on content_type_id = content_type.id 
order by views desc;

select p.id,header, username,views 
from post p 
join user u on user_id = u.id
where user_id = 1;

select content,c.date_created,username,header
from comment c
join post p on post_id = p.id
join user u on c.user_id = u.id
where post_id = 1;

insert into like_post (user_id,post_id)
values (1,2),
(2,4);

insert into subscription (user_id, subscriber_id)
values(2,3);