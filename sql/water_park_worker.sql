/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.0.34 : Database - water_park_worker
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`water_park_worker` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `water_park_worker`;

/*Table structure for table `rates` */

DROP TABLE IF EXISTS `rates`;

CREATE TABLE `rates` (
  `id_rates` int NOT NULL AUTO_INCREMENT,
  `name_rate` varchar(255) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_rates`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `rates` */

insert  into `rates`(`id_rates`,`name_rate`,`duration`,`description`) values 
(1,'Standard','02:00:00','Basic entry fee'),
(2,'VIP','04:00:00','Includes access to all attractions'),
(3,'Family','03:00:00','Discounted rate for families'),
(4,'Student','01:30:00','Special rate for students'),
(5,'Senior','02:30:00','Discounted rate for seniors');

/*Table structure for table `rates_visitor_relation` */

DROP TABLE IF EXISTS `rates_visitor_relation`;

CREATE TABLE `rates_visitor_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_rates` int DEFAULT NULL,
  `id_visitor` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_rates` (`id_rates`),
  KEY `id_visitor` (`id_visitor`),
  CONSTRAINT `rates_visitor_relation_ibfk_1` FOREIGN KEY (`id_rates`) REFERENCES `rates` (`id_rates`),
  CONSTRAINT `rates_visitor_relation_ibfk_2` FOREIGN KEY (`id_visitor`) REFERENCES `visitor` (`id_visitor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `rates_visitor_relation` */

insert  into `rates_visitor_relation`(`id`,`id_rates`,`id_visitor`) values 
(1,1,1),
(2,1,2),
(3,5,3),
(4,3,4),
(5,4,5);

/*Table structure for table `ratesvisitorrelation` */

DROP TABLE IF EXISTS `ratesvisitorrelation`;

CREATE TABLE `ratesvisitorrelation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_rates` int DEFAULT NULL,
  `id_visitor` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_rates` (`id_rates`),
  KEY `id_visitor` (`id_visitor`),
  CONSTRAINT `ratesvisitorrelation_ibfk_1` FOREIGN KEY (`id_rates`) REFERENCES `rates` (`id_rates`),
  CONSTRAINT `ratesvisitorrelation_ibfk_2` FOREIGN KEY (`id_visitor`) REFERENCES `visitor` (`id_visitor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `ratesvisitorrelation` */

/*Table structure for table `service` */

DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `id_service` int NOT NULL AUTO_INCREMENT,
  `name_service` varchar(255) DEFAULT NULL,
  `date_event` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_service`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `service` */

insert  into `service`(`id_service`,`name_service`,`date_event`,`description`) values 
(1,'Swimming Pool','2023-12-01','Enjoy our spacious swimming pool'),
(2,'Water Slides','2023-12-02','Experience thrilling water slides'),
(3,'Wave Pool','2023-12-03','Relax in our wave pool'),
(4,'Snack Bar','2023-12-04','Grab a snack at our bar'),
(5,'Fitness Center','2023-12-05','Stay fit in our fitness center');

/*Table structure for table `service_session_relation` */

DROP TABLE IF EXISTS `service_session_relation`;

CREATE TABLE `service_session_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_service` int DEFAULT NULL,
  `id_session` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_service` (`id_service`),
  KEY `id_session` (`id_session`),
  CONSTRAINT `service_session_relation_ibfk_1` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`),
  CONSTRAINT `service_session_relation_ibfk_2` FOREIGN KEY (`id_session`) REFERENCES `session` (`id_session`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `service_session_relation` */

insert  into `service_session_relation`(`id`,`id_service`,`id_session`) values 
(1,2,2),
(2,3,1),
(3,3,2),
(4,5,3),
(5,5,4);

/*Table structure for table `servicesessionrelation` */

DROP TABLE IF EXISTS `servicesessionrelation`;

CREATE TABLE `servicesessionrelation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_service` int DEFAULT NULL,
  `id_session` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_service` (`id_service`),
  KEY `id_session` (`id_session`),
  CONSTRAINT `servicesessionrelation_ibfk_1` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`),
  CONSTRAINT `servicesessionrelation_ibfk_2` FOREIGN KEY (`id_session`) REFERENCES `session` (`id_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `servicesessionrelation` */

/*Table structure for table `session` */

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
  `id_session` int NOT NULL AUTO_INCREMENT,
  `name_session` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  PRIMARY KEY (`id_session`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `session` */

insert  into `session`(`id_session`,`name_session`,`description`,`duration`) values 
(1,'Morning Swim','Early morning swim session','01:30:00'),
(2,'Afternoon Slides','Exciting afternoon on water slides','02:00:00'),
(3,'Evening Waves','Relaxing evening in the wave pool','01:45:00'),
(4,'Snack Break','Enjoy a break at the snack bar','00:45:00'),
(5,'Fitness Class','Join our fitness class','01:15:00');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `id_staff` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `number_phone_staff` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `staff` */

insert  into `staff`(`id_staff`,`full_name`,`number_phone_staff`) values 
(1,'Employee 1','555-1111'),
(2,'Employee 2','555-2222'),
(3,'Employee 3','555-3333'),
(4,'Employee 4','555-4444'),
(5,'Employee 5','555-5555');

/*Table structure for table `staff_service_relation` */

DROP TABLE IF EXISTS `staff_service_relation`;

CREATE TABLE `staff_service_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_staff` int DEFAULT NULL,
  `id_service` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_staff` (`id_staff`),
  KEY `id_service` (`id_service`),
  CONSTRAINT `staff_service_relation_ibfk_1` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`),
  CONSTRAINT `staff_service_relation_ibfk_2` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `staff_service_relation` */

insert  into `staff_service_relation`(`id`,`id_staff`,`id_service`) values 
(1,3,2),
(2,1,5),
(3,2,5),
(4,5,3),
(5,2,3);

/*Table structure for table `staffservicerelation` */

DROP TABLE IF EXISTS `staffservicerelation`;

CREATE TABLE `staffservicerelation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_staff` int DEFAULT NULL,
  `id_service` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_staff` (`id_staff`),
  KEY `id_service` (`id_service`),
  CONSTRAINT `staffservicerelation_ibfk_1` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`),
  CONSTRAINT `staffservicerelation_ibfk_2` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `staffservicerelation` */

/*Table structure for table `visitor` */

DROP TABLE IF EXISTS `visitor`;

CREATE TABLE `visitor` (
  `id_visitor` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `address_visitor` varchar(255) DEFAULT NULL,
  `number_phone_visitor` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_visitor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `visitor` */

insert  into `visitor`(`id_visitor`,`full_name`,`address_visitor`,`number_phone_visitor`) values 
(1,'John Doe','123 Main St','555-1234'),
(2,'Jane Smith','456 Oak St','555-5678'),
(3,'Bob Johnson','789 Pine St','555-9876'),
(4,'Alice Williams','101 Elm St','555-5432'),
(5,'Charlie Brown','202 Cedar St','555-6789');

/*Table structure for table `visitor_staff_relation` */

DROP TABLE IF EXISTS `visitor_staff_relation`;

CREATE TABLE `visitor_staff_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_visitor` int DEFAULT NULL,
  `id_staff` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_visitor` (`id_visitor`),
  KEY `id_staff` (`id_staff`),
  CONSTRAINT `visitor_staff_relation_ibfk_1` FOREIGN KEY (`id_visitor`) REFERENCES `visitor` (`id_visitor`),
  CONSTRAINT `visitor_staff_relation_ibfk_2` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `visitor_staff_relation` */

insert  into `visitor_staff_relation`(`id`,`id_visitor`,`id_staff`) values 
(1,4,3),
(2,3,2),
(3,5,1),
(4,1,2),
(5,2,5);

/*Table structure for table `visitorstaffrelation` */

DROP TABLE IF EXISTS `visitorstaffrelation`;

CREATE TABLE `visitorstaffrelation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_visitor` int DEFAULT NULL,
  `id_staff` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_visitor` (`id_visitor`),
  KEY `id_staff` (`id_staff`),
  CONSTRAINT `visitorstaffrelation_ibfk_1` FOREIGN KEY (`id_visitor`) REFERENCES `visitor` (`id_visitor`),
  CONSTRAINT `visitorstaffrelation_ibfk_2` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `visitorstaffrelation` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
