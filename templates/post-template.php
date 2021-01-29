<main class="page__main page__main--publication">
    <div class="container">
        <h1 class="page__title page__title--publication"><?= s($post_info['header']) ?></h1>
        <section class="post-details">
            <h2 class="visually-hidden">Публикация</h2>

            <div class="post-details__wrapper <?= s($post_info['type']) ?>">
                <div class="post-details__main-block post post--details">


                    <?php if ($post_info['type'] === 'post-photo') : ?>
                        <div class="post-details__image-wrapper post-photo__image-wrapper">
                            <img src="img/<?= s($post_info['content_media']) ?>" alt="Фото от пользователя" width="760" height="507">
                        </div>

                    <?php elseif ($post_info['type'] === 'post-text') : ?>

                        <div class="post__main">
                            <p><?= s($post_info['content_text']) ?></p>
                        </div>

                    <?php elseif ($post_info['type'] === 'post-quote') : ?>
                        <div class="post__main">
                            <blockquote>
                                <p>
                                    <?= s($post_info['content_text']) ?>
                                </p>
                                <cite><?= s($post_info['cite_author']) ?></cite>
                            </blockquote>
                        </div>
                    <?php elseif ($post_info['type'] === 'post-link') : ?>
                        <div class="post__main">
                            <div class="post-link__wrapper">
                                <a class="post-link__external" href="http://<?= (s($post_info['content_media'])) ?>" title="Перейти по ссылке">
                                    <div class="post-link__icon-wrapper">
                                        <img src="img/logo-vita.jpg" alt="Иконка">
                                    </div>
                                    <div class="post-link__info">
                                        <h3><?= s($post_info['header']) ?></h3>
                                        <p><?= s($post_info['header']) ?></p>
                                        <span><?= s($post_info['content_media']) ?></span>
                                    </div>
                                    <svg class="post-link__arrow" width="11" height="16">
                                        <use xlink:href="#icon-arrow-right-ad"></use>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    <?php endif ?>
                    <div class="post__indicators">
                        <div class="post__buttons">
                            <a class="post__indicator post__indicator--likes button" href="#" title="Лайк">
                                <svg class="post__indicator-icon" width="20" height="17">
                                    <use xlink:href="#icon-heart"></use>
                                </svg>
                                <svg class="post__indicator-icon post__indicator-icon--like-active" width="20" height="17">
                                    <use xlink:href="#icon-heart-active"></use>
                                </svg>
                                <span><?= s($post_info['likes']) ?></span>
                                <span class="visually-hidden">количество лайков</span>
                            </a>
                            <a class="post__indicator post__indicator--comments button" href="#" title="Комментарии">
                                <svg class="post__indicator-icon" width="19" height="17">
                                    <use xlink:href="#icon-comment"></use>
                                </svg>
                                <span><?= count($comments) ?></span>
                                <span class="visually-hidden">количество комментариев</span>
                            </a>
                            <a class="post__indicator post__indicator--repost button" href="#" title="Репост">
                                <svg class="post__indicator-icon" width="19" height="17">
                                    <use xlink:href="#icon-repost"></use>
                                </svg>
                                <span><?= s($post_info['repost_number']) ?></span>
                                <span class="visually-hidden">количество репостов</span>
                            </a>
                        </div>
                        <span class="post__view"><?= s($post_info['views']) ?> <?=s(get_noun_plural_form($post_info['views'],'просмотр', 'просмотра', 'просмотров'))?></span>
                    </div>
                    <ul class="post__tags">
                        <?php foreach ($hashtags as $hashtag) : ?>
                            <li><a href="#&hashtag=<?=s($hashtag['name'])?>">#<?= s($hashtag['name']) ?></a></li>
                        <?php endforeach ?>
                    </ul>
                    <div class="comments">
                        <form class="comments__form form" action="#" method="post">
                            <div class="comments__my-avatar">
                                <img class="comments__picture" src="img/userpic.jpg" alt="Аватар пользователя">
                            </div>
                            <div class="form__input-section ">
                                <textarea class="comments__textarea form__textarea form__input" placeholder="Ваш комментарий"></textarea>
                                <label class="visually-hidden">Ваш комментарий</label>

                            </div>
                            <button class="comments__submit button button--green" type="submit">Отправить</button>
                        </form>
                        <div class="comments__list-wrapper">
                            <ul class="comments__list">
                                <?php foreach ($comments as $comment) : ?>
                                    <li class="comments__item user">
                                        <div class="comments__avatar">
                                            <a class="user__avatar-link" href="#">
                                                <img class="comments__picture" src="img/<?= s($comment['avatar']) ?>" alt="Аватар пользователя">
                                            </a>
                                        </div>
                                        <div class="comments__info">
                                            <div class="comments__name-wrapper">
                                                <a class="comments__user-name" href="#">
                                                    <span><?= s($comment['username']) ?></span>
                                                </a>
                                                <time class="comments__time" datetime="<?= s($comment['date_created']) ?>"><?= s(time_ago($comment['date_created'])) ?></time>
                                            </div>
                                            <p class="comments__text">
                                                <?= s($comment['content']) ?>
                                            </p>
                                        </div>
                                    </li>
                                <?php endforeach ?>
                            </ul>
                            <a class="comments__more-link" href="#">
                                <span>Показать все комментарии</span>
                                <sup class="comments__amount">45</sup>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="post-details__user user">
                    <div class="post-details__user-info user__info">
                        <div class="post-details__avatar user__avatar">
                            <a class="post-details__avatar-link user__avatar-link" href="#">
                                <img class="post-details__picture user__picture" src="img/<?= s($author['avatar']) ?>" alt="Аватар пользователя">
                            </a>
                        </div>
                        <div class="post-details__name-wrapper user__name-wrapper">
                            <a class="post-details__name user__name" href="#">
                                <span><?= s($author['username']) ?></span>
                            </a>
                            <time class="post-details__time user__time" datetime="<?=s(date('Y-m-d',strtotime(s($post['date_created']))))?>"><?= s(time_ago($author['reg_date']))?> на сайте</time>
                        </div>
                    </div>
                    <div class="post-details__rating user__rating">
                        <p class="post-details__rating-item user__rating-item user__rating-item--subscribers">
                            <span class="post-details__rating-amount user__rating-amount"><?= s($author['subscribers']) ?></span>
                            <span class="post-details__rating-text user__rating-text"><?=s(get_noun_plural_form($author['subscribers'],'подписчик', 'подписчика', 'подписчиков'))?></span>
                        </p>
                        <p class="post-details__rating-item user__rating-item user__rating-item--publications">
                            <span class="post-details__rating-amount user__rating-amount"><?= s($author['post_number']) ?></span>
                            <span class="post-details__rating-text user__rating-text"><?=s(get_noun_plural_form($author['post_number'],'публикация', 'публикации', 'публикаций'))?></span>
                        </p>
                    </div>
                    <div class="post-details__user-buttons user__buttons">
                        <button class="user__button user__button--subscription button button--main" type="button">Подписаться</button>
                        <a class="user__button user__button--writing button button--green" href="#">Сообщение</a>
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>