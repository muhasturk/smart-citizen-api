# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.24)
# Database: smart_citizen
# Generation Time: 2016-05-27 08:31:42 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Category`;

CREATE TABLE `Category` (
  `CAT_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CAT_name` varchar(20) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`CAT_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;

INSERT INTO `Category` (`CAT_id`, `CAT_name`)
VALUES
	(1,'Elektrik'),
	(2,'Su'),
	(3,'Kanalizasyon'),
	(4,'Doğalgaz'),
	(5,'Telefon'),
	(6,'Yol Çalışması'),
	(7,'Çevre Temizliği');

/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table City
# ------------------------------------------------------------

DROP TABLE IF EXISTS `City`;

CREATE TABLE `City` (
  `CTY_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CTY_name` varchar(15) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`CTY_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `City` WRITE;
/*!40000 ALTER TABLE `City` DISABLE KEYS */;

INSERT INTO `City` (`CTY_id`, `CTY_name`)
VALUES
	(34,'İstanbul'),
	(54,'Sakarya');

/*!40000 ALTER TABLE `City` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table District
# ------------------------------------------------------------

DROP TABLE IF EXISTS `District`;

CREATE TABLE `District` (
  `DST_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DST_city` int(11) unsigned NOT NULL,
  `DST_name` varchar(15) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`DST_id`),
  KEY `DST_city` (`DST_city`),
  CONSTRAINT `district_ibfk_1` FOREIGN KEY (`DST_city`) REFERENCES `City` (`CTY_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `District` WRITE;
/*!40000 ALTER TABLE `District` DISABLE KEYS */;

INSERT INTO `District` (`DST_id`, `DST_city`, `DST_name`)
VALUES
	(1,34,'Avcılar'),
	(2,34,'Beylikdüzü'),
	(3,34,'Üsküdar'),
	(4,34,'Beyoğlu'),
	(5,34,'Fatih'),
	(6,54,'Pamukova'),
	(7,54,'Geyve'),
	(8,34,'Eyüp');

/*!40000 ALTER TABLE `District` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table INS_CAT_NBH
# ------------------------------------------------------------

DROP TABLE IF EXISTS `INS_CAT_NBH`;

CREATE TABLE `INS_CAT_NBH` (
  `ICN_institution` int(11) unsigned NOT NULL,
  `ICN_category` int(11) unsigned NOT NULL,
  `ICN_neighborhood` int(11) unsigned NOT NULL,
  KEY `ICN_institution` (`ICN_institution`),
  KEY `ICN_category` (`ICN_category`),
  KEY `ICN_neighborhood` (`ICN_neighborhood`),
  CONSTRAINT `ins_cat_nbh_ibfk_1` FOREIGN KEY (`ICN_institution`) REFERENCES `Institution` (`INS_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ins_cat_nbh_ibfk_2` FOREIGN KEY (`ICN_category`) REFERENCES `Category` (`CAT_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ins_cat_nbh_ibfk_3` FOREIGN KEY (`ICN_neighborhood`) REFERENCES `Neighborhood` (`NBH_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `INS_CAT_NBH` WRITE;
/*!40000 ALTER TABLE `INS_CAT_NBH` DISABLE KEYS */;

INSERT INTO `INS_CAT_NBH` (`ICN_institution`, `ICN_category`, `ICN_neighborhood`)
VALUES
	(4,7,1),
	(4,7,2),
	(3,1,3),
	(1,1,1);

/*!40000 ALTER TABLE `INS_CAT_NBH` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Institution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Institution`;

CREATE TABLE `Institution` (
  `INS_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `INS_name` varchar(40) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`INS_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `Institution` WRITE;
/*!40000 ALTER TABLE `Institution` DISABLE KEYS */;

INSERT INTO `Institution` (`INS_id`, `INS_name`)
VALUES
	(0,'Bağımsız'),
	(1,'Boğaziçi Elektrik Dağıtım A.Ş.'),
	(2,'İstanbul Su ve Kanalizasyon İdaresi'),
	(3,'Sakarya Elektrik Dağıtım A.Ş.'),
	(4,'Avcılar Belediyesi'),
	(5,'İstanbul Ulaşım A.Ş.'),
	(6,'İGDAŞ'),
	(7,'Türk Telekom'),
	(8,'Pamukova Belediyesi');

/*!40000 ALTER TABLE `Institution` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Location
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Location`;

CREATE TABLE `Location` (
  `LOC_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `LOC_neighborhood` int(11) unsigned DEFAULT NULL,
  `LOC_latitude` double NOT NULL,
  `LOC_longitude` double NOT NULL,
  PRIMARY KEY (`LOC_id`),
  KEY `LOC_neighborhood` (`LOC_neighborhood`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`LOC_neighborhood`) REFERENCES `Neighborhood` (`NBH_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;

INSERT INTO `Location` (`LOC_id`, `LOC_neighborhood`, `LOC_latitude`, `LOC_longitude`)
VALUES
	(1,1,40.990755,28.716683),
	(3,1,40.990347,28.719055),
	(35,1,40.995466,28.714455),
	(36,1,40.996431,28.706701);

/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Neighborhood
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Neighborhood`;

CREATE TABLE `Neighborhood` (
  `NBH_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NBH_district` int(11) unsigned NOT NULL,
  `NBH_postCode` varchar(5) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `NBH_name` varchar(25) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`NBH_id`),
  KEY `NBH_district` (`NBH_district`),
  CONSTRAINT `neighborhood_ibfk_1` FOREIGN KEY (`NBH_district`) REFERENCES `District` (`DST_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `Neighborhood` WRITE;
/*!40000 ALTER TABLE `Neighborhood` DISABLE KEYS */;

INSERT INTO `Neighborhood` (`NBH_id`, `NBH_district`, `NBH_postCode`, `NBH_name`)
VALUES
	(1,1,'34320','Üniversite Mahallesi'),
	(2,1,'34310','Merkez Mahallesi'),
	(3,6,'54920','Turgutlu Mahallesi');

/*!40000 ALTER TABLE `Neighborhood` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Problem
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Problem`;

CREATE TABLE `Problem` (
  `PRB_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `PRB_category` int(11) unsigned NOT NULL,
  `PRB_location` int(11) unsigned NOT NULL,
  `PRB_state` int(11) unsigned NOT NULL,
  `PRB_title` varchar(40) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `PRB_explanation` varchar(200) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `PRB_authorizedUser` int(11) unsigned DEFAULT NULL,
  `PRB_count` int(11) DEFAULT NULL,
  `PRB_createdDate` date DEFAULT NULL,
  `PRB_updatedDate` date DEFAULT NULL,
  `PRB_reportingUser` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`PRB_id`),
  KEY `PRB_category` (`PRB_category`),
  KEY `PRB_location` (`PRB_location`),
  KEY `PRB_state` (`PRB_state`),
  KEY `PRB_authorizedUser` (`PRB_authorizedUser`),
  KEY `PRB_reportingUser` (`PRB_reportingUser`),
  CONSTRAINT `problem_ibfk_1` FOREIGN KEY (`PRB_category`) REFERENCES `Category` (`CAT_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `problem_ibfk_2` FOREIGN KEY (`PRB_location`) REFERENCES `Location` (`LOC_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `problem_ibfk_5` FOREIGN KEY (`PRB_authorizedUser`) REFERENCES `Users` (`USR_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `problem_ibfk_6` FOREIGN KEY (`PRB_reportingUser`) REFERENCES `User` (`USR_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `problem_ibfk_7` FOREIGN KEY (`PRB_state`) REFERENCES `ProblemState` (`PRS_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `Problem` WRITE;
/*!40000 ALTER TABLE `Problem` DISABLE KEYS */;

INSERT INTO `Problem` (`PRB_id`, `PRB_category`, `PRB_location`, `PRB_state`, `PRB_title`, `PRB_explanation`, `PRB_authorizedUser`, `PRB_count`, `PRB_createdDate`, `PRB_updatedDate`, `PRB_reportingUser`)
VALUES
	(4,7,3,0,'Çöp Kovası Eksikliği','Sokaktaki Çöp kutusu yetersiz',NULL,9,'2016-03-18','2016-03-25',24),
	(10,1,1,1,'Elektrik Direği Işığı','Sokağın başındaki elektrik direğinin ışığı yanmıyor',NULL,10,'2016-03-20','2016-03-25',23),
	(38,1,35,2,'Elektrik direği problemi','Sokağın ortasında bulunan elektrik direği arızalı',NULL,15,'2016-05-05','2016-05-25',23),
	(39,3,36,3,'Kanalizasyon tıkalı','Sokakta kanalizasyon tıkandı. Logar kapağını üzerinden su taşıyor',NULL,15,'2016-05-12','2016-05-25',23);

/*!40000 ALTER TABLE `Problem` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `changeStatus` BEFORE UPDATE ON `Problem` FOR EACH ROW IF old.PRB_count < 10 and NEW.PRB_count = 10 THEN
	SET NEW.PRB_state = 1;
ELSEIF old.PRB_count > 5 and NEW.PRB_count = 5 THEN
	SET NEW.PRB_state = 0;
END IF */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table ProblemCount
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ProblemCount`;

CREATE TABLE `ProblemCount` (
  `PRC_user` int(11) unsigned NOT NULL,
  `PRC_problem` int(11) unsigned NOT NULL,
  `PRC_assent` tinyint(11) NOT NULL,
  PRIMARY KEY (`PRC_user`,`PRC_problem`),
  KEY `PRC_problem` (`PRC_problem`),
  CONSTRAINT `problemcount_ibfk_1` FOREIGN KEY (`PRC_user`) REFERENCES `User` (`USR_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `problemcount_ibfk_2` FOREIGN KEY (`PRC_problem`) REFERENCES `Problem` (`PRB_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `voteReport` AFTER INSERT ON `ProblemCount` FOR EACH ROW IF new.PRC_assent = 1 THEN
		UPDATE Problem SET PRB_count = PRB_count + 1 WHERE new.PRC_problem = PRB_id;
ELSE
		UPDATE Problem SET PRB_count = PRB_count - 1 WHERE new.PRC_problem = PRB_id;
END IF */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table ProblemImage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ProblemImage`;

CREATE TABLE `ProblemImage` (
  `PRI_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `PRI_problem` int(11) unsigned DEFAULT NULL,
  `PRI_imageUrl` varchar(300) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`PRI_id`),
  KEY `PRI_problem` (`PRI_problem`),
  CONSTRAINT `problemimage_ibfk_1` FOREIGN KEY (`PRI_problem`) REFERENCES `Problem` (`PRB_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `ProblemImage` WRITE;
/*!40000 ALTER TABLE `ProblemImage` DISABLE KEYS */;

INSERT INTO `ProblemImage` (`PRI_id`, `PRI_problem`, `PRI_imageUrl`)
VALUES
	(15,4,'https://s3-us-west-2.amazonaws.com/smart-citizen/6B31782C-26E6-41FA-978F-543C062BB6BF-1968-000001C22F5451E1.png'),
	(16,10,'https://s3-us-west-2.amazonaws.com/smart-citizen/6B31782C-26E6-41FA-978F-543C062BB6BF-1968-000001C22F5451E1.png'),
	(17,38,'https://s3-us-west-2.amazonaws.com/smart-citizen/6B31782C-26E6-41FA-978F-543C062BB6BF-1968-000001C22F5451E1.png'),
	(23,39,'https://s3-us-west-2.amazonaws.com/smart-citizen/6B31782C-26E6-41FA-978F-543C062BB6BF-1968-000001C22F5451E1.png');

/*!40000 ALTER TABLE `ProblemImage` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ProblemState
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ProblemState`;

CREATE TABLE `ProblemState` (
  `PRS_id` int(11) unsigned NOT NULL,
  `PRS_name` varchar(20) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`PRS_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `ProblemState` WRITE;
/*!40000 ALTER TABLE `ProblemState` DISABLE KEYS */;

INSERT INTO `ProblemState` (`PRS_id`, `PRS_name`)
VALUES
	(0,'New'),
	(1,'Accepted'),
	(2,'Working'),
	(3,'Done');

/*!40000 ALTER TABLE `ProblemState` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table User
# ------------------------------------------------------------

DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` (
  `USR_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `USR_email` varchar(30) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_name` varchar(35) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_password` varchar(15) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_createdDate` date DEFAULT NULL,
  `USR_institution` int(11) unsigned NOT NULL,
  `USR_deviceToken` varchar(100) COLLATE utf8_turkish_ci DEFAULT NULL,
  `USR_activated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`USR_id`),
  KEY `USR_institution` (`USR_institution`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`USR_institution`) REFERENCES `Institution` (`INS_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;

INSERT INTO `User` (`USR_id`, `USR_email`, `USR_name`, `USR_password`, `USR_createdDate`, `USR_institution`, `USR_deviceToken`, `USR_activated`)
VALUES
	(22,'mustafa.hasturk@yandex.com','Mustafa Hastürk','cokgizli',NULL,0,NULL,1),
	(23,'iskengin@gmail.com','Engin Işık','12345',NULL,0,NULL,1),
	(24,'kerim.onderr33@info.com','Kerim Önder','123',NULL,4,NULL,1),
	(25,'cemo.derrler@info.com','Cemal Derler','123',NULL,3,NULL,1),
	(26,'Emo.derler@info.com','Emrah Demezler','312',NULL,1,NULL,1),
	(27,'acemi@info.com','acemi kurnaz','1234',NULL,0,NULL,1),
	(28,'acemi1@info.com','acemi kurnaz1','1234',NULL,0,NULL,1),
	(29,'aliveli@info.com','Ali Veli','12345',NULL,0,NULL,1),
	(32,'normal@info.com','normal info','1234',NULL,0,NULL,1);

/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
