<div class="container">
            <h1 class="page__title page__title--popular">Популярное</h1>
        </div>
        <div class="popular container">
            <div class="popular__filters-wrapper">
                <div class="popular__sorting sorting">
                    <b class="popular__sorting-caption sorting__caption">Сортировка:</b>
                    <ul class="popular__sorting-list sorting__list">
                        <li class="sorting__item sorting__item--popular">
                            <a class="sorting__link sorting__link--active" href="#">
                                <span>Популярность</span>
                                <svg class="sorting__icon" width="10" height="12">
                                    <use xlink:href="#icon-sort"></use>
                                </svg>
                            </a>
                        </li>
                        <li class="sorting__item">
                            <a class="sorting__link" href="#">
                                <span>Лайки</span>
                                <svg class="sorting__icon" width="10" height="12">
                                    <use xlink:href="#icon-sort"></use>
                                </svg>
                            </a>
                        </li>
                        <li class="sorting__item">
                            <a class="sorting__link" href="#">
                                <span>Дата</span>
                                <svg class="sorting__icon" width="10" height="12">
                                    <use xlink:href="#icon-sort"></use>
                                </svg>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="popular__filters filters">
                    <b class="popular__filters-caption filters__caption">Тип контента:</b>
                    <ul class="popular__filters-list filters__list">
                        <li class="popular__filters-item popular__filters-item--all filters__item filters__item--all">
                            <?php if ($chosen_type === null):?>
                            <a class="filters__button filters__button--ellipse filters__button--all filters__button--active" href="index.php">
                            <?php else:?>
                            <a class="filters__button filters__button--ellipse filters__button--all" href="index.php">
                            <?php endif?>
                                <span>Все</span>
                            </a>
                        </li>

                        <?php foreach ($types as $type):?>
                        <li class="popular__filters-item filters__item">
                            <?php if ($chosen_type === $type['id']):?>
                            <a class="filters__button filters__button--<?=s($type['icon'])?>  button filters__button--active" href="index.php?content_type_id=<?=s($type['id'])?>">
                            <?php else:?>
                            <a class="filters__button filters__button--<?=s($type['icon'])?> button" href="index.php?content_type_id=<?=s($type['id'])?>">
                            <?php endif?>
                                <span class="visually-hidden"><?=s($type['type'])?></span>
                                <svg class="filters__icon" width="40%" height="40%">
                                    <use xlink:href="#icon-filter-<?=s($type['icon'])?>"></use>
                                </svg>
                            </a>
                        </li>
                        <?php endforeach;?>

                    </ul>
                </div>
            </div>
            <div class="popular__posts">

                <?php foreach ($posts as $post) : ?>

                    <article class="popular__post post <?= s($post['type']) ?>">
                        <header class="post__header">
                            <h2><a href = "post.php?id=<?=$post['id']?>"><?= s($post['header']) ?></a></h2>
                        </header>

                        <div class="post__main">

                            <?php if ($post['type'] === 'post-quote') : ?>
                                <blockquote>
                                    <p>
                                        <?= s($post['content_text']) ?>
                                    </p>
                                    <cite><?=s($post['cite_author'])?></cite>
                                </blockquote>

                            <?php elseif ($post['type'] === 'post-link') : ?>
                                <div class="post-link__wrapper">
                                    <a class="post-link__external" href="http://<?= s($post['content_media']) ?>" title="Перейти по ссылке">
                                        <div class="post-link__info-wrapper">
                                            <div class="post-link__icon-wrapper">
                                                <img src="https://www.google.com/s2/favicons?domain=vitadental.ru" alt="Иконка">
                                            </div>
                                            <div class="post-link__info">
                                                <h3><?= s($post['header']) ?></h3>
                                            </div>
                                        </div>
                                        <span><?= s($post['content_media']) ?></span>
                                    </a>
                                </div>

                            <?php elseif ($post['type'] === 'post-photo') : ?>

                                <div class="post-photo__image-wrapper">
                                    <img src="img/<?= s($post['content_media']) ?>" alt="Фото от пользователя" width="360" height="240">
                                </div>

                            <?php else : ?>


                                <p><?= s(cutContent($post['content_text'])) ?></p>
                                <?php if (cutContent($post['content_text']) != $post['content_text']) : ?>
                                    <a class="post-text__more-link" href="#">Читать далее</a>
                                <?php endif ?>


                            <?php endif ?>
                        </div>

                        <footer class="post__footer">
                            <div class="post__author">
                                <a class="post__author-link" href="#" title="Автор">
                                    <div class="post__avatar-wrapper">

                                        <img class="post__author-avatar" src="img/<?= s($post['avatar']) ?>" alt="Аватар пользователя">
                                    </div>
                                    <div class="post__info">
                                        <b class="post__author-name"><?= s($post['username']) ?></b>
                                        <time class="post__time" datetime="<?=s($post['date_created'])?>" title = "<?=s(date('d.m.Y H:i',strtotime(s($post['date_created']))))?>"><?= s(time_ago($post['date_created']))?> назад</time>
                                    </div>
                                </a>
                            </div>
                            <div class="post__indicators">
                                <div class="post__buttons">
                                    <a class="post__indicator post__indicator--likes button" href="#" title="Лайк">
                                        <svg class="post__indicator-icon" width="20" height="17">
                                            <use xlink:href="#icon-heart"></use>
                                        </svg>
                                        <svg class="post__indicator-icon post__indicator-icon--like-active" width="20" height="17">
                                            <use xlink:href="#icon-heart-active"></use>
                                        </svg>
                                        <span><?=s($post['likes'])?></span>
                                        <span class="visually-hidden">количество лайков</span>
                                    </a>
                                    <a class="post__indicator post__indicator--comments button" href="#" title="Комментарии">
                                        <svg class="post__indicator-icon" width="19" height="17">
                                            <use xlink:href="#icon-comment"></use>
                                        </svg>
                                        <span><?=s($post['comments_number'])?></span>
                                        <span class="visually-hidden">количество комментариев</span>
                                    </a>
                                </div>
                            </div>
                        </footer>
                    </article>
                <?php endforeach ?>
            </div>
        </div>