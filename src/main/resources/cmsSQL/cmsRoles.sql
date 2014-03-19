/*
SQLyog Ultimate v9.62 
MySQL - 5.5.28 : Database - cms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `cms`;

/*Table structure for table `t_p_account_role` */

DROP TABLE IF EXISTS `t_p_account_role`;

CREATE TABLE `t_p_account_role` (
  `id` varchar(255) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` longtext,
  `enable` tinyint(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_p_account_role` */

insert  into `t_p_account_role`(`id`,`create_time`,`update_time`,`description`,`enable`,`name`) values ('cmscategoryeditor',NULL,NULL,NULL,1,'栏目编辑');
insert  into `t_p_account_role`(`id`,`create_time`,`update_time`,`description`,`enable`,`name`) values ('cmscategorymanager',NULL,NULL,NULL,1,'栏目管理');
insert  into `t_p_account_role`(`id`,`create_time`,`update_time`,`description`,`enable`,`name`) values ('cmscontenteditor',NULL,NULL,NULL,1,'新闻编辑');
insert  into `t_p_account_role`(`id`,`create_time`,`update_time`,`description`,`enable`,`name`) values ('cmscontentmanager',NULL,NULL,NULL,1,'新闻管理');
insert  into `t_p_account_role`(`id`,`create_time`,`update_time`,`description`,`enable`,`name`) values ('cmsreviewmanager',NULL,NULL,NULL,1,'评论管理');
insert  into `t_p_account_role`(`id`,`create_time`,`update_time`,`description`,`enable`,`name`) values ('cmssiteeditor',NULL,NULL,NULL,1,'站点编辑');
insert  into `t_p_account_role`(`id`,`create_time`,`update_time`,`description`,`enable`,`name`) values ('cmssitemanager',NULL,NULL,NULL,1,'站点管理');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
