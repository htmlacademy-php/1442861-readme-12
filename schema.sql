-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema readme
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema readme
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `readme` DEFAULT CHARACTER SET utf8mb4 ;
USE `readme` ;

-- -----------------------------------------------------
-- Table `readme`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`user` ;

CREATE TABLE IF NOT EXISTS `readme`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `reg_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` VARCHAR(128) NOT NULL,
  `username` VARCHAR(128) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `avatar` VARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`content_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`content_type` ;

CREATE TABLE IF NOT EXISTS `readme`.`content_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(128) NOT NULL,
  `icon` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC),
  UNIQUE INDEX `icon_UNIQUE` (`icon` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`post` ;

CREATE TABLE IF NOT EXISTS `readme`.`post` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `header` VARCHAR(128) NOT NULL,
  `content_text` TEXT NULL DEFAULT NULL,
  `cite_author` VARCHAR(128) NULL DEFAULT NULL,
  `content_media` VARCHAR(128) NULL DEFAULT NULL,
  `views` INT(11) NULL DEFAULT NULL,
  `user_id` INT(11) NOT NULL,
  `content_type_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  INDEX `fk_post_content_type1_idx` (`content_type_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_content_type1`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `readme`.`content_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`comment` ;

CREATE TABLE IF NOT EXISTS `readme`.`comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` TEXT NOT NULL,
  `user_id` INT(11) NOT NULL,
  `post_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`hashtag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`hashtag` ;

CREATE TABLE IF NOT EXISTS `readme`.`hashtag` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `hashtag_name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`like_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`like_post` ;

CREATE TABLE IF NOT EXISTS `readme`.`like_post` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `post_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_liketag_user1_idx` (`user_id` ASC),
  INDEX `fk_liketag_post1_idx` (`post_id` ASC),
  UNIQUE INDEX `user_post_unique` (`user_id` ASC, `post_id` ASC),
  CONSTRAINT `fk_liketag_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_liketag_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`message` ;

CREATE TABLE IF NOT EXISTS `readme`.`message` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` TEXT NOT NULL,
  `sender_id` INT(11) NOT NULL,
  `receiver_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`sender_id` ASC),
  INDEX `fk_message_user2_idx` (`receiver_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`subscription` ;

CREATE TABLE IF NOT EXISTS `readme`.`subscription` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `subscriber_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscription_user1_idx` (`subscriber_id` ASC),
  UNIQUE INDEX `subscription_unique` (`user_id` ASC, `subscriber_id` ASC),
  CONSTRAINT `fk_subscription_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_user2`
    FOREIGN KEY (`subscriber_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `readme`.`hashtag_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `readme`.`hashtag_post` ;

CREATE TABLE IF NOT EXISTS `readme`.`hashtag_post` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `post_id` INT(11) NOT NULL,
  `hashtag_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_has_hashtag_hashtag1_idx` (`hashtag_id` ASC),
  INDEX `fk_post_has_hashtag_post1_idx` (`post_id` ASC),
  UNIQUE INDEX `post_hashtag` (`post_id` ASC, `hashtag_id` ASC),
  CONSTRAINT `fk_post_has_hashtag_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_hashtag_hashtag1`
    FOREIGN KEY (`hashtag_id`)
    REFERENCES `readme`.`hashtag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
