CREATE TABLE `Users` (
  `USR_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `USR_email` varchar(30) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_name` varchar(20) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_surname` varchar(20) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_password` varchar(15) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_phone` varchar(15) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_city` varchar(15) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_district` varchar(15) COLLATE utf8_turkish_ci NOT NULL DEFAULT '',
  `USR_birthDate` date DEFAULT NULL,
  `USR_createdDate` date DEFAULT NULL,
  PRIMARY KEY (`USR_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

INSERT INTO Users (`USR_email`,`USR_name`,`USR_surname`,`USR_password`, `USR_phone`,`USR_city`,`USR_district`) VALUES ("mustafa.hasturk@yandex.com","Mustafa","Hastürk","cokgizli","5418524241","İstanbul","Üsküdar");
INSERT INTO Users (`USR_email`,`USR_name`,`USR_surname`,`USR_password`, `USR_phone`,`USR_city`,`USR_district`) VALUES ("iskengin@gmail.com","Engin","Işık","12345","5350858531","İstanbul","Avcılar");