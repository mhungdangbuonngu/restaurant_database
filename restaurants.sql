SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `restaurants` ;
CREATE SCHEMA IF NOT EXISTS `restaurants` DEFAULT CHARACTER SET latin1 ;
USE `restaurants` ;

-- -----------------------------------------------------
-- Table `restaurants`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurants`.`customer` (
  `id` INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL CHECK (`gender` IN ('M' , 'F')),
  `phone_number` VARCHAR(25) NULL DEFAULT NULL,
  `email_address` VARCHAR(150) NULL DEFAULT NULL,
  `address` LONGTEXT NULL DEFAULT NULL,
  `city` VARCHAR(150) NULL DEFAULT NULL,
  `country` VARCHAR(150) NULL DEFAULT NULL,
  `fav_res_id` INT(8) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `city` (`city` ASC),
  INDEX `country` (`country` ASC),
  CONSTRAINT `customer_favourite_restaurant_foreign`
    FOREIGN KEY (`fav_res_id`)
    REFERENCES `restaurants`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `restaurants`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurants`.`restaurant` (
  `id` INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `address` LONGTEXT NULL DEFAULT NULL,
  `city` VARCHAR(150) NULL DEFAULT NULL,
  `country` VARCHAR(150) NULL DEFAULT NULL,
  `hotline_number` VARCHAR(25) NULL DEFAULT NULL,
  `rating` DECIMAL(3,2) NULL DEFAULT NULL CHECK (`rating` >= 0 AND `rating` <= 5),
  PRIMARY KEY (`id`),
  INDEX `city` (`city` ASC),
  INDEX `country` (`country` ASC),
  INDEX `rating` (`rating` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `restaurants`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurants`.`services` (
  `restaurant_id` INT(8) UNSIGNED NOT NULL,
  `menu_id` INT(8) UNSIGNED NOT NULL,
  `payment_methods` VARCHAR(150) NOT NULL,
  `buffet` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`buffet` IN (0, 1)),
  `brunch` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`brunch` IN (0, 1)),
  `kids_menu` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`kids_menu` IN (0, 1)),
  `delivery` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`delivery` IN (0, 1)),
  `take_out` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`take_out` IN (0, 1)),
  `catering` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`catering` IN (0, 1)),
  INDEX `restaurant_id` (`restaurant_id` ASC),
  CONSTRAINT `services_restaurant_id_foreign` 
	FOREIGN KEY(`restaurant_id`) 
    REFERENCES `restaurants`.`restaurant`(`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `services_menu_id_foreign` 
	FOREIGN KEY(`menu_id`) 
    REFERENCES `restaurants`.`menu`(`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `restaurants`.`facilities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurants`.`facilities` (
  `restaurant_id` INT(8) UNSIGNED NOT NULL,
  `bar` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`bar` IN (0, 1)),
  `indoor_space` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`indoor_space` IN (0, 1)),
  `outdoor_space` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`outdoor_space` IN (0, 1)),
  `private_room` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`private_room` IN (0, 1)),
  `parking_place` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`parking_place` IN (0, 1)),
  `smoking_area` TINYINT(1) NOT NULL DEFAULT '0' CHECK (`smoking_area` IN (0, 1)),
  INDEX `restaurant_id` (`restaurant_id` ASC),
  CONSTRAINT `facilities_restaurant_id_foreign` 
	FOREIGN KEY(`restaurant_id`) 
    REFERENCES `restaurants`.`restaurant`(`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `restaurants`.`food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurants`.`food` (
  `name` VARCHAR(150) NOT NULL UNIQUE,
  `price` DECIMAL(8, 2) UNSIGNED NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `restaurants`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurants`.`menu` (
  `id` INT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `food_name_1` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_2` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_3` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_4` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_5` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_6` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_7` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_8` VARCHAR(150) NULL DEFAULT NULL,
  `food_name_9` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `menu_food_name_1_foreign` 
	FOREIGN KEY(`food_name_1`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu_food_name_2_foreign` 
	FOREIGN KEY(`food_name_2`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu_food_name_3_foreign` 
	FOREIGN KEY(`food_name_3`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `menu_food_name_4_foreign` 
	FOREIGN KEY(`food_name_4`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `menu_food_name_5_foreign` 
	FOREIGN KEY(`food_name_5`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `menu_food_name_6_foreign` 
	FOREIGN KEY(`food_name_6`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `menu_food_name_7_foreign` 
	FOREIGN KEY(`food_name_7`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `menu_food_name_8_foreign` 
	FOREIGN KEY(`food_name_8`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `menu_food_name_9_foreign` 
	FOREIGN KEY(`food_name_9`) 
    REFERENCES `restaurants`.`food`(`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `restaurants`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurants`.`review` (  
  `id` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT(8) UNSIGNED NOT NULL,
  `restaurant_id` INT(8) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL DEFAULT NULL,
  `rating` DECIMAL(3,2) NULL DEFAULT '0.00' CHECK (`rating` >= 0 AND `rating` <= 5),
  `date_created` DATE NULL DEFAULT NULL,
  `date_modified` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `customer_id` (`customer_id` ASC),
  INDEX `restaurant_id` (`restaurant_id` ASC),
  CONSTRAINT `review_customer_id_foreign` 
	FOREIGN KEY(`customer_id`) 
    REFERENCES `restaurants`.`customer`(`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `review_restaurant_id_foreign`
	FOREIGN KEY(`restaurant_id`)
    REFERENCES `restaurants`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;