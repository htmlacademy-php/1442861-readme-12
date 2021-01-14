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
CREATE SCHEMA IF NOT EXISTS `readme` DEFAULT CHARACTER SET utf8 ;
USE `readme` ;

-- -----------------------------------------------------
-- Table `readme`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `reg_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` VARCHAR(128) NOT NULL,
  `username` VARCHAR(128) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `avatar` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC),
  UNIQUE INDEX `username` (`username` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`content_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`content_type` (
  `content_id` INT(11) NOT NULL AUTO_INCREMENT,
  `content_title` VARCHAR(128) NOT NULL,
  `content_icon` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`content_id`),
  UNIQUE INDEX `content_title_UNIQUE` (`content_title` ASC),
  UNIQUE INDEX `content_icon_UNIQUE` (`content_icon` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`post` (
  `post_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` CHAR(100) NOT NULL,
  `content_text` TEXT NULL DEFAULT NULL,
  `cite_author` CHAR(100) NULL DEFAULT NULL,
  `content_image` VARCHAR(128) NULL DEFAULT NULL,
  `content_video` VARCHAR(128) NULL DEFAULT NULL,
  `content_link` VARCHAR(128) NULL DEFAULT NULL,
  `views` INT(11) NULL DEFAULT NULL,
  `user_id` INT(11) NOT NULL,
  `content_type_id` INT(11) NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  INDEX `fk_post_content_type1_idx` (`content_type_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_content_type1`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `readme`.`content_type` (`content_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`comment` (
  `comment_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` TEXT NULL DEFAULT NULL,
  `user_id` INT(11) NOT NULL,
  `post_id` INT(11) NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`hashtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`hashtag` (
  `hashtag_id` INT(11) NOT NULL AUTO_INCREMENT,
  `hashtag_name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`hashtag_id`),
  UNIQUE INDEX `hashtag_name_UNIQUE` (`hashtag_name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`liketag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`liketag` (
  `like_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `post_id` INT(11) NOT NULL,
  PRIMARY KEY (`like_id`),
  INDEX `fk_liketag_user1_idx` (`user_id` ASC),
  INDEX `fk_liketag_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_liketag_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_liketag_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`message` (
  `message_id` INT(11) NOT NULL AUTO_INCREMENT,
  `message_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` TEXT NOT NULL,
  `sender_id` INT(11) NOT NULL,
  `receiver_id` INT(11) NOT NULL,
  PRIMARY KEY (`message_id`),
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
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`subscription` (
  `subscript_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`subscript_id`),
  INDEX `fk_subscription_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_subscription_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `readme`.`post_has_hashtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`post_has_hashtag` (
  `post_post_id` INT(11) NOT NULL,
  `hashtag_hashtag_id` INT(11) NOT NULL,
  PRIMARY KEY (`post_post_id`, `hashtag_hashtag_id`),
  INDEX `fk_post_has_hashtag_hashtag1_idx` (`hashtag_hashtag_id` ASC),
  INDEX `fk_post_has_hashtag_post1_idx` (`post_post_id` ASC),
  CONSTRAINT `fk_post_has_hashtag_post1`
    FOREIGN KEY (`post_post_id`)
    REFERENCES `readme`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_hashtag_hashtag1`
    FOREIGN KEY (`hashtag_hashtag_id`)
    REFERENCES `readme`.`hashtag` (`hashtag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
